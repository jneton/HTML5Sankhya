<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8" isELIgnored="false" %>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <%@ page import="java.util.*" %>
        <%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
            <%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
                <!DOCTYPE html>
                <html lang="pt-BR">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">

                    <title>PAINEL DE REUNIÃO DIARIA</title>
                    
                    <script>
                         var arr = [{value:"${XDT}", type:"D"}]
                    </script>

                    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels">
                        Chart.register(ChartDataLabels);
                    </script>
                    

                    <snk:load />

                    <style>
                        :root {
                            --bg: #edf1f5;
                            --card: #ffffff;
                            --header: #d9e1ea;
                            --border: #d7dce2;
                            --text: #1f2937;
                            --shadow: 0 2px 10px rgba(0, 0, 0, .08);
                        }

                        * {
                            margin: 0;
                            padding: 0;
                            box-sizing: border-box;
                        }

                        body {
                            font-family: Segoe UI, Tahoma, sans-serif;
                            background: var(--bg);
                            color: var(--text);
                        }

                        .header {
                            background: var(--header);
                            padding: 20px;
                            text-align: center;
                            border-bottom: 3px solid #94a3b8;
                        }

                        .header h1 {
                            font-size: 2rem;
                            font-weight: 700;
                        }

                        .dashboard {
                            padding: 15px;

                            display: grid;
                            grid-template-columns: repeat(12, 1fr);
                            gap: 15px;
                        }

                        .card {
                            background: var(--card);
                            border: 1px solid var(--border);
                            border-radius: 10px;
                            overflow: hidden;
                            box-shadow: var(--shadow);
                        }

                        .card-header {
                            padding: 10px 15px;
                            background: #f8fafc;
                            border-bottom: 1px solid var(--border);
                        }

                        .card-header h3 {
                            font-size: 14px;
                            text-transform: uppercase;
                        }

                        .card-body {
                            padding: 15px;
                        }

                        .span-5 {
                            grid-column: span 5;
                        }

                        .span-7 {
                            grid-column: span 7;
                        }

                        .span-8 {
                            grid-column: span 8;
                        }

                        .span-3 {
                            grid-column: span 3;
                        }

                        .span-4 {
                            grid-column: span 4;
                        }

                        .span-6 {
                            grid-column: span 6;
                        }

                        .span-12 {
                            grid-column: span 12;
                        }

                        table {
                            width: 100%;
                            border-collapse: collapse;
                        }

                        table th {
                            background: #f1f5f9;
                        }

                        table th,
                        table td {
                            border: 1px solid #e5e7eb;
                            padding: 8px;
                            font-size: 12px;
                        }

                        table tbody tr:hover {
                            background: #f8fafc;
                        }

                        .routines {
                            display: grid;
                            grid-template-columns: repeat(3, 1fr);
                            gap: 20px;
                        }

                        .routines ul {
                            list-style: none;
                        }

                        .routines li {
                            margin-bottom: 8px;
                        }

                        .routines li::before {
                            content: "\279C "; /* código do ➜ */
                            color: #2563eb;
                        }

                        .table-scroll {
                            max-height: 260px;
                            overflow: auto;
                        }

                        canvas {
                            width: 100% !important;
                            height: 280px !important;
                        }

                        @media(max-width:1200px) {

                            .dashboard {
                                grid-template-columns: repeat(6, 1fr);
                            }

                            .span-5,
                            .span-7,
                            .span-8 {
                                grid-column: span 6;
                            }

                            .span-3 {
                                grid-column: span 3;
                            }

                            .span-4 {
                                grid-column: span 6;
                            }

                            .span-6 {
                                grid-column: span 6;
                            }
                        }

                        @media(max-width:768px) {

                            .dashboard {
                                grid-template-columns: 1fr;
                            }

                            .span-3,
                            .span-4,
                            .span-5,
                            .span-6,
                            .span-7,
                            .span-8,
                            .span-12 {
                                grid-column: span 1;
                            }

                            .routines {
                                grid-template-columns: 1fr;
                            }

                            canvas {
                                height: 250px !important;
                            }

                            .header h1 {
                                font-size: 1.4rem;
                            }
                        }
                    </style>

                </head>

                <body>
                    
                    <snk:query var="cabecalho">
                        SELECT upper(w.opcao || ' - ' || to_char(SYSDATE, 'MONTH/YYYY')) AS DESCRICAO
                        FROM tddopc w
                        WHERE w.nucampo = 9999990191
                        AND to_char(w.valor, 'FM00') = :XSETOR
                        ORDER BY to_char(w.valor, 'FM00')
                    </snk:query>

                    <snk:query var="qualityQuery">
                        WITH base AS
                        (SELECT coalesce(qld.qtdreprovada, 0) AS qtdreprovado,
                                coalesce(qld.qtdretida, 0) AS qtdretido,
                                coalesce(qld.qtdnotificada, 0) AS qtdnotificado
                           FROM ad_qualihaiala qld
                          INNER JOIN tpriatv atv
                             ON qld.idiproc = atv.idiproc
                          INNER JOIN tpripa ipa
                             ON qld.idiproc = ipa.idiproc
                          INNER JOIN tgfpro pro
                             ON ipa.codprodpa = pro.codprod
                          INNER JOIN tprapo apo
                             ON atv.idiatv = apo.idiatv
                          WHERE trunc(apo.dhapo) BETWEEN (last_day(add_months(SYSDATE, -1)) + 1) AND last_day(SYSDATE)
                            AND (coalesce(qld.qtdreprovada, 0) + coalesce(qld.qtdretida, 0) + coalesce(qld.qtdnotificada, 0)) > 0
                            AND to_char(coalesce(qld.setor_def, pro.ad_set_producao), 'FM00') = :XSETOR),
                        tipos AS
                        (SELECT 'REPROVADO' AS tipo FROM dual
                         UNION ALL
                         SELECT 'RETIDO' FROM dual
                         UNION ALL
                         SELECT 'NOTIFICADO' FROM dual)
                        SELECT t.tipo, coalesce(SUM(val.valor), 0) AS vlr
                          FROM tipos t
                          LEFT JOIN (SELECT tipo, valor
                          FROM base unpivot(valor FOR tipo IN(qtdreprovado AS 'REPROVADO', qtdretido AS 'RETIDO', qtdnotificado AS 'NOTIFICADO'))) val
                            ON t.tipo = val.tipo
                        GROUP BY t.tipo
                    </snk:query>

                    <snk:query var="eficienciaQuery">
                        WITH base_producao AS
                        (SELECT trunc(apo.dhapo) AS dhapo,
                                SUM(apf.qtd) AS qtd,
                                coalesce((SELECT mpc.meta
                                            FROM ad_metapcp mpc
                                        WHERE mpc.dataprod = trunc(apo.dhapo)
                                            AND to_char(mpc.setor, 'FM00') = :XSETOR), 0) AS meta
                            FROM tpriproc ord
                        INNER JOIN tpriatv atv
                            ON ord.idiproc = atv.idiproc
                        INNER JOIN tpripa ipa
                            ON atv.idiproc = ipa.idiproc
                        INNER JOIN tprapo apo
                            ON atv.idiatv = apo.idiatv
                        INNER JOIN tprapf apf
                            ON apo.nuapo = apf.nuapo
                        INNER JOIN tgfpro pro
                            ON ipa.codprodpa = pro.codprod
                        WHERE to_char(apo.dhapo, 'YYYY') = to_char(SYSDATE, 'YYYY')
                            AND to_char(pro.ad_set_producao, 'FM00') = :XSETOR
                        GROUP BY trunc(apo.dhapo)),
                        producao_anual AS
                        (SELECT to_char(dhapo, 'YYYY') AS anomes,
                                SUM(meta) AS meta,
                                SUM(qtd) AS qtd
                            FROM base_producao
                        GROUP BY to_char(dhapo, 'YYYY')),
                        producao_mensal AS
                        (SELECT to_char(dhapo, 'YYYYMM') AS anomes,
                                SUM(meta) AS meta,
                                SUM(qtd) AS qtd
                            FROM base_producao
                        GROUP BY to_char(dhapo, 'YYYYMM')),
                        meses AS
                        (SELECT to_char(SYSDATE, 'YYYY') || to_char(LEVEL, 'FM00') AS anomes,
                                to_char(to_date(LEVEL, 'MM'), 'MON') AS mesano
                            FROM dual
                        CONNECT BY LEVEL <= 12),
                        resultado AS
                        (SELECT 1 AS ordem,
                                pa.anomes,
                                'ANO' AS mesano,
                                pa.meta,
                                pa.qtd,
                                CASE
                                    WHEN pa.meta = 0 THEN
                                    0
                                    ELSE
                                    (pa.qtd / pa.meta) * 100
                                END AS perc
                            FROM producao_anual pa
                        UNION ALL
                        -- Separador
                        SELECT 2    AS ordem,
                                NULL AS anomes,
                                NULL AS mesano,
                                NULL AS meta,
                                NULL AS qtd,
                                NULL AS perc
                            FROM dual
                        UNION ALL
                        -- Produção Mensal
                        SELECT 3 AS ordem,
                                m.anomes,
                                m.mesano,
                                coalesce(pm.meta, 0) AS meta,
                                coalesce(pm.qtd, 0) AS qtd,
                                CASE
                                    WHEN coalesce(pm.meta, 0) = 0 THEN
                                    0
                                    ELSE
                                    (coalesce(pm.qtd, 0) / coalesce(pm.meta, 0)) * 100
                                END AS perc
                            FROM meses m
                            LEFT JOIN producao_mensal pm
                            ON m.anomes = pm.anomes)
                        SELECT mesano,
                            meta,
                            qtd,
                            perc
                        FROM resultado
                        ORDER BY ordem,
                                anomes

                    </snk:query>

                    <snk:query var = "mediaSemanaQuery">

                        WITH semanas AS
                        (SELECT DISTINCT to_char(last_day(add_months(SYSDATE, -1)) + LEVEL, 'IW') AS iw
                            FROM dual
                        WHERE to_char(last_day(add_months(SYSDATE, -1)) + LEVEL, 'D') IN (2, 3, 4, 5, 6, 7)
                        CONNECT BY LEVEL <= to_number(to_char(last_day(SYSDATE), 'DD'))),
                        dados_brutos AS
                        (SELECT to_char(apo.dhapo, 'IW') AS semana,
                                COUNT(DISTINCT trunc(apo.dhapo)) over (PARTITION BY to_char(apo.dhapo, 'IW')) AS d,
                                apf.qtd
                            FROM tpriproc ord
                        INNER JOIN tpriatv atv
                            ON ord.idiproc = atv.idiproc
                        INNER JOIN tpripa ipa
                            ON atv.idiproc = ipa.idiproc
                        INNER JOIN tprapo apo
                            ON atv.idiatv = apo.idiatv
                        INNER JOIN tprapf apf
                            ON apo.nuapo = apf.nuapo
                        INNER JOIN tgfpro pro
                            ON ipa.codprodpa = pro.codprod
                        WHERE trunc(apo.dhapo) BETWEEN (last_day(add_months(SYSDATE, -1)) + 1) AND last_day(SYSDATE)
                            AND to_char(pro.ad_set_producao, 'FM00') = :XSETOR),
                        dados_consolidados AS
                        (SELECT semana,
                                d,
                                SUM(qtd) AS qtd
                            FROM dados_brutos
                        GROUP BY semana,
                                    d)
                        SELECT s.iw,
                            to_char(rownum, 'FM9') || 'ª SEM' AS semana_label,
                            CASE
                                WHEN dc.d = 0 THEN
                                0
                                ELSE
                                coalesce(dc.qtd / dc.d, 0)
                            END AS qtd_media
                        FROM semanas s
                        LEFT JOIN dados_consolidados dc
                            ON s.iw = dc.semana
                        ORDER BY s.iw

                    </snk:query>

                    <snk:query var = "producaoDiariaQuery">

                        WITH dias_mes AS
                        (SELECT to_char(last_day(add_months(SYSDATE, -1)) + LEVEL, 'DD') AS d,
                                to_char(last_day(add_months(SYSDATE, -1)) + LEVEL, 'DD') || '-' || to_char(last_day(add_months(SYSDATE, -1)) + LEVEL, 'DY', 'NLS_DATE_LANGUAGE=PORTUGUESE') AS dia
                            FROM dual
                        WHERE to_char(last_day(add_months(SYSDATE, -1)) + LEVEL, 'D') IN (2, 3, 4, 5, 6, 7) -- exclui domingo
                        CONNECT BY LEVEL <= to_number(to_char(last_day(SYSDATE), 'DD'))),
                        dados_producao AS
                        (SELECT to_char(apo.dhapo, 'DD') AS dia,
                                SUM(apf.qtd) AS qtd
                            FROM tpriproc ord
                        INNER JOIN tpriatv atv
                            ON ord.idiproc = atv.idiproc
                        INNER JOIN tpripa ipa
                            ON atv.idiproc = ipa.idiproc
                        INNER JOIN tprapo apo
                            ON atv.idiatv = apo.idiatv
                        INNER JOIN tprapf apf
                            ON apo.nuapo = apf.nuapo
                        INNER JOIN tgfpro pro
                            ON ipa.codprodpa = pro.codprod
                        WHERE trunc(apo.dhapo) BETWEEN (last_day(add_months(SYSDATE, -1)) + 1) AND last_day(SYSDATE)
                            AND to_char(pro.ad_set_producao, 'FM00') = :XSETOR
                        GROUP BY to_char(apo.dhapo, 'DD'))
                        SELECT dm.dia AS d,
                            coalesce(dp.qtd, 0) AS qtd
                        FROM dias_mes dm
                        LEFT JOIN dados_producao dp
                            ON dm.d = dp.dia
                        ORDER BY dm.d

                    </snk:query>

                    <snk:query var = "ocorrenciaOPQuery">

                        WITH cte_mtp AS
                        (SELECT mtp.codmtp,
                                coalesce(REPLACE(REPLACE(REPLACE(mtp.descricao, ' DE MÁQUINA / FERRAMENTA / GABARITO', ''), ' NO ', ' '), ' DE ', ' '), 'TOTAIS') AS descricao
                            FROM tprmtp mtp
                        WHERE mtp.ativo = 'S'
                        UNION ALL
                        SELECT 100 AS codmtp,
                                'TOTAL ' AS descricao
                            FROM dual),
                        cte_mtp_formatado AS
                        (SELECT codmtp,
                                initcap(descricao) AS descricao
                            FROM cte_mtp
                        ORDER BY codmtp),
                        cte_cnc AS
                        (SELECT coalesce(cnc.codmtp, 100) AS codmtp,
                                COUNT(cnc.codmtp) AS freq,
                                to_char(trunc(SUM((cnc.dtfinal - cnc.dtinicio) * 24)), 'FM9990') || 'h:' || to_char(trunc(MOD(SUM((cnc.dtfinal - cnc.dtinicio) * 24 * 60), 60)), 'FM00') || 'm' AS tempo,
                                (round((SUM((cnc.dtfinal - cnc.dtinicio) * 24) / SUM(SUM((cnc.dtfinal - cnc.dtinicio) * 24)) over()) * 100, 2) * 2) AS percentual
                            FROM ad_cnc cnc
                            LEFT JOIN tpriatv atv
                            ON cnc.idiproc = atv.idiproc
                            LEFT JOIN tpripa ipa
                            ON cnc.idiproc = ipa.idiproc
                            LEFT JOIN tgfpro pro
                            ON ipa.codprodpa = pro.codprod
                            LEFT JOIN tprapo apo
                            ON atv.idiatv = apo.idiatv
                        WHERE trunc(apo.dhapo) BETWEEN (last_day(add_months(SYSDATE, -1)) + 1) AND last_day(SYSDATE)
                            AND to_char(pro.ad_set_producao, 'FM00') = :XSETOR
                        GROUP BY ROLLUP(cnc.codmtp))
                        SELECT a.codmtp,
                            a.descricao,
                            coalesce(b.freq, 0) AS freq,
                            lpad(coalesce(b.tempo, '0h:00m'), 8, ' ') AS tempo,
                            coalesce(b.percentual, 0) AS percentual
                        FROM cte_mtp_formatado a
                        LEFT JOIN cte_cnc b
                            ON a.codmtp = b.codmtp
                        ORDER BY a.codmtp

                    </snk:query>

                    <snk:query var="rankingOSQuery">

                        WITH qtdmes AS
                        (SELECT coditem,
                                REPLACE(REPLACE(descritem, '<', ''), '>', '') AS descritem,
                                COUNT(qtdosmes) AS mes
                            FROM (SELECT mit.coditem,
                                        mit.descmaquina AS descritem,
                                        mos.coditem     AS qtdosmes
                                    FROM ad_mcabos mos
                                INNER JOIN ad_msetor mse
                                    ON mos.codsetor = mse.codsetor
                                INNER JOIN ad_mitens mit
                                    ON mos.coditem = mit.coditem
                                WHERE mos.codsetor = (SELECT codsetor
                                                        FROM (SELECT x.codsetor,
                                                                        translate(x.setdescricao, 'ÇÃÍÁ', 'CAIA') AS setdescricao
                                                                FROM ad_msetor x)
                                                        WHERE setdescricao = (SELECT upper(w.opcao)
                                                                                FROM tddopc w
                                                                                WHERE w.nucampo = 9999990191
                                                                                AND to_char(w.valor, 'FM00') = :XSETOR))
                                    AND to_char(mos.dtos, 'YYYYMM') = to_char(SYSDATE, 'YYYYMM'))
                        GROUP BY coditem,
                                    descritem),
                        qtdano AS
                        (SELECT coditem,
                                REPLACE(REPLACE(descritem, '<', ''), '>', '') AS descritem,
                                COUNT(qtdosano) AS ano
                            FROM (SELECT mit.coditem,
                                        mit.descmaquina AS descritem,
                                        mos.coditem     AS qtdosano
                                    FROM ad_mcabos mos
                                INNER JOIN ad_msetor mse
                                    ON mos.codsetor = mse.codsetor
                                INNER JOIN ad_mitens mit
                                    ON mos.coditem = mit.coditem
                                WHERE mos.codsetor = (SELECT codsetor
                                                        FROM (SELECT x.codsetor,
                                                                        translate(x.setdescricao, 'ÇÃÍÁ', 'CAIA') AS setdescricao
                                                                FROM ad_msetor x)
                                                        WHERE setdescricao = (SELECT upper(w.opcao)
                                                                                FROM tddopc w
                                                                                WHERE w.nucampo = 9999990191
                                                                                AND to_char(w.valor, 'FM00') = :XSETOR))
                                    AND to_char(mos.dtos, 'YYYY') = to_char(SYSDATE, 'YYYY'))
                        GROUP BY coditem,
                                    descritem)
                        SELECT REPLACE(REPLACE(mit.codmaq, '<', ' '), '>', ' ') || ' ' || REPLACE(REPLACE(mit.descmaquina, '<', ''), '>', '') AS descritem,
                               coalesce(m.mes, 0) AS mes,
                               coalesce(a.ano, 0) AS ano
                          FROM ad_mitens mit
                          LEFT JOIN qtdmes m
                            ON mit.coditem = m.coditem
                          LEFT JOIN qtdano a
                            ON mit.coditem = a.coditem
                        WHERE (coalesce(m.mes, 0) + coalesce(a.ano, 0)) > 0

                    </snk:query>

                    <snk:query var = "manutencaoOSQuery">

                        WITH campo_status AS
                        (SELECT nucampo
                            FROM tddcam
                        WHERE nometab = 'AD_MCABOS'
                            AND nomecampo = 'STATUSORDEMSERVICO'),
                        opcoes_status AS
                        (SELECT w.valor,
                                upper(w.opcao) AS opcao
                            FROM tddopc w
                        WHERE w.nucampo = (SELECT nucampo FROM campo_status)
                        ORDER BY w.nucampo,
                                    w.ordem),
                        setor_filtrado AS
                        (SELECT x.codsetor,
                                translate(x.setdescricao, 'ÇÃÍÁ', 'CAIA') AS setdescricao
                            FROM ad_msetor x
                        WHERE translate(x.setdescricao, 'ÇÃÍÁ', 'CAIA') = (SELECT w.opcao
                                                                                FROM tddopc w
                                                                            WHERE w.nucampo = 9999990191
                                                                                AND to_char(w.valor, 'FM00') = :XSETOR)),
                        ordens_servico AS
                        (SELECT mos.statusordemservico,
                                option_label('AD_MCABOS', 'STATUSORDEMSERVICO', mos.statusordemservico) AS stordemservico,
                                coalesce(mos.tpmanutencao, 1) AS codtpmanutencao,
                                1 AS qtd -- coluna usada para contagem
                            FROM ad_mcabos mos
                        INNER JOIN ad_msetor mse
                            ON mos.codsetor = mse.codsetor
                        WHERE mos.codsetor = (SELECT codsetor FROM setor_filtrado)
                            AND trunc(mos.dtos) BETWEEN (last_day(add_months(SYSDATE, -1)) + 1) AND last_day(SYSDATE)),
                        dados_pivot AS
                        (SELECT *
                            FROM (SELECT tp.valor,
                                        tp.opcao,
                                        pt.codtpmanutencao,
                                        pt.qtd
                                    FROM opcoes_status tp
                                    LEFT JOIN ordens_servico pt
                                    ON tp.valor = pt.statusordemservico)
                        pivot(SUM(qtd) AS o
                            FOR codtpmanutencao IN(1 AS corretiva, 2 AS preventiva, 3 AS programada, 4 AS melhorias))),
                        dados_agrupados AS
                        (SELECT valor,
                                coalesce(opcao, 'TOTAL GERAL') AS opcao,
                                SUM(coalesce(corretiva_o, 0)) AS corretiva,
                                SUM(coalesce(preventiva_o, 0)) AS preventiva,
                                SUM(coalesce(programada_o, 0)) AS programada,
                                SUM(coalesce(melhorias_o, 0)) AS melhorias,
                                SUM(coalesce(corretiva_o, 0) + coalesce(preventiva_o, 0) + coalesce(programada_o, 0) + coalesce(melhorias_o, 0)) AS total
                            FROM dados_pivot
                        GROUP BY ROLLUP((valor, opcao)))
                        SELECT valor,
                            opcao,
                            corretiva,
                            preventiva,
                            programada,
                            melhorias,
                            total
                        FROM dados_agrupados
                        
                        ORDER BY valor

                    </snk:query>

                    <snk:query var = "desperdiciosQuery">

                        WITH base_dados AS
                        (SELECT nvl(ite.ad_origem_defeito, 0) AS origem_defeito,
                                option_label('TGFITE', 'AD_ORIGEM_DEFEITO', ite.ad_origem_defeito) AS origem,
                                cab.dtneg,
                                cab.nunota,
                                cab.codtipoper,
                                gru.codgrupoprod,
                                CASE
                                    WHEN substr(gru.codgrupoprod, 1, 1) = 4
                                        AND ite.atualestoque = 1 THEN
                                    0
                                    ELSE
                                    ite.atualestoque
                                END AS atualestoque,
                                (SELECT g.descrgrupoprod
                                    FROM tgfgru g
                                WHERE substr(g.codgrupoprod, 1, 3) = substr(gru.codgrupoprod, 1, 3)
                                    AND g.grau = 2) AS descgrupoprod,
                                ite.codprod,
                                pro.descrprod || pro.compldesc AS descprod,
                                pro.codvol,
                                (ite.qtdneg * CASE
                                    WHEN substr(gru.codgrupoprod, 1, 1) = 4
                                        AND ite.atualestoque = 1 THEN
                                    0
                                    ELSE
                                    ite.atualestoque
                                END) AS qtdneg,
                                (SELECT cussemicm
                                    FROM (SELECT rank() over (PARTITION BY cus.codprod ORDER BY cus.dtatual DESC) AS i,
                                                cus.codprod,
                                                cus.cussemicm
                                            FROM tgfcus cus
                                        WHERE cus.codprod = ite.codprod
                                            AND cus.dtatual <= cab.dtneg)
                                WHERE i = 1) AS vlrcus
                            FROM tgfcab cab
                        INNER JOIN tgfite ite
                            ON cab.nunota = ite.nunota
                        INNER JOIN tgfpro pro
                            ON ite.codprod = pro.codprod
                        INNER JOIN tgfgru gru
                            ON pro.codgrupoprod = gru.codgrupoprod
                        WHERE cab.codtipoper IN (502, 503)
                            AND cab.nunota NOT IN (63316)
                            AND to_char(ite.ad_origem_defeito, 'FM00') = :XSETOR
                            AND to_char(cab.dtneg, 'YYYYMM') = to_char(SYSDATE, 'YYYYMM')),
                        movimentos AS
                        (SELECT origem_defeito,
                                codprod,
                                descprod,
                                codvol,
                                vlrcus,
                                CASE
                                    WHEN atualestoque < 0 THEN
                                    qtdneg
                                    ELSE
                                    0
                                END AS saiqtdneg,
                                CASE
                                    WHEN atualestoque < 0 THEN
                                    (qtdneg * vlrcus)
                                    ELSE
                                    0
                                END AS saicustotal,
                                CASE
                                    WHEN atualestoque > 0 THEN
                                    qtdneg
                                    ELSE
                                    0
                                END AS entqtdneg,
                                CASE
                                    WHEN atualestoque > 0 THEN
                                    (qtdneg * vlrcus)
                                    ELSE
                                    0
                                END AS entcustotal
                            FROM base_dados),
                        custos AS
                        (SELECT origem_defeito,
                                codprod,
                                descprod,
                                codvol,
                                CASE
                                    WHEN SUM(saiqtdneg + entqtdneg) <> 0 THEN
                                    SUM(saicustotal + entcustotal) / SUM(saiqtdneg + entqtdneg)
                                    ELSE
                                    0
                                END AS custo,
                                SUM(saiqtdneg + entqtdneg) AS qtd,
                                SUM(saicustotal + entcustotal) AS total
                            FROM movimentos
                        GROUP BY origem_defeito,
                                    codprod,
                                    descprod,
                                    codvol),
                        resumo AS
                        (SELECT origem_defeito,
                                codprod,
                                descprod,
                                codvol,
                                custo,
                                SUM(qtd) AS qtd,
                                SUM(total) AS total
                            FROM custos
                        WHERE qtd <> 0
                        GROUP BY ROLLUP(origem_defeito, (codprod, descprod, codvol, custo)))
                        SELECT origem_defeito,
                            codprod,
                            descprod,
                            codvol,
                            lpad(to_char(CASE
                                            WHEN custo IS NULL THEN
                                                CASE
                                                WHEN qtd <> 0 THEN
                                                    total / qtd
                                                ELSE
                                                    0
                                                END
                                            ELSE
                                                custo
                                            END, 'FM9G990D00'), 8, ' ') AS custo,
                            lpad(to_char(qtd, 'FM9G990'), 5, ' ') AS qtd,
                            lpad(to_char(total, 'FM9G999G990D00'), 11, ' ') AS total
                        FROM resumo
                        WHERE origem_defeito IS NOT NULL
                        ORDER BY codprod

                    </snk:query>

                    <header class="header">

                        <c:forEach items="${cabecalho.rows}" var="row">
                            <h1>

                                <span>
                                    <c:out value="${row.DESCRICAO}" />
                                </span>

                            </h1>
                        </c:forEach>

                    </header>

                    <div class="dashboard">

                        <!-- EFICIÊNCIA -->

                        <section class="card span-4">
                            <div class="card-header">
                                <h3>% Eficiência (Mensal)</h3>
                            </div>

                            <div class="card-body">
                                <canvas id="efficiencyChart"></canvas>
                            </div>
                        </section>

                        <!-- PRODUÇÃO SEMANA MEDIA-->

                        <section class="card span-4">
                            <div class="card-header">
                                <h3>QTD PRODUZIDA - SEMANA MÉDIA</h3>
                            </div>

                            <div class="card-body">
                                <canvas id="productionChart"></canvas>
                            </div>
                        </section>

                        <!-- PRODUÇÃO DIARIA-->

                        <section class="card span-4">
                            <div class="card-header">
                                <h3>QTD DIARIA</h3>
                            </div>

                            <div class="card-body">
                                <canvas id="productionChartDia"></canvas>
                            </div>
                        </section>

                                                
                        <!-- QUALIDADE -->

                        <section class="card span-3">
                            <div class="card-header">
                                <h3>Qualidade</h3>
                            </div>

                            <div class="card-body">
                                <canvas id="qualityChart"></canvas>
                            </div>
                        </section>

                        <!-- OCORRÊNCIAS -->

                        <section class="card span-3">
                            <div class="card-header">
                                <h3>Ocorrências na OP</h3>
                            </div>

                            <div class="card-body">

                                <table>
                                    <thead>
                                        <tr>
                                            <th>Classificação</th>
                                            <th>Freq.</th>
                                            <th>Tempo</th>
                                            <th>%</th>
                                        </tr>
                                    </thead>

                                    <tbody>

                                        <c:forEach items="${ocorrenciaOPQuery.rows}" var="row">
                                            <tr>
                                                <td><c:out value="${row.descricao}" /></td>
                                                <td><c:out value="${row.freq}" /></td>
                                                <td><c:out value="${row.tempo}" /></td>
                                                <td><c:out value="${row.percentual}" />%</td>
                                            </tr>
                                        </c:forEach>

                                    </tbody>
                                </table>

                            </div>
                        </section>

                        <!-- RANKING -->

                        <section class="card span-3">
                            <div class="card-header">
                                <h3>Ranking de O.S.</h3>
                            </div>

                            <div class="card-body">

                                <table>
                                    <thead>
                                        <tr>
                                            <th>Descrição</th>
                                            <th>OS Mês</th>
                                            <th>OS Ano</th>
                                        </tr>
                                    </thead>

                                    <tbody>

                                        <c:forEach items="${rankingOSQuery.rows}" var="row">
                                        
                                            <tr>
                                                <td><c:out value="${row.descritem}" /></td>
                                                <td><c:out value="${row.mes}" /></td>
                                                <td><c:out value="${row.ano}" /></td>
                                            </tr>

                                        </c:forEach>

                                    </tbody>
                                </table>

                            </div>
                        </section>

                        <!-- PLANO DE AÇÃO -->

                        <section class="card span-3">
                            <div class="card-header">
                                <h3>Plano de Ação</h3>
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
                                            <td>17/Mar</td>
                                            <td>Troca do Manômetro</td>
                                            <td>5265</td>
                                            <td>Paulo</td>
                                        </tr>
                                    </tbody>
                                </table>

                            </div>
                        </section>

                        <!-- MANUTENÇÃO -->

                        <section class="card span-6">
                            <div class="card-header">
                                <h3>Manutenção (Ordens de Serviço)</h3>
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
                                        <c:forEach items="${manutencaoOSQuery.rows}" var="row">
                                            <tr>
                                                <td><c:out value="${row.opcao}" /></td>
                                                <td><c:out value="${row.corretiva}" /></td>
                                                <td><c:out value="${row.preventiva}" /></td>
                                                <td><c:out value="${row.programada}" /></td>
                                                <td><c:out value="${row.melhorias}" /></td>
                                                <td><c:out value="${row.total}" /></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>

                                </table>

                            </div>
                        </section>

                        <!-- DESPERDÍCIOS -->

                        <section class="card span-6">
                            <div class="card-header">
                                <h3>Desperdícios / Perdas</h3>
                            </div>

                            <div class="card-body table-scroll">

                                <table>
                                    <thead>
                                        <tr>
                                            <th>Codpro</th>
                                            <th>Descrição</th>
                                            <th>UN</th>
                                            <th>Custo</th>
                                            <th>Qtd</th>
                                            <th>Total</th>
                                        </tr>
                                    </thead>

                                    <tbody>

                                        <c:forEach items="${desperdiciosQuery.rows}" var="row">

                                            <tr>
                                                <td><c:out value="${row.codprod}" /></td>
                                                <td><c:out value="${row.descprod}" /></td>
                                                <td><c:out value="${row.codvol}" /></td>
                                                <td><c:out value="${row.custo}" /></td>
                                                <td><c:out value="${row.qtd}" /></td>
                                                <td><c:out value="${row.total}" /></td>
                                            </tr>

                                        </c:forEach>

                                    </tbody>

                                </table>

                            </div>
                        </section>

                        <!-- ROTINAS -->

                        <section class="card span-12">
                            <div class="card-header">
                                <h3>Rotinas no Setor</h3>
                            </div>

                            <div class="card-body routines">

                                <ul>
                                    <li>Orientação Time</li>
                                    <li>Abastecimento D-1</li>
                                    <li>Controle Hora a Hora</li>
                                    <li>Segregação Diária</li>
                                    <li>Plano de Produção</li>
                                </ul>

                                <ul>
                                    <li>DDS e DDQ</li>
                                    <li>Inspeção Pontos Críticos</li>
                                    <li>Premiação</li>
                                    <li>Pontos de Manutenção</li>
                                    <li>Prioridades Produção</li>
                                </ul>

                                <ul>
                                    <li>Treinamento</li>
                                    <li>Feedback Individual</li>
                                    <li>Auditoria 5S</li>
                                    <li>Reunião Operacional</li>
                                    <li>Kaizen</li>
                                </ul>

                            </div>
                        </section>

                    </div>

                    <script>

                        // EFICIÊNCIA

                        const efilabels = [
                            <c:forEach items="${eficienciaQuery.rows}" var="row" varStatus="loop">
                                '${row.mesano}'<c:if test="${!loop.last}">,</c:if>
                            </c:forEach>
                        ];

                        const efimetas = [
                            <c:forEach items="${eficienciaQuery.rows}" var="row" varStatus="loop">
                                ${row.meta}<c:if test="${!loop.last}">,</c:if>
                            </c:forEach>
                        ];

                        const efiqtd = [
                            <c:forEach items="${eficienciaQuery.rows}" var="row" varStatus="loop">
                                ${row.qtd}<c:if test="${!loop.last}">,</c:if>
                            </c:forEach>
                        ];

                        const efiperc = [
                            <c:forEach items="${eficienciaQuery.rows}" var="row" varStatus="loop">
                                ${row.perc}<c:if test="${!loop.last}">,</c:if>
                            </c:forEach>
                        ];

                       new Chart(
                                 document.getElementById('efficiencyChart'),
                                    {
                                        type: 'bar', // gráfico principal continua sendo 'bar'
                                        data: {
                                            labels: efilabels,
                                            datasets: [
                                                {
                                                    label: 'Metas',
                                                    data: efimetas,
                                                    backgroundColor: '#4f81bd'
                                                },
                                                {
                                                    label: 'Qtds',
                                                    data: efiqtd,
                                                    backgroundColor: '#9bbb59'
                                                }/*,
                                                {
                                                    label: '%',
                                                    data: efiperc,
                                                    type: 'line', // este dataset será linha
                                                    borderColor: 'red', //'#c0504d',
                                                    backgroundColor: 'red', //'#c0504d',
                                                    fill: false, // não preencher área abaixo da linha
                                                    yAxisID: 'y' // opcional: garante que use o mesmo eixo
                                                }*/
                                            ]
                                        },
                                        options: {
                                            responsive: true,
                                            maintainAspectRatio: false
                                        }
                                    }
                                );



                        // PRODUÇÃO MEDIA SEMANA

                        const medsemlabels = [
                            <c:forEach items="${mediaSemanaQuery.rows}" var="row" varStatus="loop">
                                '${row.semana_label}'<c:if test="${!loop.last}">,</c:if>
                            </c:forEach>
                        ];

                        const mediasemana = [
                            <c:forEach items="${mediaSemanaQuery.rows}" var="row" varStatus="loop">
                                ${row.qtd_media}<c:if test="${!loop.last}">,</c:if>
                            </c:forEach>
                        ];

                        new Chart(
                            document.getElementById('productionChart'),
                            {
                                type: 'bar',
                                data: {
                                    labels: medsemlabels,
                                    datasets: [{
                                        label: 'Media Semanal',
                                        data: mediasemana,
                                        backgroundColor: '#9bbb59'
                                    }]
                                },
                                options: {
                                            responsive: true,
                                            maintainAspectRatio: false,
                                            plugins: {
                                                datalabels: {
                                                    color: 'black',          // cor do texto
                                                    anchor: 'end',           // posição em relação à barra
                                                    align: 'start',          // alinhamento dentro da barra
                                                    formatter: function(value) {
                                                        return value;        // mostra o valor diretamente
                                                    }
                                                }
                                            }
                                        }
                            });

                            

                        // PRODUÇÃO DIARIA

                        const proddialabels = [
                            <c:forEach items="${producaoDiariaQuery.rows}" var="row" varStatus="loop">
                                '${row.d}'<c:if test="${!loop.last}">,</c:if>
                            </c:forEach>
                        ];

                        const qtddia = [
                            <c:forEach items="${producaoDiariaQuery.rows}" var="row" varStatus="loop">
                                ${row.qtd}<c:if test="${!loop.last}">,</c:if>
                            </c:forEach>
                        ];

                        new Chart(
                            document.getElementById('productionChartDia'),
                            {
                                type: 'bar',
                                data: {
                                    labels: proddialabels,
                                    datasets: [{
                                        label: 'Produção Diaria',
                                        data: qtddia,
                                        backgroundColor: '#9bbb59'
                                    }]
                                },
                                options: {
                                    responsive: true,
                                    maintainAspectRatio: false
                                }
                            });


                        // QUALIDADE
                        const labels = [
                            <c:forEach items="${qualityQuery.rows}" var="row" varStatus="loop">
                                '${row.TIPO}'<c:if test="${!loop.last}">,</c:if>
                            </c:forEach>
                        ];

                        const metas = [
                            <c:forEach items="${qualityQuery.rows}" var="row" varStatus="loop">
                                ${row.VLR}<c:if test="${!loop.last}">,</c:if>
                            </c:forEach>
                        ];

                        new Chart(
                            document.getElementById('qualityChart'),
                            {
                                type: 'bar',
                                data: {
                                    labels: labels,
                                    datasets: [{
                                        data: metas,
                                        backgroundColor: [
                                            '#ef4444',
                                            '#f59e0b',
                                            '#3b82f6'
                                        ]
                                    }]
                                },
                                options: {
                                    indexAxis: 'y',
                                    responsive: true,
                                    maintainAspectRatio: false,
                                    plugins: {
                                        legend: {
                                            display: false
                                        }
                                    }
                                }
                            });

                    </script>

                </body>

                </html>