<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8" isELIgnored ="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
	<title>Painel Reunião Diária</title>
	<link rel="stylesheet" type="text/css" href="${BASE_FOLDER}/css/">
	<snk:load/> <!-- essa tag deve ficar nesta posição -->
	
	<script type='text/javascript'>
		function abrirContatos(codParc){
			var params = {'CODPARC' : codParc};
			refreshDetails('html5_ulnyo6', params);
		}
		
		function abrirFinanceiros(codParc){
			var params = {'CODPARC' : codParc};
			openLevel('lvl_ulnyo9', params);
		}
	</script>
</head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">



<snk:load/>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, Helvetica, sans-serif;
}

body{
    background:#f1f3f6;
    color:#333;
}

.header{
    background:#fff;
    padding:15px;
    text-align:center;
    border-bottom:2px solid #d9d9d9;
}

.header h1{
    font-size:32px;
    color:#3f3f3f;
}

.periodo, .setor {
    display: inline-block;
    margin-right: 10px;
}

.container{
    padding:15px;
}

.dashboard{
    display:grid;
    gap:15px;
}

.top{
    display:grid;
    grid-template-columns:40% 60%;
    gap:15px;
}

.middle{
    display:grid;
    grid-template-columns:20% 20% 30% 30%;
    gap:15px;
}

.bottom{
    display:grid;
    grid-template-columns:40% 60%;
    gap:15px;
}

.card{
    background:#fff;
    border:1px solid #dcdcdc;
    border-radius:4px;
    overflow:hidden;
}

.card-title{
    background:#f4f4f4;
    padding:10px;
    font-weight:bold;
    border-bottom:1px solid #ddd;
}

.card-body{
    padding:10px;
}

.chart-box{
    height:260px;
}

.small-chart{
    height:180px;
}

table{
    width:100%;
    border-collapse:collapse;
    font-size:12px;
}

th{
    background:#f5f5f5;
    padding:6px;
    border:1px solid #ddd;
}

td{
    padding:6px;
    border:1px solid #ddd;
}

.routines{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:20px;
}

.routines ul{
    list-style:none;
}

.routines li{
    padding:4px 0;
}

.kpis{
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:10px;
    margin-bottom:15px;
}

.kpi{
    background:#fff;
    border:1px solid #ddd;
    border-radius:4px;
    text-align:center;
    padding:15px;
}

.kpi-value{
    font-size:28px;
    font-weight:bold;
    color:#2f5597;
}

.kpi-label{
    margin-top:5px;
    font-size:13px;
}

@media(max-width:1200px){

    .top,
    .middle,
    .bottom{
        grid-template-columns:1fr;
    }

}

@media(max-width:768px){

    .kpis{
        grid-template-columns:1fr 1fr;
    }

    .routines{
        grid-template-columns:1fr;
    }

}

</style>
</head>
<body>

    <snk:query var="cabecalho">
        SELECT MESANO, DESCRICAO
        FROM (SELECT b.MESANO AS MESANO,
                    a.descset AS DESCRICAO 
                FROM (SELECT to_char(w.valor, 'FM00') AS codset,
                            w.opcao AS descset
                        FROM tddopc w
                        WHERE w.nucampo = 9999990191
                        AND to_char(w.valor, 'FM00') = :XSETOR
                        ORDER BY to_char(w.valor, 'FM00')) a
                        CROSS JOIN (SELECT :XDT AS xdt,
                                            upper(REPLACE(to_char(:XDT, 'Month/YYYY'), ' ', '')) AS MESANO
                                    FROM dual) b)

    </snk:query>

<div class="header">

    <h1>
        
        <c:forEach items="${cabecalho.rows}" var="row">
            <tr>
                <td><c:out value="${row.MESANO}" /></td>
                <td><c:out value="${row.DESCRICAO}" /></td>
            </tr>
        </c:forEach>

    </h1>

</div>

<div class="container">

    <div class="dashboard">

        <!-- TOPO -->

        <div class="top">

            <div class="card">
                <div class="card-title">% EFICIÊNCIA (MENSAL)</div>

                <div class="card-body">
                    <div class="chart-box">
                        <canvas id="efficiencyChart"></canvas>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-title">
                    QTD PRODUZIDA (1º TURNO)
                </div>

                <div class="card-body">
                    <div class="chart-box">
                        <canvas id="productionChart"></canvas>
                    </div>
                </div>
            </div>

        </div>

        <!-- MEIO -->

        <div class="middle">

            <div class="card">

                <div class="card-title">
                    QUALIDADE
                </div>

                <div class="card-body">
                    <div class="small-chart">
                        <canvas id="qualityChart"></canvas>
                    </div>
                </div>

            </div>

            <div class="card">

                <div class="card-title">
                    OCORRÊNCIAS NA OP
                </div>

                <div class="card-body">

                    <table>

                        <thead>
                        <tr>
                            <th>Classificação</th>
                            <th>Freq.</th>
                            <th>%</th>
                        </tr>
                        </thead>

                        <tbody>
                        <tr><td>Manutenção</td><td>15</td><td>7,5%</td></tr>
                        <tr><td>Retrabalho</td><td>16</td><td>12,5%</td></tr>
                        <tr><td>Falha Abastecimento</td><td>17</td><td>17,5%</td></tr>
                        <tr><td>Setup</td><td>18</td><td>22,5%</td></tr>
                        <tr><td>Ajustes</td><td>19</td><td>27,5%</td></tr>
                        <tr><td>Falta Funcionário</td><td>20</td><td>12,5%</td></tr>
                        </tbody>

                    </table>

                </div>

            </div>

            <div class="card">

                <div class="card-title">
                    RANKING DE O.S.
                </div>

                <div class="card-body">

                    <table>
                        <thead>
                        <tr>
                            <th>Equipamento</th>
                            <th>Qtd</th>
                        </tr>
                        </thead>

                        <tbody>
                        <tr><td>Equipamento Manutenção</td><td>12</td></tr>
                        <tr><td>Máquina Arquear</td><td>6</td></tr>
                        <tr><td>Bomba Centrífuga</td><td>3</td></tr>
                        <tr><td>Queimador</td><td>3</td></tr>
                        <tr><td>Outros</td><td>8</td></tr>
                        </tbody>

                    </table>

                </div>

            </div>

            <div class="card">

                <div class="card-title">
                    PLANO DE AÇÃO
                </div>

                <div class="card-body">

                    <table>

                        <thead>
                        <tr>
                            <th>Data</th>
                            <th>Ação</th>
                            <th>OS</th>
                            <th>Resp.</th>
                        </tr>
                        </thead>

                        <tbody>
                        <tr>
                            <td>17/03</td>
                            <td>Troca do Manômetro</td>
                            <td>5265</td>
                            <td>Paulo</td>
                        </tr>
                        </tbody>

                    </table>

                </div>

            </div>

        </div>

        <!-- BAIXO -->

        <div class="bottom">

            <div class="card">

                <div class="card-title">
                    MANUTENÇÃO (ORDENS DE SERVIÇO)
                </div>

                <div class="card-body">

                    <table>

                        <thead>
                        <tr>
                            <th>Status</th>
                            <th>Corretiva</th>
                            <th>Melhoria</th>
                            <th>Preventiva</th>
                            <th>Programada</th>
                            <th>Total</th>
                        </tr>
                        </thead>

                        <tbody>

                        <tr>
                            <td>Aguard. Atendimento</td>
                            <td>0</td>
                            <td>0</td>
                            <td>0</td>
                            <td>1</td>
                            <td>1</td>
                        </tr>

                        <tr>
                            <td>Em Atendimento</td>
                            <td>0</td>
                            <td>1</td>
                            <td>0</td>
                            <td>0</td>
                            <td>1</td>
                        </tr>

                        <tr>
                            <td>Finalizado</td>
                            <td>7</td>
                            <td>0</td>
                            <td>10</td>
                            <td>0</td>
                            <td>17</td>
                        </tr>

                        </tbody>

                    </table>

                </div>

            </div>

            <div class="card">

                <div class="card-title">
                    DESPERDÍCIOS / PERDA
                </div>

                <div class="card-body">

                    <div class="chart-box">
                        <canvas id="lossChart"></canvas>
                    </div>

                </div>

            </div>

        </div>

        <div class="card">

            <div class="card-title">
                ROTINAS NO SETOR
            </div>

            <div class="card-body">

                <div class="routines">

                    <ul>
                        <li>➜ Orientação Time</li>
                        <li>➜ Abastecimento D-1</li>
                        <li>➜ Controle Hora a Hora</li>
                        <li>➜ Segregação Diária</li>
                        <li>➜ Plano Produção</li>
                    </ul>

                    <ul>
                        <li>➜ DDS e DDQ</li>
                        <li>➜ Inspeção Pontos Críticos</li>
                        <li>➜ Premiação</li>
                        <li>➜ Pontos Manutenção</li>
                        <li>➜ Prioridades Produção</li>
                    </ul>

                    <ul>
                        <li>➜ Treinamento</li>
                        <li>➜ Feedback Individual</li>
                    </ul>

                </div>

            </div>

        </div>

    </div>

</div>

<script>

/* EFICIÊNCIA */

new Chart(
document.getElementById('efficiencyChart'),
{
    data:{
        labels:[
            'YTD','Jan','Fev','Mar',
            'Abr','Mai','Jun',
            'Jul','Ago','Set'
        ],
        datasets:[
        {
            type:'bar',
            label:'Eficiência',
            data:[
                85.4,88.1,89.7,
                73.7,73.3,86.7,
                88.4,90.8,88,81.1
            ],
            backgroundColor:[
                '#e67e22',
                '#4f81bd',
                '#4f81bd',
                '#4f81bd',
                '#4f81bd',
                '#4f81bd',
                '#4f81bd',
                '#4f81bd',
                '#4f81bd',
                '#4f81bd'
            ]
        },
        {
            type:'line',
            label:'Meta',
            data:[90,90,90,90,90,90,90,90,90,90],
            borderColor:'red',
            borderDash:[8,5],
            pointRadius:0,
            borderWidth:2
        }]
    },
    options:{
        responsive:true,
        maintainAspectRatio:false,
        scales:{
            y:{
                max:100,
                beginAtZero:true
            }
        }
    }
});

/* PRODUÇÃO */

new Chart(
document.getElementById('productionChart'),
{
    type:'bar',
    data:{
        labels:[
            '1S','2S','3S','4S',
            '1','2','5','6',
            '8','9','12','13',
            '14','15','16','19','20'
        ],
        datasets:[{
            data:[
                178,120,134,136,
                180,175,140,122,
                74,144,126,127,
                130,156,131,136,135
            ],
            backgroundColor:'#9bbb59'
        }]
    },
    options:{
        responsive:true,
        maintainAspectRatio:false,
        plugins:{
            legend:{
                display:false
            }
        }
    }
});

/* QUALIDADE */

new Chart(
document.getElementById('qualityChart'),
{
    type:'bar',
    data:{
        labels:[
            'Reprovado',
            'Retido',
            'Notificado'
        ],
        datasets:[{
            data:[1,2,5],
            backgroundColor:'#4f81bd'
        }]
    },
    options:{
        indexAxis:'y',
        responsive:true,
        maintainAspectRatio:false,
        plugins:{
            legend:{
                display:false
            }
        }
    }
});

/* DESPERDÍCIOS */

new Chart(
document.getElementById('lossChart'),
{
    type:'bar',
    data:{
        labels:[
            'Item 1',
            'Item 2',
            'Item 3',
            'Item 4',
            'Item 5',
            'Item 6'
        ],
        datasets:[{
            label:'R$',
            data:[
                3137,
                3136,
                3135,
                3134,
                3133,
                3132
            ],
            backgroundColor:'#c0504d'
        }]
    },
    options:{
        responsive:true,
        maintainAspectRatio:false
    }
});

</script>

</body>
</html>