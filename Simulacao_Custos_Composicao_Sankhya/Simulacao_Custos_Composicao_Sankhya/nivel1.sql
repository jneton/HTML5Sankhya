SELECT codgrupoprod,
       descrgrupoprod,
       codprod,
       referencia,
       descriprod,
       pesobruto,
       codprodmp,
       descriprodmp,
       qtd0,
       SUM(tcusto0) custo
  FROM (SELECT codgrupoprod,
               descrgrupoprod,
               codprod,
               referencia,
               descriprod,
               pesobruto,
               codprodmp,
               descriprodmp,
               qtd0,
               CASE
                  WHEN substr(codgrupoprod, 1, 3) = 403 THEN
                   custo0
                  ELSE
                   CASE
                      WHEN tcusto1 IS NULL OR tcusto1 = 0 THEN
                       custo0
                      ELSE
                       tcusto1
                   END
               END custo0,
               (qtd0 * CASE
                  WHEN tcusto1 IS NULL OR tcusto1 = 0 THEN
                   custo0
                  ELSE
                   CASE
                      WHEN substr(codgrupoprod, 1, 3) = 403 THEN
                       custo0
                      ELSE
                       tcusto1
                   END
               END) tcusto0,
               codcomposicao1,
               descricaoprod1,
               qtd1,
               custo1,
               tcusto1,
               codcomposicao2,
               descricaoprod2,
               qtd2,
               custo2,
               tcusto2,
               codcomposicao3,
               descricaoprod3,
               qtd3,
               custo3,
               tcusto3,
               codcomposicao4,
               descricaoprod4,
               qtd4,
               custo4
          FROM (SELECT codgrupoprod,
                       descrgrupoprod,
                       codprod,
                       referencia,
                       descriprod,
                       pesobruto,
                       codprodmp,
                       descriprodmp,
                       qtd0,
                       custo0,
                       codcomposicao1,
                       descricaoprod1,
                       qtd1,
                       CASE
                          WHEN tcusto2 IS NULL OR tcusto2 = 0 THEN
                           custo1
                          ELSE
                           tcusto2
                       END custo1,
                       (qtd1 * CASE
                          WHEN tcusto2 IS NULL OR tcusto2 = 0 THEN
                           custo1
                          ELSE
                           tcusto2
                       END) tcusto1,
                       codcomposicao2,
                       descricaoprod2,
                       qtd2,
                       custo2,
                       tcusto2,
                       codcomposicao3,
                       descricaoprod3,
                       qtd3,
                       custo3,
                       tcusto3,
                       codcomposicao4,
                       descricaoprod4,
                       qtd4,
                       custo4
                  FROM (SELECT codgrupoprod,
                               descrgrupoprod,
                               codprod,
                               referencia,
                               descriprod,
                               pesobruto,
                               codprodmp,
                               descriprodmp,
                               qtd0,
                               custo0,
                               codcomposicao1,
                               descricaoprod1,
                               qtd1,
                               custo1,
                               codcomposicao2,
                               descricaoprod2,
                               qtd2,
                               CASE
                                  WHEN tcusto3 IS NULL OR tcusto3 = 0 THEN
                                   custo2
                                  ELSE
                                   tcusto3
                               END custo2,
                               (qtd2 * CASE
                                  WHEN tcusto3 IS NULL OR tcusto3 = 0 THEN
                                   custo2
                                  ELSE
                                   tcusto3
                               END) tcusto2,
                               codcomposicao3,
                               descricaoprod3,
                               qtd3,
                               custo3,
                               tcusto3,
                               codcomposicao4,
                               descricaoprod4,
                               qtd4,
                               custo4
                          FROM (SELECT codgrupoprod,
                                       descrgrupoprod,
                                       codprod,
                                       referencia,
                                       descriprod,
                                       pesobruto,
                                       codprodmp,
                                       descriprodmp,
                                       qtd0,
                                       custo0,
                                       codcomposicao1,
                                       descricaoprod1,
                                       qtd1,
                                       custo1,
                                       codcomposicao2,
                                       descricaoprod2,
                                       qtd2,
                                       custo2,
                                       codcomposicao3,
                                       descricaoprod3,
                                       qtd3,
                                       CASE
                                          WHEN custo4 IS NULL OR custo4 = 0 THEN
                                           custo3
                                          ELSE
                                           custo4
                                       END custo3,
                                       qtd3 * CASE
                                          WHEN custo4 IS NULL OR custo4 = 0 THEN
                                           custo3
                                          ELSE
                                           custo4
                                       END tcusto3,
                                       codcomposicao4,
                                       descricaoprod4,
                                       qtd4,
                                       custo4
                                  FROM (SELECT b.codgrupoprod,
                                               b.descrgrupoprod,
                                               a.codprod,
                                               a.referencia,
                                               a.descrprod || a.compldesc descriprod,
                                               a.pesobruto,
                                               d.codprodmp,
                                               --rownum i,
                                               e.descrprod || e.compldesc descriprodmp,
                                               CASE
                                                  WHEN f.dividemultiplica = 'M' THEN
                                                   (d.qtdmistura * nvl(f.quantidade, 1))
                                                  ELSE
                                                   (d.qtdmistura / nvl(f.quantidade, 1))
                                               END qtd0,
                                               (SELECT CASE
                                                          WHEN :TP = '0' THEN
                                                           cusmedicm ---> Custo Com ICMS
                                                          WHEN :TP = '1' THEN
                                                           cussemicm ---> Custo Sem ICMS
                                                          WHEN :TP = '2' THEN
                                                           cusrep ---> Custo Reposição
                                                          WHEN :TP = '3' THEN
                                                           cusvariavel ---> Custo Variavel
                                                          WHEN :TP = '4' THEN
                                                           cusger ---> Custo Com Gerencial
                                                          WHEN :TP = '5' THEN
                                                           cusmed ---> Custo Médio
                                                          WHEN :TP = '6' THEN
                                                           ad_custo_objetivo ---> Custo Com ICMSValor Objetivo
                                                          ELSE
                                                           0
                                                       END custo
                                                  FROM (SELECT cus.codprod,
                                                               cus.dtatual,
                                                               cus.cusmedicm,
                                                               cus.cussemicm,
                                                               cus.cusrep,
                                                               cus.cusvariavel,
                                                               cus.cusger,
                                                               cus.cusmed,
                                                               pro.ad_custo_objetivo
                                                          FROM tgfcus cus
                                                         INNER JOIN tgfpro pro
                                                            ON cus.codprod = pro.codprod
                                                         WHERE cus.codprod = d.codprodmp
                                                           AND cus.dtatual = (SELECT MAX(c.dtatual)
                                                                                FROM tgfcus c
                                                                               WHERE c.codprod = d.codprodmp
                                                                                 AND c.dtatual <= :DT)
                                                         ORDER BY cus.dtatual DESC)) AS custo0,
                                               g.codprodmp AS codcomposicao1,
                                               g.descriprodmp AS descricaoprod1,
                                               g.qtd AS qtd1,
                                               g.custox AS custo1,
                                               h.codprodmp AS codcomposicao2,
                                               h.descriprodmp AS descricaoprod2,
                                               h.qtd AS qtd2,
                                               h.custox AS custo2,
                                               i.codprodmp AS codcomposicao3,
                                               i.descriprodmp AS descricaoprod3,
                                               i.qtd AS qtd3,
                                               i.custox AS custo3,
                                               j.codprodmp AS codcomposicao4,
                                               j.descriprodmp AS descricaoprod4,
                                               j.qtd AS qtd4,
                                               j.custox AS custo4
                                          FROM tgfpro a
                                         INNER JOIN tgfgru b
                                            ON a.codgrupoprod = b.codgrupoprod
                                          LEFT JOIN (SELECT d1.codprodpa,
                                                           MAX(d1.idefx) idefx
                                                      FROM tprlmp d1
                                                     INNER JOIN tpratv atv
                                                        ON d1.idefx = atv.idefx
                                                     INNER JOIN tprprc prc
                                                        ON atv.idproc = prc.idproc
                                                     WHERE prc.codprc NOT IN (30, 31)
                                                     GROUP BY d1.codprodpa) c
                                            ON a.codprod = c.codprodpa
                                          LEFT JOIN tprlmp d
                                            ON c.codprodpa = d.codprodpa
                                           AND c.idefx = d.idefx
                                          LEFT JOIN tgfpro e
                                            ON d.codprodmp = e.codprod
                                          LEFT JOIN tgfvoa f
                                            ON d.codprodmp = f.codprod
                                           AND d.codvol = f.codvol
                                          LEFT JOIN (SELECT b.codgrupoprod,
                                                           b.descrgrupoprod,
                                                           a.codprod,
                                                           a.descrprod || a.compldesc descriprod,
                                                           e.codgrupoprod codgrupoprodmp,
                                                           e.usoprod,
                                                           d.codprodmp,
                                                           e.descrprod || e.compldesc descriprodmp,
                                                           SUM(d.qtdmistura) qtdmistura,
                                                           d.codvol,
                                                           f.quantidade qtdformula,
                                                           f.dividemultiplica,
                                                           (CASE
                                                              WHEN f.dividemultiplica = 'M' THEN
                                                               SUM(d.qtdmistura * nvl(f.quantidade, 1))
                                                              ELSE
                                                               SUM(d.qtdmistura / nvl(f.quantidade, 1))
                                                           END) qtd,
                                                           (SELECT CASE
                                                                      WHEN :TP = '0' THEN
                                                                       cusmedicm ---> Custo Com ICMS
                                                                      WHEN :TP = '1' THEN
                                                                       cussemicm ---> Custo Sem ICMS
                                                                      WHEN :TP = '2' THEN
                                                                       cusrep ---> Custo Reposição
                                                                      WHEN :TP = '3' THEN
                                                                       cusvariavel ---> Custo Variavel
                                                                      WHEN :TP = '4' THEN
                                                                       cusger ---> Custo Com Gerencial
                                                                      WHEN :TP = '5' THEN
                                                                       cusmed ---> Custo Médio
                                                                      WHEN :TP = '6' THEN
                                                                       ad_custo_objetivo ---> Custo Com ICMSValor Objetivo
                                                                      ELSE
                                                                       0
                                                                   END custo
                                                              FROM (SELECT cus.codprod,
                                                                           cus.dtatual,
                                                                           cus.cusmedicm,
                                                                           cus.cussemicm,
                                                                           cus.cusrep,
                                                                           cus.cusvariavel,
                                                                           cus.cusger,
                                                                           cus.cusmed,
                                                                           pro.ad_custo_objetivo
                                                                      FROM tgfcus cus
                                                                     INNER JOIN tgfpro pro
                                                                        ON cus.codprod = pro.codprod
                                                                     WHERE cus.codprod = d.codprodmp
                                                                       AND cus.dtatual =
                                                                           (SELECT MAX(c.dtatual)
                                                                              FROM tgfcus c
                                                                             WHERE c.codprod = d.codprodmp
                                                                               AND c.dtatual <= :DT)
                                                                     ORDER BY cus.dtatual DESC)) custox
                                                      FROM tgfpro a
                                                     INNER JOIN tgfgru b
                                                        ON a.codgrupoprod = b.codgrupoprod
                                                      LEFT JOIN (SELECT d1.codprodpa,
                                                                       MAX(d1.idefx) idefx
                                                                  FROM tprlmp d1
                                                                 INNER JOIN tpratv atv
                                                                    ON d1.idefx = atv.idefx
                                                                 INNER JOIN tprprc prc
                                                                    ON atv.idproc = prc.idproc
                                                                 WHERE prc.codprc NOT IN (30, 31)
                                                                 GROUP BY d1.codprodpa) c
                                                        ON a.codprod = c.codprodpa
                                                      LEFT JOIN tprlmp d
                                                        ON c.codprodpa = d.codprodpa
                                                       AND c.idefx = d.idefx
                                                      LEFT JOIN tgfpro e
                                                        ON d.codprodmp = e.codprod
                                                      LEFT JOIN tgfvoa f
                                                        ON d.codprodmp = f.codprod
                                                       AND d.codvol = f.codvol
                                                     GROUP BY b.codgrupoprod,
                                                              b.descrgrupoprod,
                                                              a.codprod,
                                                              a.descrprod || a.compldesc,
                                                              e.codgrupoprod,
                                                              e.usoprod,
                                                              d.codprodmp,
                                                              e.descrprod || e.compldesc,
                                                              d.codvol,
                                                              f.quantidade,
                                                              f.dividemultiplica) g
                                            ON d.codprodmp = g.codprod
                                          LEFT JOIN (SELECT b.codgrupoprod,
                                                           b.descrgrupoprod,
                                                           a.codprod,
                                                           a.descrprod || a.compldesc descriprod,
                                                           e.codgrupoprod codgrupoprodmp,
                                                           e.usoprod,
                                                           d.codprodmp,
                                                           e.descrprod || e.compldesc descriprodmp,
                                                           SUM(d.qtdmistura) qtdmistura,
                                                           d.codvol,
                                                           f.quantidade qtdformula,
                                                           f.dividemultiplica,
                                                           (CASE
                                                              WHEN f.dividemultiplica = 'M' THEN
                                                               SUM(d.qtdmistura * nvl(f.quantidade, 1))
                                                              ELSE
                                                               SUM(d.qtdmistura / nvl(f.quantidade, 1))
                                                           END) qtd,
                                                           (SELECT CASE
                                                                      WHEN :TP = '0' THEN
                                                                       cusmedicm ---> Custo Com ICMS
                                                                      WHEN :TP = '1' THEN
                                                                       cussemicm ---> Custo Sem ICMS
                                                                      WHEN :TP = '2' THEN
                                                                       cusrep ---> Custo Reposição
                                                                      WHEN :TP = '3' THEN
                                                                       cusvariavel ---> Custo Variavel
                                                                      WHEN :TP = '4' THEN
                                                                       cusger ---> Custo Com Gerencial
                                                                      WHEN :TP = '5' THEN
                                                                       cusmed ---> Custo Médio
                                                                      WHEN :TP = '6' THEN
                                                                       ad_custo_objetivo ---> Custo Com ICMSValor Objetivo
                                                                      ELSE
                                                                       0
                                                                   END custo
                                                              FROM (SELECT cus.codprod,
                                                                           cus.dtatual,
                                                                           cus.cusmedicm,
                                                                           cus.cussemicm,
                                                                           cus.cusrep,
                                                                           cus.cusvariavel,
                                                                           cus.cusger,
                                                                           cus.cusmed,
                                                                           pro.ad_custo_objetivo
                                                                      FROM tgfcus cus
                                                                     INNER JOIN tgfpro pro
                                                                        ON cus.codprod = pro.codprod
                                                                     WHERE cus.codprod = d.codprodmp
                                                                       AND cus.dtatual =
                                                                           (SELECT MAX(c.dtatual)
                                                                              FROM tgfcus c
                                                                             WHERE c.codprod = d.codprodmp
                                                                               AND c.dtatual <= :DT)
                                                                     ORDER BY cus.dtatual DESC)) custox
                                                      FROM tgfpro a
                                                     INNER JOIN tgfgru b
                                                        ON a.codgrupoprod = b.codgrupoprod
                                                      LEFT JOIN (SELECT d1.codprodpa,
                                                                       MAX(d1.idefx) idefx
                                                                  FROM tprlmp d1
                                                                 INNER JOIN tpratv atv
                                                                    ON d1.idefx = atv.idefx
                                                                 INNER JOIN tprprc prc
                                                                    ON atv.idproc = prc.idproc
                                                                 WHERE prc.codprc NOT IN (30, 31)
                                                                 GROUP BY d1.codprodpa) c
                                                        ON a.codprod = c.codprodpa
                                                      LEFT JOIN tprlmp d
                                                        ON c.codprodpa = d.codprodpa
                                                       AND c.idefx = d.idefx
                                                      LEFT JOIN tgfpro e
                                                        ON d.codprodmp = e.codprod
                                                      LEFT JOIN tgfvoa f
                                                        ON d.codprodmp = f.codprod
                                                       AND d.codvol = f.codvol
                                                     GROUP BY b.codgrupoprod,
                                                              b.descrgrupoprod,
                                                              a.codprod,
                                                              a.descrprod || a.compldesc,
                                                              e.codgrupoprod,
                                                              e.usoprod,
                                                              d.codprodmp,
                                                              e.descrprod || e.compldesc,
                                                              d.codvol,
                                                              f.quantidade,
                                                              f.dividemultiplica) h
                                            ON g.codprodmp = h.codprod
                                          LEFT JOIN (SELECT b.codgrupoprod,
                                                           b.descrgrupoprod,
                                                           a.codprod,
                                                           a.descrprod || a.compldesc descriprod,
                                                           e.codgrupoprod codgrupoprodmp,
                                                           e.usoprod,
                                                           d.codprodmp,
                                                           e.descrprod || e.compldesc descriprodmp,
                                                           SUM(d.qtdmistura) qtdmistura,
                                                           d.codvol,
                                                           f.quantidade qtdformula,
                                                           f.dividemultiplica,
                                                           (CASE
                                                              WHEN f.dividemultiplica = 'M' THEN
                                                               SUM(d.qtdmistura * nvl(f.quantidade, 1))
                                                              ELSE
                                                               SUM(d.qtdmistura / nvl(f.quantidade, 1))
                                                           END) qtd,
                                                           (SELECT CASE
                                                                      WHEN :TP = '0' THEN
                                                                       cusmedicm ---> Custo Com ICMS
                                                                      WHEN :TP = '1' THEN
                                                                       cussemicm ---> Custo Sem ICMS
                                                                      WHEN :TP = '2' THEN
                                                                       cusrep ---> Custo Reposição
                                                                      WHEN :TP = '3' THEN
                                                                       cusvariavel ---> Custo Variavel
                                                                      WHEN :TP = '4' THEN
                                                                       cusger ---> Custo Com Gerencial
                                                                      WHEN :TP = '5' THEN
                                                                       cusmed ---> Custo Médio
                                                                      WHEN :TP = '6' THEN
                                                                       ad_custo_objetivo ---> Custo Com ICMSValor Objetivo
                                                                      ELSE
                                                                       0
                                                                   END custo
                                                              FROM (SELECT cus.codprod,
                                                                           cus.dtatual,
                                                                           cus.cusmedicm,
                                                                           cus.cussemicm,
                                                                           cus.cusrep,
                                                                           cus.cusvariavel,
                                                                           cus.cusger,
                                                                           cus.cusmed,
                                                                           pro.ad_custo_objetivo
                                                                      FROM tgfcus cus
                                                                     INNER JOIN tgfpro pro
                                                                        ON cus.codprod = pro.codprod
                                                                     WHERE cus.codprod = d.codprodmp
                                                                       AND cus.dtatual =
                                                                           (SELECT MAX(c.dtatual)
                                                                              FROM tgfcus c
                                                                             WHERE c.codprod = d.codprodmp
                                                                               AND c.dtatual <= :DT)
                                                                     ORDER BY cus.dtatual DESC)) custox
                                                      FROM tgfpro a
                                                     INNER JOIN tgfgru b
                                                        ON a.codgrupoprod = b.codgrupoprod
                                                      LEFT JOIN (SELECT d1.codprodpa,
                                                                       MAX(d1.idefx) idefx
                                                                  FROM tprlmp d1
                                                                 INNER JOIN tpratv atv
                                                                    ON d1.idefx = atv.idefx
                                                                 INNER JOIN tprprc prc
                                                                    ON atv.idproc = prc.idproc
                                                                 WHERE prc.codprc NOT IN (30, 31)
                                                                 GROUP BY d1.codprodpa) c
                                                        ON a.codprod = c.codprodpa
                                                      LEFT JOIN tprlmp d
                                                        ON c.codprodpa = d.codprodpa
                                                       AND c.idefx = d.idefx
                                                      LEFT JOIN tgfpro e
                                                        ON d.codprodmp = e.codprod
                                                      LEFT JOIN tgfvoa f
                                                        ON d.codprodmp = f.codprod
                                                       AND d.codvol = f.codvol
                                                     GROUP BY b.codgrupoprod,
                                                              b.descrgrupoprod,
                                                              a.codprod,
                                                              a.descrprod || a.compldesc,
                                                              e.codgrupoprod,
                                                              e.usoprod,
                                                              d.codprodmp,
                                                              e.descrprod || e.compldesc,
                                                              d.codvol,
                                                              f.quantidade,
                                                              f.dividemultiplica) i
                                            ON h.codprodmp = i.codprod
                                          LEFT JOIN (SELECT b.codgrupoprod,
                                                           b.descrgrupoprod,
                                                           a.codprod,
                                                           a.descrprod || a.compldesc descriprod,
                                                           e.codgrupoprod codgrupoprodmp,
                                                           e.usoprod,
                                                           d.codprodmp,
                                                           e.descrprod || e.compldesc descriprodmp,
                                                           SUM(d.qtdmistura) qtdmistura,
                                                           d.codvol,
                                                           f.quantidade qtdformula,
                                                           f.dividemultiplica,
                                                           (CASE
                                                              WHEN f.dividemultiplica = 'M' THEN
                                                               SUM(d.qtdmistura * nvl(f.quantidade, 1))
                                                              ELSE
                                                               SUM(d.qtdmistura / nvl(f.quantidade, 1))
                                                           END) qtd,
                                                           (SELECT CASE
                                                                      WHEN :TP = '0' THEN
                                                                       cusmedicm ---> Custo Com ICMS
                                                                      WHEN :TP = '1' THEN
                                                                       cussemicm ---> Custo Sem ICMS
                                                                      WHEN :TP = '2' THEN
                                                                       cusrep ---> Custo Reposição
                                                                      WHEN :TP = '3' THEN
                                                                       cusvariavel ---> Custo Variavel
                                                                      WHEN :TP = '4' THEN
                                                                       cusger ---> Custo Com Gerencial
                                                                      WHEN :TP = '5' THEN
                                                                       cusmed ---> Custo Médio
                                                                      WHEN :TP = '6' THEN
                                                                       ad_custo_objetivo ---> Custo Com ICMSValor Objetivo
                                                                      ELSE
                                                                       0
                                                                   END custo
                                                              FROM (SELECT cus.codprod,
                                                                           cus.dtatual,
                                                                           cus.cusmedicm,
                                                                           cus.cussemicm,
                                                                           cus.cusrep,
                                                                           cus.cusvariavel,
                                                                           cus.cusger,
                                                                           cus.cusmed,
                                                                           pro.ad_custo_objetivo
                                                                      FROM tgfcus cus
                                                                     INNER JOIN tgfpro pro
                                                                        ON cus.codprod = pro.codprod
                                                                     WHERE cus.codprod = d.codprodmp
                                                                       AND cus.dtatual =
                                                                           (SELECT MAX(c.dtatual)
                                                                              FROM tgfcus c
                                                                             WHERE c.codprod = d.codprodmp
                                                                               AND c.dtatual <= :DT)
                                                                     ORDER BY cus.dtatual DESC)) custox
                                                      FROM tgfpro a
                                                     INNER JOIN tgfgru b
                                                        ON a.codgrupoprod = b.codgrupoprod
                                                      LEFT JOIN (SELECT d1.codprodpa,
                                                                       MAX(d1.idefx) idefx
                                                                  FROM tprlmp d1
                                                                 INNER JOIN tpratv atv
                                                                    ON d1.idefx = atv.idefx
                                                                 INNER JOIN tprprc prc
                                                                    ON atv.idproc = prc.idproc
                                                                 WHERE prc.codprc NOT IN (30, 31)
                                                                 GROUP BY d1.codprodpa) c
                                                        ON a.codprod = c.codprodpa
                                                      LEFT JOIN tprlmp d
                                                        ON c.codprodpa = d.codprodpa
                                                       AND c.idefx = d.idefx
                                                      LEFT JOIN tgfpro e
                                                        ON d.codprodmp = e.codprod
                                                      LEFT JOIN tgfvoa f
                                                        ON d.codprodmp = f.codprod
                                                       AND d.codvol = f.codvol
                                                     GROUP BY b.codgrupoprod,
                                                              b.descrgrupoprod,
                                                              a.codprod,
                                                              a.descrprod || a.compldesc,
                                                              e.codgrupoprod,
                                                              e.usoprod,
                                                              d.codprodmp,
                                                              e.descrprod || e.compldesc,
                                                              d.codvol,
                                                              f.quantidade,
                                                              f.dividemultiplica) j
                                            ON i.codprodmp = j.codprod
                                         WHERE a.codprod IN (:CODPROD)
                                         ORDER BY a.codprod,
                                                  d.codprodmp,
                                                  g.codprodmp,
                                                  h.codprodmp)))))
 GROUP BY codgrupoprod,
          descrgrupoprod,
          codprod,
          referencia,
          descriprod,
          pesobruto,
          codprodmp,
          descriprodmp,
          qtd0
 ORDER BY codprodmp
