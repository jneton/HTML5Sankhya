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

  <title>Itens do pedido selecionado</title>
  
</head>
<body>

  <div class="painel compacto">
    <h3>Itens do pedido selecionado</h3>
    <p class="subtitulo">Detalhamento dos produtos pendentes da nota selecionada.</p>
    
    <snk:query var="dados">
SELECT
       ite.nunota,
       ite.sequencia,
       ite.codprod,
       pro.descrprod,
       pro.m3,
       (ite.qtdneg - ite.qtdentregue - ite.qtdconferida) AS qtd_pendente,
       (ite.qtdneg - ite.qtdentregue - ite.qtdconferida)
         * (ite.ad_vlrliq / NULLIF(ite.qtdneg, 0)) AS valor_pendente,
       (ite.qtdneg - ite.qtdentregue - ite.qtdconferida)
         * ite.ad_vlrunitfrete AS valor_frete
  FROM tgfite ite
  JOIN tgfpro pro
    ON pro.codprod = ite.codprod
 WHERE ite.nunota = :A_NUNOTA
   AND ite.pendente = 'S'
 ORDER BY ite.sequencia
    </snk:query>
    <div class="tabela-wrap">
      <table>
        <thead><tr><th>Pedido</th><th>Seq.</th><th>Produto</th><th>Descrição</th><th>m³ unitário</th><th>Qtd. pendente</th><th>Valor pendente</th><th>Frete</th></tr></thead>
        <tbody>
          <c:forEach items="${dados.rows}" var="r">
            <tr><td class="numero"><c:out value="${r.NUNOTA}"/></td><td class="numero"><c:out value="${r.SEQUENCIA}"/></td><td class="numero"><c:out value="${r.CODPROD}"/></td><td class="descricao"><c:out value="${r.DESCRPROD}"/></td><td class="numero"><c:out value="${r.M3}"/></td><td class="numero"><c:out value="${r.QTD_PENDENTE}"/></td><td class="numero"><c:out value="${r.VALOR_PENDENTE}"/></td><td class="numero"><c:out value="${r.VALOR_FRETE}"/></td></tr>
          </c:forEach>
          <c:if test="${empty dados.rows}">
            <tr><td colspan="8" class="vazio">Selecione um registro ou ajuste os filtros para visualizar os dados.</td></tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>
</body>
</html>
