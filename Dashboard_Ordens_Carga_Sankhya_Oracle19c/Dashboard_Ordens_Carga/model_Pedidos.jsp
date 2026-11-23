<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="${BASE_FOLDER}/css/dashboardCSS.css">
  <snk:load/>

  <title>Pedidos por Ordem de Carga</title>
  <script>
    function abrirItensPedido(nunota) {
      openLevel('lvl_itens_pedido', {'A_NUNOTA': nunota});
    }
  </script>
</head>
<body>
  <div class="painel compacto">
    <h3>Pedidos pendentes por nota</h3>
    <p class="subtitulo">Selecione um pedido para abrir seus itens.</p>
    <snk:query var="dados">
SELECT
       cab.nunota,
       cab.ordemcarga,
       cab.dtneg,
       cab.codtipoper,
       parc.nomeparc,
       cid.nomecid,
       ufs.uf,
       SUM(pro.m3 * (ite.qtdneg - ite.qtdentregue - ite.qtdconferida)) AS volume_m3,
       SUM((ite.qtdneg - ite.qtdentregue - ite.qtdconferida)
           * (ite.ad_vlrliq / NULLIF(ite.qtdneg, 0))) AS valor_pendente,
       SUM((ite.qtdneg - ite.qtdentregue - ite.qtdconferida)
           * ite.ad_vlrunitfrete) AS valor_frete
  FROM tgfcab cab
  JOIN tgfite ite
    ON ite.nunota = cab.nunota
  JOIN tgfpro pro
    ON pro.codprod = ite.codprod
  JOIN tgfpar parc
    ON parc.codparc = cab.codparc
  LEFT JOIN tsicid cid
    ON cid.codcid = parc.codcid
  LEFT JOIN tsiufs ufs
    ON ufs.coduf = cid.uf
  LEFT JOIN tgford ord
    ON ord.ordemcarga = cab.ordemcarga
 WHERE cab.tipmov = 'P'
   AND cab.pendente = 'S'
   AND ite.pendente = 'S'
   AND cab.ordemcarga IN :P_OC
   AND COALESCE(ord.ad_formconc, 'N') IN :SIT
 GROUP BY cab.nunota,
          cab.ordemcarga,
          cab.dtneg,
          cab.codtipoper,
          parc.nomeparc,
          cid.nomecid,
          ufs.uf
 ORDER BY cab.ordemcarga, cab.nunota
    </snk:query>
    <div class="tabela-wrap">
      <table>
        <thead><tr>
          <th>Nº pedido</th><th>OC</th><th>Data</th><th>Tipo operação</th>
          <th>Parceiro</th><th>Cidade</th><th>UF</th><th>Volume m³</th>
          <th>Valor pendente</th><th>Frete</th><th>Itens</th>
        </tr></thead>
        <tbody>
          <c:forEach items="${dados.rows}" var="r">
            <tr>
              <td class="numero"><c:out value="${r.NUNOTA}"/></td>
              <td class="numero"><c:out value="${r.ORDEMCARGA}"/></td>
              <td><c:out value="${r.DTNEG}"/></td>
              <td class="numero"><c:out value="${r.CODTIPOPER}"/></td>
              <td class="descricao"><c:out value="${r.NOMEPARC}"/></td>
              <td><c:out value="${r.NOMECID}"/></td>
              <td><c:out value="${r.UF}"/></td>
              <td class="numero"><c:out value="${r.VOLUME_M3}"/></td>
              <td class="numero"><c:out value="${r.VALOR_PENDENTE}"/></td>
              <td class="numero"><c:out value="${r.VALOR_FRETE}"/></td>
              <td><button type="button" onclick="abrirItensPedido('${r.NUNOTA}')">Ver itens</button></td>
            </tr>
          </c:forEach>
          <c:if test="${empty dados.rows}">
            <tr><td colspan="11" class="vazio">Nenhum pedido pendente encontrado.</td></tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>
</body>
</html>
