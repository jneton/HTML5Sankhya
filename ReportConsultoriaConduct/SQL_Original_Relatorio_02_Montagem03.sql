WITH
parametros AS
 (SELECT trunc(to_date(:dtmes, 'DD/MM/YYYY'), 'MM') AS dt_inicio,
         add_months(trunc(to_date(:dtmes, 'DD/MM/YYYY'), 'MM'), 1) AS dt_fim,
         :xsetor AS setor,
         trunc(SYSDATE) AS dt_atual
    FROM dual),
dados_producao AS
 (SELECT trunc(apo.dhapo) AS dia,
         pro.codprod,
         pro.descrprod || pro.compldesc AS descproduto,
         SUM(apf.qtd) AS qtd
    FROM tpriproc ord
   INNER JOIN tpriatv atv
      ON atv.idiproc = ord.idiproc
   INNER JOIN tpripa ipa
      ON ipa.idiproc = atv.idiproc
   INNER JOIN tprapo apo
      ON apo.idiatv = atv.idiatv
   INNER JOIN tprapf apf
      ON apf.nuapo = apo.nuapo
   INNER JOIN tgfpro pro
      ON pro.codprod = ipa.codprodpa
   CROSS JOIN parametros p
   WHERE apo.dhapo >= p.dt_inicio
     AND apo.dhapo < p.dt_fim
     AND apo.dhapo < p.dt_atual + 1
     AND pro.ad_set_producao = p.setor
   GROUP BY trunc(apo.dhapo),
            pro.codprod,
            pro.descrprod || pro.compldesc),
matriz_producao AS
 (SELECT dp.codprod,
         dp.descproduto,
         /* Dia 01 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 1 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_01,
         /* Dia 02 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 2 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_02,
         /* Dia 03 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 3 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_03,
         /* Dia 04 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 4 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_04,
         /* Dia 05 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 5 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_05,
         /* Dia 06 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 6 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_06,
         /* Dia 07 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 7 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_07,
         /* Dia 08 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 8 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_08,
         /* Dia 09 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 9 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_09,
         /* Dia 10 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 10 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_10,
         /* Dia 11 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 11 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_11,
         /* Dia 12 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 12 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_12,
         /* Dia 13 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 13 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_13,
         /* Dia 14 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 14 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_14,
         /* Dia 15 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 15 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_15,
         /* Dia 16 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 16 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_16,
         /* Dia 17 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 17 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_17,
         /* Dia 18 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 18 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_18,
         /* Dia 19 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 19 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_19,
         /* Dia 20 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 20 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_20,
         /* Dia 21 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 21 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_21,
         /* Dia 22 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 22 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_22,
         /* Dia 23 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 23 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_23,
         /* Dia 24 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 24 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_24,
         /* Dia 25 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 25 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_25,
         /* Dia 26 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 26 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_26,
         /* Dia 27 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 27 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_27,
         /* Dia 28 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 28 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_28,
         /* Dia 29 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 29 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_29,
         /* Dia 30 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 30 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_30,
         /* Dia 31 */
         SUM(CASE
                WHEN extract(DAY FROM dp.dia) = 31 THEN
                 dp.qtd
                ELSE
                 0
             END) AS dia_31,
         /* Total produzido no periodo */
         SUM(dp.qtd) AS total_mes
    FROM dados_producao dp
   GROUP BY dp.codprod,
            dp.descproduto)
SELECT mp.codprod,
       mp.descproduto,
       CASE
          WHEN p.dt_inicio + 0 <= p.dt_atual THEN
           mp.dia_01
       END AS dia_01,
       CASE
          WHEN p.dt_inicio + 1 <= p.dt_atual THEN
           mp.dia_02
       END AS dia_02,
       CASE
          WHEN p.dt_inicio + 2 <= p.dt_atual THEN
           mp.dia_03
       END AS dia_03,
       CASE
          WHEN p.dt_inicio + 3 <= p.dt_atual THEN
           mp.dia_04
       END AS dia_04,
       CASE
          WHEN p.dt_inicio + 4 <= p.dt_atual THEN
           mp.dia_05
       END AS dia_05,
       CASE
          WHEN p.dt_inicio + 5 <= p.dt_atual THEN
           mp.dia_06
       END AS dia_06,
       CASE
          WHEN p.dt_inicio + 6 <= p.dt_atual THEN
           mp.dia_07
       END AS dia_07,
       CASE
          WHEN p.dt_inicio + 7 <= p.dt_atual THEN
           mp.dia_08
       END AS dia_08,
       CASE
          WHEN p.dt_inicio + 8 <= p.dt_atual THEN
           mp.dia_09
       END AS dia_09,
       CASE
          WHEN p.dt_inicio + 9 <= p.dt_atual THEN
           mp.dia_10
       END AS dia_10,
       CASE
          WHEN p.dt_inicio + 10 <= p.dt_atual THEN
           mp.dia_11
       END AS dia_11,
       CASE
          WHEN p.dt_inicio + 11 <= p.dt_atual THEN
           mp.dia_12
       END AS dia_12,
       CASE
          WHEN p.dt_inicio + 12 <= p.dt_atual THEN
           mp.dia_13
       END AS dia_13,
       CASE
          WHEN p.dt_inicio + 13 <= p.dt_atual THEN
           mp.dia_14
       END AS dia_14,
       CASE
          WHEN p.dt_inicio + 14 <= p.dt_atual THEN
           mp.dia_15
       END AS dia_15,
       CASE
          WHEN p.dt_inicio + 15 <= p.dt_atual THEN
           mp.dia_16
       END AS dia_16,
       CASE
          WHEN p.dt_inicio + 16 <= p.dt_atual THEN
           mp.dia_17
       END AS dia_17,
       CASE
          WHEN p.dt_inicio + 17 <= p.dt_atual THEN
           mp.dia_18
       END AS dia_18,
       CASE
          WHEN p.dt_inicio + 18 <= p.dt_atual THEN
           mp.dia_19
       END AS dia_19,
       CASE
          WHEN p.dt_inicio + 19 <= p.dt_atual THEN
           mp.dia_20
       END AS dia_20,
       CASE
          WHEN p.dt_inicio + 20 <= p.dt_atual THEN
           mp.dia_21
       END AS dia_21,
       CASE
          WHEN p.dt_inicio + 21 <= p.dt_atual THEN
           mp.dia_22
       END AS dia_22,
       CASE
          WHEN p.dt_inicio + 22 <= p.dt_atual THEN
           mp.dia_23
       END AS dia_23,
       CASE
          WHEN p.dt_inicio + 23 <= p.dt_atual THEN
           mp.dia_24
       END AS dia_24,
       CASE
          WHEN p.dt_inicio + 24 <= p.dt_atual THEN
           mp.dia_25
       END AS dia_25,
       CASE
          WHEN p.dt_inicio + 25 <= p.dt_atual THEN
           mp.dia_26
       END AS dia_26,
       CASE
          WHEN p.dt_inicio + 26 <= p.dt_atual THEN
           mp.dia_27
       END AS dia_27,
       CASE
          WHEN p.dt_inicio + 27 <= p.dt_atual THEN
           mp.dia_28
       END AS dia_28,
       CASE
          WHEN p.dt_inicio + 28 <= p.dt_atual THEN
           mp.dia_29
       END AS dia_29,
       CASE
          WHEN p.dt_inicio + 29 <= p.dt_atual THEN
           mp.dia_30
       END AS dia_30,
       CASE
          WHEN p.dt_inicio + 30 <= p.dt_atual THEN
           mp.dia_31
       END AS dia_31,
       mp.total_mes
  FROM matriz_producao mp
 CROSS JOIN parametros p
 ORDER BY mp.codprod
