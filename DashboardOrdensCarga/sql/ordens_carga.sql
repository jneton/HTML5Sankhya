/*
 Dashboard Gerencial de Ordens de Carga
 Oracle Database 19c / Sankhya
 Parâmetros do componente:
   P_OC : multiList:Text (obrigatório; valores de ORDEMCARGA)
   SIT  : multiList:Text (obrigatório; valores de AD_FORMCONC)

 Estratégia: resultado em formato LONG (produto x ordem de carga).
 Não existe limite fixo de 30 OCs. A interface agrupa dinamicamente as OCs
 retornadas e apresenta totais por produto e por ordem.
*/
WITH
/* 1. Ordens selecionadas e válidas. */
ordens_selecionadas AS (
    SELECT DISTINCT
           cab.ordemcarga
      FROM tgfcab cab
      JOIN tgfite ite
        ON ite.nunota = cab.nunota
      LEFT JOIN tgford ord
        ON ord.ordemcarga = cab.ordemcarga
     WHERE cab.tipmov = 'P'
       AND cab.pendente = 'S'
       AND ite.pendente = 'S'
       AND cab.ordemcarga IN :P_OC
       AND NVL(ord.ad_formconc, 'N') IN :SIT
       AND cab.ordemcarga IS NOT NULL
),
/* 2. Itens pendentes somente das OCs selecionadas. */
itens_base AS (
    SELECT cab.ordemcarga,
           ite.nunota,
           ite.codprod,
           ite.qtdneg,
           ite.qtdentregue,
           ite.qtdconferida,
           ite.ad_vlrliq,
           ite.ad_vlrunitfrete,
           (ite.qtdneg - ite.qtdentregue - ite.qtdconferida) AS qtd_pendente
      FROM ordens_selecionadas os
      JOIN tgfcab cab
        ON cab.ordemcarga = os.ordemcarga
      JOIN tgfite ite
        ON ite.nunota = cab.nunota
     WHERE cab.tipmov = 'P'
       AND cab.pendente = 'S'
       AND ite.pendente = 'S'
),
/* 3. Estoques agregados uma única vez por produto. */
estoques AS (
    SELECT est.codprod,
           SUM(CASE
                 WHEN est.codparc = 0 AND est.codlocal <> 2030000
                 THEN NVL(est.estoque, 0) ELSE 0
               END) AS estoque_disponivel,
           SUM(CASE
                 WHEN est.codparc = 0 AND est.codlocal = 2030000
                 THEN NVL(est.estoque, 0) ELSE 0
               END) AS estoque_definido,
           SUM(CASE
                 WHEN est.codlocal = 2010000
                 THEN NVL(est.estoque, 0) ELSE 0
               END) AS estoque_sa
      FROM tgfest est
     WHERE est.codparc = 0
        OR est.codlocal IN (2010000, 2030000)
     GROUP BY est.codprod
),
/* 4. Mapeamento dos produtos SA e regra especial do grupo 301. */
produtos_sa_base AS (
    SELECT pro.codprod,
           pro.ad_cod_prod_sa AS cod_sa_1,
           sa1.descrprod || sa1.compldesc AS descricao_sa_1,
           SUBSTR(sa1.codgrupoprod, 1, 3) AS grupo_sa_1,
           pro_sa.ad_cod_prod_sa AS cod_sa_2,
           sa2.descrprod || sa2.compldesc AS descricao_sa_2
      FROM tgfpro pro
      LEFT JOIN tgfpro pro_sa
        ON pro_sa.codprod = pro.ad_cod_prod_sa
      LEFT JOIN tgfpro sa1
        ON sa1.codprod = pro.ad_cod_prod_sa
      LEFT JOIN tgfpro sa2
        ON sa2.codprod = pro_sa.ad_cod_prod_sa
     WHERE SUBSTR(pro.codgrupoprod, 1, 1) = '4'
),
produtos_sa AS (
    SELECT ps.codprod,
           CASE WHEN ps.grupo_sa_1 = '301' THEN ps.cod_sa_1
                ELSE ps.cod_sa_2 END AS codpro_sa,
           CASE WHEN ps.grupo_sa_1 = '301' THEN ps.cod_sa_1
                ELSE ps.cod_sa_1 END AS codpro_pint,
           CASE WHEN ps.grupo_sa_1 = '301' THEN ps.descricao_sa_1
                ELSE ps.descricao_sa_2 END AS descricao_sa
      FROM produtos_sa_base ps
     WHERE CASE WHEN ps.grupo_sa_1 = '301' THEN ps.cod_sa_1
                ELSE ps.cod_sa_2 END IS NOT NULL
),
/* 5. Observações: granularidade correta por OC e produto.
      LISTAGG substitui os pivots fixos de até 20 notas. */
observacoes AS (
    SELECT b.ordemcarga,
           b.codprod,
           COUNT(DISTINCT b.nunota) AS qtdpedobs,
           LISTAGG(TO_CHAR(b.nunota), ', ')
             WITHIN GROUP (ORDER BY b.nunota) AS pedidos_observados
      FROM (
            SELECT DISTINCT ib.ordemcarga,
                   ib.codprod,
                   ib.nunota
              FROM itens_base ib
              JOIN tgfite itobs
                ON itobs.nunota = ib.nunota
               AND itobs.codprod = ib.codprod
             WHERE itobs.observacao IS NOT NULL
           ) b
     GROUP BY b.ordemcarga, b.codprod
),
/* 6. Agregação por produto e ordem de carga. */
produto_oc AS (
    SELECT ib.ordemcarga,
           ib.codprod,
           SUM(ib.qtd_pendente) AS qtd_pendente,
           SUM(ib.qtd_pendente * (ib.ad_vlrliq / NULLIF(ib.qtdneg, 0))) AS valor_total,
           SUM(ib.qtd_pendente * ib.ad_vlrunitfrete) AS valor_frete,
           SUM(NVL(pro.m3, 0) * ib.qtd_pendente) AS volume_m3,
           SUM(NVL(oc.qtdpedobs, 0)) AS qtdpedobs,
           LISTAGG(oc.pedidos_observados, '; ')
             WITHIN GROUP (ORDER BY oc.pedidos_observados) AS pedidos_observados
      FROM itens_base ib
      JOIN tgfpro pro
        ON pro.codprod = ib.codprod
      LEFT JOIN observacoes oc
        ON oc.ordemcarga = ib.ordemcarga
       AND oc.codprod = ib.codprod
     GROUP BY ib.ordemcarga, ib.codprod
),
/* 7. Totais gerais por produto, sem multiplicação causada por observações. */
produto_total AS (
    SELECT poc.codprod,
           SUM(poc.qtd_pendente) AS pendente,
           SUM(poc.valor_total) AS vlttot,
           SUM(poc.valor_frete) AS frete,
           SUM(poc.volume_m3) AS volume_m3
      FROM produto_oc poc
     GROUP BY poc.codprod
)
SELECT
       TO_CHAR(LPAD(gru.codgrupoprod, 10, '0'), 'FM00G00G00G000') AS codgrupoprod,
       gru.descrgrupoprod,
       pro.codprod,
       pro.descrprod,
       pro.marca,
       NVL(pt.pendente, 0) AS pendente,
       NVL(est.estoque_disponivel, 0) AS estoque,
       NVL(est.estoque_definido, 0) AS estoque_def,
       NVL(est.estoque_disponivel, 0) - NVL(pt.pendente, 0) AS diferenca_estoque,
       CASE WHEN NVL(est.estoque_disponivel, 0) - NVL(pt.pendente, 0) >= 0
            THEN 'Sobrando' ELSE 'Faltando' END AS situacao,
       ps.codpro_sa,
       NVL(est_sa.estoque_sa, 0) AS estsa,
       ps.codpro_pint,
       NVL(est_pint.estoque_sa, 0) AS estpint,
       pt.vlttot,
       pt.frete,
       pt.volume_m3,
       NVL(pro.estmin, 0) AS estmin,
       CASE
         WHEN NVL(est.estoque_disponivel, 0) - NVL(pt.pendente, 0) <= 0 THEN 'RED'
         WHEN NVL(est.estoque_disponivel, 0) - NVL(pt.pendente, 0) <= NVL(pro.estmin, 0) THEN 'YELLOW'
         ELSE 'BLUE'
       END AS farol,
       poc.ordemcarga,
       poc.qtd_pendente AS qtd_oc,
       poc.valor_total AS valor_oc,
       poc.valor_frete AS frete_oc,
       poc.volume_m3 AS volume_oc,
       NVL(obs.qtdpedobs, 0) AS qtdpedobs_oc,
       obs.pedidos_observados
  FROM produto_oc poc
  JOIN produto_total pt
    ON pt.codprod = poc.codprod
  JOIN tgfpro pro
    ON pro.codprod = poc.codprod
  JOIN tgfgru gru
    ON gru.codgrupoprod = pro.codgrupoprod
  LEFT JOIN estoques est
    ON est.codprod = pro.codprod
  LEFT JOIN produtos_sa ps
    ON ps.codprod = pro.codprod
  LEFT JOIN estoques est_sa
    ON est_sa.codprod = ps.codpro_sa
  LEFT JOIN estoques est_pint
    ON est_pint.codprod = ps.codpro_pint
  LEFT JOIN observacoes obs
    ON obs.ordemcarga = poc.ordemcarga
   AND obs.codprod = poc.codprod
 ORDER BY pro.codprod, poc.ordemcarga
