<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Simulação de Custos de Produtos</title>
  <link rel="stylesheet" type="text/css" href="${BASE_FOLDER}/css/simulacaoCusto.css">
  <snk:load/>
  <script type="text/javascript">
    // Os filtros globais CODPROD, DT e TP são mantidos pelo próprio gadget.
    // Cada clique atualiza somente o ramo abaixo do componente selecionado.
    var produtoRaiz = '<c:out value="${CODPROD}"/>';
    var dataBase = '<c:out value="${DT}"/>';
    var tipoCusto = '<c:out value="${TP}"/>';
    var compA = '<c:out value="${A_CODPROD}"/>';
    var compB = '<c:out value="${B_CODPROD}"/>';
    var compC = '<c:out value="${C_CODPROD}"/>';

    function atualizarComposicao(nivel, codigo) {
      var params = {
        'A_CODPROD': (nivel <= 1 ? codigo : compA),
        'B_CODPROD': (nivel <= 2 ? '' : compB),
        'C_CODPROD': (nivel <= 3 ? '' : compC)
      };
      if (nivel === 2) { params.A_CODPROD = compA; params.B_CODPROD = codigo; }
      if (nivel === 3) { params.A_CODPROD = compA; params.B_CODPROD = compB; params.C_CODPROD = codigo; }
      refreshDetails('html5_sim_custo', params);
    }
    function limparNiveis() {
      refreshDetails('html5_sim_custo', {'A_CODPROD':'', 'B_CODPROD':'', 'C_CODPROD':''});
    }
  </script>
</head>
<body>
  <snk:query var="produto">
    SELECT p.CODPROD,
           p.REFERENCIA,
           p.DESCRPROD || p.COMPLDESC AS DESCRPROD,
           p.PESOBRUTO,
           g.DESCRGRUPOPROD,
           CASE :TP
             WHEN '0' THEN 'Custo com ICMS'
             WHEN '1' THEN 'Custo sem ICMS'
             WHEN '2' THEN 'Custo de reposição'
             WHEN '3' THEN 'Custo variável'
             WHEN '4' THEN 'Custo gerencial'
             WHEN '5' THEN 'Custo médio'
             WHEN '6' THEN 'Custo objetivo'
             ELSE 'Não informado'
           END AS TIPO_CUSTO
      FROM TGFPRO p
      LEFT JOIN TGFGRU g ON g.CODGRUPOPROD = p.CODGRUPOPROD
     WHERE p.CODPROD = :CODPROD
  </snk:query>

	<snk:query var="nivel1">
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
	</snk:query>

	<snk:query var="nivel2">
SELECT codgrupoprod, 
       descrgrupoprod, 
       codprod, 
       referencia, 
       descriprod, 
       pesobruto, 
       codprodmp, 
       descriprodmp, 
       qtd0, 
       sum(tcusto0) custo
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
                  WHEN tcusto1 IS NULL OR tcusto1 = 0 THEN
                   custo0
                  ELSE
                   tcusto1
               END custo0,
               (qtd0 * CASE
                  WHEN tcusto1 IS NULL OR tcusto1 = 0 THEN
                   custo0
                  ELSE
                   tcusto1
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
                                                         WHERE cus.codprod = case when substr(b.codgrupoprod,1,3) in (103) then a.codprod else d.codprodmp end
                                                           AND cus.dtatual = (SELECT MAX(c.dtatual)
                                                                                FROM tgfcus c
                                                                               WHERE c.codprod = case when substr(b.codgrupoprod,1,3) in (103) then a.codprod else d.codprodmp end
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
                                                                       AND cus.dtatual = (SELECT MAX(c.dtatual)
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
                                                                       AND cus.dtatual = (SELECT MAX(c.dtatual)
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
                                                                       AND cus.dtatual = (SELECT MAX(c.dtatual)
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
                                                                       AND cus.dtatual = (SELECT MAX(c.dtatual)
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
                                         WHERE a.codprod IN (:A_CODPROD)
                                         ORDER BY a.codprod, d.codprodmp, g.codprodmp, h.codprodmp)))))
group by codgrupoprod, 
         descrgrupoprod, 
         codprod, 
         referencia, 
         descriprod, 
         pesobruto, 
         codprodmp, 
         descriprodmp, 
         qtd0
order by codprodmp
	</snk:query>

	<snk:query var="nivel3">
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
                  WHEN tcusto1 IS NULL OR tcusto1 = 0 THEN
                   custo0
                  ELSE
                   tcusto1
               END custo0,
               (qtd0 * CASE
                  WHEN tcusto1 IS NULL OR tcusto1 = 0 THEN
                   custo0
                  ELSE
                   tcusto1
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
                                         WHERE a.codprod IN (:B_CODPROD)
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
	</snk:query>

	<snk:query var="nivel4">
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
                  WHEN tcusto1 IS NULL OR tcusto1 = 0 THEN
                   custo0
                  ELSE
                   tcusto1
               END custo0,
               (qtd0 * CASE
                  WHEN tcusto1 IS NULL OR tcusto1 = 0 THEN
                   custo0
                  ELSE
                   tcusto1
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
                                         WHERE a.codprod IN (:C_CODPROD)
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
	</snk:query>
  <div class="dashboard">
    <div class="cabecalho">
      <div class="titulo">SIMULAÇÃO DE CUSTOS DE PRODUTOS</div>
      <div class="linha-info">
        <strong>Produto:</strong> <c:out value="${produto.rows[0].CODPROD}"/> &nbsp;|&nbsp;
        <strong>Referência:</strong> <c:out value="${produto.rows[0].REFERENCIA}"/> &nbsp;|&nbsp;
        <strong>Grupo:</strong> <c:out value="${produto.rows[0].DESCRGRUPOPROD}"/>
      </div>
      <div class="linha-info descricao"><strong>Descrição:</strong> <c:out value="${produto.rows[0].DESCRPROD}"/> &nbsp;|&nbsp;
        <strong>Peso bruto:</strong> <c:out value="${produto.rows[0].PESOBRUTO}"/> &nbsp;|&nbsp;
        <strong>Tipo de custo:</strong> <c:out value="${produto.rows[0].TIPO_CUSTO}"/> &nbsp;|&nbsp;
        <strong>Data-base:</strong> <c:out value="${DT}"/>
      </div>
      <button class="btn-limpar" type="button" onclick="limparNiveis()">Limpar navegação dos níveis</button>
    </div>
    <div class="painel-grid">
      <section class="painel">
        <div class="painel-titulo">NÍVEL 1</div>
        <div class="tabela-wrap">
          <table>
            <thead><tr><th class="codigo">Código</th><th>Descrição</th><th class="numero">Qtd.</th><th class="numero">Custo</th><th class="acao"></th></tr></thead>
            <tbody>
              <c:set var="total1" value="0"/>
              <c:forEach items="${nivel1.rows}" var="row">
                <c:set var="total1" value="${total1 + row.CUSTO}"/>
                <tr>
                  <td class="codigo"><c:out value="${row.CODPRODMP}"/></td>
                  <td class="descricao-celula" title="${row.DESCRIPRODMP}"><c:out value="${row.DESCRIPRODMP}"/></td>
                  <td class="numero"><c:out value="${row.QTD0}"/></td>
                  <td class="numero"><c:out value="${row.CUSTO}"/></td>
                  <td class="acao"><button type="button" title="Abrir composição no próximo nível" onclick="atualizarComposicao(1, '<c:out value="${row.CODPRODMP}"/>')">›</button></td>
                </tr>
              </c:forEach>
            </tbody>
            <tfoot><tr><td colspan="3">Total do nível 1</td><td class="numero"><c:out value="${total1}"/></td><td></td></tr></tfoot>
          </table>
        </div>
      </section>
      <section class="painel">
        <div class="painel-titulo">NÍVEL 2</div>
        <div class="tabela-wrap">
          <table>
            <thead><tr><th class="codigo">Código</th><th>Descrição</th><th class="numero">Qtd.</th><th class="numero">Custo</th><th class="acao"></th></tr></thead>
            <tbody>
              <c:set var="total2" value="0"/>
              <c:forEach items="${nivel2.rows}" var="row">
                <c:set var="total2" value="${total2 + row.CUSTO}"/>
                <tr>
                  <td class="codigo"><c:out value="${row.CODPRODMP}"/></td>
                  <td class="descricao-celula" title="${row.DESCRIPRODMP}"><c:out value="${row.DESCRIPRODMP}"/></td>
                  <td class="numero"><c:out value="${row.QTD0}"/></td>
                  <td class="numero"><c:out value="${row.CUSTO}"/></td>
                  <td class="acao"><button type="button" title="Abrir composição no próximo nível" onclick="atualizarComposicao(2, '<c:out value="${row.CODPRODMP}"/>')">›</button></td>
                </tr>
              </c:forEach>
            </tbody>
            <tfoot><tr><td colspan="3">Total do nível 2</td><td class="numero"><c:out value="${total2}"/></td><td></td></tr></tfoot>
          </table>
        </div>
      </section>
      <section class="painel">
        <div class="painel-titulo">NÍVEL 3</div>
        <div class="tabela-wrap">
          <table>
            <thead><tr><th class="codigo">Código</th><th>Descrição</th><th class="numero">Qtd.</th><th class="numero">Custo</th><th class="acao"></th></tr></thead>
            <tbody>
              <c:set var="total3" value="0"/>
              <c:forEach items="${nivel3.rows}" var="row">
                <c:set var="total3" value="${total3 + row.CUSTO}"/>
                <tr>
                  <td class="codigo"><c:out value="${row.CODPRODMP}"/></td>
                  <td class="descricao-celula" title="${row.DESCRIPRODMP}"><c:out value="${row.DESCRIPRODMP}"/></td>
                  <td class="numero"><c:out value="${row.QTD0}"/></td>
                  <td class="numero"><c:out value="${row.CUSTO}"/></td>
                  <td class="acao"><button type="button" title="Abrir composição no próximo nível" onclick="atualizarComposicao(3, '<c:out value="${row.CODPRODMP}"/>')">›</button></td>
                </tr>
              </c:forEach>
            </tbody>
            <tfoot><tr><td colspan="3">Total do nível 3</td><td class="numero"><c:out value="${total3}"/></td><td></td></tr></tfoot>
          </table>
        </div>
      </section>
      <section class="painel">
        <div class="painel-titulo">NÍVEL 4</div>
        <div class="tabela-wrap">
          <table>
            <thead><tr><th class="codigo">Código</th><th>Descrição</th><th class="numero">Qtd.</th><th class="numero">Custo</th><th class="acao"></th></tr></thead>
            <tbody>
              <c:set var="total4" value="0"/>
              <c:forEach items="${nivel4.rows}" var="row">
                <c:set var="total4" value="${total4 + row.CUSTO}"/>
                <tr>
                  <td class="codigo"><c:out value="${row.CODPRODMP}"/></td>
                  <td class="descricao-celula" title="${row.DESCRIPRODMP}"><c:out value="${row.DESCRIPRODMP}"/></td>
                  <td class="numero"><c:out value="${row.QTD0}"/></td>
                  <td class="numero"><c:out value="${row.CUSTO}"/></td>
                  <td class="acao"></td>
                </tr>
              </c:forEach>
            </tbody>
            <tfoot><tr><td colspan="3">Total do nível 4</td><td class="numero"><c:out value="${total4}"/></td><td></td></tr></tfoot>
          </table>
        </div>
      </section>
    </div>
  </div>
</body>
</html>
