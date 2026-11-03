WITH
/* ================================================================
   1. Parâmetros recebidos do Construtor de Dashboards
   ================================================================ */
parametros AS (
    SELECT TO_NUMBER(:XIDEFX) AS idefx_inicial,
           TO_NUMBER(:XCODPROD) AS codprod_inicial,
           :DT AS dt_referencia,
           :TP AS tipo_custo
      FROM dual
),

/* ================================================================
   2. Última estrutura cadastrada por produto pai.
      Mantida a regra original: maior IDEFX.
   ================================================================ */
ultima_estrutura AS (
    SELECT lmp.codprodpa,
           MAX(lmp.idefx) AS idefx
      FROM tprlmp lmp
     GROUP BY lmp.codprodpa
),

/* ================================================================
   3. Último registro de custo até a data de referência.
   ================================================================ */
custo_atual AS (
    SELECT cus.codprod,
           cus.cusmedicm,
           cus.cussemicm,
           cus.cusrep,
           cus.cusvariavel,
           cus.cusger,
           cus.cusmed,
           ROW_NUMBER() OVER (
               PARTITION BY cus.codprod
               ORDER BY cus.dtatual DESC
           ) AS rn
      FROM tgfcus cus
      CROSS JOIN parametros p
     WHERE cus.dtatual <= p.dt_referencia
),

/* ================================================================
   4. Seleção do tipo de custo solicitado.
   ================================================================ */
custos_produtos AS (
    SELECT pro.codprod,
           CASE p.tipo_custo
               WHEN '0' THEN cus.cusmedicm
               WHEN '1' THEN cus.cussemicm
               WHEN '2' THEN cus.cusrep
               WHEN '3' THEN cus.cusvariavel
               WHEN '4' THEN cus.cusger
               WHEN '5' THEN cus.cusmed
               WHEN '6' THEN pro.ad_custo_objetivo
           END AS custo_unitario
      FROM tgfpro pro
      CROSS JOIN parametros p
      LEFT JOIN custo_atual cus
        ON cus.codprod = pro.codprod
       AND cus.rn = 1
),

/* ================================================================
   5. Componentes e conversão da quantidade para a unidade da BOM.
   ================================================================ */
componentes AS (
    SELECT lmp.idefx,
           lmp.codprodpa,
           pai.descrprod AS descrprodpa,
           lmp.codprodmp,
           mp.descrprod AS descrprodmp,
           lmp.codvol,
           lmp.seqmp,
           CASE
               WHEN voa.dividemultiplica = 'M'
                   THEN lmp.qtdmistura * NVL(voa.quantidade, 1)
               ELSE lmp.qtdmistura / NULLIF(NVL(voa.quantidade, 1), 0)
           END AS quantidade,
           NVL(cus.custo_unitario, 0) AS custo_unitario
      FROM tprlmp lmp
      LEFT JOIN tgfpro pai
        ON pai.codprod = lmp.codprodpa
      LEFT JOIN tgfpro mp
        ON mp.codprod = lmp.codprodmp
      LEFT JOIN tgfvoa voa
        ON voa.codprod = lmp.codprodmp
       AND voa.codvol = lmp.codvol
      LEFT JOIN custos_produtos cus
        ON cus.codprod = lmp.codprodmp
),

/* ================================================================
   6. Explosão recursiva da estrutura até quatro níveis.
      O caminho evita ciclos e diferencia ocorrências repetidas do
      mesmo componente em sequências distintas.
   ================================================================ */
hierarquia (
    nivel, codproduto, descricao, seqmp, quantidade,
    quantidade_acumulada, custo_unitario, idefx,
    caminho, caminho_item
) AS (
    SELECT 1 AS nivel,
           pro.codprod,
           pro.descrprod,
           CAST(NULL AS NUMBER) AS seqmp,
           1 AS quantidade,
           1 AS quantidade_acumulada,
           NVL(cus.custo_unitario, 0) AS custo_unitario,
           p.idefx_inicial AS idefx,
           '/' || TO_CHAR(pro.codprod) || '/' AS caminho,
           '/R:' || TO_CHAR(pro.codprod) || '/' AS caminho_item
      FROM parametros p
      INNER JOIN tgfpro pro
        ON pro.codprod = p.codprod_inicial
      LEFT JOIN custos_produtos cus
        ON cus.codprod = pro.codprod

    UNION ALL

    SELECT h.nivel + 1,
           comp.codprodmp,
           comp.descrprodmp,
           comp.seqmp,
           comp.quantidade,
           h.quantidade_acumulada * comp.quantidade,
           comp.custo_unitario,
           comp.idefx,
           h.caminho || TO_CHAR(comp.codprodmp) || '/',
           h.caminho_item || 'S:' || NVL(TO_CHAR(comp.seqmp), '0') ||
               '-P:' || TO_CHAR(comp.codprodmp) || '/'
      FROM hierarquia h
      INNER JOIN componentes comp
        ON comp.codprodpa = h.codproduto
      LEFT JOIN ultima_estrutura ue
        ON ue.codprodpa = comp.codprodpa
      CROSS JOIN parametros p
     WHERE h.nivel < 4
       AND (
             (h.nivel = 1 AND comp.idefx = p.idefx_inicial)
          OR (h.nivel > 1 AND comp.idefx = ue.idefx)
       )
       AND INSTR(h.caminho, '/' || TO_CHAR(comp.codprodmp) || '/') = 0
),

/* ================================================================
   7. Identifica os nós folha e calcula o custo acumulado da folha.
   ================================================================ */
folhas_hierarquia AS (
    SELECT h.nivel,
           h.codproduto,
           h.descricao,
           h.seqmp,
           h.quantidade,
           h.quantidade_acumulada,
           h.custo_unitario,
           h.idefx,
           h.caminho,
           h.caminho_item,
           h.quantidade_acumulada * h.custo_unitario AS custo_folha
      FROM hierarquia h
     WHERE NOT EXISTS (
           SELECT 1
             FROM hierarquia filho
            WHERE filho.nivel = h.nivel + 1
              AND filho.caminho_item LIKE h.caminho_item || '%'
     )
),

/* ================================================================
   8. Reconstrói cada caminho completo da raiz até a folha.
   ================================================================ */
caminhos_completos AS (
    SELECT folha.caminho_item AS caminho_folha,
           folha.nivel AS profundidade,
           folha.custo_folha,
           nivel.nivel,
           nivel.codproduto,
           nivel.descricao,
           nivel.seqmp,
           nivel.quantidade,
           nivel.quantidade_acumulada,
           nivel.custo_unitario,
           nivel.caminho,
           nivel.caminho_item
      FROM folhas_hierarquia folha
      INNER JOIN hierarquia nivel
        ON folha.caminho_item LIKE nivel.caminho_item || '%'
),

/* ================================================================
   9. Transforma os níveis em colunas para apresentação tabular.
   ================================================================ */
composicao_pivot AS (
    SELECT caminho_folha,
           MAX(custo_folha) AS custo_folha,
           MAX(profundidade) AS profundidade,

           MAX(CASE WHEN nivel = 1 THEN codproduto END) AS codigo1,
           MAX(CASE WHEN nivel = 1 THEN descricao END) AS descricao1,
           MAX(CASE WHEN nivel = 1 THEN quantidade_acumulada END) AS qtd1,
           MAX(CASE WHEN nivel = 1 THEN custo_unitario END) AS custo1,
           MAX(CASE WHEN nivel = 1 THEN caminho_item END) AS caminho_item1,

           MAX(CASE WHEN nivel = 2 THEN codproduto END) AS codigo2,
           MAX(CASE WHEN nivel = 2 THEN descricao END) AS descricao2,
           MAX(CASE WHEN nivel = 2 THEN quantidade_acumulada END) AS qtd2,
           MAX(CASE WHEN nivel = 2 THEN custo_unitario END) AS custo2,
           MAX(CASE WHEN nivel = 2 THEN caminho_item END) AS caminho_item2,

           MAX(CASE WHEN nivel = 3 THEN codproduto END) AS codigo3,
           MAX(CASE WHEN nivel = 3 THEN descricao END) AS descricao3,
           MAX(CASE WHEN nivel = 3 THEN quantidade_acumulada END) AS qtd3,
           MAX(CASE WHEN nivel = 3 THEN custo_unitario END) AS custo3,
           MAX(CASE WHEN nivel = 3 THEN caminho_item END) AS caminho_item3,

           MAX(CASE WHEN nivel = 4 THEN codproduto END) AS codigo4,
           MAX(CASE WHEN nivel = 4 THEN descricao END) AS descricao4,
           MAX(CASE WHEN nivel = 4 THEN quantidade_acumulada END) AS qtd4,
           MAX(CASE WHEN nivel = 4 THEN custo_unitario END) AS custo4,
           MAX(CASE WHEN nivel = 4 THEN caminho_item END) AS caminho_item4
      FROM caminhos_completos
     GROUP BY caminho_folha
),

/* ================================================================
   10. Consolida o custo das folhas por ocorrência em cada nível.
   ================================================================ */
custos_consolidados AS (
    SELECT cp.*,
           SUM(custo_folha) OVER (PARTITION BY caminho_item1) AS custo_total1,
           SUM(custo_folha) OVER (PARTITION BY caminho_item2) AS custo_total2,
           SUM(custo_folha) OVER (PARTITION BY caminho_item3) AS custo_total3,
           SUM(custo_folha) OVER (PARTITION BY caminho_item4) AS custo_total4
      FROM composicao_pivot cp
),

/* ================================================================
   11. Numera as ocorrências para não repetir os dados dos níveis
       superiores em todas as linhas da composição.
   ================================================================ */
resultado_ordenado AS (
    SELECT cc.*,
           ROW_NUMBER() OVER (
               PARTITION BY caminho_item1 ORDER BY caminho_folha
           ) AS rn1,
           ROW_NUMBER() OVER (
               PARTITION BY caminho_item2 ORDER BY caminho_folha
           ) AS rn2,
           ROW_NUMBER() OVER (
               PARTITION BY caminho_item3 ORDER BY caminho_folha
           ) AS rn3,
           ROW_NUMBER() OVER (
               PARTITION BY caminho_item4 ORDER BY caminho_folha
           ) AS rn4
      FROM custos_consolidados cc
)

/* ================================================================
   12. Resultado final consumido pelo dashboard.
   ================================================================ */
SELECT
       CASE WHEN rn1 = 1 THEN codigo1 END AS codigo1,
       CASE WHEN rn1 = 1 THEN descricao1 END AS descricao1,
       CASE WHEN rn1 = 1 THEN qtd1 END AS qtd1,
       CASE WHEN rn1 = 1 THEN custo1 END AS custo1,
       CASE WHEN rn1 = 1 THEN custo_total1 END AS custo_total1,

       CASE WHEN profundidade >= 2 AND rn2 = 1 THEN codigo2 END AS codigo2,
       CASE WHEN profundidade >= 2 AND rn2 = 1 THEN descricao2 END AS descricao2,
       CASE WHEN profundidade >= 2 AND rn2 = 1 THEN qtd2 END AS qtd2,
       CASE WHEN profundidade >= 2 AND rn2 = 1 THEN custo2 END AS custo2,
       CASE WHEN profundidade >= 2 AND rn2 = 1 THEN custo_total2 END AS custo_total2,

       CASE WHEN profundidade >= 3 AND rn3 = 1 THEN codigo3 END AS codigo3,
       CASE WHEN profundidade >= 3 AND rn3 = 1 THEN descricao3 END AS descricao3,
       CASE WHEN profundidade >= 3 AND rn3 = 1 THEN qtd3 END AS qtd3,
       CASE WHEN profundidade >= 3 AND rn3 = 1 THEN custo3 END AS custo3,
       CASE WHEN profundidade >= 3 AND rn3 = 1 THEN custo_total3 END AS custo_total3,

       CASE WHEN profundidade >= 4 AND rn4 = 1 THEN codigo4 END AS codigo4,
       CASE WHEN profundidade >= 4 AND rn4 = 1 THEN descricao4 END AS descricao4,
       CASE WHEN profundidade >= 4 AND rn4 = 1 THEN qtd4 END AS qtd4,
       CASE WHEN profundidade >= 4 AND rn4 = 1 THEN custo4 END AS custo4,
       CASE WHEN profundidade >= 4 AND rn4 = 1 THEN custo_total4 END AS custo_total4
  FROM resultado_ordenado
 ORDER BY caminho_folha
