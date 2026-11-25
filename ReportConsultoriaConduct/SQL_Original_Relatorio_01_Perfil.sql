WITH
parametros AS
 (SELECT to_date(:dtmes, 'DD/MM/YYYY') AS data_referencia,
         trunc(SYSDATE) AS data_atual,
         1 AS codemp
    FROM dual),
periodo AS
 (SELECT last_day(add_months(data_referencia, -1)) + 1 AS data_inicio,
         last_day(data_referencia) AS data_fim,
         codemp,
         data_atual
    FROM parametros),
calendario AS
 (SELECT periodo.data_inicio + LEVEL - 1 AS dia
    FROM periodo
  CONNECT BY LEVEL <= periodo.data_fim - periodo.data_inicio + 1),
produtos AS
 (SELECT pro.codgrupoprod,
         gru.descrgrupoprod,
         pro.codprod,
         pro.descrprod || pro.compldesc AS descproduto
    FROM tgfpro pro
   INNER JOIN tgfgru gru
      ON gru.codgrupoprod = pro.codgrupoprod
   WHERE substr(pro.codgrupoprod, 1, 1) = '6'),
estoque_atual AS
 (SELECT est.codprod,
         SUM(est.estoque) AS quantidade_atual
    FROM tgfest est
   INNER JOIN produtos pro
      ON pro.codprod = est.codprod
   CROSS JOIN periodo per
   WHERE est.codemp = per.codemp
   GROUP BY est.codprod),
produto_dia AS
 (SELECT pro.codgrupoprod,
         pro.descrgrupoprod,
         pro.codprod,
         pro.descproduto,
         cal.dia
    FROM produtos pro
   CROSS JOIN calendario cal),
movimentacoes_posteriores AS
 (SELECT pd.codprod,
         pd.dia,
         SUM(ese.qtdneg * ese.atualestoque) AS quantidade_movimentada
    FROM produto_dia pd
   CROSS JOIN periodo per
    LEFT JOIN tgfese ese
      ON ese.codemp = per.codemp
     AND ese.codprod = pd.codprod
     AND ese.dtreferencia > pd.dia
   GROUP BY pd.codprod,
            pd.dia),
estoque_diario AS
 (SELECT pd.codgrupoprod,
         pd.descrgrupoprod,
         pd.codprod,
         pd.descproduto,
         pd.dia,
         CASE
            WHEN pd.dia > per.data_atual THEN
             NULL
            WHEN pd.dia < per.data_atual THEN
             nvl(ea.quantidade_atual, 0) - nvl(mp.quantidade_movimentada, 0)
            ELSE
             nvl(ea.quantidade_atual, 0)
         END AS estoque
    FROM produto_dia pd
   CROSS JOIN periodo per
    LEFT JOIN estoque_atual ea
      ON ea.codprod = pd.codprod
    LEFT JOIN movimentacoes_posteriores mp
      ON mp.codprod = pd.codprod
     AND mp.dia = pd.dia)
SELECT codgrupoprod,
       descrgrupoprod,
       codprod,
       descproduto,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 1 THEN
               estoque
           END) AS d01,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 2 THEN
               estoque
           END) AS d02,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 3 THEN
               estoque
           END) AS d03,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 4 THEN
               estoque
           END) AS d04,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 5 THEN
               estoque
           END) AS d05,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 6 THEN
               estoque
           END) AS d06,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 7 THEN
               estoque
           END) AS d07,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 8 THEN
               estoque
           END) AS d08,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 9 THEN
               estoque
           END) AS d09,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 10 THEN
               estoque
           END) AS d10,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 11 THEN
               estoque
           END) AS d11,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 12 THEN
               estoque
           END) AS d12,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 13 THEN
               estoque
           END) AS d13,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 14 THEN
               estoque
           END) AS d14,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 15 THEN
               estoque
           END) AS d15,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 16 THEN
               estoque
           END) AS d16,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 17 THEN
               estoque
           END) AS d17,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 18 THEN
               estoque
           END) AS d18,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 19 THEN
               estoque
           END) AS d19,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 20 THEN
               estoque
           END) AS d20,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 21 THEN
               estoque
           END) AS d21,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 22 THEN
               estoque
           END) AS d22,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 23 THEN
               estoque
           END) AS d23,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 24 THEN
               estoque
           END) AS d24,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 25 THEN
               estoque
           END) AS d25,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 26 THEN
               estoque
           END) AS d26,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 27 THEN
               estoque
           END) AS d27,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 28 THEN
               estoque
           END) AS d28,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 29 THEN
               estoque
           END) AS d29,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 30 THEN
               estoque
           END) AS d30,
       MAX(CASE
              WHEN extract(DAY FROM dia) = 31 THEN
               estoque
           END) AS d31
  FROM estoque_diario
 GROUP BY codgrupoprod,
          descrgrupoprod,
          codprod,
          descproduto
 ORDER BY codgrupoprod,
          codprod
