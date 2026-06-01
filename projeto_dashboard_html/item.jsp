<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"  isELIgnored ="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>

<title>Dashboard de Vendas - Detalhes</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<snk:load/>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:'Inter',sans-serif;
    background:#eef2f7;
    color:#1e293b;
    padding:24px;
}

/* TOPO */

.topo{
    margin-bottom:24px;
}

.topo-card{
    background:linear-gradient(135deg,#0f172a,#1e40af);
    border-radius:22px;
    padding:32px;
    color:white;
    box-shadow:0 15px 40px rgba(0,0,0,0.12);
}

.topo-card h1{
    font-size:32px;
    margin-bottom:10px;
}

.topo-card p{
    opacity:0.85;
    font-size:15px;
    line-height:1.5;
}

/* INFO NF */

.info-grid{
    margin-top:24px;
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:18px;
}

.info-card{
    background:white;
    border-radius:18px;
    padding:22px;
    box-shadow:0 4px 15px rgba(0,0,0,0.05);
}

.info-card small{
    color:#64748b;
    display:block;
    margin-bottom:8px;
}

.info-card h2{
    font-size:24px;
    color:#0f172a;
}

.info-card span{
    display:block;
    margin-top:8px;
    color:#16a34a;
    font-size:13px;
    font-weight:600;
}

/* TABELA */

.painel{
    margin-top:28px;
    background:white;
    border-radius:22px;
    overflow:hidden;
    box-shadow:0 5px 18px rgba(0,0,0,0.06);
}

.painel-header{
    padding:24px 28px;
    border-bottom:1px solid #e2e8f0;

    display:flex;
    justify-content:space-between;
    align-items:center;
    flex-wrap:wrap;
    gap:14px;
}

.painel-header h2{
    font-size:22px;
}

.status{
    background:#dcfce7;
    color:#166534;
    padding:8px 14px;
    border-radius:999px;
    font-size:13px;
    font-weight:600;
}

.table-responsive{
    width:100%;
    overflow-x:auto;
}

table{
    width:100%;
    border-collapse:collapse;
    min-width:1100px;
}

thead{
    background:#f8fafc;
}

th{
    padding:18px;
    text-align:left;
    font-size:13px;
    color:#475569;
    border-bottom:1px solid #e2e8f0;
}

td{
    padding:18px;
    border-bottom:1px solid #edf2f7;
    font-size:14px;
}

tbody tr{
    transition:0.2s;
}

tbody tr:hover{
    background:#f8fbff;
}

.codigo{
    font-weight:700;
    color:#2563eb;
}

.produto{
    font-weight:600;
    color:#0f172a;
}

.quantidade{
    font-weight:700;
    color:#7c3aed;
}

.valor{
    font-weight:700;
    color:#059669;
}

.footer-total{
    background:#f8fafc;
}

.footer-total td{
    font-size:16px;
    font-weight:700;
}

/* RESPONSIVO */

@media(max-width:768px){

    body{
        padding:14px;
    }

    .topo-card{
        padding:24px;
    }

    .topo-card h1{
        font-size:26px;
    }

    .painel-header{
        flex-direction:column;
        align-items:flex-start;
    }

}

</style>
</head>
<body>

<!-- TOPO -->

    <snk:query var="itens">
		<%
			String query = "SELECT ITE.SEQUENCIA, ITE.CODPROD, PRO.DESCRPROD, ITE.QTDNEG, ITE.VLRUNIT, ITE.VLRTOT FROM TGFITE ITE INNER JOIN TGFPRO PRO ON ITE.CODPROD = PRO.CODPROD WHERE ";
			
			if(request.getAttribute("NUNOTA") != null) {
				query += " NUNOTA  = :NUNOTA ";
			} else {
				query += " 1 <> 1 ";
			}

			query += " order by SEQUENCIA asc ";

			out.println(query);
		%>
	</snk:query>



<section class="painel">

    <div class="painel-header">

        <h2> Itens da Nota Fiscal</h2>

        <div class="status">
            Nota Processada
        </div>

    </div>

    <div class="table-responsive">

        <table>

            <thead>

                <tr>
                    <th>Sequência</th>
                    <th>Cód. Produto</th>
                    <th>Produto</th>
                    <th>Quantidade</th>
                    <th>Vlr. Unitário</th>
                    <th>Vlr. Total</th>
                </tr>

            </thead>

            <tbody>

                <c:forEach items="${itens.rows}" var="row">
                    <tr>
                        <td class="codigo"><c:out value="${row.SEQUENCIA}" /></td>
                        <td><c:out value="${row.CODPROD}" /></td>
                        <td class="produto"><c:out value="${row.DESCRPROD}" /></td>
                        <td class="quantidade"><c:out value="${row.QTDNEG}" /></td>
                        <td>R$ <c:out value="${row.VLRUNIT}" /></td>
                        <td class="valor">R$ <c:out value="${row.VLRTOT}" /></td>
                    </tr>

                </c:forEach>

            </tbody>

        </table>

    </div>

</section>

</body>
</html>