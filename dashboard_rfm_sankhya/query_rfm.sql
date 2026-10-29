WITH
/* ============================================================
   DASHBOARD RFM - CLIENTES
   Período: últimos 6 meses completos até o último dia do mês
            anterior ao mês atual.
   Banco: Oracle 19c / Sankhya
   ============================================================ */
parametros_periodo AS (
    SELECT TRUNC(ADD_MONTHS(SYSDATE, -6), 'MM') AS dt_inicio,
           TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) AS dt_fim
      FROM dual
),
/* Tipos de operação válidos para a análise */
tops_validas AS (
    SELECT DISTINCT top.codtipoper, top.dhalter
      FROM tgftop top
     WHERE top.tipmov = 'P'
       AND COALESCE(top.orcamento, 'N') = 'N'
       AND top.codtipoper > 0
       AND top.atualfin = 1
),
/* Recência em dias e frequência por datas distintas de negociação */
metricas_recencia_frequencia AS (
    SELECT cab.codparc,
           p.dt_fim - MAX(cab.dtneg) AS qtd_recencia,
           COUNT(DISTINCT cab.dtneg) AS qtd_frequencia
      FROM tgfcab cab
      JOIN parametros_periodo p
        ON cab.dtneg >= p.dt_inicio
       AND cab.dtneg < p.dt_fim + 1
      JOIN tops_validas top
        ON top.codtipoper = cab.codtipoper
       AND top.dhalter = cab.dhtipoper
     GROUP BY cab.codparc, p.dt_fim
),
/* Valor monetário total no período */
metrica_monetaria AS (
    SELECT cab.codparc,
           SUM(ite.ad_vlrliq) AS valor_monetario
      FROM tgfcab cab
      JOIN tgfite ite ON ite.nunota = cab.nunota
      JOIN tops_validas top
        ON top.codtipoper = cab.codtipoper
       AND top.dhalter = cab.dhtipoper
      CROSS JOIN parametros_periodo p
     WHERE cab.dtneg >= p.dt_inicio
       AND cab.dtneg < p.dt_fim + 1
     GROUP BY cab.codparc
),
/* Universo de clientes ativos */
metricas_clientes AS (
    SELECT par.codparc,
           COALESCE(rf.qtd_recencia, 999999) AS qtd_recencia,
           COALESCE(rf.qtd_frequencia, 0) AS qtd_frequencia,
           COALESCE(mm.valor_monetario, 0) AS valor_monetario
      FROM tgfpar par
      LEFT JOIN metricas_recencia_frequencia rf
        ON rf.codparc = par.codparc
      LEFT JOIN metrica_monetaria mm
        ON mm.codparc = par.codparc
     WHERE par.ativo = 'S'
       AND par.codparc > 1
       AND par.cliente = 'S'
),
/* Notas de Recência, Frequência e Valor Monetário (1 a 5) */
pontuacao_rfm AS (
    SELECT mc.codparc,
           mc.qtd_recencia,
           CASE WHEN mc.qtd_recencia <= 30 THEN 5
                WHEN mc.qtd_recencia <= 60 THEN 4
                WHEN mc.qtd_recencia <= 90 THEN 3
                WHEN mc.qtd_recencia <= 120 THEN 2
                ELSE 1 END AS nota_recencia,
           mc.qtd_frequencia,
           CASE WHEN mc.qtd_frequencia >= 5 THEN 5
                WHEN mc.qtd_frequencia = 4 THEN 4
                WHEN mc.qtd_frequencia = 3 THEN 3
                WHEN mc.qtd_frequencia = 2 THEN 2
                ELSE 1 END AS nota_frequencia,
           mc.valor_monetario,
           CASE WHEN mc.valor_monetario >= 240000 THEN 5
                WHEN mc.valor_monetario >= 120000 THEN 4
                WHEN mc.valor_monetario >= 60000 THEN 3
                WHEN mc.valor_monetario > 20000 THEN 2
                ELSE 1 END AS nota_monetaria
      FROM metricas_clientes mc
),
/* Peso maior para o valor monetário: 70% */
media_ponderada AS (
    SELECT rfm.*,
           (rfm.nota_recencia * 0.10) +
           (rfm.nota_frequencia * 0.20) +
           (rfm.nota_monetaria * 0.70) AS media
      FROM pontuacao_rfm rfm
),
/* Segmentação de clientes por média ponderada */
classificacao_clientes AS (
    SELECT mp.*,
           CASE WHEN mp.media >= 4.01 THEN 'ALTA'
                WHEN mp.media >= 3.01 THEN 'MÉDIA ALTA'
                WHEN mp.media >= 2.01 THEN 'MÉDIA'
                WHEN mp.media >= 1.01 THEN 'BAIXA'
                ELSE 'QUALIFICAR' END AS classificacao
      FROM media_ponderada mp
)
/* Dataset final consumido pelo dashboard HTML5 */
SELECT grv.codvend AS codgrv,
       grv.apelido AS nomegrv,
       rca.codvend AS codrca,
       rca.apelido AS nomerca,
       par.codparc,
       par.razaosocial,
       cc.qtd_recencia,
       cc.nota_recencia,
       cc.qtd_frequencia,
       cc.nota_frequencia,
       cc.valor_monetario AS vlrmonetario,
       cc.nota_monetaria,
       cc.media,
       cc.classificacao AS classificacao
  FROM tgfpar par
  JOIN tgfven rca ON rca.codvend = par.codvend
  JOIN tgfven grv ON grv.codvend = rca.codger
  JOIN classificacao_clientes cc ON cc.codparc = par.codparc
 WHERE par.ativo = 'S'
   AND par.codparc > 1
   AND par.cliente = 'S'
 ORDER BY cc.media DESC, cc.valor_monetario DESC