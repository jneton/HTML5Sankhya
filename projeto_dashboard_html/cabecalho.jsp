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

<title>Dashboard de Vendas</title>

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

/* HEADER */

.topo{
    width:100%;
    margin-bottom:24px;
}

.topo-card{
    background:linear-gradient(135deg,#111827,#1e3a8a);
    border-radius:22px;
    padding:32px;
    color:white;
    box-shadow:0 15px 40px rgba(0,0,0,0.12);
}

.topo-card h1{
    font-size:34px;
    font-weight:700;
    margin-bottom:10px;
}

.topo-card p{
    opacity:0.85;
    font-size:15px;
}

/* KPIS */

.kpis{
    margin-top:24px;
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:18px;
}

.kpi{
    background:white;
    border-radius:18px;
    padding:22px;
    box-shadow:0 4px 15px rgba(0,0,0,0.05);
    transition:0.3s;
}

.kpi:hover{
    transform:translateY(-4px);
}

.kpi small{
    color:#64748b;
    display:block;
    margin-bottom:8px;
}

.kpi h2{
    font-size:28px;
    margin-bottom:6px;
}

.kpi span{
    font-size:13px;
    color:#16a34a;
    font-weight:600;
}

/* TABELA */

.painel{
    margin-top:28px;
    background:white;
    border-radius:22px;
    box-shadow:0 5px 18px rgba(0,0,0,0.06);
    overflow:hidden;
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
    color:#0f172a;
}

.search{
    width:300px;
}

.search input{
    width:100%;
    padding:13px 16px;
    border-radius:12px;
    border:1px solid #dbe3ee;
    background:#f8fafc;
    outline:none;
    transition:0.3s;
}

.search input:focus{
    border-color:#2563eb;
    background:white;
}

/* TABELA */

.table-responsive{
    width:100%;
    overflow-x:auto;
}

table{
    width:100%;
    min-width:1100px;
    border-collapse:collapse;
}

thead{
    background:#f8fafc;
}

th{
    padding:18px;
    text-align:left;
    color:#475569;
    font-size:13px;
    font-weight:600;
    border-bottom:1px solid #e2e8f0;
}

td{
    padding:20px 18px;
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

.empresa{
    background:#eff6ff;
    color:#2563eb;
    padding:6px 12px;
    border-radius:999px;
    font-size:12px;
    font-weight:600;
    display:inline-block;
}

.valor{
    font-weight:700;
    color:#059669;
}

.btn{
    border:none;
    background:linear-gradient(135deg,#2563eb,#1d4ed8);
    color:white;
    padding:11px 18px;
    border-radius:12px;
    font-weight:600;
    cursor:pointer;
    transition:0.3s;
}

.btn:hover{
    transform:scale(1.03);
    box-shadow:0 6px 14px rgba(37,99,235,0.3);
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
        font-size:28px;
    }

    .painel-header{
        flex-direction:column;
        align-items:flex-start;
    }

    .search{
        width:100%;
    }

}

</style>


<script type='text/javascript'>
		function abrirDetalhes(nuNota){
			var params = {'NUNOTA' : nuNota};
			refreshDetails('html5_07M', params);
		}
		
	</script>

</head>
<body>


    <snk:query var="cabecalho">
		SELECT CAB.NUNOTA, CAB.NUMNOTA, PAR.CODPARC, PAR.NOMEPARC, EMP.CODEMP, EMP.RAZAOSOCIAL, CAB.VLRNOTA
        FROM TGFCAB CAB
        INNER JOIN TGFPAR PAR ON PAR.CODPARC = CAB.CODPARC
        INNER JOIN TSIEMP EMP ON EMP.CODEMP = CAB.CODEMP
        WHERE CAB.TIPMOV = 'V'
        AND CAB.STATUSNOTA = 'L'
        AND CAB.DTNEG BETWEEN :P_PERIODO.INI AND :P_PERIODO.FIN
	</snk:query>

<!-- TOPO -->

 <h1>Dashboard de Vendas</h1>

<!-- KPIS -->



<!-- TABELA -->

<section class="painel">

    <div class="painel-header">

        <h2>Lista de Vendas</h2>

        <div class="search">
            <input type="text" placeholder="Pesquisar cliente, NFE ou empresa...">
        </div>

    </div>

    <div class="table-responsive">

        <table>

            <thead>
                <tr>
                    <th>Nro. Único</th>
                    <th>Nro NFE</th>
                    <th>Cliente</th>
                    <th>Empresa</th>
                    <th>Valor Total</th>
                    <th>Ações</th>
                </tr>
            </thead>

            <tbody>

                <c:forEach items="${cabecalho.rows}" var="row">
                    <tr>
                        <td class="codigo"><c:out value="${row.NUNOTA}" /></td>
                        <td><c:out value="${row.NUMNOTA}" /></td>
                        <td><c:out value="${row.NOMEPARC}" /></td>
                        <td>
                            <span class="empresa">
                                <c:out value="${row.RAZAOSOCIAL}" />
                            </span>
                            </span>
                        </td>
                        <td class="valor">
                            <c:out value="${row.VLRNOTA}" />
                        </td>
                        <td>
                            <button class="btn" onclick="javascript:abrirDetalhes( ${row.NUNOTA} )">
                                Abrir Detalhes
                            </button>
                        </td>
                    </tr>
                </c:forEach>

                
            </tbody>

        </table>

    </div>

</section>

</body>
</html>