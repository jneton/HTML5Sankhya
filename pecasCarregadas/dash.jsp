<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"  isELIgnored ="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Painel de Peças Carregadas</title>

<snk:load/>

<style>

		<snk:query var="tabPcs">
            WITH dt AS
                (SELECT rownum AS i,
                        to_char((trunc(SYSDATE) - 6) - 1 + LEVEL, 'DY') AS dy,
                        (trunc(SYSDATE) - 6) - 1 + LEVEL AS dia
                    FROM dual
                CONNECT BY LEVEL <= (trunc(SYSDATE) + 1) - (trunc(SYSDATE) - 6)),
                produto AS
                (SELECT pro.codprod,
                        pro.referencia,
                        pro.descrprod || pro.compldesc AS descproduto,
                        pro.codgrupoprod
                    FROM tgfpro pro
                WHERE substr(pro.codgrupoprod, 1, 5) NOT IN ('40209'))
                SELECT dia,
                    total
                FROM (SELECT i,
                            to_char(dia, 'DD/MM/YYYY') || ' ' || dy AS dia,
                            lpad(to_char(SUM(qtd), 'FM99G990'), 6, ' ') || ' Pc(s)' AS total
                        FROM (SELECT t.i,
                                    t.dy,
                                    t.dia,
                                    coalesce(trunc(e.dtalter), t.dia) AS dtcarregado,
                                    g.ordemcarga,
                                    h.roteiro,
                                    g.nunota,
                                    f.referencia,
                                    f.descproduto,
                                    CASE
                                        WHEN g.ordemcarga IS NULL THEN
                                        0
                                        ELSE
                                        1
                                    END AS qtd,
                                    f.codgrupoprod
                                FROM dt t
                                LEFT JOIN tgfconser e
                                    ON t.dia = trunc(e.dtalter)
                                LEFT JOIN tgfcon2 d
                                    ON d.nuconf = e.nuconf
                                LEFT JOIN produto f
                                    ON e.codprod = f.codprod
                                LEFT JOIN tgfcab g
                                    ON d.nunotaorig = g.nunota
                                LEFT JOIN tgford h
                                    ON g.ordemcarga = h.ordemcarga
                                WHERE t.dia BETWEEN (trunc(SYSDATE) - 6) AND (trunc(SYSDATE) + 1))
                        GROUP BY (i, dia, dy, to_char(dtcarregado, 'IW'), to_char(dtcarregado, 'D')))
                ORDER BY i DESC
		</snk:query>

        <snk:query var="resumoDia">
            SELECT trunc(SYSDATE) AS dia,
                nvl(SUM(qtd), 0) AS total,
                nvl(COUNT(DISTINCT ordemcarga), 0) AS qtdoc
            FROM (SELECT g.ordemcarga,
                        h.roteiro,
                        g.nunota,
                        f.referencia,
                        (f.descrprod || f.compldesc) AS descproduto,
                        1 AS qtd,
                        f.codgrupoprod
                    FROM tgfconser e
                    INNER JOIN tgfcon2 d
                        ON d.nuconf = e.nuconf
                    INNER JOIN tgfpro f
                        ON e.codprod = f.codprod
                    INNER JOIN tgfcab g
                        ON d.nunotaorig = g.nunota
                    INNER JOIN tgford h
                        ON g.ordemcarga = h.ordemcarga
                    WHERE trunc(e.dtalter) = trunc(SYSDATE)
                    AND substr(f.codgrupoprod, 1, 5) NOT IN ('40209'))
		</snk:query>        

:root{
    --azul:#2563eb;
    --laranja:#f59e0b;
    --cinza:#6b7280;
    --fundo:#f3f4f6;
    --branco:#ffffff;
    --borda:#e5e7eb;
}

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Segoe UI, Arial, sans-serif;
}

body{
    background:var(--fundo);
    padding:10px;
}

/* ===============================
   TÍTULO
================================ */

.header{
    margin-bottom:10px;
}

.header h1{
    font-size:22px;
    color:#111827;
}

.header p{
    font-size:10px;
    color:var(--cinza);
}

/* ===============================
   CARDS
================================ */

.cards{
    display:flex;
    gap:10px;
    margin-bottom:10px;
}

.card{
    flex:1;
    max-width:140px;
    background:var(--branco);
    border-radius:8px;
    padding:10px;
    min-height:60px;
    box-shadow:0 1px 4px rgba(0,0,0,.08);
}

.card-pecas{
    border-left:4px solid var(--azul);
}

.card-cargas{
    border-left:4px solid var(--laranja);
}

.card-titulo{
    text-align:center;
    font-size:11px;
    font-weight:600;
    color:#4b5563;
}

.card-valor{
    text-align:center;
    font-size:16px;
    font-weight:bold;
    color:#111827;
    margin:6px 0;
}

.card-info{
    text-align:center;
    font-size:9px;
    color:var(--cinza);
}

/* ===============================
   TABELA
================================ */

.tabela{
    width:450px;
    background:var(--branco);
    border-radius:8px;
    overflow:hidden;
    box-shadow:0 1px 4px rgba(0,0,0,.08);
}

.tabela-titulo{
    background:var(--azul);
    color:white;
    padding:8px;
    font-size:11px;
    font-weight:bold;
}

table{
    width:100%;
    border-collapse:collapse;
}

thead{
    background:#eff6ff;
}

thead th{
    padding:6px;
    font-size:10px;
    border-bottom:1px solid var(--borda);
}

tbody td{
    padding:6px;
    font-size:10px;
    text-align:center;
    border-bottom:1px solid var(--borda);
}

.valor{
    font-weight:bold;
}

/* ===============================
   RESPONSIVO
================================ */

@media(max-width:768px){

    .cards{
        flex-direction:column;
    }

    .card{
        max-width:100%;
    }

    .tabela{
        width:100%;
    }

}

</style>

</head>

<body>

<div class="header">
    <h1>Painel de Peças Carregadas</h1>
    <p>Monitoramento Operacional</p>
</div>

<div class="cards">

    <c:forEach items="${resumoDia.rows}" var="row">

        <div class="card card-pecas">

            <div class="card-titulo">
                Peças Carregadas Hoje
            </div>

            <div class="card-valor">
                <c:out value="${row.TOTAL}" />
            </div>

            <div class="card-info">
                Quantidade carregada
            </div>

        </div>

        <div class="card card-cargas">

            <div class="card-titulo">
                Cargas em Andamento
            </div>

            <div class="card-valor">
                <c:out value="${row.QTDOC}" />
            </div>

            <div class="card-info">
                Carregamentos ativos
            </div>

        </div>

    </c:forEach>

</div>

<div class="tabela">

    <div class="tabela-titulo">
        Histórico de Carregamentos
    </div>

    <table>

        <thead>
            <tr>
                <th>Data</th>
                <th>Peças</th>
            </tr>
        </thead>

        <tbody>

            <c:forEach items="${tabPcs.rows}" var="row">
            <tr>
                <td><c:out value="${row.DIA}" /></td>
                <td class="valor"><c:out value="${row.TOTAL}" /></td>
            </tr>
            </c:forEach>
        </tbody>

    </table>

</div>

<script>

document.getElementById('pecasHoje').innerHTML =
    Number(12450).toLocaleString('pt-BR');

document.getElementById('cargas').innerHTML = 9;

</script>

</body>
</html>