WITH
-- 1. Ordens de carga válidas e sequência usada no PIVOT (01 a 30).
ordens_carga AS
 (SELECT ordemcarga,
         row_number() over (ORDER BY ordemcarga) AS sequencia
    FROM (SELECT DISTINCT cab.ordemcarga
            FROM tgfcab cab
            JOIN tgfite ite
              ON ite.nunota = cab.nunota
            LEFT JOIN tgford ord
              ON ord.ordemcarga = cab.ordemcarga
           WHERE cab.tipmov = 'P'
             AND cab.pendente = 'S'
             AND ite.pendente = 'S'
             AND cab.ordemcarga IN (:P_OC)
             AND coalesce(ord.ad_formconc, 'N') IN (:SIT)
             AND cab.ordemcarga IS NOT NULL)),
-- 2. Estoque disponível por produto, excluindo o local de estoque definido. 
estoque_disponivel AS
 (SELECT est.codprod,
         SUM(coalesce(est.estoque, 0)) AS estoque
    FROM tgfest est
   WHERE est.codparc = 0
     AND est.codlocal <> 2030000
   GROUP BY est.codprod),
-- 3. Estoque reservado/definido no local específico. 
estoque_definido AS
 (SELECT est.codprod,
         SUM(coalesce(est.estoque, 0)) AS estoque_def
    FROM tgfest est
   WHERE est.codparc = 0
     AND est.codlocal = 2030000
   GROUP BY est.codprod),
-- 4. Estoque dos produtos SA no local 2010000. 
estoque_produtos_sa AS
 (SELECT est.codprod,
         SUM(est.estoque) AS estoque_sa
    FROM tgfest est
   WHERE est.codlocal = 2010000
   GROUP BY est.codprod),
/* 5. Relacionamento do produto acabado com os produtos SA.
   A regra do grupo 301 foi preservada:
   - Quando o primeiro produto SA pertence ao grupo 301, ele passa a ocupar a posição SA principal e a segunda posição fica nula.
   - Nos demais casos, são mantidas as duas posições originais.*/
produtos_sa_base AS
 (SELECT pro.codprod,
         pro.ad_cod_prod_sa AS cod_sa_1,
         sa1.descrprod || sa1.compldesc AS descricao_sa_1,
         substr(sa1.codgrupoprod, 1, 3) AS grupo_sa_1,
         pro_sa.ad_cod_prod_sa AS cod_sa_2,
         sa2.descrprod || sa2.compldesc AS descricao_sa_2,
         substr(sa2.codgrupoprod, 1, 3) AS grupo_sa_2
    FROM tgfpro pro
    LEFT JOIN tgfpro pro_sa
      ON pro_sa.codprod = pro.ad_cod_prod_sa
    LEFT JOIN tgfpro sa1
      ON sa1.codprod = pro.ad_cod_prod_sa
    LEFT JOIN tgfpro sa2
      ON sa2.codprod = pro_sa.ad_cod_prod_sa
   WHERE substr(pro.codgrupoprod, 1, 1) = '4'),
produtos_sa_normalizados AS
 (SELECT codprod,
         CASE
            WHEN grupo_sa_1 = '301' THEN
             NULL
            ELSE
             cod_sa_1
         END AS codpro_pint,
         CASE
            WHEN grupo_sa_1 = '301' THEN
             NULL
            ELSE
             descricao_sa_1
         END AS descricao_pint,
         CASE
            WHEN grupo_sa_1 = '301' THEN
             descricao_sa_1
            ELSE
             descricao_sa_2
         END AS descricao_sa,
         CASE
            WHEN grupo_sa_1 = '301' THEN
             cod_sa_1
            ELSE
             cod_sa_2
         END AS codpro_sa
    FROM produtos_sa_base),
produtos_sa AS
 (SELECT ps.codprod,
         ps.codpro_sa,
         coalesce(es_sa.estoque_sa, 0) AS estsa,
         ps.codpro_pint,
         es_pint.estoque_sa AS estpint
    FROM produtos_sa_normalizados ps
    LEFT JOIN estoque_produtos_sa es_sa
      ON es_sa.codprod = ps.codpro_sa
    LEFT JOIN estoque_produtos_sa es_pint
      ON es_pint.codprod = ps.codpro_pint
  -- Expressão original preservada, embora pareça redundante. 
   WHERE ps.codpro_sa IS NOT NULL),
-- 6. Itens pendentes das ordens de carga, com quantidade e valores calculados.
itens_ordem_carga AS
 (SELECT ite.codprod,
         prod_sa.codpro_sa,
         prod_sa.estsa,
         prod_sa.codpro_pint,
         prod_sa.estpint,
         (ite.qtdneg - ite.qtdentregue - ite.qtdconferida) AS qtd_pendente,
         ordem.sequencia,
         cab.ordemcarga,
         ite.ad_vlrunitfrete * (ite.qtdneg - ite.qtdentregue - ite.qtdconferida) AS valor_frete,
         pro.m3 * (ite.qtdneg - ite.qtdentregue - ite.qtdconferida) AS volume_m3
    FROM tgfcab cab
    JOIN tgfite ite
      ON ite.nunota = cab.nunota
    JOIN tgfpro pro
      ON pro.codprod = ite.codprod
    JOIN ordens_carga ordem
      ON ordem.ordemcarga = cab.ordemcarga
    LEFT JOIN produtos_sa prod_sa
      ON prod_sa.codprod = ite.codprod
   WHERE cab.tipmov = 'P'
     AND ite.pendente = 'S'
     AND cab.pendente = 'S'),
--   7. Consolidação por produto e posição da ordem de carga. PIVOT mantém as 30 posições fixas esperadas pelo relatório.
ordens_por_produto AS
 (SELECT codprod,
         codpro_sa,
         estsa,
         codpro_pint,
         estpint,
         "A01_OCA"   AS oca_01,
         "A01_QTD"   AS qtd_01,
         "A01_FRT"   AS frt_01,
         "A01_MT3"   AS mt3_01,
         "A02_OCA"   AS oca_02,
         "A02_QTD"   AS qtd_02,
         "A02_FRT"   AS frt_02,
         "A02_MT3"   AS mt3_02,
         "A03_OCA"   AS oca_03,
         "A03_QTD"   AS qtd_03,
         "A03_FRT"   AS frt_03,
         "A03_MT3"   AS mt3_03,
         "A04_OCA"   AS oca_04,
         "A04_QTD"   AS qtd_04,
         "A04_FRT"   AS frt_04,
         "A04_MT3"   AS mt3_04,
         "A05_OCA"   AS oca_05,
         "A05_QTD"   AS qtd_05,
         "A05_FRT"   AS frt_05,
         "A05_MT3"   AS mt3_05,
         "A06_OCA"   AS oca_06,
         "A06_QTD"   AS qtd_06,
         "A06_FRT"   AS frt_06,
         "A06_MT3"   AS mt3_06,
         "A07_OCA"   AS oca_07,
         "A07_QTD"   AS qtd_07,
         "A07_FRT"   AS frt_07,
         "A07_MT3"   AS mt3_07,
         "A08_OCA"   AS oca_08,
         "A08_QTD"   AS qtd_08,
         "A08_FRT"   AS frt_08,
         "A08_MT3"   AS mt3_08,
         "A09_OCA"   AS oca_09,
         "A09_QTD"   AS qtd_09,
         "A09_FRT"   AS frt_09,
         "A09_MT3"   AS mt3_09,
         "A10_OCA"   AS oca_10,
         "A10_QTD"   AS qtd_10,
         "A10_FRT"   AS frt_10,
         "A10_MT3"   AS mt3_10,
         "A11_OCA"   AS oca_11,
         "A11_QTD"   AS qtd_11,
         "A11_FRT"   AS frt_11,
         "A11_MT3"   AS mt3_11,
         "A12_OCA"   AS oca_12,
         "A12_QTD"   AS qtd_12,
         "A12_FRT"   AS frt_12,
         "A12_MT3"   AS mt3_12,
         "A13_OCA"   AS oca_13,
         "A13_QTD"   AS qtd_13,
         "A13_FRT"   AS frt_13,
         "A13_MT3"   AS mt3_13,
         "A14_OCA"   AS oca_14,
         "A14_QTD"   AS qtd_14,
         "A14_FRT"   AS frt_14,
         "A14_MT3"   AS mt3_14,
         "A15_OCA"   AS oca_15,
         "A15_QTD"   AS qtd_15,
         "A15_FRT"   AS frt_15,
         "A15_MT3"   AS mt3_15,
         "A16_OCA"   AS oca_16,
         "A16_QTD"   AS qtd_16,
         "A16_FRT"   AS frt_16,
         "A16_MT3"   AS mt3_16,
         "A17_OCA"   AS oca_17,
         "A17_QTD"   AS qtd_17,
         "A17_FRT"   AS frt_17,
         "A17_MT3"   AS mt3_17,
         "A18_OCA"   AS oca_18,
         "A18_QTD"   AS qtd_18,
         "A18_FRT"   AS frt_18,
         "A18_MT3"   AS mt3_18,
         "A19_OCA"   AS oca_19,
         "A19_QTD"   AS qtd_19,
         "A19_FRT"   AS frt_19,
         "A19_MT3"   AS mt3_19,
         "A20_OCA"   AS oca_20,
         "A20_QTD"   AS qtd_20,
         "A20_FRT"   AS frt_20,
         "A20_MT3"   AS mt3_20,
         "A21_OCA"   AS oca_21,
         "A21_QTD"   AS qtd_21,
         "A21_FRT"   AS frt_21,
         "A21_MT3"   AS mt3_21,
         "A22_OCA"   AS oca_22,
         "A22_QTD"   AS qtd_22,
         "A22_FRT"   AS frt_22,
         "A22_MT3"   AS mt3_22,
         "A23_OCA"   AS oca_23,
         "A23_QTD"   AS qtd_23,
         "A23_FRT"   AS frt_23,
         "A23_MT3"   AS mt3_23,
         "A24_OCA"   AS oca_24,
         "A24_QTD"   AS qtd_24,
         "A24_FRT"   AS frt_24,
         "A24_MT3"   AS mt3_24,
         "A25_OCA"   AS oca_25,
         "A25_QTD"   AS qtd_25,
         "A25_FRT"   AS frt_25,
         "A25_MT3"   AS mt3_25,
         "A26_OCA"   AS oca_26,
         "A26_QTD"   AS qtd_26,
         "A26_FRT"   AS frt_26,
         "A26_MT3"   AS mt3_26,
         "A27_OCA"   AS oca_27,
         "A27_QTD"   AS qtd_27,
         "A27_FRT"   AS frt_27,
         "A27_MT3"   AS mt3_27,
         "A28_OCA"   AS oca_28,
         "A28_QTD"   AS qtd_28,
         "A28_FRT"   AS frt_28,
         "A28_MT3"   AS mt3_28,
         "A29_OCA"   AS oca_29,
         "A29_QTD"   AS qtd_29,
         "A29_FRT"   AS frt_29,
         "A29_MT3"   AS mt3_29,
         "A30_OCA"   AS oca_30,
         "A30_QTD"   AS qtd_30,
         "A30_FRT"   AS frt_30,
         "A30_MT3"   AS mt3_30
    FROM (SELECT codprod,
                 codpro_sa,
                 estsa,
                 codpro_pint,
                 estpint,
                 sequencia,
                 ordemcarga,
                 qtd_pendente,
                 valor_frete,
                 volume_m3
            FROM itens_ordem_carga)
  pivot(MAX(ordemcarga) AS oca, SUM(qtd_pendente) AS qtd, SUM(valor_frete) AS frt, SUM(volume_m3) AS mt3
     FOR sequencia IN(01 AS a01, 02 AS a02, 03 AS a03, 04 AS a04, 05 AS a05, 06 AS a06, 07 AS a07, 08 AS a08, 09 AS a09, 10 AS a10, 11 AS a11, 12 AS a12, 13 AS a13, 14 AS a14, 15 AS a15, 16 AS a16, 17 AS a17, 18 AS a18, 19 AS a19, 20 AS a20, 21 AS a21, 22 AS a22, 23 AS a23, 24 AS a24, 25 AS a25, 26 AS a26, 27 AS a27, 28 AS a28, 29 AS a29, 30 AS a30))),
-- 8. Pedidos com observação agregados por produto.
--    A agregação por produto evita multiplicação de linhas no resumo final,
--    que também é consolidado por produto.
pedidos_com_observacao_qtd AS
 (SELECT ite.codprod,
         COUNT(DISTINCT ite.nunota) AS qtdpedobs
    FROM tgfite ite
    JOIN tgfcab cab
      ON cab.nunota = ite.nunota
    LEFT JOIN tgford ord
      ON ord.ordemcarga = cab.ordemcarga
   WHERE ite.observacao IS NOT NULL
     AND cab.ordemcarga IN (:P_OC)
     AND COALESCE(ord.ad_formconc, 'N') IN (:SIT)
     AND cab.tipmov = 'P'
     AND cab.pendente = 'S'
   GROUP BY ite.codprod),
-- 9. Texto dos pedidos com observação por produto e ordem de carga.
--    LISTAGG substitui o PIVOT fixo de 20 pedidos; em caso de texto extenso,
--    ON OVERFLOW TRUNCATE evita ORA-01489 (Oracle 19c).
pedidos_com_observacao_texto AS
 (SELECT codprod,
         LISTAGG(
             'OC: ' || TO_CHAR(ordemcarga, 'FM999999') ||
             ' Ped: ' || TO_CHAR(nunota),
             ', ' ON OVERFLOW TRUNCATE '...' WITHOUT COUNT
         ) WITHIN GROUP (ORDER BY ordemcarga, nunota) AS pedcomobs
    FROM (SELECT DISTINCT
                 cab.ordemcarga,
                 ite.codprod,
                 ite.nunota
            FROM tgfite ite
            JOIN tgfcab cab
              ON cab.nunota = ite.nunota
            LEFT JOIN tgford ord
              ON ord.ordemcarga = cab.ordemcarga
           WHERE ite.observacao IS NOT NULL
             AND cab.ordemcarga > 0
             AND cab.ordemcarga IN (:P_OC)
             AND COALESCE(ord.ad_formconc, 'N') IN (:SIT)
             AND cab.tipmov = 'P'
             AND cab.pendente = 'S')
   GROUP BY codprod),
-- 12. Base agregada do relatório: Estoques são consultados uma única vez por produto, em vez de executar subqueries correlacionadas repetidamente para cada linha/expressão.
resumo_produto AS
 (SELECT to_char(lpad(gru.codgrupoprod, 10, 0), 'FM00G00G00G000') AS codgrupoprod,
         gru.descrgrupoprod,
         ite.codprod,
         pro.descrprod,
         obs_qtd.qtdpedobs,
         obs_txt.pedcomobs,
         pro.marca,
         oc.codpro_sa,
         oc.estsa,
         oc.codpro_pint,
         oc.estpint,
         SUM(ite.qtdneg - ite.qtdentregue - ite.qtdconferida) AS pendente,
         coalesce(est.estoque, 0) AS estoque,
         coalesce(est_def.estoque_def, 0) AS estoque_def,
         coalesce(est.estoque, 0) - coalesce(SUM(ite.qtdneg - ite.qtdentregue - ite.qtdconferida), 0) AS dif,
         CASE
            WHEN coalesce(est.estoque, 0) - coalesce(SUM(ite.qtdneg - ite.qtdentregue - ite.qtdconferida), 0) > 0 THEN
             'Sobrando'
            ELSE
             'Faltando'
         END AS situacao,
         SUM((ite.qtdneg - ite.qtdentregue - ite.qtdconferida) * (ite.ad_vlrliq / NULLIF(ite.qtdneg, 0))) AS vlttot,
         SUM((ite.qtdneg - ite.qtdentregue - ite.qtdconferida) * ite.ad_vlrunitfrete) AS frete,
         coalesce(pro.estmin, 0) AS estmin,
         CASE
            WHEN coalesce(est.estoque, 0) - coalesce(SUM(ite.qtdneg - ite.qtdentregue - ite.qtdconferida), 0) <= 0 THEN
             'RED'
            WHEN coalesce(est.estoque, 0) - coalesce(SUM(ite.qtdneg - ite.qtdentregue - ite.qtdconferida), 0) <=
                 pro.estmin THEN
             'YELLOW'
            ELSE
             'BLUE'
         END AS farol,
         oc.oca_01 AS oca_01,
         oc.qtd_01 AS qtd_01,
         oc.frt_01 AS frt_01,
         oc.mt3_01 AS mt3_01,
         oc.oca_02 AS oca_02,
         oc.qtd_02 AS qtd_02,
         oc.frt_02 AS frt_02,
         oc.mt3_02 AS mt3_02,
         oc.oca_03 AS oca_03,
         oc.qtd_03 AS qtd_03,
         oc.frt_03 AS frt_03,
         oc.mt3_03 AS mt3_03,
         oc.oca_04 AS oca_04,
         oc.qtd_04 AS qtd_04,
         oc.frt_04 AS frt_04,
         oc.mt3_04 AS mt3_04,
         oc.oca_05 AS oca_05,
         oc.qtd_05 AS qtd_05,
         oc.frt_05 AS frt_05,
         oc.mt3_05 AS mt3_05,
         oc.oca_06 AS oca_06,
         oc.qtd_06 AS qtd_06,
         oc.frt_06 AS frt_06,
         oc.mt3_06 AS mt3_06,
         oc.oca_07 AS oca_07,
         oc.qtd_07 AS qtd_07,
         oc.frt_07 AS frt_07,
         oc.mt3_07 AS mt3_07,
         oc.oca_08 AS oca_08,
         oc.qtd_08 AS qtd_08,
         oc.frt_08 AS frt_08,
         oc.mt3_08 AS mt3_08,
         oc.oca_09 AS oca_09,
         oc.qtd_09 AS qtd_09,
         oc.frt_09 AS frt_09,
         oc.mt3_09 AS mt3_09,
         oc.oca_10 AS oca_10,
         oc.qtd_10 AS qtd_10,
         oc.frt_10 AS frt_10,
         oc.mt3_10 AS mt3_10,
         oc.oca_11 AS oca_11,
         oc.qtd_11 AS qtd_11,
         oc.frt_11 AS frt_11,
         oc.mt3_11 AS mt3_11,
         oc.oca_12 AS oca_12,
         oc.qtd_12 AS qtd_12,
         oc.frt_12 AS frt_12,
         oc.mt3_12 AS mt3_12,
         oc.oca_13 AS oca_13,
         oc.qtd_13 AS qtd_13,
         oc.frt_13 AS frt_13,
         oc.mt3_13 AS mt3_13,
         oc.oca_14 AS oca_14,
         oc.qtd_14 AS qtd_14,
         oc.frt_14 AS frt_14,
         oc.mt3_14 AS mt3_14,
         oc.oca_15 AS oca_15,
         oc.qtd_15 AS qtd_15,
         oc.frt_15 AS frt_15,
         oc.mt3_15 AS mt3_15,
         oc.oca_16 AS oca_16,
         oc.qtd_16 AS qtd_16,
         oc.frt_16 AS frt_16,
         oc.mt3_16 AS mt3_16,
         oc.oca_17 AS oca_17,
         oc.qtd_17 AS qtd_17,
         oc.frt_17 AS frt_17,
         oc.mt3_17 AS mt3_17,
         oc.oca_18 AS oca_18,
         oc.qtd_18 AS qtd_18,
         oc.frt_18 AS frt_18,
         oc.mt3_18 AS mt3_18,
         oc.oca_19 AS oca_19,
         oc.qtd_19 AS qtd_19,
         oc.frt_19 AS frt_19,
         oc.mt3_19 AS mt3_19,
         oc.oca_20 AS oca_20,
         oc.qtd_20 AS qtd_20,
         oc.frt_20 AS frt_20,
         oc.mt3_20 AS mt3_20,
         oc.oca_21 AS oca_21,
         oc.qtd_21 AS qtd_21,
         oc.frt_21 AS frt_21,
         oc.mt3_21 AS mt3_21,
         oc.oca_22 AS oca_22,
         oc.qtd_22 AS qtd_22,
         oc.frt_22 AS frt_22,
         oc.mt3_22 AS mt3_22,
         oc.oca_23 AS oca_23,
         oc.qtd_23 AS qtd_23,
         oc.frt_23 AS frt_23,
         oc.mt3_23 AS mt3_23,
         oc.oca_24 AS oca_24,
         oc.qtd_24 AS qtd_24,
         oc.frt_24 AS frt_24,
         oc.mt3_24 AS mt3_24,
         oc.oca_25 AS oca_25,
         oc.qtd_25 AS qtd_25,
         oc.frt_25 AS frt_25,
         oc.mt3_25 AS mt3_25,
         oc.oca_26 AS oca_26,
         oc.qtd_26 AS qtd_26,
         oc.frt_26 AS frt_26,
         oc.mt3_26 AS mt3_26,
         oc.oca_27 AS oca_27,
         oc.qtd_27 AS qtd_27,
         oc.frt_27 AS frt_27,
         oc.mt3_27 AS mt3_27,
         oc.oca_28 AS oca_28,
         oc.qtd_28 AS qtd_28,
         oc.frt_28 AS frt_28,
         oc.mt3_28 AS mt3_28,
         oc.oca_29 AS oca_29,
         oc.qtd_29 AS qtd_29,
         oc.frt_29 AS frt_29,
         oc.mt3_29 AS mt3_29,
         oc.oca_30 AS oca_30,
         oc.qtd_30 AS qtd_30,
         oc.frt_30 AS frt_30,
         oc.mt3_30 AS mt3_30
    FROM tgfcab cab
    JOIN tgfite ite
      ON ite.nunota = cab.nunota
    JOIN tgfpro pro
      ON pro.codprod = ite.codprod
    JOIN tgfgru gru
      ON gru.codgrupoprod = pro.codgrupoprod
    LEFT JOIN tgford ord
      ON ord.ordemcarga = cab.ordemcarga
    LEFT JOIN pedidos_com_observacao_qtd obs_qtd
      ON obs_qtd.codprod = ite.codprod
    LEFT JOIN pedidos_com_observacao_texto obs_txt
      ON obs_txt.codprod = ite.codprod
    LEFT JOIN estoque_disponivel est
      ON est.codprod = ite.codprod
    LEFT JOIN estoque_definido est_def
      ON est_def.codprod = ite.codprod
    LEFT JOIN ordens_por_produto oc
      ON oc.codprod = ite.codprod
   WHERE cab.tipmov = 'P'
     AND cab.pendente = 'S'
     AND ite.pendente = 'S'
     AND cab.ordemcarga IN (:P_OC)
     AND coalesce(ord.ad_formconc, 'N') IN (:SIT)
   GROUP BY gru.codgrupoprod,
            gru.descrgrupoprod,
            ite.codprod,
            pro.descrprod,
            obs_qtd.qtdpedobs,
            obs_txt.pedcomobs,
            pro.marca,
            pro.estmin,
            oc.codpro_sa,
            oc.estsa,
            oc.codpro_pint,
            oc.estpint,
            est.estoque,
            est_def.estoque_def,
            oc.oca_01,
            oc.qtd_01,
            oc.frt_01,
            oc.mt3_01,
            oc.oca_02,
            oc.qtd_02,
            oc.frt_02,
            oc.mt3_02,
            oc.oca_03,
            oc.qtd_03,
            oc.frt_03,
            oc.mt3_03,
            oc.oca_04,
            oc.qtd_04,
            oc.frt_04,
            oc.mt3_04,
            oc.oca_05,
            oc.qtd_05,
            oc.frt_05,
            oc.mt3_05,
            oc.oca_06,
            oc.qtd_06,
            oc.frt_06,
            oc.mt3_06,
            oc.oca_07,
            oc.qtd_07,
            oc.frt_07,
            oc.mt3_07,
            oc.oca_08,
            oc.qtd_08,
            oc.frt_08,
            oc.mt3_08,
            oc.oca_09,
            oc.qtd_09,
            oc.frt_09,
            oc.mt3_09,
            oc.oca_10,
            oc.qtd_10,
            oc.frt_10,
            oc.mt3_10,
            oc.oca_11,
            oc.qtd_11,
            oc.frt_11,
            oc.mt3_11,
            oc.oca_12,
            oc.qtd_12,
            oc.frt_12,
            oc.mt3_12,
            oc.oca_13,
            oc.qtd_13,
            oc.frt_13,
            oc.mt3_13,
            oc.oca_14,
            oc.qtd_14,
            oc.frt_14,
            oc.mt3_14,
            oc.oca_15,
            oc.qtd_15,
            oc.frt_15,
            oc.mt3_15,
            oc.oca_16,
            oc.qtd_16,
            oc.frt_16,
            oc.mt3_16,
            oc.oca_17,
            oc.qtd_17,
            oc.frt_17,
            oc.mt3_17,
            oc.oca_18,
            oc.qtd_18,
            oc.frt_18,
            oc.mt3_18,
            oc.oca_19,
            oc.qtd_19,
            oc.frt_19,
            oc.mt3_19,
            oc.oca_20,
            oc.qtd_20,
            oc.frt_20,
            oc.mt3_20,
            oc.oca_21,
            oc.qtd_21,
            oc.frt_21,
            oc.mt3_21,
            oc.oca_22,
            oc.qtd_22,
            oc.frt_22,
            oc.mt3_22,
            oc.oca_23,
            oc.qtd_23,
            oc.frt_23,
            oc.mt3_23,
            oc.oca_24,
            oc.qtd_24,
            oc.frt_24,
            oc.mt3_24,
            oc.oca_25,
            oc.qtd_25,
            oc.frt_25,
            oc.mt3_25,
            oc.oca_26,
            oc.qtd_26,
            oc.frt_26,
            oc.mt3_26,
            oc.oca_27,
            oc.qtd_27,
            oc.frt_27,
            oc.mt3_27,
            oc.oca_28,
            oc.qtd_28,
            oc.frt_28,
            oc.mt3_28,
            oc.oca_29,
            oc.qtd_29,
            oc.frt_29,
            oc.mt3_29,
            oc.oca_30,
            oc.qtd_30,
            oc.frt_30,
            oc.mt3_30)
-- 13. Projeção final: mantém os nomes e a ordem das colunas do relatório. 
SELECT codgrupoprod,
       descrgrupoprod,
       codprod,
       descrprod,
       qtdpedobs,
       pedcomobs,
       marca,
       pendente,
       estoque,
       estoque_def,
       CASE
          WHEN dif >= 0 THEN
           dif
          ELSE
           0
       END AS difpos,
       CASE
          WHEN dif < 0 THEN
           dif
          ELSE
           0
       END AS difneg,
       situacao,
       codpro_sa,
       option_label('TGFPRO', 'AD_SET_PRODUCAO', (SELECT p.ad_set_producao FROM tgfpro p WHERE p.codprod = codpro_sa)) AS set_sa,
       estsa,
       codpro_pint,
       estpint,
       vlttot,
       frete,
       estmin,
       farol,
       oca_01,
       qtd_01,
       frt_01,
       mt3_01,
       oca_02,
       qtd_02,
       frt_02,
       mt3_02,
       oca_03,
       qtd_03,
       frt_03,
       mt3_03,
       oca_04,
       qtd_04,
       frt_04,
       mt3_04,
       oca_05,
       qtd_05,
       frt_05,
       mt3_05,
       oca_06,
       qtd_06,
       frt_06,
       mt3_06,
       oca_07,
       qtd_07,
       frt_07,
       mt3_07,
       oca_08,
       qtd_08,
       frt_08,
       mt3_08,
       oca_09,
       qtd_09,
       frt_09,
       mt3_09,
       oca_10,
       qtd_10,
       frt_10,
       mt3_10,
       oca_11,
       qtd_11,
       frt_11,
       mt3_11,
       oca_12,
       qtd_12,
       frt_12,
       mt3_12,
       oca_13,
       qtd_13,
       frt_13,
       mt3_13,
       oca_14,
       qtd_14,
       frt_14,
       mt3_14,
       oca_15,
       qtd_15,
       frt_15,
       mt3_15,
       oca_16,
       qtd_16,
       frt_16,
       mt3_16,
       oca_17,
       qtd_17,
       frt_17,
       mt3_17,
       oca_18,
       qtd_18,
       frt_18,
       mt3_18,
       oca_19,
       qtd_19,
       frt_19,
       mt3_19,
       oca_20,
       qtd_20,
       frt_20,
       mt3_20,
       oca_21,
       qtd_21,
       frt_21,
       mt3_21,
       oca_22,
       qtd_22,
       frt_22,
       mt3_22,
       oca_23,
       qtd_23,
       frt_23,
       mt3_23,
       oca_24,
       qtd_24,
       frt_24,
       mt3_24,
       oca_25,
       qtd_25,
       frt_25,
       mt3_25,
       oca_26,
       qtd_26,
       frt_26,
       mt3_26,
       oca_27,
       qtd_27,
       frt_27,
       mt3_27,
       oca_28,
       qtd_28,
       frt_28,
       mt3_28,
       oca_29,
       qtd_29,
       frt_29,
       mt3_29,
       oca_30,
       qtd_30,
       frt_30,
       mt3_30
  FROM resumo_produto
 ORDER BY codprod