<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<!doctype html><html lang="pt-BR"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>HAIALA - Painel de Bordo Comercial - Ambiente de Teste V6.1.5</title><style>
:root{font-family:Inter,ui-sans-serif,system-ui,'Segoe UI',Arial;color:#192d41;background:#f3f6fa}*{box-sizing:border-box}body{margin:0}button,input,select{font:inherit}button{cursor:pointer}button:disabled{cursor:not-allowed;opacity:.45}#app{display:block;min-height:100vh}.sidebar{background:#172d43;color:#eef6fd;padding:14px 22px;position:sticky;top:0;z-index:20;box-shadow:0 4px 16px #0c21321f;display:flex;align-items:center;gap:22px;flex-wrap:wrap}.brand{display:flex;gap:11px;align-items:center;margin:0;min-width:max-content}.logomark{background:#3c6d87;border-radius:12px;font-weight:900;padding:11px}.brand strong{font-size:21px;letter-spacing:2px}.brand small{display:block;font-size:10px;letter-spacing:1px;color:#bbcfdf}.modhead{font-size:10px;color:#a5bfce;letter-spacing:1.3px;text-transform:uppercase;white-space:nowrap;margin-right:6px}.navgroups{display:flex;gap:10px;flex-wrap:wrap;align-items:center}.navgroup{position:relative}.navgroup>summary{list-style:none;display:flex;align-items:center;gap:8px;border:1px solid #34506a;background:#1d3951;color:#e7f0f7;border-radius:10px;padding:10px 14px;font-size:12px;font-weight:700;cursor:pointer;min-height:40px}.navgroup>summary::-webkit-details-marker{display:none}.navgroup>summary::after{content:"v";font-size:11px;color:#aecdde}.navgroup[open]>summary{background:#29445a;border-color:#46627c}.navgroup[open]>summary::after{content:"^"}.dropdownmenu{position:absolute;top:calc(100% + 8px);left:0;min-width:280px;max-height:68vh;overflow:auto;background:#fff;border:1px solid #dbe6ef;border-radius:12px;box-shadow:0 20px 50px #0b233633;padding:8px;z-index:30}.dropdownmenu .nav{width:100%;text-align:left;border:0;background:transparent;color:#274258;border-radius:8px;padding:10px 12px;margin:2px 0;font-size:12px;display:block}.dropdownmenu .nav:hover{background:#edf4f9}.dropdownmenu .nav.active{background:#e1eef5;color:#172d43;font-weight:800}.navgroup .groupcaption{font-size:10px;color:#7891a4;letter-spacing:1px;text-transform:uppercase;padding:4px 8px 8px}.main{min-width:0;padding:25px 28px;max-width:1600px;width:100%;margin:auto}.top{display:flex;justify-content:space-between;gap:14px;align-items:center;margin-bottom:20px}.eyebrow{color:#63798d;font-size:12px;margin-bottom:4px}.title{font-size:27px;line-height:1.15;margin:0}.subtitle{font-size:13px;color:#718397;margin-top:8px}.tag{background:#e9f1f8;color:#275874;padding:5px 9px;border-radius:50px;font-size:11px;font-weight:700}.notice{background:#fff5dd;border:1px solid #f2dfb6;color:#805b1a;border-radius:10px;padding:10px 13px;font-size:12px}.box{background:#fff;border:1px solid #dfe7ef;border-radius:13px;box-shadow:0 2px 8px #183a5810;padding:18px}.filters{display:grid;grid-template-columns:repeat(5,minmax(0,1fr));gap:12px}.field label{display:block;color:#657b8f;font-size:11px;font-weight:700;margin-bottom:5px}.field select,.field input{border:1px solid #d0dce6;color:#23384c;background:white;width:100%;border-radius:7px;padding:9px;min-width:0}.section{display:flex;justify-content:space-between;align-items:center;gap:10px;margin:25px 0 12px}.section h2{font-size:15px;margin:0}.section small{color:#7c8d9e}.kpis{display:grid;grid-template-columns:repeat(4,1fr);gap:13px}
.kpis.five-kpis{grid-template-columns:repeat(5,minmax(0,1fr))}.kpis.six-kpis{grid-template-columns:repeat(6,minmax(0,1fr))}
@media(max-width:1100px){.kpis.five-kpis,.kpis.six-kpis{grid-template-columns:repeat(3,minmax(0,1fr))}}
@media(max-width:680px){.kpis.five-kpis,.kpis.six-kpis{grid-template-columns:repeat(2,minmax(0,1fr))}}
.kpi{background:#fff;border:1px solid #e0e8ef;border-radius:12px;padding:18px;cursor:pointer;min-width:0}.kpi:hover{border-color:#78a6c4}.kpi span{font-size:12px;color:#718397}.kpi strong{display:block;font-size:25px;margin:9px 0 5px;overflow-wrap:anywhere}.kpi small{color:#688298;font-size:11px}.analytics{display:grid;grid-template-columns:minmax(0,1.8fr) minmax(270px,1fr);gap:15px}.paneltitle{font-size:14px;font-weight:750;margin:0 0 14px}.bars{height:220px;display:flex;align-items:end;gap:9px;border-bottom:1px solid #e0e9f0;padding:9px 0 0}.barcol{flex:1;display:flex;flex-direction:column;align-items:center;justify-content:flex-end;gap:7px;height:100%;min-width:0}.bar{background:#397b9d;border-radius:5px 5px 0 0;width:75%;min-height:2px}.barcol span{font-size:10px;color:#728697;white-space:nowrap}.barcol em{font-size:9px;color:#52788f;font-style:normal}.minirow{display:flex;gap:9px;align-items:center;margin:12px 0}.minilabel{width:105px;font-size:11px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}.minirail{background:#eaf0f5;flex:1;height:10px;border-radius:10px;overflow:hidden}.minifill{background:#73a5bb;height:100%;border-radius:10px}.miniv{font-size:11px;color:#526e80;width:65px;text-align:right}.tablewrap{overflow:auto;max-height:420px}table{width:100%;border-collapse:collapse;font-size:12px}th{text-align:left;background:#f4f7fb;color:#5b7489;font-weight:700;position:sticky;top:0;white-space:nowrap}th,td{padding:11px;border-bottom:1px solid #eaf0f5}tbody tr:hover{background:#f5faff;cursor:pointer}td.num,th.num{text-align:right;font-variant-numeric:tabular-nums}button.btn{border:1px solid #cfdee9;background:#fff;color:#31546e;border-radius:7px;padding:9px 12px;font-size:12px;font-weight:700}button.btn.primary{background:#1c5678;color:white;border-color:#1c5678}button.btn:hover{filter:brightness(.97)}.actions{display:flex;gap:8px;flex-wrap:wrap}.status{font-size:11px;color:#648195}.footer{font-size:11px;color:#7b90a3;padding:23px 0}.chips{display:flex;gap:8px;flex-wrap:wrap}.chip{font-size:11px;color:#41617a;background:#eaf2f8;padding:6px 9px;border-radius:7px}.empty{color:#6c8091;font-size:13px;padding:27px 5px;text-align:center}.modalbg{position:fixed;inset:0;background:#0e2536a0;display:grid;place-items:center;padding:20px;z-index:9}.modal{width:min(670px,100%);max-height:85vh;overflow:auto;background:white;border-radius:16px;padding:22px;box-shadow:0 25px 75px #001a3290}.modalhead{display:flex;justify-content:space-between;align-items:center}.datagrid{display:grid;grid-template-columns:1fr 1fr;gap:8px}.dataitem{background:#f4f8fb;padding:10px;border-radius:8px;font-size:12px}.dataitem b{display:block;color:#667d90;font-size:10px;margin-bottom:5px}.svgmap{width:100%;max-height:230px;border-radius:9px;background:#f5f9fc}.svgmap text{font-family:inherit}.note{font-size:11px;color:#607d91}.audit{white-space:pre-wrap;background:#f3f7fa;padding:12px;border-radius:8px;max-height:220px;overflow:auto;font-size:12px}.bar:hover{background:#225d83}@media(max-width:1080px){.filters{grid-template-columns:repeat(3,1fr)}.kpis{grid-template-columns:repeat(2,1fr)}.dropdownmenu{min-width:240px}}@media(max-width:730px){.sidebar{position:relative;padding:14px 16px;align-items:flex-start}.main{padding:16px}.analytics{grid-template-columns:1fr}.filters{grid-template-columns:repeat(2,1fr)}.title{font-size:22px}.top{align-items:start}.kpis{grid-template-columns:repeat(2,minmax(0,1fr))}.kpi strong{font-size:20px}.navgroups{width:100%}.navgroup{width:100%}.navgroup>summary{width:100%;justify-content:space-between}.dropdownmenu{position:static;min-width:100%;margin-top:6px}}@media(max-width:390px){.filters{grid-template-columns:1fr}.kpis{grid-template-columns:1fr}}

.rulesgrid{display:grid;grid-template-columns:repeat(auto-fit,minmax(185px,1fr));gap:12px}.ruleitem{padding:13px;border:1px solid #d8e2ed;border-radius:9px;background:#f7fafc}.ruleitem b{display:block;font-size:20px;margin-top:5px}.ruleitem span{font-size:12px;color:#667889}.rulealert{padding:10px 12px;border-left:4px solid #bd7e16;background:#fff8e9;margin:9px 0;border-radius:4px;font-size:13px}.ruleok{border-left-color:#39876d;background:#eaf6ef}.rulesection{margin:13px 0 7px;font-size:14px}.rulestable{width:100%;border-collapse:collapse;font-size:12px}.rulestable td,.rulestable th{padding:7px;border-bottom:1px solid #e3ebf3;text-align:left}.progressbars{display:flex;height:9px;background:#e7edf3;border-radius:9px;overflow:hidden}.progressbars>span{display:block;background:#3f8dad}.rulefoot{font-size:12px;color:#657a90;margin-top:12px}


/* HAIALA V3.3 - Composicao financeira e tributaria informativa */
.tax-compact{margin:14px 0 2px;border:1px solid #dce5ee;border-radius:10px;background:#fff;overflow:hidden}
.tax-compact summary{cursor:pointer;padding:12px 15px;display:flex;justify-content:space-between;gap:14px;align-items:center;font-weight:650;color:#294761;list-style:none}
.tax-compact summary::-webkit-details-marker{display:none}
.tax-compact summary:after{content:"v";color:#537084}
.tax-compact[open] summary:after{content:"^"}
.tax-compact small{font-size:11px;font-weight:400;color:#6b8092}
.tax-compact .tax-summary{display:flex;align-items:center;gap:10px;flex-wrap:wrap}
.tax-compact .tax-pill{font-size:11px;background:#edf4f7;border-radius:20px;padding:3px 9px;color:#315877}
.tax-compact .tax-content{padding:0 15px 14px}
.tax-compact .tax-grid{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:8px;margin:9px 0}
.tax-compact .tax-metric{background:#f5f8fa;padding:10px;border-radius:8px}
.tax-compact .tax-metric span{display:block;font-size:11px;color:#60778c}
.tax-compact .tax-metric strong{display:block;margin-top:4px;font-size:17px;color:#294761}
.tax-compact .tax-notice{margin:9px 0 0;font-size:11px;color:#657a90;line-height:1.55}
.tax-compact table{border-collapse:collapse;width:100%;font-size:12px}
.tax-compact td{padding:7px;border-bottom:1px solid #e9eef2}
/* v6.1.10: alinhar consistentemente colunas numericas da composicao financeira. */
.tax-compact thead td:first-child,.tax-compact tbody td:first-child{text-align:left}
.tax-compact thead td:not(:first-child),.tax-compact tbody td:not(:first-child){text-align:right;font-variant-numeric:tabular-nums;white-space:nowrap}
@media(max-width:640px){.tax-compact .tax-grid{grid-template-columns:1fr}.tax-compact summary{align-items:flex-start;flex-direction:column}}

#q12Real{border:1px solid #c8d8e3;border-radius:12px;padding:16px;margin:12px 0;background:#f8fbfd;color:#183343}
#q12Real .q12-head{display:flex;flex-wrap:wrap;justify-content:space-between;gap:8px;margin-bottom:12px}
#q12Real .q12-head small{color:#526575}
#q12Real .q12-values{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:9px;margin-bottom:12px}
#q12Real .q12-values>div{border:1px solid #e0e8ee;border-radius:8px;background:#fff;padding:10px;display:flex;flex-direction:column;gap:5px}
#q12Real .q12-values small{color:#516675}#q12Real .q12-values strong{font-size:17px}
#q12Real details{padding:8px;border:1px solid #e1eaf0;border-radius:8px;background:#fff}#q12Real summary{cursor:pointer;font-weight:600}
#q12Real table{width:100%;margin-top:10px;border-collapse:collapse}#q12Real th,#q12Real td{padding:7px;border-bottom:1px solid #edf1f4;text-align:left;white-space:nowrap}
#q12Real .q12-scroll{overflow:auto}#q12Real .q12-disclaimer{font-size:12px;color:#526575;margin:10px 0 0}
@media(max-width:800px){#q12Real .q12-values{grid-template-columns:repeat(2,minmax(0,1fr))}}

/* v3.7 - dock compacto de filtros no espaço superior direito, preservando o layout das 26 páginas */
.top{display:grid;grid-template-columns:minmax(245px,0.33fr) minmax(720px,1fr);gap:20px;align-items:start;margin-bottom:12px}
.page-heading{padding-top:10px;min-width:0}.page-heading .tag{display:inline-block;margin-top:13px}.filter-dock{min-width:0}
.filter-dock-head{display:flex;justify-content:space-between;align-items:center;margin:0 0 6px;gap:8px}.filter-dock-head strong{font-size:13px}.filter-dock-head .status{font-size:11px}
.filter-dock .box.filters{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:7px 10px;padding:11px 13px;border-radius:11px}
.filter-dock .field label{font-size:10px;margin-bottom:3px}.filter-dock .field select,.filter-dock .field input{font-size:12px;padding:6px 7px;height:33px}
.main>.notice{margin-top:6px;margin-bottom:3px}
@media(max-width:1320px){.top{grid-template-columns:minmax(205px,0.3fr) minmax(560px,1fr)}.filter-dock .box.filters{grid-template-columns:repeat(3,minmax(0,1fr))}}
@media(max-width:1020px){.top{grid-template-columns:1fr}.filter-dock .box.filters{grid-template-columns:repeat(3,minmax(0,1fr))}}
@media(max-width:660px){.filter-dock .box.filters{grid-template-columns:repeat(2,minmax(0,1fr))}.page-heading{padding-top:0}}

.haiala-diagnostics{background:#fff6e7;border:1px solid #e9d4ab;border-radius:10px;padding:11px 14px;margin:12px 0;font-size:12px;color:#72501c}.haiala-diagnostics strong{display:block;color:#523715;margin-bottom:4px}.haiala-oracle-test{margin-top:8px;min-height:34px}.haiala-oracle-test strong{display:inline;margin:0 8px 0 0}
/* HAIALA v4.8.5.2: Ficha 360, comportamento real do cliente */
.cl02-behavior{margin-top:18px;padding:20px}
.cl02-behavior h4{font-size:14px;color:#263d52;margin:20px 0 10px}
.cl02-behavior-cards{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:10px;margin-top:12px}
.cl02-behavior-kpi{padding:12px;border:1px solid #d9e5ef;border-radius:9px;background:#f4f8fb;display:flex;flex-direction:column;gap:6px}
.cl02-behavior-kpi span{font-size:12px;color:#637b92}.cl02-behavior-kpi strong{font-size:19px;color:#16314a}
.cl02-month-track{display:grid;grid-template-columns:repeat(12,minmax(0,1fr));gap:5px;overflow-x:auto}
.cl02-month-cell{padding:9px 4px;border-radius:7px;border:1px solid #dfe6ed;background:#f4f6f8;text-align:center;min-width:65px;display:flex;flex-direction:column;gap:5px}
.cl02-month-cell.has-purchase{background:#e0f0fa;border-color:#9fc5da}.cl02-month-cell.outside-period{opacity:.5}
.cl02-month-cell span{font-size:12px;font-weight:700}.cl02-month-cell strong{font-size:11px;white-space:nowrap}.cl02-month-cell small{font-size:10px;color:#6a7b8a}
.cl02-month-bars{display:grid;gap:7px}.cl02-month-bar{display:grid;grid-template-columns:38px minmax(0,1fr) 124px;gap:10px;align-items:center;font-size:12px}
.cl02-track{background:#e7eef3;height:12px;border-radius:4px;overflow:hidden}.cl02-track div{height:100%;background:#337fa6;border-radius:4px}
.cl02-month-bar strong{text-align:right;font-size:12px}.cl02-dates{margin-top:16px}.cl02-dates summary{cursor:pointer;font-size:13px;font-weight:700}
.cl02-dates table{width:100%;margin-top:8px;border-collapse:collapse}.cl02-dates td,.cl02-dates th{text-align:left;padding:8px;border-bottom:1px solid #e5edf3}
.cl02-wide-table table{min-width:100%;width:max-content} .cl02-wide-table .tablewrap{overflow-x:auto}
/* v4.8.5.2: pin tipologia column during horizontal table scroll */
.cl02-wide-table .tablewrap{position:relative;overflow-x:auto;overflow-y:auto}
.cl02-wide-table table th:first-child,.cl02-wide-table table td:first-child{position:sticky;left:0;min-width:215px;max-width:300px;background:#fff;z-index:2;box-shadow:2px 0 5px #183a5815}
.cl02-wide-table table th:first-child{background:#f4f7fb;z-index:4;top:0}
.cl02-wide-table table tbody tr:last-child td:first-child{background:#edf3f8;font-weight:700}
.cl02-wide-table table tbody tr:hover td:first-child{background:#f5faff}

@media(max-width:900px){.cl02-behavior-cards{grid-template-columns:repeat(2,minmax(0,1fr))}.cl02-month-track{grid-template-columns:repeat(12,minmax(66px,1fr))}}

/* v4.8.6.1: layout CL03, sem alterar consultas Oracle */
body.cl03-layout .haiala-diagnostics {margin:0;border-radius:5px;padding:9px 12px;font-size:12px}
body.cl03-layout #cl03Origins {margin:12px 0 18px;border:1px solid #d7e2ec;background:#fff;border-radius:10px}
body.cl03-layout #cl03Origins>summary{padding:14px 16px;font-size:13px;font-weight:700;color:#27435a;cursor:pointer}
body.cl03-layout #cl03OriginsContent{padding:0 12px 12px;display:grid;gap:7px}
body.cl03-layout #cl03OriginsContent .haiala-diagnostics {display:block}
body.cl03-layout #taxReferencePanel{margin-bottom:12px}
body.cl03-layout #kpis{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:14px}
body.cl03-layout #cl01Sec02+.analytics{display:grid;grid-template-columns:1fr 1fr;gap:14px;align-items:start}
body.cl03-layout #primaryPanel,body.cl03-layout #secondaryPanel {min-width:0;}
body.cl03-layout #secondaryPanel .cl03-month-table{max-height:380px;overflow:auto}
body.cl03-layout #secondaryPanel .cl03-month-table table{font-size:12px}
body.cl03-layout #rulesPanel .rulesgrid{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:10px}
body.cl03-layout #rulesPanel .ruleitem{padding:14px 12px;min-width:0}
body.cl03-layout #cl03Tools{display:flex;gap:12px;align-items:center;justify-content:space-between;flex-wrap:wrap;margin:0 0 12px}
body.cl03-layout #cl03QuickSearch{max-width:400px;width:100%;border:1px solid #cbd8e3;border-radius:7px;padding:10px 12px;font:inherit}
body.cl03-layout #cl03QuickCount{font-size:12px;color:#62778a}
body.cl03-layout #cl03SortHint{font-size:12px;color:#62778a;margin-bottom:8px}
body.cl03-layout #tablePanel thead th.cl03-sort{cursor:pointer;user-select:none}
body.cl03-layout #tablePanel thead th.cl03-sort:hover{background:#e7f1f8}
body.cl03-layout #tablePanel td:nth-child(8){font-weight:600}
@media(max-width:950px){body.cl03-layout #kpis{grid-template-columns:repeat(2,minmax(0,1fr))}body.cl03-layout #cl01Sec02+.analytics{grid-template-columns:1fr}body.cl03-layout #rulesPanel .rulesgrid{grid-template-columns:repeat(2,minmax(0,1fr))}}
@media(max-width:520px){body.cl03-layout #kpis{grid-template-columns:1fr}}

/* v4.8.6.2 - tabela mensal em largura integral abaixo dos dois graficos */
body.cl03-layout #cl03MonthlyFull {display:block;margin:14px 0 20px;padding:16px 18px}
body.cl03-layout #cl03MonthlyFull .cl03-month-table{max-height:none;overflow:auto}
body.cl03-layout #cl03MonthlyFull table{width:100%;font-size:12px;border-collapse:collapse}
body.cl03-layout #cl03MonthlyFull thead th{position:sticky;top:0;background:#f1f5f9}
body.cl03-layout #cl03MonthlyFull .paneltitle{margin-bottom:12px}
body.cl03-layout #cl01Sec02+.analytics{align-items:stretch}
body.cl03-layout #primaryPanel,body.cl03-layout #secondaryPanel{height:100%}
body.cl03-layout main>.notice,body.cl03-layout main>section.haiala-diagnostics{display:none}
body.cl03-layout #cl03OracleStatus{display:flex;align-items:center;gap:10px;flex-wrap:wrap;padding:10px 14px;margin:12px 0 10px;border:1px solid #b9d9c6;background:#eff8f2;border-radius:9px;font-size:12px;color:#24533c}
body.cl03-layout #cl03OracleStatus.cl03-error{border-color:#eed0a2;background:#fff7e9;color:#77511d}
body.cl03-layout #cl03OriginsContent>section.haiala-diagnostics{display:block;margin:0}
body.cl03-layout #tablePanel th.cl03-sort::after{content:'';display:inline-block;margin-left:7px;width:0;height:0;border-left:4px solid transparent;border-right:4px solid transparent;border-top:5px solid #8297aa;vertical-align:middle}
body.cl03-layout #tablePanel th.cl03-sort[data-dir='asc']::after{border-top:0;border-bottom:5px solid #236789}
body.cl03-layout #tablePanel th.cl03-sort[data-dir='desc']::after{border-top:5px solid #236789;border-bottom:0}
body.cl04-real #kpis{grid-template-columns:repeat(3,minmax(0,1fr))}body.cl04-real #cl04Filters{display:flex;flex-wrap:wrap;gap:10px;margin:0 0 12px}body.cl04-real #cl04Filters input,body.cl04-real #cl04Filters select{padding:9px;border:1px solid #c5d3df;border-radius:7px;min-width:180px;background:#fff}body.cl04-real #cl04Filters input{flex:1}body.cl04-real #cl04Count{flex-basis:100%;font-size:12px}body.cl04-real #tablePanel{overflow-x:auto}body.cl04-real #tablePanel th{white-space:nowrap}body.cl04-real .cl04-tag{font-size:12px;white-space:nowrap} @media(max-width:850px){body.cl04-real #kpis{grid-template-columns:repeat(2,minmax(0,1fr))}}
/* v4.8.7.1 - leitura compacta e transparente da CL-04 */
body.cl04-real main.main>.notice,body.cl04-real main.main>section.haiala-diagnostics {display:none}
body.cl04-real #cl04OracleStatus{display:block;margin:12px 0 10px;padding:10px 14px;border:1px solid #b8dac8;background:#eff8f2;border-radius:8px;color:#285840;font-size:12px}
body.cl04-real #cl04OracleStatus.cl04-fail{background:#fff4e8;border-color:#e8b986;color:#844d24}
body.cl04-real #cl04Origins{display:block;margin:10px 0 18px;border:1px solid #d6e2ec;background:#fff;border-radius:9px}
body.cl04-real #cl04Origins>summary{padding:13px 16px;font-size:13px;font-weight:700;cursor:pointer;color:#29465d}
body.cl04-real #cl04OriginsContent{display:grid;gap:7px;padding:0 12px 12px}
body.cl04-real #cl04OriginsContent .haiala-diagnostics{display:block;margin:0;padding:9px 11px;font-size:12px}
body.cl04-real #taxReferencePanel{margin-bottom:10px}
body.cl04-real #rulesPanel .cl04-criteria{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:12px}
body.cl04-real #rulesPanel .cl04-criterion{border:1px solid #d9e4eb;border-radius:9px;padding:14px;background:#f8fafc}
body.cl04-real #rulesPanel .cl04-criterion strong{font-size:13px;display:block;margin-bottom:7px}
body.cl04-real #rulesPanel .cl04-criterion p{font-size:12px;line-height:1.5;margin:0;color:#4c6276}
@media(max-width:850px){body.cl04-real #rulesPanel .cl04-criteria{grid-template-columns:1fr}}

/* HAIALA v5.3: acesso direto sem submenu em Acompanhamento, Vendas e Clientes */
.nav-direct{display:flex;align-items:center;border:1px solid #34506a;background:#1d3951;color:#e7f0f7;border-radius:10px;padding:10px 14px;font-size:12px;font-weight:700;cursor:pointer;min-height:40px}
.nav-direct:hover,.nav-direct-active{background:#294b65;border-color:#607f95}
.nav-direct:focus-visible{outline:3px solid #8bbad8;outline-offset:2px}
.v5-tabs{margin-top:12px;gap:8px}
.v5-tab{white-space:nowrap}
@media(max-width:800px){.navgroups{gap:6px}.nav-direct,.navgroup>summary{padding:9px 10px}.v5-tabs{overflow-x:auto;max-width:100%;padding-bottom:5px}}
.ac-bars-scroll{overflow-x:auto;overflow-y:hidden;width:100%;padding-bottom:6px}
.ac-bars{gap:5px;box-sizing:border-box}
.ac-bars .ac-bars-col{min-width:42px}
.ac-bars .ac-bars-col span{font-size:10px;white-space:nowrap;letter-spacing:0;text-align:center}

/* v5.3.3.6 - Acompanhamento: gráfico ampliado e resumo compacto, sem rótulos cortados. */
.analytics.ac-summary-compact{grid-template-columns:minmax(0,4.5fr) minmax(250px,1fr);align-items:stretch}
.analytics.ac-summary-compact #primaryPanel,.analytics.ac-summary-compact #secondaryPanel{min-width:0}
.analytics.ac-summary-compact #secondaryPanel{padding:16px 13px}
.analytics.ac-summary-compact #secondaryPanel .minirow{display:flex;flex-direction:column;align-items:flex-start;gap:3px;margin:12px 0}
.analytics.ac-summary-compact #secondaryPanel .minilabel{display:block;width:auto;max-width:100%;white-space:normal;overflow:visible;text-overflow:clip;line-height:1.4;overflow-wrap:break-word}
.analytics.ac-summary-compact #secondaryPanel .minirow strong{font-size:15px;white-space:normal;overflow-wrap:anywhere;line-height:1.3}
@media(max-width:980px){.analytics.ac-summary-compact{grid-template-columns:1fr}.analytics.ac-summary-compact #secondaryPanel .minirow{display:grid;grid-template-columns:minmax(0,1fr) auto;align-items:center;gap:12px}}

/* HAIALA v5.3.3.9 - oito indicadores em uma unica linha em telas amplas. */
.kpis.eight-kpis{grid-template-columns:repeat(8,minmax(0,1fr));gap:9px}
.kpis.eight-kpis .kpi{padding:12px 9px}
.kpis.eight-kpis .kpi strong{font-size:clamp(12px,1.12vw,20px);white-space:nowrap;overflow-wrap:normal;letter-spacing:-.45px;font-variant-numeric:tabular-nums}
.kpis.eight-kpis .kpi span{font-size:11px}
@media(max-width:1350px){.kpis.eight-kpis{grid-template-columns:repeat(4,minmax(0,1fr))}}
@media(max-width:700px){.kpis.eight-kpis{grid-template-columns:repeat(2,minmax(0,1fr))}}

/* v5.3.3.14.6.4 - tabela com ate 30 linhas visiveis e totalizador fixo na base da rolagem. */
body.ac535-detail #tablePanel{max-height:1305px;overflow-y:auto;overflow-x:auto}
body.ac535-detail #tablePanel table{min-width:1350px;width:100%;border-collapse:collapse}
body.ac535-detail #tablePanel thead th{position:sticky;top:0;z-index:4;background:#f4f7fb}
body.ac535-detail #tablePanel tfoot td{position:sticky;bottom:0;z-index:3;background:#e7f0f6;font-weight:750;border-top:2px solid #9db5c6;white-space:nowrap}
body.ac535-detail #tablePanel tbody tr{height:41px}
body.ac535-detail #tablePanel td{white-space:nowrap}
body.ac535-detail #tablePanel th:nth-child(4),body.ac535-detail #tablePanel td:nth-child(4){min-width:135px}

/* v5.3.3.14.6.4 - bloqueio exclusivo de seletores de representante */
#filters select:disabled {cursor:not-allowed;opacity:.70;background-color:#edf2f6;}

/* HAIALA 5.3.3.14.5 - cliente multiselect com pesquisa */
.haiala-client-field{min-width:0}.haiala-client-multi{position:relative;width:100%}.haiala-client-toggle{background:#fff;border:1px solid #d0dce6;border-radius:7px;height:33px;width:100%;padding:6px 9px;display:flex;align-items:center;justify-content:space-between;gap:6px;font-size:12px;color:#23384c;text-align:left;overflow:hidden;white-space:nowrap;text-overflow:ellipsis}.haiala-client-toggle span{margin-left:auto;flex-shrink:0}.haiala-client-popup{position:absolute;z-index:90;top:calc(100% + 5px);left:0;width:max(100%,340px);max-width:min(520px,85vw);padding:10px;border:1px solid #cbdce9;border-radius:9px;background:#fff;box-shadow:0 12px 32px #19354a35}.haiala-client-popup[hidden]{display:none}.haiala-client-popup input[type=search]{height:34px;width:100%;padding:6px 10px;border:1px solid #cbdce9;border-radius:6px;margin-bottom:8px}.haiala-client-matches{max-height:248px;overflow-y:auto;border:1px solid #e1e9f0;border-radius:5px}.haiala-client-option{display:flex;align-items:center;gap:8px;padding:8px;font-size:12px;cursor:pointer;min-height:31px}.haiala-client-option:hover{background:#edf5fa}.haiala-client-option input{flex:none}.haiala-client-actions{display:flex;justify-content:space-between;margin-top:10px;gap:8px}.haiala-client-actions button{border:1px solid #cbdce9;border-radius:6px;background:#f5f9fc;padding:7px 11px;font-weight:600;color:#294b63;font-size:12px}.haiala-client-actions button:last-child{background:#1c4660;color:#fff}.haiala-client-popup .haiala-client-option span{overflow-wrap:anywhere}

/* v5.3.3.14.6.4 - multiselect compacto, caixas alinhadas e sem glyph de fonte. */
.filter-dock .haiala-client-multi .haiala-client-toggle{
  display:flex;align-items:center;gap:9px;width:100%;height:33px;
  padding:6px 10px;overflow:hidden;min-width:0;font-size:12px;
}
.haiala-client-summary{display:block;flex:1;min-width:0;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.haiala-client-chevron{display:block;flex:0 0 7px;width:7px;height:7px;
  border-right:1.6px solid #31546b;border-bottom:1.6px solid #31546b;
  transform:rotate(45deg) translateY(-2px);margin:0 4px 0 auto}
.haiala-client-toggle[aria-expanded="true"] .haiala-client-chevron{transform:rotate(225deg) translateY(-2px)}
.filter-dock .haiala-client-popup{box-sizing:border-box;width:min(420px,calc(100vw - 36px));max-width:none;min-width:min(330px,calc(100vw - 36px));padding:10px;}
.filter-dock .haiala-client-popup input[type="search"]{display:block;width:100%;height:34px;margin:0 0 8px;padding:7px 10px;}
.filter-dock .haiala-client-matches{max-height:260px;overflow:auto;scrollbar-width:thin;}
.filter-dock .haiala-client-option{display:flex;flex-direction:row;align-items:center;
  justify-content:flex-start;gap:10px;min-height:37px;padding:8px 9px;
  border-bottom:1px solid #edf2f7;line-height:1.35;font-size:12px;}
.filter-dock .haiala-client-option:last-child{border-bottom:none}
.filter-dock .haiala-client-option input[type="checkbox"]{
  appearance:auto;-webkit-appearance:checkbox;display:inline-block;position:static;
  flex:0 0 16px;width:16px!important;min-width:16px!important;max-width:16px;
  height:16px!important;margin:0!important;padding:0!important;border:0;
  border-radius:3px;accent-color:#245775;cursor:pointer;vertical-align:middle;
}
.filter-dock .haiala-client-option span{display:block;flex:1;min-width:0;white-space:normal;overflow-wrap:break-word;}
.filter-dock .haiala-client-actions{display:flex;flex-direction:row;align-items:center;justify-content:space-between;gap:10px;margin-top:10px}
.filter-dock .haiala-client-actions button{width:auto;min-height:32px;padding:7px 12px;white-space:nowrap;}
@media(max-width:560px){.filter-dock .haiala-client-popup{left:auto;right:0;max-width:calc(100vw - 36px)}}

/* v5.3.3.14.6.4: botoes de limpeza do multiselect */
.filter-dock .haiala-client-actions-left{display:flex;align-items:center;gap:6px;min-width:0;flex-wrap:wrap}
.filter-dock .haiala-client-actions{display:flex;align-items:center;justify-content:space-between;gap:8px;flex-wrap:wrap}
.filter-dock .haiala-client-actions button{font-size:11px;padding:7px 9px;min-height:32px}
.filter-dock #haialaClientClearDraft{background:#fff;color:#294b63;border:1px solid #cbdce9}
.filter-dock #haialaClientApply{margin-left:auto;background:#1c4660;color:#fff}

/* v5.3.3.14.6.10 - KPIs compactos e drill-down Oracle de pedidos */
.kpis.six-ac-kpis{grid-template-columns:repeat(6,minmax(0,1fr));gap:9px}
.kpis.six-ac-kpis .kpi{padding:12px 10px;cursor:default}
.kpis.six-ac-kpis .kpi strong{font-size:clamp(14px,1.20vw,21px);white-space:nowrap}
.kpi .kpi-comparison{display:flex;align-items:center;gap:6px;flex-wrap:wrap;margin-top:5px;padding-top:5px;border-top:1px solid #e8edf3}
.kpi .kpi-comparison b{font-size:13px;color:#264b63;font-variant-numeric:tabular-nums}
.kpi .kpi-comparison span{font-size:10px;color:#667f93}
@media(max-width:1250px){.kpis.six-ac-kpis{grid-template-columns:repeat(3,minmax(0,1fr))}}
@media(max-width:650px){.kpis.six-ac-kpis{grid-template-columns:repeat(2,minmax(0,1fr))}}
.ac-order-modalbg{z-index:100}
.ac-order-modal{width:min(1150px,98vw);max-height:91vh;padding:20px 22px;display:flex;flex-direction:column;gap:11px}
.ac-order-modal .modalhead{flex-shrink:0;gap:12px}
.ac-order-modal .modalhead h2{font-size:19px;margin:0}
.ac-order-intro{font-size:11px;color:#647d90;margin:0}
.ac-order-summary{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:8px}
.ac-order-summary>div{border:1px solid #e3eaf0;border-radius:8px;padding:9px;background:#f6f9fc;min-width:0}
.ac-order-summary span{display:block;font-size:10px;color:#6b8294}
.ac-order-summary strong{font-size:17px;display:block;margin-top:3px;color:#1c3d56}
.ac-order-controls{display:flex;justify-content:space-between;gap:10px;align-items:center;flex-wrap:wrap}
.ac-order-controls input{padding:9px 10px;border:1px solid #cbdce9;border-radius:7px;flex:1;min-width:220px}
.ac-order-list{overflow:auto;flex:1;min-height:120px;border:1px solid #e4ebf0;border-radius:8px}
.ac-order-table{width:100%;font-size:11px}
.ac-order-table th{position:sticky;top:0;z-index:1;background:#edf3f8}
.ac-order-table td,.ac-order-table th{padding:9px 8px}
.ac-order-table .ac-number{text-align:right;white-space:nowrap;font-variant-numeric:tabular-nums}
.ac-order-expand{border:1px solid #b8cad8;color:#1f435a;background:linear-gradient(180deg,#ffffff 0%,#f2f7fb 100%);border-radius:8px;min-width:30px;min-height:30px;padding:4px 8px;cursor:pointer;font-size:17px;font-weight:700;line-height:1;display:inline-flex;align-items:center;justify-content:center;box-shadow:0 1px 0 rgba(17,52,77,.05)}.ac-order-expand:hover{background:linear-gradient(180deg,#fafdff 0%,#e8f2f9 100%);border-color:#9bb6c8}
.ac-order-glyph{display:inline-block;width:13px;height:13px;position:relative;vertical-align:middle;flex:none}
.ac-order-glyph::before,.ac-order-glyph::after{content:"";display:block;position:absolute;background:#24485f;border-radius:2px}
.ac-order-glyph::before{width:13px;height:2px;left:0;top:5.5px}
.ac-order-glyph::after{width:2px;height:13px;left:5.5px;top:0}
.ac-order-expand[aria-expanded="true"] .ac-order-glyph::after{display:none}.ac-order-expand:focus-visible{outline:2px solid #32749a;outline-offset:2px}.ac-order-subrow .ac-order-margin-note{font-size:10px;color:#527189;margin-top:8px}
.ac-order-subrow td{padding:12px 14px;background:#edf4f9;border-top:1px solid #d7e4ef}
.ac-order-subpanel{background:#f7fbfe;border:1px solid #d6e5f0;border-left:4px solid #7ea7c3;border-radius:10px;padding:10px 12px;box-shadow:inset 0 1px 0 rgba(255,255,255,.7)}
.ac-order-subpanel strong{display:block;margin-bottom:8px;color:#23455d}
.ac-order-subhead{display:flex;align-items:center;flex-wrap:wrap;gap:8px 20px;margin-bottom:8px}
.ac-order-subhead strong{display:inline;margin:0}
.ac-order-prazo{font-size:11px;color:#35566e;white-space:nowrap}
.ac-order-prazo b{font-weight:700;color:#23455d}
@media(max-width:740px){.ac-order-prazo{white-space:normal}}

.ac-order-subrow table{font-size:11px;min-width:600px;border-collapse:separate;border-spacing:0;width:100%}
.ac-order-subrow thead th{background:#ddeaf3;color:#35566e;border-bottom:1px solid #cadbe8}
.ac-order-subrow tbody tr:nth-child(odd) td{background:#ffffff}
.ac-order-subrow tbody tr:nth-child(even) td{background:#f2f7fb}
.ac-order-subrow th,.ac-order-subrow td{padding:8px 8px}
.ac-order-subrow tbody td{border-top:1px solid #e4eef5}
.ac-order-footer{display:flex;align-items:center;justify-content:flex-end;gap:9px;flex-shrink:0;font-size:11px}
.ac-order-footer button{border:1px solid #cbdce9;border-radius:6px;padding:6px 10px;background:#fff;color:#2e526d;cursor:pointer}
.ac-order-footer button:disabled{opacity:.4;cursor:not-allowed}
@media(max-width:740px){.ac-order-summary{grid-template-columns:repeat(2,minmax(0,1fr))}.ac-order-modal{padding:12px}}

/* v5.3.3.14.6.17: botão e modal da memória financeira */
.ac-mc-btn{border:1px solid #a9bfd0;border-radius:7px;color:#234c67;background:#eff6fb;min-width:30px;min-height:30px;font-size:18px;cursor:pointer}.ac-mc-btn:hover{background:#d9eaf5}.haiala-mc-memory-backdrop{z-index:220}.haiala-mc-memory-modal{width:min(1050px,96vw);max-height:90vh;overflow:auto}.haiala-mc-memory-modal h2{font-size:18px}.haiala-mc-scroll{overflow:auto;max-height:65vh;border:1px solid #d6e4ee;border-radius:8px}.haiala-mc-scroll table{min-width:660px}.haiala-mc-scroll td,.haiala-mc-scroll th{padding:9px}.haiala-mc-indicator{display:flex;align-items:baseline;gap:16px;margin:12px 0;color:#1b5a7a}.haiala-mc-indicator strong{font-size:24px}.haiala-mc-indicator span{font-size:18px;font-weight:650}.ac-mc-warning{color:#9d4b18;font-size:12px}

/* v18: icon has no Unicode glyph dependency (Sankhya/DBExplorer encoding). */
.ac-mc-btn{display:inline-flex;align-items:center;justify-content:center;font-size:0;vertical-align:middle}
.haiala-calculator-glyph{position:relative;display:inline-block;box-sizing:border-box;width:15px;height:18px;border:2px solid currentColor;border-radius:3px}
.haiala-calculator-glyph:before{content:"";position:absolute;top:3px;left:2px;right:2px;border-top:2px solid currentColor}
.haiala-calculator-glyph:after{content:"";position:absolute;top:8px;left:2px;width:3px;height:3px;background:currentColor;box-shadow:5px 0 currentColor,0 5px currentColor,5px 5px currentColor}

/* v22: memória de cálculo sem rolagem interna vertical em viewport desktop.
   Em telas pequenas, apenas a janela externa pode rolar para não cortar conteúdo. */
.haiala-mc-memory-modal{width:min(1180px,97vw);max-height:96vh;max-height:96dvh;overflow-y:auto;overflow-x:hidden;padding:14px 18px;box-sizing:border-box}
.haiala-mc-memory-modal .modalhead{margin-bottom:4px}
.haiala-mc-memory-modal .modalhead h2{font-size:17px}
.haiala-mc-memory-modal .note{font-size:10px;line-height:1.24;margin:5px 0}
.haiala-mc-memory-modal .haiala-mc-indicator{margin:5px 0 7px;gap:12px}
.haiala-mc-memory-modal .haiala-mc-indicator strong{font-size:22px}
.haiala-mc-memory-modal .haiala-mc-indicator span{font-size:16px}
.haiala-mc-memory-modal .haiala-mc-scroll{max-height:none;overflow-y:visible;overflow-x:auto;border-radius:7px}
.haiala-mc-memory-modal .haiala-mc-scroll table{min-width:620px;width:100%;font-size:10.5px;border-collapse:collapse}
.haiala-mc-memory-modal .haiala-mc-scroll td,.haiala-mc-memory-modal .haiala-mc-scroll th{padding:4px 7px;line-height:1.15}
.haiala-mc-memory-modal .haiala-mc-scroll th{position:static}
@media(max-width:740px){.haiala-mc-memory-modal{padding:12px;width:98vw}.haiala-mc-memory-modal .haiala-mc-scroll td,.haiala-mc-memory-modal .haiala-mc-scroll th{padding:5px}}
/* v31: medidor somente-leitura; não altera Oracle, KPI ou renderização. */
.haiala-load-meter{display:inline-block;border:1px solid #3f607a;border-radius:6px;padding:4px 7px;color:#d4e9f6;font-size:10px;font-variant-numeric:tabular-nums;white-space:nowrap;letter-spacing:0;cursor:help}

/* v6.0.3 - somente Bloco 02: tabela unica hierarquica, colunas pelo conteudo. */
.v6-gerrep{margin:18px 0 22px;min-width:0}
.v6-gerrep h2{font-size:16px;color:#1a354c;margin:0 0 6px}
.v6-gerrep .v6-subtitle{font-size:11px;color:#617c90;margin-bottom:12px}
.v6-gerrep .v6-scroll{max-width:100%;overflow-x:auto;border:1px solid #d8e5ef;border-radius:9px;background:#fff}
.v6-gerrep table{border-collapse:separate;border-spacing:0;table-layout:auto;width:max-content;min-width:100%;font-size:11px}
.v6-gerrep th,.v6-gerrep td{padding:5px 7px;border-bottom:1px solid #e3ebf1;text-align:right;white-space:nowrap;vertical-align:middle;font-size:11px;font-variant-numeric:tabular-nums}
.v6-gerrep th{background:#e7f0f6;color:#2c526c;font-weight:700;position:sticky;top:0;z-index:2;white-space:normal;line-height:1.15;max-width:112px;min-width:55px}
.v6-gerrep th:first-child,.v6-gerrep td:first-child{position:sticky;left:0;width:186px;min-width:186px;max-width:186px;box-sizing:border-box;text-align:left;background:#fff;z-index:3;box-shadow:2px 0 4px rgba(24,56,82,.1);overflow:hidden;text-overflow:ellipsis}
.v6-gerrep th:first-child{background:#e7f0f6;z-index:5}
.v6-gerrep tbody tr:hover td,.v6-gerrep tbody tr:hover td:first-child{background:#c7e0f0}
.v6-gerrep tbody tr.v6-total td,.v6-gerrep tbody tr.v6-total td:first-child{font-weight:700;background:#dceaf2;border-top:1px solid #a0bacd}
.v6-gerrep tbody tr.v6-total:hover td,.v6-gerrep tbody tr.v6-total:hover td:first-child{background:#bfd9ea}
.v6-gerrep .v6-warning{color:#8a5515;background:#fff7e8;padding:9px 12px;border-radius:6px;margin:8px 0;font-size:11px}
.v6-gerrep .v6-row-toggle{display:flex;align-items:center;gap:7px;width:100%;min-width:0;border:0;background:transparent;padding:0;text-align:left;font:inherit;color:inherit;cursor:pointer}
.v6-gerrep .v6-row-name{display:block;min-width:0;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.v6-gerrep .v6-caret{width:7px;height:7px;flex:none;border-right:1.5px solid #315574;border-bottom:1.5px solid #315574;transform:rotate(-45deg);transition:transform .12s ease}
.v6-gerrep .v6-row-toggle[aria-expanded="true"] .v6-caret{transform:rotate(45deg)}
.v6-gerrep .v6-row-toggle:focus-visible{outline:2px solid #1e6399;outline-offset:2px}
.v6-gerrep .v6-rep-name{padding-left:20px;display:block}
.v6-gerrep .v6-rep-link{padding:0 0 0 20px;margin:0;border:0;background:transparent;text-align:left;font:inherit;color:#1e5d86;cursor:pointer;display:block;max-width:100%;white-space:nowrap;text-decoration:underline;text-decoration-color:#a0bdd0;text-underline-offset:2px}
.v6-gerrep .v6-rep-link:hover{text-decoration-color:currentColor;color:#154a6a}
.v6-gerrep .v6-rep-link:focus-visible{outline:2px solid #1e6399;outline-offset:2px}
.v6-gerrep .v6-rep-idle{font-style:italic;color:#657d8d}
.v6-gerrep [hidden]{display:none!important}

</style><snk:load/>
<c:catch var="haialaFalhaOracle">
<snk:query var="haialaTesteOracle">
SELECT COUNT(*) AS TOTAL
FROM SANKHYA.TGFCAB
WHERE CODEMP = 1 AND TIPMOV = 'P'
AND CODTIPOPER IN (1000, 1001, 1005, 1007, 9000, 9001)
AND STATUSNOTA IN ('A','P','L')
AND DTNEG >= DATE '2026-01-01'
AND DTNEG < TRUNC(SYSDATE) + 1
</snk:query>
</c:catch>
<c:catch var="haialaFalhaQ43">
<snk:query var="haialaQ43">
SELECT TO_CHAR(CAB.DTNEG, 'YYYY-MM-DD') AS DIA,
       CAB.CODTIPOPER AS OPERACAO,
       COUNT(DISTINCT CAB.NUNOTA) AS PEDIDOS,
       ROUND(SUM(NVL(CAB.VLRNOTA,0)-NVL(CAB.VLRSUBST,0)),2) AS VLC,
       ROUND(SUM(NVL(CAB.VLRSUBST,0)),2) AS ST,
       ROUND(SUM(NVL(CAB.VLRICMS,0)),2) AS ICMS,
       ROUND(SUM(NVL(CAB.VLRDESCTOTITEM,0)),2) AS DESCONTOS
FROM SANKHYA.TGFCAB CAB
WHERE CAB.CODEMP = 1
  AND CAB.DTNEG >= DATE '2026-01-01'
  AND CAB.DTNEG < TRUNC(SYSDATE) + 1
  AND CAB.TIPMOV = 'P'
  AND CAB.CODTIPOPER IN (1000, 1001, 1005, 1007, 9000, 9001)
  AND CAB.STATUSNOTA IN ('A','P','L')
GROUP BY TO_CHAR(CAB.DTNEG, 'YYYY-MM-DD'), CAB.CODTIPOPER
ORDER BY DIA, OPERACAO
</snk:query>
</c:catch>
<!-- v6.1.11: detalhes por NUNOTA, somente para popup informativo e de Pedidos; nao alimenta KPIs. -->
<c:catch var="haialaFalhaQ6111DocsTOP">
<snk:query var="haialaQ6111DocsTOP">
SELECT CAB.NUNOTA AS PEDIDO_ID,
       TO_CHAR(CAB.DTNEG,'YYYY-MM-DD') AS DIA,
       CASE WHEN CAB.TIPMOV='P' AND CAB.CODTIPOPER IN (1000,1001,1005,1007,9000,9001)
            THEN 1 ELSE TOP.AD_GRUPO END AS GRUPO,
       CAB.CODTIPOPER AS OPERACAO,
       NVL(CAB.CODVEND,-1) AS REPRESENTANTE,
       NVL(CAB.CODPARC,-1) AS CLIENTE,
       CAB.STATUSNOTA AS STATUSNOTA,
       ROUND(NVL(CAB.VLRNOTA,0)-NVL(CAB.VLRSUBST,0),2) AS VLC,
       ROUND(NVL(CAB.VLRSUBST,0),2) AS ST
FROM SANKHYA.TGFCAB CAB
JOIN SANKHYA.TGFTOP TOP
  ON TOP.CODTIPOPER=CAB.CODTIPOPER
 AND TOP.DHALTER=CAB.DHTIPOPER
WHERE CAB.CODEMP=1
  AND CAB.DTNEG>=DATE '2026-01-01'
  AND CAB.DTNEG<TRUNC(SYSDATE)+1
  AND CAB.STATUSNOTA IN ('A','P','L')
  AND ((CAB.TIPMOV='P' AND CAB.CODTIPOPER IN (1000,1001,1005,1007,9000,9001))
       OR TOP.AD_GRUPO IN (3,4,5))
ORDER BY CAB.DTNEG,CAB.NUNOTA
</snk:query>
</c:catch>
<!-- v6.1.8: grupos informativos de TOP. Nao alimentam indicadores comerciais. -->
<c:catch var="haialaFalhaQ618Informativo">
<snk:query var="haialaQ618Informativo">
SELECT TO_CHAR(CAB.DTNEG,'YYYY-MM-DD') AS DIA,
       TOP.AD_GRUPO AS GRUPO,
       CAB.CODTIPOPER AS OPERACAO,
       TOP.DESCROPER AS DESCRICAO,
       NVL(CAB.CODVEND,-1) AS REPRESENTANTE,
       NVL(CAB.CODPARC,-1) AS CLIENTE,
       COUNT(DISTINCT CAB.NUNOTA) AS DOCUMENTOS,
       ROUND(SUM(NVL(CAB.VLRNOTA,0)-NVL(CAB.VLRSUBST,0)),2) AS VLC,
       ROUND(SUM(NVL(CAB.VLRSUBST,0)),2) AS ST
FROM SANKHYA.TGFCAB CAB
INNER JOIN SANKHYA.TGFTOP TOP
  ON TOP.CODTIPOPER = CAB.CODTIPOPER
 AND TOP.DHALTER = CAB.DHTIPOPER
WHERE CAB.CODEMP = 1
  AND CAB.DTNEG >= DATE '2026-01-01'
  AND CAB.DTNEG < TRUNC(SYSDATE) + 1
  AND CAB.STATUSNOTA IN ('A','P','L')
  AND TOP.AD_GRUPO IN (3,4,5)
GROUP BY TO_CHAR(CAB.DTNEG,'YYYY-MM-DD'), TOP.AD_GRUPO,
         CAB.CODTIPOPER, TOP.DESCROPER, NVL(CAB.CODVEND,-1), NVL(CAB.CODPARC,-1)
ORDER BY DIA, GRUPO, OPERACAO
</snk:query>
</c:catch>
<c:catch var="haialaFalhaQ616SemItensZero">
<snk:query var="haialaQ616SemItensZero">
SELECT TO_CHAR(CAB.DTNEG, 'YYYY-MM-DD') AS DIA,
       CAB.CODTIPOPER AS OPERACAO,
       COUNT(DISTINCT CAB.NUNOTA) AS QTD_SEM_ITENS_ZERO
FROM SANKHYA.TGFCAB CAB
WHERE CAB.CODEMP = 1
  AND CAB.DTNEG >= DATE '2026-01-01'
  AND CAB.DTNEG < TRUNC(SYSDATE) + 1
  AND CAB.TIPMOV = 'P'
  AND CAB.CODTIPOPER IN (1000, 1001, 1005, 1007, 9000, 9001)
  AND CAB.STATUSNOTA IN ('A','P','L')
  AND NVL(CAB.VLRNOTA,0) = 0
  AND NVL(CAB.VLRSUBST,0) = 0
  AND NVL(CAB.VLRICMS,0) = 0
  AND NVL(CAB.VLRDESCTOTITEM,0) = 0
  AND NOT EXISTS (
      SELECT 1 FROM SANKHYA.TGFITE ITE WHERE ITE.NUNOTA = CAB.NUNOTA
  )
GROUP BY TO_CHAR(CAB.DTNEG, 'YYYY-MM-DD'), CAB.CODTIPOPER
</snk:query>
</c:catch>
<c:catch var="haialaFalhaQ45">
<snk:query var="haialaQ45">
SELECT TO_CHAR(CAB.DTNEG, 'YYYY-MM-DD') AS DIA,
       CAB.CODTIPOPER AS OPERACAO,
       NVL(CAB.CODVEND,-1) AS REPRESENTANTE,
       COUNT(DISTINCT CAB.NUNOTA) AS PEDIDOS,
       ROUND(SUM(NVL(CAB.VLRNOTA,0)-NVL(CAB.VLRSUBST,0)),2) AS VLC,
       ROUND(SUM(NVL(CAB.VLRSUBST,0)),2) AS ST,
       ROUND(SUM(NVL(CAB.VLRICMS,0)),2) AS ICMS,
       ROUND(SUM(NVL(CAB.VLRDESCTOTITEM,0)),2) AS DESCONTOS
FROM SANKHYA.TGFCAB CAB
WHERE CAB.CODEMP = 1
  AND CAB.DTNEG >= DATE '2026-01-01'
  AND CAB.DTNEG < TRUNC(SYSDATE) + 1
  AND CAB.TIPMOV = 'P'
  AND CAB.CODTIPOPER IN (1000, 1001, 1005, 1007, 9000, 9001)
  AND CAB.STATUSNOTA IN ('A','P','L')
GROUP BY TO_CHAR(CAB.DTNEG, 'YYYY-MM-DD'), CAB.CODTIPOPER, NVL(CAB.CODVEND,-1)
ORDER BY DIA, OPERACAO, REPRESENTANTE
</snk:query>
</c:catch>
<c:catch var="haialaFalhaQ46">
<snk:query var="haialaQ46">
SELECT TO_CHAR(CAB.DTNEG, 'YYYY-MM-DD') AS DIA,
       CAB.CODTIPOPER AS OPERACAO,
       NVL(CAB.CODVEND,-1) AS REPRESENTANTE,
       CAB.CODPARC AS CLIENTE,
       COUNT(DISTINCT CAB.NUNOTA) AS PEDIDOS,
       ROUND(SUM(NVL(CAB.VLRNOTA,0)-NVL(CAB.VLRSUBST,0)),2) AS VLC,
       ROUND(SUM(NVL(CAB.VLRSUBST,0)),2) AS ST,
       ROUND(SUM(NVL(CAB.VLRICMS,0)),2) AS ICMS,
       ROUND(SUM(NVL(CAB.VLRDESCTOTITEM,0)),2) AS DESCONTOS
FROM SANKHYA.TGFCAB CAB
WHERE CAB.CODEMP = 1
  AND CAB.DTNEG >= DATE '2026-01-01'
  AND CAB.DTNEG < TRUNC(SYSDATE) + 1
  AND CAB.TIPMOV = 'P'
  AND CAB.CODTIPOPER IN (1000, 1001, 1005, 1007, 9000, 9001)
  AND CAB.STATUSNOTA IN ('A','P','L')
GROUP BY TO_CHAR(CAB.DTNEG, 'YYYY-MM-DD'),
         CAB.CODTIPOPER, NVL(CAB.CODVEND,-1), CAB.CODPARC
ORDER BY DIA, OPERACAO, REPRESENTANTE, CLIENTE
</snk:query>
</c:catch>
<c:catch var="haialaFalhaQ471">
<snk:query var="haialaQ471">
SELECT CAB.NUNOTA AS PEDIDO_ID,
       TO_CHAR(CAB.DTNEG,'YYYY-MM-DD') AS DIA,
       CAB.CODTIPOPER AS OPERACAO,
       NVL(CAB.CODVEND,-1) AS REPRESENTANTE,
       CAB.CODPARC AS CLIENTE,
       ITE.CODPROD AS SKU,
       NVL(TRIM(PRO.AD_TIPOLOGIA), '(SEM TIPOLOGIA)') AS TIPOLOGIA,
       ROUND(SUM(NVL(ITE.VLRTOT,0) - NVL(ITE.VLRDESC,0) - NVL(ITE.VLRDESCRAT,0)),2) AS VENDAS_SKU,
       ROUND(SUM(NVL(ITE.VLRDESC,0) + NVL(ITE.VLRDESCRAT,0)),2) AS DESCONTO_SKU,
       ROUND(SUM(NVL(ITE.VLRICMS,0)),2) AS ICMS_SKU,
       ROUND(SUM(NVL(ITE.VLRSUBST,0)),2) AS ST_SKU,
       ROUND(SUM(NVL(ITE.VLRIPI,0)),2) AS IPI_SKU
FROM SANKHYA.TGFCAB CAB
JOIN SANKHYA.TGFITE ITE ON ITE.NUNOTA = CAB.NUNOTA
LEFT JOIN SANKHYA.TGFPRO PRO ON PRO.CODPROD = ITE.CODPROD
WHERE CAB.CODEMP = 1
  AND CAB.DTNEG >= DATE '2026-01-01'
  AND CAB.DTNEG < TRUNC(SYSDATE)+1
  AND CAB.TIPMOV = 'P'
  AND (CAB.CODTIPOPER IN (1000, 1001, 1005, 1007, 9000, 9001) OR (CAB.CODTIPOPER = 1100 AND PRO.CODGRUPOPROD = 40209001))
  AND CAB.STATUSNOTA IN ('A','P','L')
GROUP BY CAB.NUNOTA, TO_CHAR(CAB.DTNEG,'YYYY-MM-DD'), CAB.CODTIPOPER,
         NVL(CAB.CODVEND,-1), CAB.CODPARC, ITE.CODPROD,
         NVL(TRIM(PRO.AD_TIPOLOGIA), '(SEM TIPOLOGIA)')
ORDER BY DIA, PEDIDO_ID, SKU
</snk:query>
</c:catch>


<c:catch var="haialaFalhaQ539T01">
<snk:query var="haialaQ539T01">
WITH
parametros AS
(SELECT DATE '2026-01-01' AS data_inicial,
         TRUNC(SYSDATE) AS data_final,
         DATE '2026-01-01' AS data_consulta_inicio,
         DATE '2026-02-01' AS data_consulta_fim
    FROM dual),
historico_gerentes AS
(SELECT h.codger,
         h.codvend
    FROM SANKHYA.AD_HISGRVRCA h
   CROSS JOIN parametros p
   WHERE p.data_inicial BETWEEN h.dtinicial AND h.dtfinal),
variacoes_nota AS
(SELECT DISTINCT v.nunota,
                  v.sequencia,
                  v.nunotaorig,
                  v.sequenciaorig
    FROM SANKHYA.TGFVAR v),
itens_originais AS
(SELECT v.nunota,
         v.sequencia,
         v.nunotaorig,
         v.sequenciaorig,
         i.nunota        AS nunota_item_origem,
         i.sequencia     AS sequencia_item_origem
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunotaorig
     AND i.sequencia = v.sequenciaorig),
cabecalhos_originais AS
(SELECT i.nunota,
         i.sequencia,
         i.nunotaorig,
         i.sequenciaorig,
         c.nunota AS nunota_cab_origem,
         c.codusuinc,
         c.ad_diassemcompra,
         c.ad_dtultimacompra
    FROM itens_originais i
    LEFT JOIN SANKHYA.TGFCAB c
      ON c.nunota = i.nunota_item_origem),
comissoes_originais AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig,
                  v.sequencia,
                  v.sequenciaorig,
                  i.codprod,
                  i.perccom AS perccomf
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunota
     AND i.sequencia = v.sequencia),
variacoes_anteriores AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig
    FROM SANKHYA.TGFVAR v),
precos_originais AS
(SELECT DISTINCT i.nunota,
                  t.nutab
    FROM SANKHYA.TGFITE i
   INNER JOIN SANKHYA.TGFTAB t
      ON t.nutab = i.nutab),
valores_prazo_medio AS
(SELECT c.nunota,
         c.codtipvenda,
         coalesce(SUM((c.vlrliq * pg.percentual / 100) * CASE
                         WHEN pg.prazo = 0 THEN
                          1
                         ELSE
                          pg.prazo
                      END), 0) AS dividendo,
         coalesce(SUM(c.vlrliq * pg.percentual / 100), 0) AS divisor
    FROM (SELECT cab.nunota,
                 cab.codtipvenda,
                 SUM(ite.ad_vlrliq) AS vlrliq
            FROM SANKHYA.TGFCAB cab
            LEFT JOIN SANKHYA.TGFITE ite
              ON ite.nunota = cab.nunota
           CROSS JOIN parametros p
           WHERE cab.tipmov = 'P'
             AND cab.dtneg >= p.data_consulta_inicio
             AND cab.dtneg < p.data_consulta_fim
             AND cab.codtipoper > 999
             AND cab.codtipoper NOT IN (1002, 1003, 9002, 1006, 1009)
           GROUP BY cab.nunota,
                    cab.codtipvenda) c
    LEFT JOIN SANKHYA.TGFPPG pg
      ON pg.codtipvenda = c.codtipvenda
   GROUP BY c.nunota,
            c.codtipvenda),
base_vendas AS
(SELECT ger.codvend AS codgrv,
         cab.codvend AS codrca,
         item.nutab,
         coalesce(cab_orig.codusuinc, 0) AS codusuincped,
         coalesce(usu_orig.nomeusu, 'MEGA') AS usuincped,
         coalesce(cab.codusuinc, 0) AS codusuinc,
         coalesce(usu.nomeusu, 'MEGA') AS usuinc,
         cab.codcencus,
         cc.descrcencus,
         cab.codtipoper,
         top.descroper AS desctipoper,
         cab.nunota,
         item.sequencia AS sequencia,
         cab.dtneg,
         coalesce(cab.ad_diassemcompra, cab_orig.ad_diassemcompra) AS ad_diassemcompra,
         coalesce(cab.ad_dtultimacompra, cab_orig.ad_dtultimacompra) AS ad_dtultimacompra,
         cab.codparc,
         prod.codprod,
         prod.descrprod || prod.compldesc AS descrprod,
         prod.codgrupoprod,
         item.aliqicms,
         item.qtdneg,
         item.qtdentregue,
         item.pendente,
         item.ad_vlrliq,
         item.vlricms,
         item.perccom,
         item.nupromocao,
         CASE
            WHEN item.nupromocao IS NULL THEN
             'N'
            ELSE
             'S'
         END AS promo,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percom,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percentual_comissao,
         NVL(item.qtdneg, 0) AS qtd_considerada,
         CASE
            WHEN cab.codtipoper IN (1200, 1201, 1202, 1209, 9200) THEN
             -1
            ELSE
             1
         END AS fator_operacao,
         item.ad_vlrliq / NULLIF(item.qtdneg, 0) AS vlr_unitario_calculado,
         coalesce(item.qtdneg, 0) AS qtd_negociada,
         coalesce(preco.vlrvenda, 0) AS preco_tabela,
         CASE
            WHEN coalesce(preco.ad_vlrfrete, 0) = 0 THEN
             preco_orig.ad_vlrfrete
            ELSE
             preco.ad_vlrfrete
         END AS frete_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN custo_mes.CUSSEMICM
              WHEN item.VLRUNIT > 0 THEN item.VLRUNIT
              ELSE NULL END AS custo_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN
              CASE WHEN custo_mes.DTATUAL >= ADD_MONTHS(TRUNC(cab.DTNEG,'MM'),-1)
                         AND custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '01_MES_ANTERIOR'
                   WHEN custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '02_HISTORICO_ANTERIOR'
                   ELSE '03_ATUAL_CONTINGENCIA' END
              WHEN item.VLRUNIT > 0 THEN '04_VLRUNIT_CONTINGENCIA'
              ELSE 'SEM_REFERENCIA' END AS origem_custo,
         TO_CHAR(custo_mes.DTATUAL,'YYYY-MM-DD') AS data_custo_referencia,
         prazo.dividendo,
         prazo.divisor
    FROM SANKHYA.TGFCAB cab
    LEFT JOIN historico_gerentes ger
      ON ger.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN vend
      ON vend.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN gerente
      ON gerente.codvend = ger.codger
    LEFT JOIN SANKHYA.TGFITE item
      ON item.nunota = cab.nunota
    LEFT JOIN SANKHYA.TGFPRO prod
      ON prod.codprod = item.codprod
    OUTER APPLY (
      SELECT E.VLRVENDA, E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = item.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco
    LEFT JOIN SANKHYA.TSIUSU usu
      ON usu.codusu = cab.codusuinc
    LEFT JOIN SANKHYA.TSICUS cc
      ON cc.codcencus = cab.codcencus
    LEFT JOIN variacoes_nota var
      ON var.nunota = item.nunota
     AND var.sequencia = item.sequencia
    LEFT JOIN itens_originais item_orig
      ON item_orig.nunota = var.nunota
     AND item_orig.sequencia = var.sequencia
    LEFT JOIN cabecalhos_originais cab_orig
      ON cab_orig.nunota = var.nunota
     AND cab_orig.sequencia = var.sequencia
    LEFT JOIN SANKHYA.TSIUSU usu_orig
      ON usu_orig.codusu = cab_orig.codusuinc
    LEFT JOIN comissoes_originais com_orig
      ON com_orig.nunota = cab.nunota
     AND com_orig.sequencia = item.sequencia
     AND com_orig.nunotaorig = cab_orig.nunotaorig
     AND com_orig.sequenciaorig = item_orig.sequencia_item_origem
     AND com_orig.codprod = item.codprod
    LEFT JOIN variacoes_anteriores var_ant
      ON var_ant.nunota = var.nunotaorig
    LEFT JOIN SANKHYA.TGFCAB cab_ant
      ON cab_ant.nunota = var_ant.nunotaorig
    LEFT JOIN precos_originais tabela_orig
      ON tabela_orig.nunota = cab_ant.nunota
    OUTER APPLY (
      SELECT E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = tabela_orig.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco_orig
    LEFT JOIN SANKHYA.TGFTOP top
      ON top.codtipoper = cab.codtipoper
      AND top.dhalter = cab.dhtipoper
    LEFT JOIN valores_prazo_medio prazo
      ON prazo.nunota = cab.nunota
    OUTER APPLY (
      SELECT C.CUSSEMICM, C.DTATUAL
        FROM SANKHYA.TGFCUS C
       WHERE C.CODEMP = cab.CODEMP
         AND C.CODPROD = item.CODPROD
         AND C.CUSSEMICM > 0
       ORDER BY CASE WHEN C.DTATUAL < TRUNC(cab.DTNEG,'MM') THEN 0 ELSE 1 END,
                C.DTATUAL DESC, C.DHALTER DESC,
                C.CODLOCAL DESC, C.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) custo_mes
   CROSS JOIN parametros p
   WHERE
   CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END >= p.data_consulta_inicio
AND CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END < p.data_consulta_fim
 AND cab.codemp = 1
 AND cab.tipmov = 'P'
 AND cab.STATUSNOTA IN ('A','P','L')
 AND (cab.codtipoper IN (1000, 1001, 1005, 1007, 9000, 9001, 1002, 1003, 1006, 1009, 9002, 1004) OR (cab.codtipoper = 1100 AND prod.codgrupoprod = 40209001))
 AND cab.dtneg >= DATE '2026-01-01'
 AND cab.dtneg < DATE '2026-02-01'

),
calculos_comerciais AS
(SELECT b.*,
         b.qtd_considerada * b.fator_operacao AS qtdneg_calculada,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdaco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdalu,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlraco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlrapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlralu,
         b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao AS vlrtotal,
         (b.vlricms / NULLIF(b.qtdneg, 0)) * b.qtd_considerada * b.fator_operacao AS vlricms_calculado,
         coalesce(b.qtd_considerada * b.preco_tabela, 0) AS vlrtab,
         coalesce(b.qtd_considerada * b.frete_unitario, 0) AS ad_vlrfrete,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao
         END AS vlrcom,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao * 0.083333
         END AS x12avos,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165
         END AS vlrpis,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076
         END AS vlrcofins,
         b.qtd_considerada * b.custo_unitario * b.fator_operacao AS custo
    FROM base_vendas b),
resultado_final AS
(SELECT c.codgrv,
         c.codrca,
         c.codusuincped,
         c.usuincped,
         c.codusuinc,
         c.usuinc,
         c.codcencus,
         c.descrcencus,
         c.codtipoper,
         c.desctipoper,
         c.nunota,
         c.sequencia,
         c.dtneg,
         c.ad_diassemcompra,
         c.ad_dtultimacompra,
         c.codparc,
         c.promo,
         c.percom,
         c.codprod,
         c.descrprod,
         c.qtdaco,
         c.qtdapd,
         c.qtdalu,
         c.qtdneg_calculada  AS qtdneg,
         c.vlraco,
         c.vlrapd,
         c.vlralu,
         c.vlrtotal          AS vlrunit,
         c.vlricms_calculado AS vlricms,
         c.vlrtotal          AS vlrvenda,
         c.vlrtab,
         c.ad_vlrfrete,
         c.vlrcom,
         c.x12avos,
         c.vlrpis,
         c.vlrcofins,
         c.custo,
         c.custo_unitario,
         c.origem_custo,
         c.data_custo_referencia,
         coalesce(c.dividendo, 0) AS dividendo,
         coalesce(c.divisor, 0) AS divisor
    FROM calculos_comerciais c),
MARGEM_BRUTA AS (
    SELECT R.NUNOTA, R.SEQUENCIA, R.CODPARC,
           R.VLRVENDA, R.CUSTO, R.CUSTO_UNITARIO, R.ORIGEM_CUSTO, R.DATA_CUSTO_REFERENCIA, R.QTDNEG, R.VLRICMS, R.VLRPIS, R.VLRCOFINS,
           R.VLRCOM, R.X12AVOS, R.AD_VLRFRETE,
           ROW_NUMBER() OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
             ORDER BY R.NUNOTA
           ) RN,
           COUNT(*) OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
           ) N_VINCULOS
      FROM RESULTADO_FINAL R
),
MARGEM_ITENS AS (
    SELECT B.*,
           (NVL(B.VLRVENDA,0) -
            (NVL(B.CUSTO,0)+NVL(B.VLRICMS,0)+NVL(B.VLRPIS,0)+
             NVL(B.VLRCOFINS,0)+NVL(B.VLRCOM,0)+NVL(B.X12AVOS,0)+
             NVL(B.AD_VLRFRETE,0))) AS MARGEM
      FROM MARGEM_BRUTA B
     WHERE B.RN = 1
),
Q539_AGREGADO AS (
 SELECT M.NUNOTA AS PEDIDO_ID,
        I.CODPROD AS SKU,
        TO_CHAR(C.DTNEG,'YYYY-MM-DD') AS DIA,
        C.CODTIPOPER AS OPERACAO,
        NVL(C.CODVEND,-1) AS REPRESENTANTE,
        C.CODPARC AS CLIENTE,
        COUNT(*) AS ITENS,
        SUM(M.N_VINCULOS-1) AS DUPLICADOS,
        SUM(CASE WHEN (M.CUSTO_UNITARIO IS NULL OR M.CUSTO_UNITARIO<=0)
             AND NVL(I.QTDNEG,0)>0
             THEN 1 ELSE 0 END) AS SEM_CUSTO,
        SUM(NVL(M.VLRVENDA,0)) AS RECEITA,
        SUM(NVL(M.QTDNEG,0)) AS QUANTIDADE,
        SUM(NVL(M.CUSTO,0)) AS CUSTO,
        SUM(NVL(M.VLRICMS,0)) AS ICMS,
        SUM(NVL(M.VLRPIS,0)) AS PIS,
        SUM(NVL(M.VLRCOFINS,0)) AS COFINS,
        SUM(NVL(M.VLRCOM,0)) AS COMISSAO,
        SUM(NVL(M.X12AVOS,0)) AS REFLEXO_COMISSAO,
        SUM(NVL(M.AD_VLRFRETE,0)) AS FRETE,
        MAX(M.DATA_CUSTO_REFERENCIA) AS DATA_CUSTO,
        MAX(M.ORIGEM_CUSTO) AS ORIGEM_CUSTO,
        MAX(CASE WHEN NVL(I.NUPROMOCAO,0) > 0 THEN 1 ELSE 0 END) AS ITEM_PROMOCIONAL,
        SUM(NVL(M.MARGEM,0)) AS MARGEM
   FROM MARGEM_ITENS M
   JOIN SANKHYA.TGFCAB C ON C.NUNOTA=M.NUNOTA
   JOIN SANKHYA.TGFITE I ON I.NUNOTA=M.NUNOTA AND I.SEQUENCIA=M.SEQUENCIA
  GROUP BY M.NUNOTA,I.CODPROD,C.DTNEG,C.CODTIPOPER,C.CODVEND,C.CODPARC
)
SELECT PEDIDO_ID, SKU, DIA, OPERACAO, REPRESENTANTE, CLIENTE,
       ITENS, DUPLICADOS, SEM_CUSTO,
       ROUND(RECEITA,6) AS RECEITA,
       ROUND(QUANTIDADE,6) AS QUANTIDADE,
       ROUND(CUSTO,6) AS CUSTO,
       ROUND(ICMS,6) AS ICMS,
       ROUND(PIS,6) AS PIS,
       ROUND(COFINS,6) AS COFINS,
       ROUND(COMISSAO,6) AS COMISSAO,
       ROUND(REFLEXO_COMISSAO,6) AS REFLEXO_COMISSAO,
       ROUND(FRETE,6) AS FRETE,
       DATA_CUSTO,
       ORIGEM_CUSTO, ITEM_PROMOCIONAL,
       ROUND(MARGEM,6) AS MARGEM
  FROM Q539_AGREGADO
 ORDER BY PEDIDO_ID,SKU
</snk:query>
</c:catch>
<c:catch var="haialaFalhaQ539T02">
<snk:query var="haialaQ539T02">
WITH
parametros AS
(SELECT DATE '2026-01-01' AS data_inicial,
         TRUNC(SYSDATE) AS data_final,
         DATE '2026-02-01' AS data_consulta_inicio,
         DATE '2026-03-01' AS data_consulta_fim
    FROM dual),
historico_gerentes AS
(SELECT h.codger,
         h.codvend
    FROM SANKHYA.AD_HISGRVRCA h
   CROSS JOIN parametros p
   WHERE p.data_inicial BETWEEN h.dtinicial AND h.dtfinal),
variacoes_nota AS
(SELECT DISTINCT v.nunota,
                  v.sequencia,
                  v.nunotaorig,
                  v.sequenciaorig
    FROM SANKHYA.TGFVAR v),
itens_originais AS
(SELECT v.nunota,
         v.sequencia,
         v.nunotaorig,
         v.sequenciaorig,
         i.nunota        AS nunota_item_origem,
         i.sequencia     AS sequencia_item_origem
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunotaorig
     AND i.sequencia = v.sequenciaorig),
cabecalhos_originais AS
(SELECT i.nunota,
         i.sequencia,
         i.nunotaorig,
         i.sequenciaorig,
         c.nunota AS nunota_cab_origem,
         c.codusuinc,
         c.ad_diassemcompra,
         c.ad_dtultimacompra
    FROM itens_originais i
    LEFT JOIN SANKHYA.TGFCAB c
      ON c.nunota = i.nunota_item_origem),
comissoes_originais AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig,
                  v.sequencia,
                  v.sequenciaorig,
                  i.codprod,
                  i.perccom AS perccomf
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunota
     AND i.sequencia = v.sequencia),
variacoes_anteriores AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig
    FROM SANKHYA.TGFVAR v),
precos_originais AS
(SELECT DISTINCT i.nunota,
                  t.nutab
    FROM SANKHYA.TGFITE i
   INNER JOIN SANKHYA.TGFTAB t
      ON t.nutab = i.nutab),
valores_prazo_medio AS
(SELECT c.nunota,
         c.codtipvenda,
         coalesce(SUM((c.vlrliq * pg.percentual / 100) * CASE
                         WHEN pg.prazo = 0 THEN
                          1
                         ELSE
                          pg.prazo
                      END), 0) AS dividendo,
         coalesce(SUM(c.vlrliq * pg.percentual / 100), 0) AS divisor
    FROM (SELECT cab.nunota,
                 cab.codtipvenda,
                 SUM(ite.ad_vlrliq) AS vlrliq
            FROM SANKHYA.TGFCAB cab
            LEFT JOIN SANKHYA.TGFITE ite
              ON ite.nunota = cab.nunota
           CROSS JOIN parametros p
           WHERE cab.tipmov = 'P'
             AND cab.dtneg >= p.data_consulta_inicio
             AND cab.dtneg < p.data_consulta_fim
             AND cab.codtipoper > 999
             AND cab.codtipoper NOT IN (1002, 1003, 9002, 1006, 1009)
           GROUP BY cab.nunota,
                    cab.codtipvenda) c
    LEFT JOIN SANKHYA.TGFPPG pg
      ON pg.codtipvenda = c.codtipvenda
   GROUP BY c.nunota,
            c.codtipvenda),
base_vendas AS
(SELECT ger.codvend AS codgrv,
         cab.codvend AS codrca,
         item.nutab,
         coalesce(cab_orig.codusuinc, 0) AS codusuincped,
         coalesce(usu_orig.nomeusu, 'MEGA') AS usuincped,
         coalesce(cab.codusuinc, 0) AS codusuinc,
         coalesce(usu.nomeusu, 'MEGA') AS usuinc,
         cab.codcencus,
         cc.descrcencus,
         cab.codtipoper,
         top.descroper AS desctipoper,
         cab.nunota,
         item.sequencia AS sequencia,
         cab.dtneg,
         coalesce(cab.ad_diassemcompra, cab_orig.ad_diassemcompra) AS ad_diassemcompra,
         coalesce(cab.ad_dtultimacompra, cab_orig.ad_dtultimacompra) AS ad_dtultimacompra,
         cab.codparc,
         prod.codprod,
         prod.descrprod || prod.compldesc AS descrprod,
         prod.codgrupoprod,
         item.aliqicms,
         item.qtdneg,
         item.qtdentregue,
         item.pendente,
         item.ad_vlrliq,
         item.vlricms,
         item.perccom,
         item.nupromocao,
         CASE
            WHEN item.nupromocao IS NULL THEN
             'N'
            ELSE
             'S'
         END AS promo,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percom,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percentual_comissao,
         NVL(item.qtdneg, 0) AS qtd_considerada,
         CASE
            WHEN cab.codtipoper IN (1200, 1201, 1202, 1209, 9200) THEN
             -1
            ELSE
             1
         END AS fator_operacao,
         item.ad_vlrliq / NULLIF(item.qtdneg, 0) AS vlr_unitario_calculado,
         coalesce(item.qtdneg, 0) AS qtd_negociada,
         coalesce(preco.vlrvenda, 0) AS preco_tabela,
         CASE
            WHEN coalesce(preco.ad_vlrfrete, 0) = 0 THEN
             preco_orig.ad_vlrfrete
            ELSE
             preco.ad_vlrfrete
         END AS frete_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN custo_mes.CUSSEMICM
              WHEN item.VLRUNIT > 0 THEN item.VLRUNIT
              ELSE NULL END AS custo_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN
              CASE WHEN custo_mes.DTATUAL >= ADD_MONTHS(TRUNC(cab.DTNEG,'MM'),-1)
                         AND custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '01_MES_ANTERIOR'
                   WHEN custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '02_HISTORICO_ANTERIOR'
                   ELSE '03_ATUAL_CONTINGENCIA' END
              WHEN item.VLRUNIT > 0 THEN '04_VLRUNIT_CONTINGENCIA'
              ELSE 'SEM_REFERENCIA' END AS origem_custo,
         TO_CHAR(custo_mes.DTATUAL,'YYYY-MM-DD') AS data_custo_referencia,
         prazo.dividendo,
         prazo.divisor
    FROM SANKHYA.TGFCAB cab
    LEFT JOIN historico_gerentes ger
      ON ger.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN vend
      ON vend.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN gerente
      ON gerente.codvend = ger.codger
    LEFT JOIN SANKHYA.TGFITE item
      ON item.nunota = cab.nunota
    LEFT JOIN SANKHYA.TGFPRO prod
      ON prod.codprod = item.codprod
    OUTER APPLY (
      SELECT E.VLRVENDA, E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = item.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco
    LEFT JOIN SANKHYA.TSIUSU usu
      ON usu.codusu = cab.codusuinc
    LEFT JOIN SANKHYA.TSICUS cc
      ON cc.codcencus = cab.codcencus
    LEFT JOIN variacoes_nota var
      ON var.nunota = item.nunota
     AND var.sequencia = item.sequencia
    LEFT JOIN itens_originais item_orig
      ON item_orig.nunota = var.nunota
     AND item_orig.sequencia = var.sequencia
    LEFT JOIN cabecalhos_originais cab_orig
      ON cab_orig.nunota = var.nunota
     AND cab_orig.sequencia = var.sequencia
    LEFT JOIN SANKHYA.TSIUSU usu_orig
      ON usu_orig.codusu = cab_orig.codusuinc
    LEFT JOIN comissoes_originais com_orig
      ON com_orig.nunota = cab.nunota
     AND com_orig.sequencia = item.sequencia
     AND com_orig.nunotaorig = cab_orig.nunotaorig
     AND com_orig.sequenciaorig = item_orig.sequencia_item_origem
     AND com_orig.codprod = item.codprod
    LEFT JOIN variacoes_anteriores var_ant
      ON var_ant.nunota = var.nunotaorig
    LEFT JOIN SANKHYA.TGFCAB cab_ant
      ON cab_ant.nunota = var_ant.nunotaorig
    LEFT JOIN precos_originais tabela_orig
      ON tabela_orig.nunota = cab_ant.nunota
    OUTER APPLY (
      SELECT E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = tabela_orig.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco_orig
    LEFT JOIN SANKHYA.TGFTOP top
      ON top.codtipoper = cab.codtipoper
      AND top.dhalter = cab.dhtipoper
    LEFT JOIN valores_prazo_medio prazo
      ON prazo.nunota = cab.nunota
    OUTER APPLY (
      SELECT C.CUSSEMICM, C.DTATUAL
        FROM SANKHYA.TGFCUS C
       WHERE C.CODEMP = cab.CODEMP
         AND C.CODPROD = item.CODPROD
         AND C.CUSSEMICM > 0
       ORDER BY CASE WHEN C.DTATUAL < TRUNC(cab.DTNEG,'MM') THEN 0 ELSE 1 END,
                C.DTATUAL DESC, C.DHALTER DESC,
                C.CODLOCAL DESC, C.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) custo_mes
   CROSS JOIN parametros p
   WHERE
   CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END >= p.data_consulta_inicio
AND CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END < p.data_consulta_fim
 AND cab.codemp = 1
 AND cab.tipmov = 'P'
 AND cab.STATUSNOTA IN ('A','P','L')
 AND (cab.codtipoper IN (1000, 1001, 1005, 1007, 9000, 9001, 1002, 1003, 1006, 1009, 9002, 1004) OR (cab.codtipoper = 1100 AND prod.codgrupoprod = 40209001))
 AND cab.dtneg >= DATE '2026-02-01'
 AND cab.dtneg < DATE '2026-03-01'

),
calculos_comerciais AS
(SELECT b.*,
         b.qtd_considerada * b.fator_operacao AS qtdneg_calculada,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdaco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdalu,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlraco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlrapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlralu,
         b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao AS vlrtotal,
         (b.vlricms / NULLIF(b.qtdneg, 0)) * b.qtd_considerada * b.fator_operacao AS vlricms_calculado,
         coalesce(b.qtd_considerada * b.preco_tabela, 0) AS vlrtab,
         coalesce(b.qtd_considerada * b.frete_unitario, 0) AS ad_vlrfrete,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao
         END AS vlrcom,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao * 0.083333
         END AS x12avos,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165
         END AS vlrpis,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076
         END AS vlrcofins,
         b.qtd_considerada * b.custo_unitario * b.fator_operacao AS custo
    FROM base_vendas b),
resultado_final AS
(SELECT c.codgrv,
         c.codrca,
         c.codusuincped,
         c.usuincped,
         c.codusuinc,
         c.usuinc,
         c.codcencus,
         c.descrcencus,
         c.codtipoper,
         c.desctipoper,
         c.nunota,
         c.sequencia,
         c.dtneg,
         c.ad_diassemcompra,
         c.ad_dtultimacompra,
         c.codparc,
         c.promo,
         c.percom,
         c.codprod,
         c.descrprod,
         c.qtdaco,
         c.qtdapd,
         c.qtdalu,
         c.qtdneg_calculada  AS qtdneg,
         c.vlraco,
         c.vlrapd,
         c.vlralu,
         c.vlrtotal          AS vlrunit,
         c.vlricms_calculado AS vlricms,
         c.vlrtotal          AS vlrvenda,
         c.vlrtab,
         c.ad_vlrfrete,
         c.vlrcom,
         c.x12avos,
         c.vlrpis,
         c.vlrcofins,
         c.custo,
         c.custo_unitario,
         c.origem_custo,
         c.data_custo_referencia,
         coalesce(c.dividendo, 0) AS dividendo,
         coalesce(c.divisor, 0) AS divisor
    FROM calculos_comerciais c),
MARGEM_BRUTA AS (
    SELECT R.NUNOTA, R.SEQUENCIA, R.CODPARC,
           R.VLRVENDA, R.CUSTO, R.CUSTO_UNITARIO, R.ORIGEM_CUSTO, R.DATA_CUSTO_REFERENCIA, R.QTDNEG, R.VLRICMS, R.VLRPIS, R.VLRCOFINS,
           R.VLRCOM, R.X12AVOS, R.AD_VLRFRETE,
           ROW_NUMBER() OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
             ORDER BY R.NUNOTA
           ) RN,
           COUNT(*) OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
           ) N_VINCULOS
      FROM RESULTADO_FINAL R
),
MARGEM_ITENS AS (
    SELECT B.*,
           (NVL(B.VLRVENDA,0) -
            (NVL(B.CUSTO,0)+NVL(B.VLRICMS,0)+NVL(B.VLRPIS,0)+
             NVL(B.VLRCOFINS,0)+NVL(B.VLRCOM,0)+NVL(B.X12AVOS,0)+
             NVL(B.AD_VLRFRETE,0))) AS MARGEM
      FROM MARGEM_BRUTA B
     WHERE B.RN = 1
),
Q539_AGREGADO AS (
 SELECT M.NUNOTA AS PEDIDO_ID,
        I.CODPROD AS SKU,
        TO_CHAR(C.DTNEG,'YYYY-MM-DD') AS DIA,
        C.CODTIPOPER AS OPERACAO,
        NVL(C.CODVEND,-1) AS REPRESENTANTE,
        C.CODPARC AS CLIENTE,
        COUNT(*) AS ITENS,
        SUM(M.N_VINCULOS-1) AS DUPLICADOS,
        SUM(CASE WHEN (M.CUSTO_UNITARIO IS NULL OR M.CUSTO_UNITARIO<=0)
             AND NVL(I.QTDNEG,0)>0
             THEN 1 ELSE 0 END) AS SEM_CUSTO,
        SUM(NVL(M.VLRVENDA,0)) AS RECEITA,
        SUM(NVL(M.QTDNEG,0)) AS QUANTIDADE,
        SUM(NVL(M.CUSTO,0)) AS CUSTO,
        SUM(NVL(M.VLRICMS,0)) AS ICMS,
        SUM(NVL(M.VLRPIS,0)) AS PIS,
        SUM(NVL(M.VLRCOFINS,0)) AS COFINS,
        SUM(NVL(M.VLRCOM,0)) AS COMISSAO,
        SUM(NVL(M.X12AVOS,0)) AS REFLEXO_COMISSAO,
        SUM(NVL(M.AD_VLRFRETE,0)) AS FRETE,
        MAX(M.DATA_CUSTO_REFERENCIA) AS DATA_CUSTO,
        MAX(M.ORIGEM_CUSTO) AS ORIGEM_CUSTO,
        MAX(CASE WHEN NVL(I.NUPROMOCAO,0) > 0 THEN 1 ELSE 0 END) AS ITEM_PROMOCIONAL,
        SUM(NVL(M.MARGEM,0)) AS MARGEM
   FROM MARGEM_ITENS M
   JOIN SANKHYA.TGFCAB C ON C.NUNOTA=M.NUNOTA
   JOIN SANKHYA.TGFITE I ON I.NUNOTA=M.NUNOTA AND I.SEQUENCIA=M.SEQUENCIA
  GROUP BY M.NUNOTA,I.CODPROD,C.DTNEG,C.CODTIPOPER,C.CODVEND,C.CODPARC
)
SELECT PEDIDO_ID, SKU, DIA, OPERACAO, REPRESENTANTE, CLIENTE,
       ITENS, DUPLICADOS, SEM_CUSTO,
       ROUND(RECEITA,6) AS RECEITA,
       ROUND(QUANTIDADE,6) AS QUANTIDADE,
       ROUND(CUSTO,6) AS CUSTO,
       ROUND(ICMS,6) AS ICMS,
       ROUND(PIS,6) AS PIS,
       ROUND(COFINS,6) AS COFINS,
       ROUND(COMISSAO,6) AS COMISSAO,
       ROUND(REFLEXO_COMISSAO,6) AS REFLEXO_COMISSAO,
       ROUND(FRETE,6) AS FRETE,
       DATA_CUSTO,
       ORIGEM_CUSTO, ITEM_PROMOCIONAL,
       ROUND(MARGEM,6) AS MARGEM
  FROM Q539_AGREGADO
 ORDER BY PEDIDO_ID,SKU
</snk:query>
</c:catch>
<c:catch var="haialaFalhaQ539T03">
<snk:query var="haialaQ539T03">
WITH
parametros AS
(SELECT DATE '2026-01-01' AS data_inicial,
         TRUNC(SYSDATE) AS data_final,
         DATE '2026-03-01' AS data_consulta_inicio,
         DATE '2026-04-01' AS data_consulta_fim
    FROM dual),
historico_gerentes AS
(SELECT h.codger,
         h.codvend
    FROM SANKHYA.AD_HISGRVRCA h
   CROSS JOIN parametros p
   WHERE p.data_inicial BETWEEN h.dtinicial AND h.dtfinal),
variacoes_nota AS
(SELECT DISTINCT v.nunota,
                  v.sequencia,
                  v.nunotaorig,
                  v.sequenciaorig
    FROM SANKHYA.TGFVAR v),
itens_originais AS
(SELECT v.nunota,
         v.sequencia,
         v.nunotaorig,
         v.sequenciaorig,
         i.nunota        AS nunota_item_origem,
         i.sequencia     AS sequencia_item_origem
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunotaorig
     AND i.sequencia = v.sequenciaorig),
cabecalhos_originais AS
(SELECT i.nunota,
         i.sequencia,
         i.nunotaorig,
         i.sequenciaorig,
         c.nunota AS nunota_cab_origem,
         c.codusuinc,
         c.ad_diassemcompra,
         c.ad_dtultimacompra
    FROM itens_originais i
    LEFT JOIN SANKHYA.TGFCAB c
      ON c.nunota = i.nunota_item_origem),
comissoes_originais AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig,
                  v.sequencia,
                  v.sequenciaorig,
                  i.codprod,
                  i.perccom AS perccomf
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunota
     AND i.sequencia = v.sequencia),
variacoes_anteriores AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig
    FROM SANKHYA.TGFVAR v),
precos_originais AS
(SELECT DISTINCT i.nunota,
                  t.nutab
    FROM SANKHYA.TGFITE i
   INNER JOIN SANKHYA.TGFTAB t
      ON t.nutab = i.nutab),
valores_prazo_medio AS
(SELECT c.nunota,
         c.codtipvenda,
         coalesce(SUM((c.vlrliq * pg.percentual / 100) * CASE
                         WHEN pg.prazo = 0 THEN
                          1
                         ELSE
                          pg.prazo
                      END), 0) AS dividendo,
         coalesce(SUM(c.vlrliq * pg.percentual / 100), 0) AS divisor
    FROM (SELECT cab.nunota,
                 cab.codtipvenda,
                 SUM(ite.ad_vlrliq) AS vlrliq
            FROM SANKHYA.TGFCAB cab
            LEFT JOIN SANKHYA.TGFITE ite
              ON ite.nunota = cab.nunota
           CROSS JOIN parametros p
           WHERE cab.tipmov = 'P'
             AND cab.dtneg >= p.data_consulta_inicio
             AND cab.dtneg < p.data_consulta_fim
             AND cab.codtipoper > 999
             AND cab.codtipoper NOT IN (1002, 1003, 9002, 1006, 1009)
           GROUP BY cab.nunota,
                    cab.codtipvenda) c
    LEFT JOIN SANKHYA.TGFPPG pg
      ON pg.codtipvenda = c.codtipvenda
   GROUP BY c.nunota,
            c.codtipvenda),
base_vendas AS
(SELECT ger.codvend AS codgrv,
         cab.codvend AS codrca,
         item.nutab,
         coalesce(cab_orig.codusuinc, 0) AS codusuincped,
         coalesce(usu_orig.nomeusu, 'MEGA') AS usuincped,
         coalesce(cab.codusuinc, 0) AS codusuinc,
         coalesce(usu.nomeusu, 'MEGA') AS usuinc,
         cab.codcencus,
         cc.descrcencus,
         cab.codtipoper,
         top.descroper AS desctipoper,
         cab.nunota,
         item.sequencia AS sequencia,
         cab.dtneg,
         coalesce(cab.ad_diassemcompra, cab_orig.ad_diassemcompra) AS ad_diassemcompra,
         coalesce(cab.ad_dtultimacompra, cab_orig.ad_dtultimacompra) AS ad_dtultimacompra,
         cab.codparc,
         prod.codprod,
         prod.descrprod || prod.compldesc AS descrprod,
         prod.codgrupoprod,
         item.aliqicms,
         item.qtdneg,
         item.qtdentregue,
         item.pendente,
         item.ad_vlrliq,
         item.vlricms,
         item.perccom,
         item.nupromocao,
         CASE
            WHEN item.nupromocao IS NULL THEN
             'N'
            ELSE
             'S'
         END AS promo,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percom,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percentual_comissao,
         NVL(item.qtdneg, 0) AS qtd_considerada,
         CASE
            WHEN cab.codtipoper IN (1200, 1201, 1202, 1209, 9200) THEN
             -1
            ELSE
             1
         END AS fator_operacao,
         item.ad_vlrliq / NULLIF(item.qtdneg, 0) AS vlr_unitario_calculado,
         coalesce(item.qtdneg, 0) AS qtd_negociada,
         coalesce(preco.vlrvenda, 0) AS preco_tabela,
         CASE
            WHEN coalesce(preco.ad_vlrfrete, 0) = 0 THEN
             preco_orig.ad_vlrfrete
            ELSE
             preco.ad_vlrfrete
         END AS frete_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN custo_mes.CUSSEMICM
              WHEN item.VLRUNIT > 0 THEN item.VLRUNIT
              ELSE NULL END AS custo_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN
              CASE WHEN custo_mes.DTATUAL >= ADD_MONTHS(TRUNC(cab.DTNEG,'MM'),-1)
                         AND custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '01_MES_ANTERIOR'
                   WHEN custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '02_HISTORICO_ANTERIOR'
                   ELSE '03_ATUAL_CONTINGENCIA' END
              WHEN item.VLRUNIT > 0 THEN '04_VLRUNIT_CONTINGENCIA'
              ELSE 'SEM_REFERENCIA' END AS origem_custo,
         TO_CHAR(custo_mes.DTATUAL,'YYYY-MM-DD') AS data_custo_referencia,
         prazo.dividendo,
         prazo.divisor
    FROM SANKHYA.TGFCAB cab
    LEFT JOIN historico_gerentes ger
      ON ger.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN vend
      ON vend.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN gerente
      ON gerente.codvend = ger.codger
    LEFT JOIN SANKHYA.TGFITE item
      ON item.nunota = cab.nunota
    LEFT JOIN SANKHYA.TGFPRO prod
      ON prod.codprod = item.codprod
    OUTER APPLY (
      SELECT E.VLRVENDA, E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = item.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco
    LEFT JOIN SANKHYA.TSIUSU usu
      ON usu.codusu = cab.codusuinc
    LEFT JOIN SANKHYA.TSICUS cc
      ON cc.codcencus = cab.codcencus
    LEFT JOIN variacoes_nota var
      ON var.nunota = item.nunota
     AND var.sequencia = item.sequencia
    LEFT JOIN itens_originais item_orig
      ON item_orig.nunota = var.nunota
     AND item_orig.sequencia = var.sequencia
    LEFT JOIN cabecalhos_originais cab_orig
      ON cab_orig.nunota = var.nunota
     AND cab_orig.sequencia = var.sequencia
    LEFT JOIN SANKHYA.TSIUSU usu_orig
      ON usu_orig.codusu = cab_orig.codusuinc
    LEFT JOIN comissoes_originais com_orig
      ON com_orig.nunota = cab.nunota
     AND com_orig.sequencia = item.sequencia
     AND com_orig.nunotaorig = cab_orig.nunotaorig
     AND com_orig.sequenciaorig = item_orig.sequencia_item_origem
     AND com_orig.codprod = item.codprod
    LEFT JOIN variacoes_anteriores var_ant
      ON var_ant.nunota = var.nunotaorig
    LEFT JOIN SANKHYA.TGFCAB cab_ant
      ON cab_ant.nunota = var_ant.nunotaorig
    LEFT JOIN precos_originais tabela_orig
      ON tabela_orig.nunota = cab_ant.nunota
    OUTER APPLY (
      SELECT E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = tabela_orig.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco_orig
    LEFT JOIN SANKHYA.TGFTOP top
      ON top.codtipoper = cab.codtipoper
      AND top.dhalter = cab.dhtipoper
    LEFT JOIN valores_prazo_medio prazo
      ON prazo.nunota = cab.nunota
    OUTER APPLY (
      SELECT C.CUSSEMICM, C.DTATUAL
        FROM SANKHYA.TGFCUS C
       WHERE C.CODEMP = cab.CODEMP
         AND C.CODPROD = item.CODPROD
         AND C.CUSSEMICM > 0
       ORDER BY CASE WHEN C.DTATUAL < TRUNC(cab.DTNEG,'MM') THEN 0 ELSE 1 END,
                C.DTATUAL DESC, C.DHALTER DESC,
                C.CODLOCAL DESC, C.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) custo_mes
   CROSS JOIN parametros p
   WHERE
   CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END >= p.data_consulta_inicio
AND CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END < p.data_consulta_fim
 AND cab.codemp = 1
 AND cab.tipmov = 'P'
 AND cab.STATUSNOTA IN ('A','P','L')
 AND (cab.codtipoper IN (1000, 1001, 1005, 1007, 9000, 9001, 1002, 1003, 1006, 1009, 9002, 1004) OR (cab.codtipoper = 1100 AND prod.codgrupoprod = 40209001))
 AND cab.dtneg >= DATE '2026-03-01'
 AND cab.dtneg < DATE '2026-04-01'

),
calculos_comerciais AS
(SELECT b.*,
         b.qtd_considerada * b.fator_operacao AS qtdneg_calculada,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdaco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdalu,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlraco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlrapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlralu,
         b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao AS vlrtotal,
         (b.vlricms / NULLIF(b.qtdneg, 0)) * b.qtd_considerada * b.fator_operacao AS vlricms_calculado,
         coalesce(b.qtd_considerada * b.preco_tabela, 0) AS vlrtab,
         coalesce(b.qtd_considerada * b.frete_unitario, 0) AS ad_vlrfrete,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao
         END AS vlrcom,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao * 0.083333
         END AS x12avos,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165
         END AS vlrpis,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076
         END AS vlrcofins,
         b.qtd_considerada * b.custo_unitario * b.fator_operacao AS custo
    FROM base_vendas b),
resultado_final AS
(SELECT c.codgrv,
         c.codrca,
         c.codusuincped,
         c.usuincped,
         c.codusuinc,
         c.usuinc,
         c.codcencus,
         c.descrcencus,
         c.codtipoper,
         c.desctipoper,
         c.nunota,
         c.sequencia,
         c.dtneg,
         c.ad_diassemcompra,
         c.ad_dtultimacompra,
         c.codparc,
         c.promo,
         c.percom,
         c.codprod,
         c.descrprod,
         c.qtdaco,
         c.qtdapd,
         c.qtdalu,
         c.qtdneg_calculada  AS qtdneg,
         c.vlraco,
         c.vlrapd,
         c.vlralu,
         c.vlrtotal          AS vlrunit,
         c.vlricms_calculado AS vlricms,
         c.vlrtotal          AS vlrvenda,
         c.vlrtab,
         c.ad_vlrfrete,
         c.vlrcom,
         c.x12avos,
         c.vlrpis,
         c.vlrcofins,
         c.custo,
         c.custo_unitario,
         c.origem_custo,
         c.data_custo_referencia,
         coalesce(c.dividendo, 0) AS dividendo,
         coalesce(c.divisor, 0) AS divisor
    FROM calculos_comerciais c),
MARGEM_BRUTA AS (
    SELECT R.NUNOTA, R.SEQUENCIA, R.CODPARC,
           R.VLRVENDA, R.CUSTO, R.CUSTO_UNITARIO, R.ORIGEM_CUSTO, R.DATA_CUSTO_REFERENCIA, R.QTDNEG, R.VLRICMS, R.VLRPIS, R.VLRCOFINS,
           R.VLRCOM, R.X12AVOS, R.AD_VLRFRETE,
           ROW_NUMBER() OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
             ORDER BY R.NUNOTA
           ) RN,
           COUNT(*) OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
           ) N_VINCULOS
      FROM RESULTADO_FINAL R
),
MARGEM_ITENS AS (
    SELECT B.*,
           (NVL(B.VLRVENDA,0) -
            (NVL(B.CUSTO,0)+NVL(B.VLRICMS,0)+NVL(B.VLRPIS,0)+
             NVL(B.VLRCOFINS,0)+NVL(B.VLRCOM,0)+NVL(B.X12AVOS,0)+
             NVL(B.AD_VLRFRETE,0))) AS MARGEM
      FROM MARGEM_BRUTA B
     WHERE B.RN = 1
),
Q539_AGREGADO AS (
 SELECT M.NUNOTA AS PEDIDO_ID,
        I.CODPROD AS SKU,
        TO_CHAR(C.DTNEG,'YYYY-MM-DD') AS DIA,
        C.CODTIPOPER AS OPERACAO,
        NVL(C.CODVEND,-1) AS REPRESENTANTE,
        C.CODPARC AS CLIENTE,
        COUNT(*) AS ITENS,
        SUM(M.N_VINCULOS-1) AS DUPLICADOS,
        SUM(CASE WHEN (M.CUSTO_UNITARIO IS NULL OR M.CUSTO_UNITARIO<=0)
             AND NVL(I.QTDNEG,0)>0
             THEN 1 ELSE 0 END) AS SEM_CUSTO,
        SUM(NVL(M.VLRVENDA,0)) AS RECEITA,
        SUM(NVL(M.QTDNEG,0)) AS QUANTIDADE,
        SUM(NVL(M.CUSTO,0)) AS CUSTO,
        SUM(NVL(M.VLRICMS,0)) AS ICMS,
        SUM(NVL(M.VLRPIS,0)) AS PIS,
        SUM(NVL(M.VLRCOFINS,0)) AS COFINS,
        SUM(NVL(M.VLRCOM,0)) AS COMISSAO,
        SUM(NVL(M.X12AVOS,0)) AS REFLEXO_COMISSAO,
        SUM(NVL(M.AD_VLRFRETE,0)) AS FRETE,
        MAX(M.DATA_CUSTO_REFERENCIA) AS DATA_CUSTO,
        MAX(M.ORIGEM_CUSTO) AS ORIGEM_CUSTO,
        MAX(CASE WHEN NVL(I.NUPROMOCAO,0) > 0 THEN 1 ELSE 0 END) AS ITEM_PROMOCIONAL,
        SUM(NVL(M.MARGEM,0)) AS MARGEM
   FROM MARGEM_ITENS M
   JOIN SANKHYA.TGFCAB C ON C.NUNOTA=M.NUNOTA
   JOIN SANKHYA.TGFITE I ON I.NUNOTA=M.NUNOTA AND I.SEQUENCIA=M.SEQUENCIA
  GROUP BY M.NUNOTA,I.CODPROD,C.DTNEG,C.CODTIPOPER,C.CODVEND,C.CODPARC
)
SELECT PEDIDO_ID, SKU, DIA, OPERACAO, REPRESENTANTE, CLIENTE,
       ITENS, DUPLICADOS, SEM_CUSTO,
       ROUND(RECEITA,6) AS RECEITA,
       ROUND(QUANTIDADE,6) AS QUANTIDADE,
       ROUND(CUSTO,6) AS CUSTO,
       ROUND(ICMS,6) AS ICMS,
       ROUND(PIS,6) AS PIS,
       ROUND(COFINS,6) AS COFINS,
       ROUND(COMISSAO,6) AS COMISSAO,
       ROUND(REFLEXO_COMISSAO,6) AS REFLEXO_COMISSAO,
       ROUND(FRETE,6) AS FRETE,
       DATA_CUSTO,
       ORIGEM_CUSTO, ITEM_PROMOCIONAL,
       ROUND(MARGEM,6) AS MARGEM
  FROM Q539_AGREGADO
 ORDER BY PEDIDO_ID,SKU
</snk:query>
</c:catch>
<c:catch var="haialaFalhaQ539T04">
<snk:query var="haialaQ539T04">
WITH
parametros AS
(SELECT DATE '2026-01-01' AS data_inicial,
         TRUNC(SYSDATE) AS data_final,
         DATE '2026-04-01' AS data_consulta_inicio,
         DATE '2026-05-01' AS data_consulta_fim
    FROM dual),
historico_gerentes AS
(SELECT h.codger,
         h.codvend
    FROM SANKHYA.AD_HISGRVRCA h
   CROSS JOIN parametros p
   WHERE p.data_inicial BETWEEN h.dtinicial AND h.dtfinal),
variacoes_nota AS
(SELECT DISTINCT v.nunota,
                  v.sequencia,
                  v.nunotaorig,
                  v.sequenciaorig
    FROM SANKHYA.TGFVAR v),
itens_originais AS
(SELECT v.nunota,
         v.sequencia,
         v.nunotaorig,
         v.sequenciaorig,
         i.nunota        AS nunota_item_origem,
         i.sequencia     AS sequencia_item_origem
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunotaorig
     AND i.sequencia = v.sequenciaorig),
cabecalhos_originais AS
(SELECT i.nunota,
         i.sequencia,
         i.nunotaorig,
         i.sequenciaorig,
         c.nunota AS nunota_cab_origem,
         c.codusuinc,
         c.ad_diassemcompra,
         c.ad_dtultimacompra
    FROM itens_originais i
    LEFT JOIN SANKHYA.TGFCAB c
      ON c.nunota = i.nunota_item_origem),
comissoes_originais AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig,
                  v.sequencia,
                  v.sequenciaorig,
                  i.codprod,
                  i.perccom AS perccomf
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunota
     AND i.sequencia = v.sequencia),
variacoes_anteriores AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig
    FROM SANKHYA.TGFVAR v),
precos_originais AS
(SELECT DISTINCT i.nunota,
                  t.nutab
    FROM SANKHYA.TGFITE i
   INNER JOIN SANKHYA.TGFTAB t
      ON t.nutab = i.nutab),
valores_prazo_medio AS
(SELECT c.nunota,
         c.codtipvenda,
         coalesce(SUM((c.vlrliq * pg.percentual / 100) * CASE
                         WHEN pg.prazo = 0 THEN
                          1
                         ELSE
                          pg.prazo
                      END), 0) AS dividendo,
         coalesce(SUM(c.vlrliq * pg.percentual / 100), 0) AS divisor
    FROM (SELECT cab.nunota,
                 cab.codtipvenda,
                 SUM(ite.ad_vlrliq) AS vlrliq
            FROM SANKHYA.TGFCAB cab
            LEFT JOIN SANKHYA.TGFITE ite
              ON ite.nunota = cab.nunota
           CROSS JOIN parametros p
           WHERE cab.tipmov = 'P'
             AND cab.dtneg >= p.data_consulta_inicio
             AND cab.dtneg < p.data_consulta_fim
             AND cab.codtipoper > 999
             AND cab.codtipoper NOT IN (1002, 1003, 9002, 1006, 1009)
           GROUP BY cab.nunota,
                    cab.codtipvenda) c
    LEFT JOIN SANKHYA.TGFPPG pg
      ON pg.codtipvenda = c.codtipvenda
   GROUP BY c.nunota,
            c.codtipvenda),
base_vendas AS
(SELECT ger.codvend AS codgrv,
         cab.codvend AS codrca,
         item.nutab,
         coalesce(cab_orig.codusuinc, 0) AS codusuincped,
         coalesce(usu_orig.nomeusu, 'MEGA') AS usuincped,
         coalesce(cab.codusuinc, 0) AS codusuinc,
         coalesce(usu.nomeusu, 'MEGA') AS usuinc,
         cab.codcencus,
         cc.descrcencus,
         cab.codtipoper,
         top.descroper AS desctipoper,
         cab.nunota,
         item.sequencia AS sequencia,
         cab.dtneg,
         coalesce(cab.ad_diassemcompra, cab_orig.ad_diassemcompra) AS ad_diassemcompra,
         coalesce(cab.ad_dtultimacompra, cab_orig.ad_dtultimacompra) AS ad_dtultimacompra,
         cab.codparc,
         prod.codprod,
         prod.descrprod || prod.compldesc AS descrprod,
         prod.codgrupoprod,
         item.aliqicms,
         item.qtdneg,
         item.qtdentregue,
         item.pendente,
         item.ad_vlrliq,
         item.vlricms,
         item.perccom,
         item.nupromocao,
         CASE
            WHEN item.nupromocao IS NULL THEN
             'N'
            ELSE
             'S'
         END AS promo,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percom,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percentual_comissao,
         NVL(item.qtdneg, 0) AS qtd_considerada,
         CASE
            WHEN cab.codtipoper IN (1200, 1201, 1202, 1209, 9200) THEN
             -1
            ELSE
             1
         END AS fator_operacao,
         item.ad_vlrliq / NULLIF(item.qtdneg, 0) AS vlr_unitario_calculado,
         coalesce(item.qtdneg, 0) AS qtd_negociada,
         coalesce(preco.vlrvenda, 0) AS preco_tabela,
         CASE
            WHEN coalesce(preco.ad_vlrfrete, 0) = 0 THEN
             preco_orig.ad_vlrfrete
            ELSE
             preco.ad_vlrfrete
         END AS frete_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN custo_mes.CUSSEMICM
              WHEN item.VLRUNIT > 0 THEN item.VLRUNIT
              ELSE NULL END AS custo_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN
              CASE WHEN custo_mes.DTATUAL >= ADD_MONTHS(TRUNC(cab.DTNEG,'MM'),-1)
                         AND custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '01_MES_ANTERIOR'
                   WHEN custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '02_HISTORICO_ANTERIOR'
                   ELSE '03_ATUAL_CONTINGENCIA' END
              WHEN item.VLRUNIT > 0 THEN '04_VLRUNIT_CONTINGENCIA'
              ELSE 'SEM_REFERENCIA' END AS origem_custo,
         TO_CHAR(custo_mes.DTATUAL,'YYYY-MM-DD') AS data_custo_referencia,
         prazo.dividendo,
         prazo.divisor
    FROM SANKHYA.TGFCAB cab
    LEFT JOIN historico_gerentes ger
      ON ger.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN vend
      ON vend.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN gerente
      ON gerente.codvend = ger.codger
    LEFT JOIN SANKHYA.TGFITE item
      ON item.nunota = cab.nunota
    LEFT JOIN SANKHYA.TGFPRO prod
      ON prod.codprod = item.codprod
    OUTER APPLY (
      SELECT E.VLRVENDA, E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = item.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco
    LEFT JOIN SANKHYA.TSIUSU usu
      ON usu.codusu = cab.codusuinc
    LEFT JOIN SANKHYA.TSICUS cc
      ON cc.codcencus = cab.codcencus
    LEFT JOIN variacoes_nota var
      ON var.nunota = item.nunota
     AND var.sequencia = item.sequencia
    LEFT JOIN itens_originais item_orig
      ON item_orig.nunota = var.nunota
     AND item_orig.sequencia = var.sequencia
    LEFT JOIN cabecalhos_originais cab_orig
      ON cab_orig.nunota = var.nunota
     AND cab_orig.sequencia = var.sequencia
    LEFT JOIN SANKHYA.TSIUSU usu_orig
      ON usu_orig.codusu = cab_orig.codusuinc
    LEFT JOIN comissoes_originais com_orig
      ON com_orig.nunota = cab.nunota
     AND com_orig.sequencia = item.sequencia
     AND com_orig.nunotaorig = cab_orig.nunotaorig
     AND com_orig.sequenciaorig = item_orig.sequencia_item_origem
     AND com_orig.codprod = item.codprod
    LEFT JOIN variacoes_anteriores var_ant
      ON var_ant.nunota = var.nunotaorig
    LEFT JOIN SANKHYA.TGFCAB cab_ant
      ON cab_ant.nunota = var_ant.nunotaorig
    LEFT JOIN precos_originais tabela_orig
      ON tabela_orig.nunota = cab_ant.nunota
    OUTER APPLY (
      SELECT E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = tabela_orig.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco_orig
    LEFT JOIN SANKHYA.TGFTOP top
      ON top.codtipoper = cab.codtipoper
      AND top.dhalter = cab.dhtipoper
    LEFT JOIN valores_prazo_medio prazo
      ON prazo.nunota = cab.nunota
    OUTER APPLY (
      SELECT C.CUSSEMICM, C.DTATUAL
        FROM SANKHYA.TGFCUS C
       WHERE C.CODEMP = cab.CODEMP
         AND C.CODPROD = item.CODPROD
         AND C.CUSSEMICM > 0
       ORDER BY CASE WHEN C.DTATUAL < TRUNC(cab.DTNEG,'MM') THEN 0 ELSE 1 END,
                C.DTATUAL DESC, C.DHALTER DESC,
                C.CODLOCAL DESC, C.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) custo_mes
   CROSS JOIN parametros p
   WHERE
   CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END >= p.data_consulta_inicio
AND CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END < p.data_consulta_fim
 AND cab.codemp = 1
 AND cab.tipmov = 'P'
 AND cab.STATUSNOTA IN ('A','P','L')
 AND (cab.codtipoper IN (1000, 1001, 1005, 1007, 9000, 9001, 1002, 1003, 1006, 1009, 9002, 1004) OR (cab.codtipoper = 1100 AND prod.codgrupoprod = 40209001))
 AND cab.dtneg >= DATE '2026-04-01'
 AND cab.dtneg < DATE '2026-05-01'

),
calculos_comerciais AS
(SELECT b.*,
         b.qtd_considerada * b.fator_operacao AS qtdneg_calculada,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdaco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdalu,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlraco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlrapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlralu,
         b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao AS vlrtotal,
         (b.vlricms / NULLIF(b.qtdneg, 0)) * b.qtd_considerada * b.fator_operacao AS vlricms_calculado,
         coalesce(b.qtd_considerada * b.preco_tabela, 0) AS vlrtab,
         coalesce(b.qtd_considerada * b.frete_unitario, 0) AS ad_vlrfrete,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao
         END AS vlrcom,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao * 0.083333
         END AS x12avos,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165
         END AS vlrpis,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076
         END AS vlrcofins,
         b.qtd_considerada * b.custo_unitario * b.fator_operacao AS custo
    FROM base_vendas b),
resultado_final AS
(SELECT c.codgrv,
         c.codrca,
         c.codusuincped,
         c.usuincped,
         c.codusuinc,
         c.usuinc,
         c.codcencus,
         c.descrcencus,
         c.codtipoper,
         c.desctipoper,
         c.nunota,
         c.sequencia,
         c.dtneg,
         c.ad_diassemcompra,
         c.ad_dtultimacompra,
         c.codparc,
         c.promo,
         c.percom,
         c.codprod,
         c.descrprod,
         c.qtdaco,
         c.qtdapd,
         c.qtdalu,
         c.qtdneg_calculada  AS qtdneg,
         c.vlraco,
         c.vlrapd,
         c.vlralu,
         c.vlrtotal          AS vlrunit,
         c.vlricms_calculado AS vlricms,
         c.vlrtotal          AS vlrvenda,
         c.vlrtab,
         c.ad_vlrfrete,
         c.vlrcom,
         c.x12avos,
         c.vlrpis,
         c.vlrcofins,
         c.custo,
         c.custo_unitario,
         c.origem_custo,
         c.data_custo_referencia,
         coalesce(c.dividendo, 0) AS dividendo,
         coalesce(c.divisor, 0) AS divisor
    FROM calculos_comerciais c),
MARGEM_BRUTA AS (
    SELECT R.NUNOTA, R.SEQUENCIA, R.CODPARC,
           R.VLRVENDA, R.CUSTO, R.CUSTO_UNITARIO, R.ORIGEM_CUSTO, R.DATA_CUSTO_REFERENCIA, R.QTDNEG, R.VLRICMS, R.VLRPIS, R.VLRCOFINS,
           R.VLRCOM, R.X12AVOS, R.AD_VLRFRETE,
           ROW_NUMBER() OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
             ORDER BY R.NUNOTA
           ) RN,
           COUNT(*) OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
           ) N_VINCULOS
      FROM RESULTADO_FINAL R
),
MARGEM_ITENS AS (
    SELECT B.*,
           (NVL(B.VLRVENDA,0) -
            (NVL(B.CUSTO,0)+NVL(B.VLRICMS,0)+NVL(B.VLRPIS,0)+
             NVL(B.VLRCOFINS,0)+NVL(B.VLRCOM,0)+NVL(B.X12AVOS,0)+
             NVL(B.AD_VLRFRETE,0))) AS MARGEM
      FROM MARGEM_BRUTA B
     WHERE B.RN = 1
),
Q539_AGREGADO AS (
 SELECT M.NUNOTA AS PEDIDO_ID,
        I.CODPROD AS SKU,
        TO_CHAR(C.DTNEG,'YYYY-MM-DD') AS DIA,
        C.CODTIPOPER AS OPERACAO,
        NVL(C.CODVEND,-1) AS REPRESENTANTE,
        C.CODPARC AS CLIENTE,
        COUNT(*) AS ITENS,
        SUM(M.N_VINCULOS-1) AS DUPLICADOS,
        SUM(CASE WHEN (M.CUSTO_UNITARIO IS NULL OR M.CUSTO_UNITARIO<=0)
             AND NVL(I.QTDNEG,0)>0
             THEN 1 ELSE 0 END) AS SEM_CUSTO,
        SUM(NVL(M.VLRVENDA,0)) AS RECEITA,
        SUM(NVL(M.QTDNEG,0)) AS QUANTIDADE,
        SUM(NVL(M.CUSTO,0)) AS CUSTO,
        SUM(NVL(M.VLRICMS,0)) AS ICMS,
        SUM(NVL(M.VLRPIS,0)) AS PIS,
        SUM(NVL(M.VLRCOFINS,0)) AS COFINS,
        SUM(NVL(M.VLRCOM,0)) AS COMISSAO,
        SUM(NVL(M.X12AVOS,0)) AS REFLEXO_COMISSAO,
        SUM(NVL(M.AD_VLRFRETE,0)) AS FRETE,
        MAX(M.DATA_CUSTO_REFERENCIA) AS DATA_CUSTO,
        MAX(M.ORIGEM_CUSTO) AS ORIGEM_CUSTO,
        MAX(CASE WHEN NVL(I.NUPROMOCAO,0) > 0 THEN 1 ELSE 0 END) AS ITEM_PROMOCIONAL,
        SUM(NVL(M.MARGEM,0)) AS MARGEM
   FROM MARGEM_ITENS M
   JOIN SANKHYA.TGFCAB C ON C.NUNOTA=M.NUNOTA
   JOIN SANKHYA.TGFITE I ON I.NUNOTA=M.NUNOTA AND I.SEQUENCIA=M.SEQUENCIA
  GROUP BY M.NUNOTA,I.CODPROD,C.DTNEG,C.CODTIPOPER,C.CODVEND,C.CODPARC
)
SELECT PEDIDO_ID, SKU, DIA, OPERACAO, REPRESENTANTE, CLIENTE,
       ITENS, DUPLICADOS, SEM_CUSTO,
       ROUND(RECEITA,6) AS RECEITA,
       ROUND(QUANTIDADE,6) AS QUANTIDADE,
       ROUND(CUSTO,6) AS CUSTO,
       ROUND(ICMS,6) AS ICMS,
       ROUND(PIS,6) AS PIS,
       ROUND(COFINS,6) AS COFINS,
       ROUND(COMISSAO,6) AS COMISSAO,
       ROUND(REFLEXO_COMISSAO,6) AS REFLEXO_COMISSAO,
       ROUND(FRETE,6) AS FRETE,
       DATA_CUSTO,
       ORIGEM_CUSTO, ITEM_PROMOCIONAL,
       ROUND(MARGEM,6) AS MARGEM
  FROM Q539_AGREGADO
 ORDER BY PEDIDO_ID,SKU
</snk:query>
</c:catch>
<c:catch var="haialaFalhaQ539T05">
<snk:query var="haialaQ539T05">
WITH
parametros AS
(SELECT DATE '2026-01-01' AS data_inicial,
         TRUNC(SYSDATE) AS data_final,
         DATE '2026-05-01' AS data_consulta_inicio,
         DATE '2026-06-01' AS data_consulta_fim
    FROM dual),
historico_gerentes AS
(SELECT h.codger,
         h.codvend
    FROM SANKHYA.AD_HISGRVRCA h
   CROSS JOIN parametros p
   WHERE p.data_inicial BETWEEN h.dtinicial AND h.dtfinal),
variacoes_nota AS
(SELECT DISTINCT v.nunota,
                  v.sequencia,
                  v.nunotaorig,
                  v.sequenciaorig
    FROM SANKHYA.TGFVAR v),
itens_originais AS
(SELECT v.nunota,
         v.sequencia,
         v.nunotaorig,
         v.sequenciaorig,
         i.nunota        AS nunota_item_origem,
         i.sequencia     AS sequencia_item_origem
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunotaorig
     AND i.sequencia = v.sequenciaorig),
cabecalhos_originais AS
(SELECT i.nunota,
         i.sequencia,
         i.nunotaorig,
         i.sequenciaorig,
         c.nunota AS nunota_cab_origem,
         c.codusuinc,
         c.ad_diassemcompra,
         c.ad_dtultimacompra
    FROM itens_originais i
    LEFT JOIN SANKHYA.TGFCAB c
      ON c.nunota = i.nunota_item_origem),
comissoes_originais AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig,
                  v.sequencia,
                  v.sequenciaorig,
                  i.codprod,
                  i.perccom AS perccomf
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunota
     AND i.sequencia = v.sequencia),
variacoes_anteriores AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig
    FROM SANKHYA.TGFVAR v),
precos_originais AS
(SELECT DISTINCT i.nunota,
                  t.nutab
    FROM SANKHYA.TGFITE i
   INNER JOIN SANKHYA.TGFTAB t
      ON t.nutab = i.nutab),
valores_prazo_medio AS
(SELECT c.nunota,
         c.codtipvenda,
         coalesce(SUM((c.vlrliq * pg.percentual / 100) * CASE
                         WHEN pg.prazo = 0 THEN
                          1
                         ELSE
                          pg.prazo
                      END), 0) AS dividendo,
         coalesce(SUM(c.vlrliq * pg.percentual / 100), 0) AS divisor
    FROM (SELECT cab.nunota,
                 cab.codtipvenda,
                 SUM(ite.ad_vlrliq) AS vlrliq
            FROM SANKHYA.TGFCAB cab
            LEFT JOIN SANKHYA.TGFITE ite
              ON ite.nunota = cab.nunota
           CROSS JOIN parametros p
           WHERE cab.tipmov = 'P'
             AND cab.dtneg >= p.data_consulta_inicio
             AND cab.dtneg < p.data_consulta_fim
             AND cab.codtipoper > 999
             AND cab.codtipoper NOT IN (1002, 1003, 9002, 1006, 1009)
           GROUP BY cab.nunota,
                    cab.codtipvenda) c
    LEFT JOIN SANKHYA.TGFPPG pg
      ON pg.codtipvenda = c.codtipvenda
   GROUP BY c.nunota,
            c.codtipvenda),
base_vendas AS
(SELECT ger.codvend AS codgrv,
         cab.codvend AS codrca,
         item.nutab,
         coalesce(cab_orig.codusuinc, 0) AS codusuincped,
         coalesce(usu_orig.nomeusu, 'MEGA') AS usuincped,
         coalesce(cab.codusuinc, 0) AS codusuinc,
         coalesce(usu.nomeusu, 'MEGA') AS usuinc,
         cab.codcencus,
         cc.descrcencus,
         cab.codtipoper,
         top.descroper AS desctipoper,
         cab.nunota,
         item.sequencia AS sequencia,
         cab.dtneg,
         coalesce(cab.ad_diassemcompra, cab_orig.ad_diassemcompra) AS ad_diassemcompra,
         coalesce(cab.ad_dtultimacompra, cab_orig.ad_dtultimacompra) AS ad_dtultimacompra,
         cab.codparc,
         prod.codprod,
         prod.descrprod || prod.compldesc AS descrprod,
         prod.codgrupoprod,
         item.aliqicms,
         item.qtdneg,
         item.qtdentregue,
         item.pendente,
         item.ad_vlrliq,
         item.vlricms,
         item.perccom,
         item.nupromocao,
         CASE
            WHEN item.nupromocao IS NULL THEN
             'N'
            ELSE
             'S'
         END AS promo,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percom,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percentual_comissao,
         NVL(item.qtdneg, 0) AS qtd_considerada,
         CASE
            WHEN cab.codtipoper IN (1200, 1201, 1202, 1209, 9200) THEN
             -1
            ELSE
             1
         END AS fator_operacao,
         item.ad_vlrliq / NULLIF(item.qtdneg, 0) AS vlr_unitario_calculado,
         coalesce(item.qtdneg, 0) AS qtd_negociada,
         coalesce(preco.vlrvenda, 0) AS preco_tabela,
         CASE
            WHEN coalesce(preco.ad_vlrfrete, 0) = 0 THEN
             preco_orig.ad_vlrfrete
            ELSE
             preco.ad_vlrfrete
         END AS frete_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN custo_mes.CUSSEMICM
              WHEN item.VLRUNIT > 0 THEN item.VLRUNIT
              ELSE NULL END AS custo_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN
              CASE WHEN custo_mes.DTATUAL >= ADD_MONTHS(TRUNC(cab.DTNEG,'MM'),-1)
                         AND custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '01_MES_ANTERIOR'
                   WHEN custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '02_HISTORICO_ANTERIOR'
                   ELSE '03_ATUAL_CONTINGENCIA' END
              WHEN item.VLRUNIT > 0 THEN '04_VLRUNIT_CONTINGENCIA'
              ELSE 'SEM_REFERENCIA' END AS origem_custo,
         TO_CHAR(custo_mes.DTATUAL,'YYYY-MM-DD') AS data_custo_referencia,
         prazo.dividendo,
         prazo.divisor
    FROM SANKHYA.TGFCAB cab
    LEFT JOIN historico_gerentes ger
      ON ger.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN vend
      ON vend.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN gerente
      ON gerente.codvend = ger.codger
    LEFT JOIN SANKHYA.TGFITE item
      ON item.nunota = cab.nunota
    LEFT JOIN SANKHYA.TGFPRO prod
      ON prod.codprod = item.codprod
    OUTER APPLY (
      SELECT E.VLRVENDA, E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = item.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco
    LEFT JOIN SANKHYA.TSIUSU usu
      ON usu.codusu = cab.codusuinc
    LEFT JOIN SANKHYA.TSICUS cc
      ON cc.codcencus = cab.codcencus
    LEFT JOIN variacoes_nota var
      ON var.nunota = item.nunota
     AND var.sequencia = item.sequencia
    LEFT JOIN itens_originais item_orig
      ON item_orig.nunota = var.nunota
     AND item_orig.sequencia = var.sequencia
    LEFT JOIN cabecalhos_originais cab_orig
      ON cab_orig.nunota = var.nunota
     AND cab_orig.sequencia = var.sequencia
    LEFT JOIN SANKHYA.TSIUSU usu_orig
      ON usu_orig.codusu = cab_orig.codusuinc
    LEFT JOIN comissoes_originais com_orig
      ON com_orig.nunota = cab.nunota
     AND com_orig.sequencia = item.sequencia
     AND com_orig.nunotaorig = cab_orig.nunotaorig
     AND com_orig.sequenciaorig = item_orig.sequencia_item_origem
     AND com_orig.codprod = item.codprod
    LEFT JOIN variacoes_anteriores var_ant
      ON var_ant.nunota = var.nunotaorig
    LEFT JOIN SANKHYA.TGFCAB cab_ant
      ON cab_ant.nunota = var_ant.nunotaorig
    LEFT JOIN precos_originais tabela_orig
      ON tabela_orig.nunota = cab_ant.nunota
    OUTER APPLY (
      SELECT E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = tabela_orig.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco_orig
    LEFT JOIN SANKHYA.TGFTOP top
      ON top.codtipoper = cab.codtipoper
      AND top.dhalter = cab.dhtipoper
    LEFT JOIN valores_prazo_medio prazo
      ON prazo.nunota = cab.nunota
    OUTER APPLY (
      SELECT C.CUSSEMICM, C.DTATUAL
        FROM SANKHYA.TGFCUS C
       WHERE C.CODEMP = cab.CODEMP
         AND C.CODPROD = item.CODPROD
         AND C.CUSSEMICM > 0
       ORDER BY CASE WHEN C.DTATUAL < TRUNC(cab.DTNEG,'MM') THEN 0 ELSE 1 END,
                C.DTATUAL DESC, C.DHALTER DESC,
                C.CODLOCAL DESC, C.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) custo_mes
   CROSS JOIN parametros p
   WHERE
   CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END >= p.data_consulta_inicio
AND CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END < p.data_consulta_fim
 AND cab.codemp = 1
 AND cab.tipmov = 'P'
 AND cab.STATUSNOTA IN ('A','P','L')
 AND (cab.codtipoper IN (1000, 1001, 1005, 1007, 9000, 9001, 1002, 1003, 1006, 1009, 9002, 1004) OR (cab.codtipoper = 1100 AND prod.codgrupoprod = 40209001))
 AND cab.dtneg >= DATE '2026-05-01'
 AND cab.dtneg < DATE '2026-06-01'

),
calculos_comerciais AS
(SELECT b.*,
         b.qtd_considerada * b.fator_operacao AS qtdneg_calculada,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdaco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdalu,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlraco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlrapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlralu,
         b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao AS vlrtotal,
         (b.vlricms / NULLIF(b.qtdneg, 0)) * b.qtd_considerada * b.fator_operacao AS vlricms_calculado,
         coalesce(b.qtd_considerada * b.preco_tabela, 0) AS vlrtab,
         coalesce(b.qtd_considerada * b.frete_unitario, 0) AS ad_vlrfrete,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao
         END AS vlrcom,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao * 0.083333
         END AS x12avos,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165
         END AS vlrpis,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076
         END AS vlrcofins,
         b.qtd_considerada * b.custo_unitario * b.fator_operacao AS custo
    FROM base_vendas b),
resultado_final AS
(SELECT c.codgrv,
         c.codrca,
         c.codusuincped,
         c.usuincped,
         c.codusuinc,
         c.usuinc,
         c.codcencus,
         c.descrcencus,
         c.codtipoper,
         c.desctipoper,
         c.nunota,
         c.sequencia,
         c.dtneg,
         c.ad_diassemcompra,
         c.ad_dtultimacompra,
         c.codparc,
         c.promo,
         c.percom,
         c.codprod,
         c.descrprod,
         c.qtdaco,
         c.qtdapd,
         c.qtdalu,
         c.qtdneg_calculada  AS qtdneg,
         c.vlraco,
         c.vlrapd,
         c.vlralu,
         c.vlrtotal          AS vlrunit,
         c.vlricms_calculado AS vlricms,
         c.vlrtotal          AS vlrvenda,
         c.vlrtab,
         c.ad_vlrfrete,
         c.vlrcom,
         c.x12avos,
         c.vlrpis,
         c.vlrcofins,
         c.custo,
         c.custo_unitario,
         c.origem_custo,
         c.data_custo_referencia,
         coalesce(c.dividendo, 0) AS dividendo,
         coalesce(c.divisor, 0) AS divisor
    FROM calculos_comerciais c),
MARGEM_BRUTA AS (
    SELECT R.NUNOTA, R.SEQUENCIA, R.CODPARC,
           R.VLRVENDA, R.CUSTO, R.CUSTO_UNITARIO, R.ORIGEM_CUSTO, R.DATA_CUSTO_REFERENCIA, R.QTDNEG, R.VLRICMS, R.VLRPIS, R.VLRCOFINS,
           R.VLRCOM, R.X12AVOS, R.AD_VLRFRETE,
           ROW_NUMBER() OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
             ORDER BY R.NUNOTA
           ) RN,
           COUNT(*) OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
           ) N_VINCULOS
      FROM RESULTADO_FINAL R
),
MARGEM_ITENS AS (
    SELECT B.*,
           (NVL(B.VLRVENDA,0) -
            (NVL(B.CUSTO,0)+NVL(B.VLRICMS,0)+NVL(B.VLRPIS,0)+
             NVL(B.VLRCOFINS,0)+NVL(B.VLRCOM,0)+NVL(B.X12AVOS,0)+
             NVL(B.AD_VLRFRETE,0))) AS MARGEM
      FROM MARGEM_BRUTA B
     WHERE B.RN = 1
),
Q539_AGREGADO AS (
 SELECT M.NUNOTA AS PEDIDO_ID,
        I.CODPROD AS SKU,
        TO_CHAR(C.DTNEG,'YYYY-MM-DD') AS DIA,
        C.CODTIPOPER AS OPERACAO,
        NVL(C.CODVEND,-1) AS REPRESENTANTE,
        C.CODPARC AS CLIENTE,
        COUNT(*) AS ITENS,
        SUM(M.N_VINCULOS-1) AS DUPLICADOS,
        SUM(CASE WHEN (M.CUSTO_UNITARIO IS NULL OR M.CUSTO_UNITARIO<=0)
             AND NVL(I.QTDNEG,0)>0
             THEN 1 ELSE 0 END) AS SEM_CUSTO,
        SUM(NVL(M.VLRVENDA,0)) AS RECEITA,
        SUM(NVL(M.QTDNEG,0)) AS QUANTIDADE,
        SUM(NVL(M.CUSTO,0)) AS CUSTO,
        SUM(NVL(M.VLRICMS,0)) AS ICMS,
        SUM(NVL(M.VLRPIS,0)) AS PIS,
        SUM(NVL(M.VLRCOFINS,0)) AS COFINS,
        SUM(NVL(M.VLRCOM,0)) AS COMISSAO,
        SUM(NVL(M.X12AVOS,0)) AS REFLEXO_COMISSAO,
        SUM(NVL(M.AD_VLRFRETE,0)) AS FRETE,
        MAX(M.DATA_CUSTO_REFERENCIA) AS DATA_CUSTO,
        MAX(M.ORIGEM_CUSTO) AS ORIGEM_CUSTO,
        MAX(CASE WHEN NVL(I.NUPROMOCAO,0) > 0 THEN 1 ELSE 0 END) AS ITEM_PROMOCIONAL,
        SUM(NVL(M.MARGEM,0)) AS MARGEM
   FROM MARGEM_ITENS M
   JOIN SANKHYA.TGFCAB C ON C.NUNOTA=M.NUNOTA
   JOIN SANKHYA.TGFITE I ON I.NUNOTA=M.NUNOTA AND I.SEQUENCIA=M.SEQUENCIA
  GROUP BY M.NUNOTA,I.CODPROD,C.DTNEG,C.CODTIPOPER,C.CODVEND,C.CODPARC
)
SELECT PEDIDO_ID, SKU, DIA, OPERACAO, REPRESENTANTE, CLIENTE,
       ITENS, DUPLICADOS, SEM_CUSTO,
       ROUND(RECEITA,6) AS RECEITA,
       ROUND(QUANTIDADE,6) AS QUANTIDADE,
       ROUND(CUSTO,6) AS CUSTO,
       ROUND(ICMS,6) AS ICMS,
       ROUND(PIS,6) AS PIS,
       ROUND(COFINS,6) AS COFINS,
       ROUND(COMISSAO,6) AS COMISSAO,
       ROUND(REFLEXO_COMISSAO,6) AS REFLEXO_COMISSAO,
       ROUND(FRETE,6) AS FRETE,
       DATA_CUSTO,
       ORIGEM_CUSTO, ITEM_PROMOCIONAL,
       ROUND(MARGEM,6) AS MARGEM
  FROM Q539_AGREGADO
 ORDER BY PEDIDO_ID,SKU
</snk:query>
</c:catch>
<c:catch var="haialaFalhaQ539T06">
<snk:query var="haialaQ539T06">
WITH
parametros AS
(SELECT DATE '2026-01-01' AS data_inicial,
         TRUNC(SYSDATE) AS data_final,
         DATE '2026-06-01' AS data_consulta_inicio,
         DATE '2026-07-01' AS data_consulta_fim
    FROM dual),
historico_gerentes AS
(SELECT h.codger,
         h.codvend
    FROM SANKHYA.AD_HISGRVRCA h
   CROSS JOIN parametros p
   WHERE p.data_inicial BETWEEN h.dtinicial AND h.dtfinal),
variacoes_nota AS
(SELECT DISTINCT v.nunota,
                  v.sequencia,
                  v.nunotaorig,
                  v.sequenciaorig
    FROM SANKHYA.TGFVAR v),
itens_originais AS
(SELECT v.nunota,
         v.sequencia,
         v.nunotaorig,
         v.sequenciaorig,
         i.nunota        AS nunota_item_origem,
         i.sequencia     AS sequencia_item_origem
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunotaorig
     AND i.sequencia = v.sequenciaorig),
cabecalhos_originais AS
(SELECT i.nunota,
         i.sequencia,
         i.nunotaorig,
         i.sequenciaorig,
         c.nunota AS nunota_cab_origem,
         c.codusuinc,
         c.ad_diassemcompra,
         c.ad_dtultimacompra
    FROM itens_originais i
    LEFT JOIN SANKHYA.TGFCAB c
      ON c.nunota = i.nunota_item_origem),
comissoes_originais AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig,
                  v.sequencia,
                  v.sequenciaorig,
                  i.codprod,
                  i.perccom AS perccomf
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunota
     AND i.sequencia = v.sequencia),
variacoes_anteriores AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig
    FROM SANKHYA.TGFVAR v),
precos_originais AS
(SELECT DISTINCT i.nunota,
                  t.nutab
    FROM SANKHYA.TGFITE i
   INNER JOIN SANKHYA.TGFTAB t
      ON t.nutab = i.nutab),
valores_prazo_medio AS
(SELECT c.nunota,
         c.codtipvenda,
         coalesce(SUM((c.vlrliq * pg.percentual / 100) * CASE
                         WHEN pg.prazo = 0 THEN
                          1
                         ELSE
                          pg.prazo
                      END), 0) AS dividendo,
         coalesce(SUM(c.vlrliq * pg.percentual / 100), 0) AS divisor
    FROM (SELECT cab.nunota,
                 cab.codtipvenda,
                 SUM(ite.ad_vlrliq) AS vlrliq
            FROM SANKHYA.TGFCAB cab
            LEFT JOIN SANKHYA.TGFITE ite
              ON ite.nunota = cab.nunota
           CROSS JOIN parametros p
           WHERE cab.tipmov = 'P'
             AND cab.dtneg >= p.data_consulta_inicio
             AND cab.dtneg < p.data_consulta_fim
             AND cab.codtipoper > 999
             AND cab.codtipoper NOT IN (1002, 1003, 9002, 1006, 1009)
           GROUP BY cab.nunota,
                    cab.codtipvenda) c
    LEFT JOIN SANKHYA.TGFPPG pg
      ON pg.codtipvenda = c.codtipvenda
   GROUP BY c.nunota,
            c.codtipvenda),
base_vendas AS
(SELECT ger.codvend AS codgrv,
         cab.codvend AS codrca,
         item.nutab,
         coalesce(cab_orig.codusuinc, 0) AS codusuincped,
         coalesce(usu_orig.nomeusu, 'MEGA') AS usuincped,
         coalesce(cab.codusuinc, 0) AS codusuinc,
         coalesce(usu.nomeusu, 'MEGA') AS usuinc,
         cab.codcencus,
         cc.descrcencus,
         cab.codtipoper,
         top.descroper AS desctipoper,
         cab.nunota,
         item.sequencia AS sequencia,
         cab.dtneg,
         coalesce(cab.ad_diassemcompra, cab_orig.ad_diassemcompra) AS ad_diassemcompra,
         coalesce(cab.ad_dtultimacompra, cab_orig.ad_dtultimacompra) AS ad_dtultimacompra,
         cab.codparc,
         prod.codprod,
         prod.descrprod || prod.compldesc AS descrprod,
         prod.codgrupoprod,
         item.aliqicms,
         item.qtdneg,
         item.qtdentregue,
         item.pendente,
         item.ad_vlrliq,
         item.vlricms,
         item.perccom,
         item.nupromocao,
         CASE
            WHEN item.nupromocao IS NULL THEN
             'N'
            ELSE
             'S'
         END AS promo,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percom,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percentual_comissao,
         NVL(item.qtdneg, 0) AS qtd_considerada,
         CASE
            WHEN cab.codtipoper IN (1200, 1201, 1202, 1209, 9200) THEN
             -1
            ELSE
             1
         END AS fator_operacao,
         item.ad_vlrliq / NULLIF(item.qtdneg, 0) AS vlr_unitario_calculado,
         coalesce(item.qtdneg, 0) AS qtd_negociada,
         coalesce(preco.vlrvenda, 0) AS preco_tabela,
         CASE
            WHEN coalesce(preco.ad_vlrfrete, 0) = 0 THEN
             preco_orig.ad_vlrfrete
            ELSE
             preco.ad_vlrfrete
         END AS frete_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN custo_mes.CUSSEMICM
              WHEN item.VLRUNIT > 0 THEN item.VLRUNIT
              ELSE NULL END AS custo_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN
              CASE WHEN custo_mes.DTATUAL >= ADD_MONTHS(TRUNC(cab.DTNEG,'MM'),-1)
                         AND custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '01_MES_ANTERIOR'
                   WHEN custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '02_HISTORICO_ANTERIOR'
                   ELSE '03_ATUAL_CONTINGENCIA' END
              WHEN item.VLRUNIT > 0 THEN '04_VLRUNIT_CONTINGENCIA'
              ELSE 'SEM_REFERENCIA' END AS origem_custo,
         TO_CHAR(custo_mes.DTATUAL,'YYYY-MM-DD') AS data_custo_referencia,
         prazo.dividendo,
         prazo.divisor
    FROM SANKHYA.TGFCAB cab
    LEFT JOIN historico_gerentes ger
      ON ger.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN vend
      ON vend.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN gerente
      ON gerente.codvend = ger.codger
    LEFT JOIN SANKHYA.TGFITE item
      ON item.nunota = cab.nunota
    LEFT JOIN SANKHYA.TGFPRO prod
      ON prod.codprod = item.codprod
    OUTER APPLY (
      SELECT E.VLRVENDA, E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = item.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco
    LEFT JOIN SANKHYA.TSIUSU usu
      ON usu.codusu = cab.codusuinc
    LEFT JOIN SANKHYA.TSICUS cc
      ON cc.codcencus = cab.codcencus
    LEFT JOIN variacoes_nota var
      ON var.nunota = item.nunota
     AND var.sequencia = item.sequencia
    LEFT JOIN itens_originais item_orig
      ON item_orig.nunota = var.nunota
     AND item_orig.sequencia = var.sequencia
    LEFT JOIN cabecalhos_originais cab_orig
      ON cab_orig.nunota = var.nunota
     AND cab_orig.sequencia = var.sequencia
    LEFT JOIN SANKHYA.TSIUSU usu_orig
      ON usu_orig.codusu = cab_orig.codusuinc
    LEFT JOIN comissoes_originais com_orig
      ON com_orig.nunota = cab.nunota
     AND com_orig.sequencia = item.sequencia
     AND com_orig.nunotaorig = cab_orig.nunotaorig
     AND com_orig.sequenciaorig = item_orig.sequencia_item_origem
     AND com_orig.codprod = item.codprod
    LEFT JOIN variacoes_anteriores var_ant
      ON var_ant.nunota = var.nunotaorig
    LEFT JOIN SANKHYA.TGFCAB cab_ant
      ON cab_ant.nunota = var_ant.nunotaorig
    LEFT JOIN precos_originais tabela_orig
      ON tabela_orig.nunota = cab_ant.nunota
    OUTER APPLY (
      SELECT E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = tabela_orig.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco_orig
    LEFT JOIN SANKHYA.TGFTOP top
      ON top.codtipoper = cab.codtipoper
      AND top.dhalter = cab.dhtipoper
    LEFT JOIN valores_prazo_medio prazo
      ON prazo.nunota = cab.nunota
    OUTER APPLY (
      SELECT C.CUSSEMICM, C.DTATUAL
        FROM SANKHYA.TGFCUS C
       WHERE C.CODEMP = cab.CODEMP
         AND C.CODPROD = item.CODPROD
         AND C.CUSSEMICM > 0
       ORDER BY CASE WHEN C.DTATUAL < TRUNC(cab.DTNEG,'MM') THEN 0 ELSE 1 END,
                C.DTATUAL DESC, C.DHALTER DESC,
                C.CODLOCAL DESC, C.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) custo_mes
   CROSS JOIN parametros p
   WHERE
   CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END >= p.data_consulta_inicio
AND CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END < p.data_consulta_fim
 AND cab.codemp = 1
 AND cab.tipmov = 'P'
 AND cab.STATUSNOTA IN ('A','P','L')
 AND (cab.codtipoper IN (1000, 1001, 1005, 1007, 9000, 9001, 1002, 1003, 1006, 1009, 9002, 1004) OR (cab.codtipoper = 1100 AND prod.codgrupoprod = 40209001))
 AND cab.dtneg >= DATE '2026-06-01'
 AND cab.dtneg < DATE '2026-07-01'

),
calculos_comerciais AS
(SELECT b.*,
         b.qtd_considerada * b.fator_operacao AS qtdneg_calculada,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdaco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdalu,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlraco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlrapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlralu,
         b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao AS vlrtotal,
         (b.vlricms / NULLIF(b.qtdneg, 0)) * b.qtd_considerada * b.fator_operacao AS vlricms_calculado,
         coalesce(b.qtd_considerada * b.preco_tabela, 0) AS vlrtab,
         coalesce(b.qtd_considerada * b.frete_unitario, 0) AS ad_vlrfrete,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao
         END AS vlrcom,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao * 0.083333
         END AS x12avos,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165
         END AS vlrpis,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076
         END AS vlrcofins,
         b.qtd_considerada * b.custo_unitario * b.fator_operacao AS custo
    FROM base_vendas b),
resultado_final AS
(SELECT c.codgrv,
         c.codrca,
         c.codusuincped,
         c.usuincped,
         c.codusuinc,
         c.usuinc,
         c.codcencus,
         c.descrcencus,
         c.codtipoper,
         c.desctipoper,
         c.nunota,
         c.sequencia,
         c.dtneg,
         c.ad_diassemcompra,
         c.ad_dtultimacompra,
         c.codparc,
         c.promo,
         c.percom,
         c.codprod,
         c.descrprod,
         c.qtdaco,
         c.qtdapd,
         c.qtdalu,
         c.qtdneg_calculada  AS qtdneg,
         c.vlraco,
         c.vlrapd,
         c.vlralu,
         c.vlrtotal          AS vlrunit,
         c.vlricms_calculado AS vlricms,
         c.vlrtotal          AS vlrvenda,
         c.vlrtab,
         c.ad_vlrfrete,
         c.vlrcom,
         c.x12avos,
         c.vlrpis,
         c.vlrcofins,
         c.custo,
         c.custo_unitario,
         c.origem_custo,
         c.data_custo_referencia,
         coalesce(c.dividendo, 0) AS dividendo,
         coalesce(c.divisor, 0) AS divisor
    FROM calculos_comerciais c),
MARGEM_BRUTA AS (
    SELECT R.NUNOTA, R.SEQUENCIA, R.CODPARC,
           R.VLRVENDA, R.CUSTO, R.CUSTO_UNITARIO, R.ORIGEM_CUSTO, R.DATA_CUSTO_REFERENCIA, R.QTDNEG, R.VLRICMS, R.VLRPIS, R.VLRCOFINS,
           R.VLRCOM, R.X12AVOS, R.AD_VLRFRETE,
           ROW_NUMBER() OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
             ORDER BY R.NUNOTA
           ) RN,
           COUNT(*) OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
           ) N_VINCULOS
      FROM RESULTADO_FINAL R
),
MARGEM_ITENS AS (
    SELECT B.*,
           (NVL(B.VLRVENDA,0) -
            (NVL(B.CUSTO,0)+NVL(B.VLRICMS,0)+NVL(B.VLRPIS,0)+
             NVL(B.VLRCOFINS,0)+NVL(B.VLRCOM,0)+NVL(B.X12AVOS,0)+
             NVL(B.AD_VLRFRETE,0))) AS MARGEM
      FROM MARGEM_BRUTA B
     WHERE B.RN = 1
),
Q539_AGREGADO AS (
 SELECT M.NUNOTA AS PEDIDO_ID,
        I.CODPROD AS SKU,
        TO_CHAR(C.DTNEG,'YYYY-MM-DD') AS DIA,
        C.CODTIPOPER AS OPERACAO,
        NVL(C.CODVEND,-1) AS REPRESENTANTE,
        C.CODPARC AS CLIENTE,
        COUNT(*) AS ITENS,
        SUM(M.N_VINCULOS-1) AS DUPLICADOS,
        SUM(CASE WHEN (M.CUSTO_UNITARIO IS NULL OR M.CUSTO_UNITARIO<=0)
             AND NVL(I.QTDNEG,0)>0
             THEN 1 ELSE 0 END) AS SEM_CUSTO,
        SUM(NVL(M.VLRVENDA,0)) AS RECEITA,
        SUM(NVL(M.QTDNEG,0)) AS QUANTIDADE,
        SUM(NVL(M.CUSTO,0)) AS CUSTO,
        SUM(NVL(M.VLRICMS,0)) AS ICMS,
        SUM(NVL(M.VLRPIS,0)) AS PIS,
        SUM(NVL(M.VLRCOFINS,0)) AS COFINS,
        SUM(NVL(M.VLRCOM,0)) AS COMISSAO,
        SUM(NVL(M.X12AVOS,0)) AS REFLEXO_COMISSAO,
        SUM(NVL(M.AD_VLRFRETE,0)) AS FRETE,
        MAX(M.DATA_CUSTO_REFERENCIA) AS DATA_CUSTO,
        MAX(M.ORIGEM_CUSTO) AS ORIGEM_CUSTO,
        MAX(CASE WHEN NVL(I.NUPROMOCAO,0) > 0 THEN 1 ELSE 0 END) AS ITEM_PROMOCIONAL,
        SUM(NVL(M.MARGEM,0)) AS MARGEM
   FROM MARGEM_ITENS M
   JOIN SANKHYA.TGFCAB C ON C.NUNOTA=M.NUNOTA
   JOIN SANKHYA.TGFITE I ON I.NUNOTA=M.NUNOTA AND I.SEQUENCIA=M.SEQUENCIA
  GROUP BY M.NUNOTA,I.CODPROD,C.DTNEG,C.CODTIPOPER,C.CODVEND,C.CODPARC
)
SELECT PEDIDO_ID, SKU, DIA, OPERACAO, REPRESENTANTE, CLIENTE,
       ITENS, DUPLICADOS, SEM_CUSTO,
       ROUND(RECEITA,6) AS RECEITA,
       ROUND(QUANTIDADE,6) AS QUANTIDADE,
       ROUND(CUSTO,6) AS CUSTO,
       ROUND(ICMS,6) AS ICMS,
       ROUND(PIS,6) AS PIS,
       ROUND(COFINS,6) AS COFINS,
       ROUND(COMISSAO,6) AS COMISSAO,
       ROUND(REFLEXO_COMISSAO,6) AS REFLEXO_COMISSAO,
       ROUND(FRETE,6) AS FRETE,
       DATA_CUSTO,
       ORIGEM_CUSTO, ITEM_PROMOCIONAL,
       ROUND(MARGEM,6) AS MARGEM
  FROM Q539_AGREGADO
 ORDER BY PEDIDO_ID,SKU
</snk:query>
</c:catch>
<c:catch var="haialaFalhaQ539T07">
<snk:query var="haialaQ539T07">
WITH
parametros AS
(SELECT DATE '2026-01-01' AS data_inicial,
         TRUNC(SYSDATE) AS data_final,
         DATE '2026-07-01' AS data_consulta_inicio,
         DATE '2026-08-01' AS data_consulta_fim
    FROM dual),
historico_gerentes AS
(SELECT h.codger,
         h.codvend
    FROM SANKHYA.AD_HISGRVRCA h
   CROSS JOIN parametros p
   WHERE p.data_inicial BETWEEN h.dtinicial AND h.dtfinal),
variacoes_nota AS
(SELECT DISTINCT v.nunota,
                  v.sequencia,
                  v.nunotaorig,
                  v.sequenciaorig
    FROM SANKHYA.TGFVAR v),
itens_originais AS
(SELECT v.nunota,
         v.sequencia,
         v.nunotaorig,
         v.sequenciaorig,
         i.nunota        AS nunota_item_origem,
         i.sequencia     AS sequencia_item_origem
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunotaorig
     AND i.sequencia = v.sequenciaorig),
cabecalhos_originais AS
(SELECT i.nunota,
         i.sequencia,
         i.nunotaorig,
         i.sequenciaorig,
         c.nunota AS nunota_cab_origem,
         c.codusuinc,
         c.ad_diassemcompra,
         c.ad_dtultimacompra
    FROM itens_originais i
    LEFT JOIN SANKHYA.TGFCAB c
      ON c.nunota = i.nunota_item_origem),
comissoes_originais AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig,
                  v.sequencia,
                  v.sequenciaorig,
                  i.codprod,
                  i.perccom AS perccomf
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunota
     AND i.sequencia = v.sequencia),
variacoes_anteriores AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig
    FROM SANKHYA.TGFVAR v),
precos_originais AS
(SELECT DISTINCT i.nunota,
                  t.nutab
    FROM SANKHYA.TGFITE i
   INNER JOIN SANKHYA.TGFTAB t
      ON t.nutab = i.nutab),
valores_prazo_medio AS
(SELECT c.nunota,
         c.codtipvenda,
         coalesce(SUM((c.vlrliq * pg.percentual / 100) * CASE
                         WHEN pg.prazo = 0 THEN
                          1
                         ELSE
                          pg.prazo
                      END), 0) AS dividendo,
         coalesce(SUM(c.vlrliq * pg.percentual / 100), 0) AS divisor
    FROM (SELECT cab.nunota,
                 cab.codtipvenda,
                 SUM(ite.ad_vlrliq) AS vlrliq
            FROM SANKHYA.TGFCAB cab
            LEFT JOIN SANKHYA.TGFITE ite
              ON ite.nunota = cab.nunota
           CROSS JOIN parametros p
           WHERE cab.tipmov = 'P'
             AND cab.dtneg >= p.data_consulta_inicio
             AND cab.dtneg < p.data_consulta_fim
             AND cab.codtipoper > 999
             AND cab.codtipoper NOT IN (1002, 1003, 9002, 1006, 1009)
           GROUP BY cab.nunota,
                    cab.codtipvenda) c
    LEFT JOIN SANKHYA.TGFPPG pg
      ON pg.codtipvenda = c.codtipvenda
   GROUP BY c.nunota,
            c.codtipvenda),
base_vendas AS
(SELECT ger.codvend AS codgrv,
         cab.codvend AS codrca,
         item.nutab,
         coalesce(cab_orig.codusuinc, 0) AS codusuincped,
         coalesce(usu_orig.nomeusu, 'MEGA') AS usuincped,
         coalesce(cab.codusuinc, 0) AS codusuinc,
         coalesce(usu.nomeusu, 'MEGA') AS usuinc,
         cab.codcencus,
         cc.descrcencus,
         cab.codtipoper,
         top.descroper AS desctipoper,
         cab.nunota,
         item.sequencia AS sequencia,
         cab.dtneg,
         coalesce(cab.ad_diassemcompra, cab_orig.ad_diassemcompra) AS ad_diassemcompra,
         coalesce(cab.ad_dtultimacompra, cab_orig.ad_dtultimacompra) AS ad_dtultimacompra,
         cab.codparc,
         prod.codprod,
         prod.descrprod || prod.compldesc AS descrprod,
         prod.codgrupoprod,
         item.aliqicms,
         item.qtdneg,
         item.qtdentregue,
         item.pendente,
         item.ad_vlrliq,
         item.vlricms,
         item.perccom,
         item.nupromocao,
         CASE
            WHEN item.nupromocao IS NULL THEN
             'N'
            ELSE
             'S'
         END AS promo,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percom,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percentual_comissao,
         NVL(item.qtdneg, 0) AS qtd_considerada,
         CASE
            WHEN cab.codtipoper IN (1200, 1201, 1202, 1209, 9200) THEN
             -1
            ELSE
             1
         END AS fator_operacao,
         item.ad_vlrliq / NULLIF(item.qtdneg, 0) AS vlr_unitario_calculado,
         coalesce(item.qtdneg, 0) AS qtd_negociada,
         coalesce(preco.vlrvenda, 0) AS preco_tabela,
         CASE
            WHEN coalesce(preco.ad_vlrfrete, 0) = 0 THEN
             preco_orig.ad_vlrfrete
            ELSE
             preco.ad_vlrfrete
         END AS frete_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN custo_mes.CUSSEMICM
              WHEN item.VLRUNIT > 0 THEN item.VLRUNIT
              ELSE NULL END AS custo_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN
              CASE WHEN custo_mes.DTATUAL >= ADD_MONTHS(TRUNC(cab.DTNEG,'MM'),-1)
                         AND custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '01_MES_ANTERIOR'
                   WHEN custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '02_HISTORICO_ANTERIOR'
                   ELSE '03_ATUAL_CONTINGENCIA' END
              WHEN item.VLRUNIT > 0 THEN '04_VLRUNIT_CONTINGENCIA'
              ELSE 'SEM_REFERENCIA' END AS origem_custo,
         TO_CHAR(custo_mes.DTATUAL,'YYYY-MM-DD') AS data_custo_referencia,
         prazo.dividendo,
         prazo.divisor
    FROM SANKHYA.TGFCAB cab
    LEFT JOIN historico_gerentes ger
      ON ger.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN vend
      ON vend.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN gerente
      ON gerente.codvend = ger.codger
    LEFT JOIN SANKHYA.TGFITE item
      ON item.nunota = cab.nunota
    LEFT JOIN SANKHYA.TGFPRO prod
      ON prod.codprod = item.codprod
    OUTER APPLY (
      SELECT E.VLRVENDA, E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = item.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco
    LEFT JOIN SANKHYA.TSIUSU usu
      ON usu.codusu = cab.codusuinc
    LEFT JOIN SANKHYA.TSICUS cc
      ON cc.codcencus = cab.codcencus
    LEFT JOIN variacoes_nota var
      ON var.nunota = item.nunota
     AND var.sequencia = item.sequencia
    LEFT JOIN itens_originais item_orig
      ON item_orig.nunota = var.nunota
     AND item_orig.sequencia = var.sequencia
    LEFT JOIN cabecalhos_originais cab_orig
      ON cab_orig.nunota = var.nunota
     AND cab_orig.sequencia = var.sequencia
    LEFT JOIN SANKHYA.TSIUSU usu_orig
      ON usu_orig.codusu = cab_orig.codusuinc
    LEFT JOIN comissoes_originais com_orig
      ON com_orig.nunota = cab.nunota
     AND com_orig.sequencia = item.sequencia
     AND com_orig.nunotaorig = cab_orig.nunotaorig
     AND com_orig.sequenciaorig = item_orig.sequencia_item_origem
     AND com_orig.codprod = item.codprod
    LEFT JOIN variacoes_anteriores var_ant
      ON var_ant.nunota = var.nunotaorig
    LEFT JOIN SANKHYA.TGFCAB cab_ant
      ON cab_ant.nunota = var_ant.nunotaorig
    LEFT JOIN precos_originais tabela_orig
      ON tabela_orig.nunota = cab_ant.nunota
    OUTER APPLY (
      SELECT E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = tabela_orig.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco_orig
    LEFT JOIN SANKHYA.TGFTOP top
      ON top.codtipoper = cab.codtipoper
      AND top.dhalter = cab.dhtipoper
    LEFT JOIN valores_prazo_medio prazo
      ON prazo.nunota = cab.nunota
    OUTER APPLY (
      SELECT C.CUSSEMICM, C.DTATUAL
        FROM SANKHYA.TGFCUS C
       WHERE C.CODEMP = cab.CODEMP
         AND C.CODPROD = item.CODPROD
         AND C.CUSSEMICM > 0
       ORDER BY CASE WHEN C.DTATUAL < TRUNC(cab.DTNEG,'MM') THEN 0 ELSE 1 END,
                C.DTATUAL DESC, C.DHALTER DESC,
                C.CODLOCAL DESC, C.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) custo_mes
   CROSS JOIN parametros p
   WHERE
   CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END >= p.data_consulta_inicio
AND CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END < p.data_consulta_fim
 AND cab.codemp = 1
 AND cab.tipmov = 'P'
 AND cab.STATUSNOTA IN ('A','P','L')
 AND (cab.codtipoper IN (1000, 1001, 1005, 1007, 9000, 9001, 1002, 1003, 1006, 1009, 9002, 1004) OR (cab.codtipoper = 1100 AND prod.codgrupoprod = 40209001))
 AND cab.dtneg >= DATE '2026-07-01'
 AND cab.dtneg < DATE '2026-08-01'

),
calculos_comerciais AS
(SELECT b.*,
         b.qtd_considerada * b.fator_operacao AS qtdneg_calculada,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdaco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdalu,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlraco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlrapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlralu,
         b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao AS vlrtotal,
         (b.vlricms / NULLIF(b.qtdneg, 0)) * b.qtd_considerada * b.fator_operacao AS vlricms_calculado,
         coalesce(b.qtd_considerada * b.preco_tabela, 0) AS vlrtab,
         coalesce(b.qtd_considerada * b.frete_unitario, 0) AS ad_vlrfrete,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao
         END AS vlrcom,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao * 0.083333
         END AS x12avos,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165
         END AS vlrpis,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076
         END AS vlrcofins,
         b.qtd_considerada * b.custo_unitario * b.fator_operacao AS custo
    FROM base_vendas b),
resultado_final AS
(SELECT c.codgrv,
         c.codrca,
         c.codusuincped,
         c.usuincped,
         c.codusuinc,
         c.usuinc,
         c.codcencus,
         c.descrcencus,
         c.codtipoper,
         c.desctipoper,
         c.nunota,
         c.sequencia,
         c.dtneg,
         c.ad_diassemcompra,
         c.ad_dtultimacompra,
         c.codparc,
         c.promo,
         c.percom,
         c.codprod,
         c.descrprod,
         c.qtdaco,
         c.qtdapd,
         c.qtdalu,
         c.qtdneg_calculada  AS qtdneg,
         c.vlraco,
         c.vlrapd,
         c.vlralu,
         c.vlrtotal          AS vlrunit,
         c.vlricms_calculado AS vlricms,
         c.vlrtotal          AS vlrvenda,
         c.vlrtab,
         c.ad_vlrfrete,
         c.vlrcom,
         c.x12avos,
         c.vlrpis,
         c.vlrcofins,
         c.custo,
         c.custo_unitario,
         c.origem_custo,
         c.data_custo_referencia,
         coalesce(c.dividendo, 0) AS dividendo,
         coalesce(c.divisor, 0) AS divisor
    FROM calculos_comerciais c),
MARGEM_BRUTA AS (
    SELECT R.NUNOTA, R.SEQUENCIA, R.CODPARC,
           R.VLRVENDA, R.CUSTO, R.CUSTO_UNITARIO, R.ORIGEM_CUSTO, R.DATA_CUSTO_REFERENCIA, R.QTDNEG, R.VLRICMS, R.VLRPIS, R.VLRCOFINS,
           R.VLRCOM, R.X12AVOS, R.AD_VLRFRETE,
           ROW_NUMBER() OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
             ORDER BY R.NUNOTA
           ) RN,
           COUNT(*) OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
           ) N_VINCULOS
      FROM RESULTADO_FINAL R
),
MARGEM_ITENS AS (
    SELECT B.*,
           (NVL(B.VLRVENDA,0) -
            (NVL(B.CUSTO,0)+NVL(B.VLRICMS,0)+NVL(B.VLRPIS,0)+
             NVL(B.VLRCOFINS,0)+NVL(B.VLRCOM,0)+NVL(B.X12AVOS,0)+
             NVL(B.AD_VLRFRETE,0))) AS MARGEM
      FROM MARGEM_BRUTA B
     WHERE B.RN = 1
),
Q539_AGREGADO AS (
 SELECT M.NUNOTA AS PEDIDO_ID,
        I.CODPROD AS SKU,
        TO_CHAR(C.DTNEG,'YYYY-MM-DD') AS DIA,
        C.CODTIPOPER AS OPERACAO,
        NVL(C.CODVEND,-1) AS REPRESENTANTE,
        C.CODPARC AS CLIENTE,
        COUNT(*) AS ITENS,
        SUM(M.N_VINCULOS-1) AS DUPLICADOS,
        SUM(CASE WHEN (M.CUSTO_UNITARIO IS NULL OR M.CUSTO_UNITARIO<=0)
             AND NVL(I.QTDNEG,0)>0
             THEN 1 ELSE 0 END) AS SEM_CUSTO,
        SUM(NVL(M.VLRVENDA,0)) AS RECEITA,
        SUM(NVL(M.QTDNEG,0)) AS QUANTIDADE,
        SUM(NVL(M.CUSTO,0)) AS CUSTO,
        SUM(NVL(M.VLRICMS,0)) AS ICMS,
        SUM(NVL(M.VLRPIS,0)) AS PIS,
        SUM(NVL(M.VLRCOFINS,0)) AS COFINS,
        SUM(NVL(M.VLRCOM,0)) AS COMISSAO,
        SUM(NVL(M.X12AVOS,0)) AS REFLEXO_COMISSAO,
        SUM(NVL(M.AD_VLRFRETE,0)) AS FRETE,
        MAX(M.DATA_CUSTO_REFERENCIA) AS DATA_CUSTO,
        MAX(M.ORIGEM_CUSTO) AS ORIGEM_CUSTO,
        MAX(CASE WHEN NVL(I.NUPROMOCAO,0) > 0 THEN 1 ELSE 0 END) AS ITEM_PROMOCIONAL,
        SUM(NVL(M.MARGEM,0)) AS MARGEM
   FROM MARGEM_ITENS M
   JOIN SANKHYA.TGFCAB C ON C.NUNOTA=M.NUNOTA
   JOIN SANKHYA.TGFITE I ON I.NUNOTA=M.NUNOTA AND I.SEQUENCIA=M.SEQUENCIA
  GROUP BY M.NUNOTA,I.CODPROD,C.DTNEG,C.CODTIPOPER,C.CODVEND,C.CODPARC
)
SELECT PEDIDO_ID, SKU, DIA, OPERACAO, REPRESENTANTE, CLIENTE,
       ITENS, DUPLICADOS, SEM_CUSTO,
       ROUND(RECEITA,6) AS RECEITA,
       ROUND(QUANTIDADE,6) AS QUANTIDADE,
       ROUND(CUSTO,6) AS CUSTO,
       ROUND(ICMS,6) AS ICMS,
       ROUND(PIS,6) AS PIS,
       ROUND(COFINS,6) AS COFINS,
       ROUND(COMISSAO,6) AS COMISSAO,
       ROUND(REFLEXO_COMISSAO,6) AS REFLEXO_COMISSAO,
       ROUND(FRETE,6) AS FRETE,
       DATA_CUSTO,
       ORIGEM_CUSTO, ITEM_PROMOCIONAL,
       ROUND(MARGEM,6) AS MARGEM
  FROM Q539_AGREGADO
 ORDER BY PEDIDO_ID,SKU
</snk:query>
</c:catch>
<c:catch var="haialaFalhaQ539T08">
<snk:query var="haialaQ539T08">
WITH
parametros AS
(SELECT DATE '2026-01-01' AS data_inicial,
         TRUNC(SYSDATE) AS data_final,
         DATE '2026-08-01' AS data_consulta_inicio,
         DATE '2026-09-01' AS data_consulta_fim
    FROM dual),
historico_gerentes AS
(SELECT h.codger,
         h.codvend
    FROM SANKHYA.AD_HISGRVRCA h
   CROSS JOIN parametros p
   WHERE p.data_inicial BETWEEN h.dtinicial AND h.dtfinal),
variacoes_nota AS
(SELECT DISTINCT v.nunota,
                  v.sequencia,
                  v.nunotaorig,
                  v.sequenciaorig
    FROM SANKHYA.TGFVAR v),
itens_originais AS
(SELECT v.nunota,
         v.sequencia,
         v.nunotaorig,
         v.sequenciaorig,
         i.nunota        AS nunota_item_origem,
         i.sequencia     AS sequencia_item_origem
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunotaorig
     AND i.sequencia = v.sequenciaorig),
cabecalhos_originais AS
(SELECT i.nunota,
         i.sequencia,
         i.nunotaorig,
         i.sequenciaorig,
         c.nunota AS nunota_cab_origem,
         c.codusuinc,
         c.ad_diassemcompra,
         c.ad_dtultimacompra
    FROM itens_originais i
    LEFT JOIN SANKHYA.TGFCAB c
      ON c.nunota = i.nunota_item_origem),
comissoes_originais AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig,
                  v.sequencia,
                  v.sequenciaorig,
                  i.codprod,
                  i.perccom AS perccomf
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunota
     AND i.sequencia = v.sequencia),
variacoes_anteriores AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig
    FROM SANKHYA.TGFVAR v),
precos_originais AS
(SELECT DISTINCT i.nunota,
                  t.nutab
    FROM SANKHYA.TGFITE i
   INNER JOIN SANKHYA.TGFTAB t
      ON t.nutab = i.nutab),
valores_prazo_medio AS
(SELECT c.nunota,
         c.codtipvenda,
         coalesce(SUM((c.vlrliq * pg.percentual / 100) * CASE
                         WHEN pg.prazo = 0 THEN
                          1
                         ELSE
                          pg.prazo
                      END), 0) AS dividendo,
         coalesce(SUM(c.vlrliq * pg.percentual / 100), 0) AS divisor
    FROM (SELECT cab.nunota,
                 cab.codtipvenda,
                 SUM(ite.ad_vlrliq) AS vlrliq
            FROM SANKHYA.TGFCAB cab
            LEFT JOIN SANKHYA.TGFITE ite
              ON ite.nunota = cab.nunota
           CROSS JOIN parametros p
           WHERE cab.tipmov = 'P'
             AND cab.dtneg >= p.data_consulta_inicio
             AND cab.dtneg < p.data_consulta_fim
             AND cab.codtipoper > 999
             AND cab.codtipoper NOT IN (1002, 1003, 9002, 1006, 1009)
           GROUP BY cab.nunota,
                    cab.codtipvenda) c
    LEFT JOIN SANKHYA.TGFPPG pg
      ON pg.codtipvenda = c.codtipvenda
   GROUP BY c.nunota,
            c.codtipvenda),
base_vendas AS
(SELECT ger.codvend AS codgrv,
         cab.codvend AS codrca,
         item.nutab,
         coalesce(cab_orig.codusuinc, 0) AS codusuincped,
         coalesce(usu_orig.nomeusu, 'MEGA') AS usuincped,
         coalesce(cab.codusuinc, 0) AS codusuinc,
         coalesce(usu.nomeusu, 'MEGA') AS usuinc,
         cab.codcencus,
         cc.descrcencus,
         cab.codtipoper,
         top.descroper AS desctipoper,
         cab.nunota,
         item.sequencia AS sequencia,
         cab.dtneg,
         coalesce(cab.ad_diassemcompra, cab_orig.ad_diassemcompra) AS ad_diassemcompra,
         coalesce(cab.ad_dtultimacompra, cab_orig.ad_dtultimacompra) AS ad_dtultimacompra,
         cab.codparc,
         prod.codprod,
         prod.descrprod || prod.compldesc AS descrprod,
         prod.codgrupoprod,
         item.aliqicms,
         item.qtdneg,
         item.qtdentregue,
         item.pendente,
         item.ad_vlrliq,
         item.vlricms,
         item.perccom,
         item.nupromocao,
         CASE
            WHEN item.nupromocao IS NULL THEN
             'N'
            ELSE
             'S'
         END AS promo,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percom,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percentual_comissao,
         NVL(item.qtdneg, 0) AS qtd_considerada,
         CASE
            WHEN cab.codtipoper IN (1200, 1201, 1202, 1209, 9200) THEN
             -1
            ELSE
             1
         END AS fator_operacao,
         item.ad_vlrliq / NULLIF(item.qtdneg, 0) AS vlr_unitario_calculado,
         coalesce(item.qtdneg, 0) AS qtd_negociada,
         coalesce(preco.vlrvenda, 0) AS preco_tabela,
         CASE
            WHEN coalesce(preco.ad_vlrfrete, 0) = 0 THEN
             preco_orig.ad_vlrfrete
            ELSE
             preco.ad_vlrfrete
         END AS frete_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN custo_mes.CUSSEMICM
              WHEN item.VLRUNIT > 0 THEN item.VLRUNIT
              ELSE NULL END AS custo_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN
              CASE WHEN custo_mes.DTATUAL >= ADD_MONTHS(TRUNC(cab.DTNEG,'MM'),-1)
                         AND custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '01_MES_ANTERIOR'
                   WHEN custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '02_HISTORICO_ANTERIOR'
                   ELSE '03_ATUAL_CONTINGENCIA' END
              WHEN item.VLRUNIT > 0 THEN '04_VLRUNIT_CONTINGENCIA'
              ELSE 'SEM_REFERENCIA' END AS origem_custo,
         TO_CHAR(custo_mes.DTATUAL,'YYYY-MM-DD') AS data_custo_referencia,
         prazo.dividendo,
         prazo.divisor
    FROM SANKHYA.TGFCAB cab
    LEFT JOIN historico_gerentes ger
      ON ger.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN vend
      ON vend.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN gerente
      ON gerente.codvend = ger.codger
    LEFT JOIN SANKHYA.TGFITE item
      ON item.nunota = cab.nunota
    LEFT JOIN SANKHYA.TGFPRO prod
      ON prod.codprod = item.codprod
    OUTER APPLY (
      SELECT E.VLRVENDA, E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = item.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco
    LEFT JOIN SANKHYA.TSIUSU usu
      ON usu.codusu = cab.codusuinc
    LEFT JOIN SANKHYA.TSICUS cc
      ON cc.codcencus = cab.codcencus
    LEFT JOIN variacoes_nota var
      ON var.nunota = item.nunota
     AND var.sequencia = item.sequencia
    LEFT JOIN itens_originais item_orig
      ON item_orig.nunota = var.nunota
     AND item_orig.sequencia = var.sequencia
    LEFT JOIN cabecalhos_originais cab_orig
      ON cab_orig.nunota = var.nunota
     AND cab_orig.sequencia = var.sequencia
    LEFT JOIN SANKHYA.TSIUSU usu_orig
      ON usu_orig.codusu = cab_orig.codusuinc
    LEFT JOIN comissoes_originais com_orig
      ON com_orig.nunota = cab.nunota
     AND com_orig.sequencia = item.sequencia
     AND com_orig.nunotaorig = cab_orig.nunotaorig
     AND com_orig.sequenciaorig = item_orig.sequencia_item_origem
     AND com_orig.codprod = item.codprod
    LEFT JOIN variacoes_anteriores var_ant
      ON var_ant.nunota = var.nunotaorig
    LEFT JOIN SANKHYA.TGFCAB cab_ant
      ON cab_ant.nunota = var_ant.nunotaorig
    LEFT JOIN precos_originais tabela_orig
      ON tabela_orig.nunota = cab_ant.nunota
    OUTER APPLY (
      SELECT E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = tabela_orig.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco_orig
    LEFT JOIN SANKHYA.TGFTOP top
      ON top.codtipoper = cab.codtipoper
      AND top.dhalter = cab.dhtipoper
    LEFT JOIN valores_prazo_medio prazo
      ON prazo.nunota = cab.nunota
    OUTER APPLY (
      SELECT C.CUSSEMICM, C.DTATUAL
        FROM SANKHYA.TGFCUS C
       WHERE C.CODEMP = cab.CODEMP
         AND C.CODPROD = item.CODPROD
         AND C.CUSSEMICM > 0
       ORDER BY CASE WHEN C.DTATUAL < TRUNC(cab.DTNEG,'MM') THEN 0 ELSE 1 END,
                C.DTATUAL DESC, C.DHALTER DESC,
                C.CODLOCAL DESC, C.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) custo_mes
   CROSS JOIN parametros p
   WHERE
   CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END >= p.data_consulta_inicio
AND CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END < p.data_consulta_fim
 AND cab.codemp = 1
 AND cab.tipmov = 'P'
 AND cab.STATUSNOTA IN ('A','P','L')
 AND (cab.codtipoper IN (1000, 1001, 1005, 1007, 9000, 9001, 1002, 1003, 1006, 1009, 9002, 1004) OR (cab.codtipoper = 1100 AND prod.codgrupoprod = 40209001))
 AND cab.dtneg >= DATE '2026-08-01'
 AND cab.dtneg < DATE '2026-09-01'

),
calculos_comerciais AS
(SELECT b.*,
         b.qtd_considerada * b.fator_operacao AS qtdneg_calculada,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdaco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdalu,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlraco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlrapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlralu,
         b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao AS vlrtotal,
         (b.vlricms / NULLIF(b.qtdneg, 0)) * b.qtd_considerada * b.fator_operacao AS vlricms_calculado,
         coalesce(b.qtd_considerada * b.preco_tabela, 0) AS vlrtab,
         coalesce(b.qtd_considerada * b.frete_unitario, 0) AS ad_vlrfrete,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao
         END AS vlrcom,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao * 0.083333
         END AS x12avos,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165
         END AS vlrpis,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076
         END AS vlrcofins,
         b.qtd_considerada * b.custo_unitario * b.fator_operacao AS custo
    FROM base_vendas b),
resultado_final AS
(SELECT c.codgrv,
         c.codrca,
         c.codusuincped,
         c.usuincped,
         c.codusuinc,
         c.usuinc,
         c.codcencus,
         c.descrcencus,
         c.codtipoper,
         c.desctipoper,
         c.nunota,
         c.sequencia,
         c.dtneg,
         c.ad_diassemcompra,
         c.ad_dtultimacompra,
         c.codparc,
         c.promo,
         c.percom,
         c.codprod,
         c.descrprod,
         c.qtdaco,
         c.qtdapd,
         c.qtdalu,
         c.qtdneg_calculada  AS qtdneg,
         c.vlraco,
         c.vlrapd,
         c.vlralu,
         c.vlrtotal          AS vlrunit,
         c.vlricms_calculado AS vlricms,
         c.vlrtotal          AS vlrvenda,
         c.vlrtab,
         c.ad_vlrfrete,
         c.vlrcom,
         c.x12avos,
         c.vlrpis,
         c.vlrcofins,
         c.custo,
         c.custo_unitario,
         c.origem_custo,
         c.data_custo_referencia,
         coalesce(c.dividendo, 0) AS dividendo,
         coalesce(c.divisor, 0) AS divisor
    FROM calculos_comerciais c),
MARGEM_BRUTA AS (
    SELECT R.NUNOTA, R.SEQUENCIA, R.CODPARC,
           R.VLRVENDA, R.CUSTO, R.CUSTO_UNITARIO, R.ORIGEM_CUSTO, R.DATA_CUSTO_REFERENCIA, R.QTDNEG, R.VLRICMS, R.VLRPIS, R.VLRCOFINS,
           R.VLRCOM, R.X12AVOS, R.AD_VLRFRETE,
           ROW_NUMBER() OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
             ORDER BY R.NUNOTA
           ) RN,
           COUNT(*) OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
           ) N_VINCULOS
      FROM RESULTADO_FINAL R
),
MARGEM_ITENS AS (
    SELECT B.*,
           (NVL(B.VLRVENDA,0) -
            (NVL(B.CUSTO,0)+NVL(B.VLRICMS,0)+NVL(B.VLRPIS,0)+
             NVL(B.VLRCOFINS,0)+NVL(B.VLRCOM,0)+NVL(B.X12AVOS,0)+
             NVL(B.AD_VLRFRETE,0))) AS MARGEM
      FROM MARGEM_BRUTA B
     WHERE B.RN = 1
),
Q539_AGREGADO AS (
 SELECT M.NUNOTA AS PEDIDO_ID,
        I.CODPROD AS SKU,
        TO_CHAR(C.DTNEG,'YYYY-MM-DD') AS DIA,
        C.CODTIPOPER AS OPERACAO,
        NVL(C.CODVEND,-1) AS REPRESENTANTE,
        C.CODPARC AS CLIENTE,
        COUNT(*) AS ITENS,
        SUM(M.N_VINCULOS-1) AS DUPLICADOS,
        SUM(CASE WHEN (M.CUSTO_UNITARIO IS NULL OR M.CUSTO_UNITARIO<=0)
             AND NVL(I.QTDNEG,0)>0
             THEN 1 ELSE 0 END) AS SEM_CUSTO,
        SUM(NVL(M.VLRVENDA,0)) AS RECEITA,
        SUM(NVL(M.QTDNEG,0)) AS QUANTIDADE,
        SUM(NVL(M.CUSTO,0)) AS CUSTO,
        SUM(NVL(M.VLRICMS,0)) AS ICMS,
        SUM(NVL(M.VLRPIS,0)) AS PIS,
        SUM(NVL(M.VLRCOFINS,0)) AS COFINS,
        SUM(NVL(M.VLRCOM,0)) AS COMISSAO,
        SUM(NVL(M.X12AVOS,0)) AS REFLEXO_COMISSAO,
        SUM(NVL(M.AD_VLRFRETE,0)) AS FRETE,
        MAX(M.DATA_CUSTO_REFERENCIA) AS DATA_CUSTO,
        MAX(M.ORIGEM_CUSTO) AS ORIGEM_CUSTO,
        MAX(CASE WHEN NVL(I.NUPROMOCAO,0) > 0 THEN 1 ELSE 0 END) AS ITEM_PROMOCIONAL,
        SUM(NVL(M.MARGEM,0)) AS MARGEM
   FROM MARGEM_ITENS M
   JOIN SANKHYA.TGFCAB C ON C.NUNOTA=M.NUNOTA
   JOIN SANKHYA.TGFITE I ON I.NUNOTA=M.NUNOTA AND I.SEQUENCIA=M.SEQUENCIA
  GROUP BY M.NUNOTA,I.CODPROD,C.DTNEG,C.CODTIPOPER,C.CODVEND,C.CODPARC
)
SELECT PEDIDO_ID, SKU, DIA, OPERACAO, REPRESENTANTE, CLIENTE,
       ITENS, DUPLICADOS, SEM_CUSTO,
       ROUND(RECEITA,6) AS RECEITA,
       ROUND(QUANTIDADE,6) AS QUANTIDADE,
       ROUND(CUSTO,6) AS CUSTO,
       ROUND(ICMS,6) AS ICMS,
       ROUND(PIS,6) AS PIS,
       ROUND(COFINS,6) AS COFINS,
       ROUND(COMISSAO,6) AS COMISSAO,
       ROUND(REFLEXO_COMISSAO,6) AS REFLEXO_COMISSAO,
       ROUND(FRETE,6) AS FRETE,
       DATA_CUSTO,
       ORIGEM_CUSTO, ITEM_PROMOCIONAL,
       ROUND(MARGEM,6) AS MARGEM
  FROM Q539_AGREGADO
 ORDER BY PEDIDO_ID,SKU
</snk:query>
</c:catch>
<c:catch var="haialaFalhaQ539T09">
<snk:query var="haialaQ539T09">
WITH
parametros AS
(SELECT DATE '2026-01-01' AS data_inicial,
         TRUNC(SYSDATE) AS data_final,
         DATE '2026-09-01' AS data_consulta_inicio,
         DATE '2026-10-01' AS data_consulta_fim
    FROM dual),
historico_gerentes AS
(SELECT h.codger,
         h.codvend
    FROM SANKHYA.AD_HISGRVRCA h
   CROSS JOIN parametros p
   WHERE p.data_inicial BETWEEN h.dtinicial AND h.dtfinal),
variacoes_nota AS
(SELECT DISTINCT v.nunota,
                  v.sequencia,
                  v.nunotaorig,
                  v.sequenciaorig
    FROM SANKHYA.TGFVAR v),
itens_originais AS
(SELECT v.nunota,
         v.sequencia,
         v.nunotaorig,
         v.sequenciaorig,
         i.nunota        AS nunota_item_origem,
         i.sequencia     AS sequencia_item_origem
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunotaorig
     AND i.sequencia = v.sequenciaorig),
cabecalhos_originais AS
(SELECT i.nunota,
         i.sequencia,
         i.nunotaorig,
         i.sequenciaorig,
         c.nunota AS nunota_cab_origem,
         c.codusuinc,
         c.ad_diassemcompra,
         c.ad_dtultimacompra
    FROM itens_originais i
    LEFT JOIN SANKHYA.TGFCAB c
      ON c.nunota = i.nunota_item_origem),
comissoes_originais AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig,
                  v.sequencia,
                  v.sequenciaorig,
                  i.codprod,
                  i.perccom AS perccomf
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunota
     AND i.sequencia = v.sequencia),
variacoes_anteriores AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig
    FROM SANKHYA.TGFVAR v),
precos_originais AS
(SELECT DISTINCT i.nunota,
                  t.nutab
    FROM SANKHYA.TGFITE i
   INNER JOIN SANKHYA.TGFTAB t
      ON t.nutab = i.nutab),
valores_prazo_medio AS
(SELECT c.nunota,
         c.codtipvenda,
         coalesce(SUM((c.vlrliq * pg.percentual / 100) * CASE
                         WHEN pg.prazo = 0 THEN
                          1
                         ELSE
                          pg.prazo
                      END), 0) AS dividendo,
         coalesce(SUM(c.vlrliq * pg.percentual / 100), 0) AS divisor
    FROM (SELECT cab.nunota,
                 cab.codtipvenda,
                 SUM(ite.ad_vlrliq) AS vlrliq
            FROM SANKHYA.TGFCAB cab
            LEFT JOIN SANKHYA.TGFITE ite
              ON ite.nunota = cab.nunota
           CROSS JOIN parametros p
           WHERE cab.tipmov = 'P'
             AND cab.dtneg >= p.data_consulta_inicio
             AND cab.dtneg < p.data_consulta_fim
             AND cab.codtipoper > 999
             AND cab.codtipoper NOT IN (1002, 1003, 9002, 1006, 1009)
           GROUP BY cab.nunota,
                    cab.codtipvenda) c
    LEFT JOIN SANKHYA.TGFPPG pg
      ON pg.codtipvenda = c.codtipvenda
   GROUP BY c.nunota,
            c.codtipvenda),
base_vendas AS
(SELECT ger.codvend AS codgrv,
         cab.codvend AS codrca,
         item.nutab,
         coalesce(cab_orig.codusuinc, 0) AS codusuincped,
         coalesce(usu_orig.nomeusu, 'MEGA') AS usuincped,
         coalesce(cab.codusuinc, 0) AS codusuinc,
         coalesce(usu.nomeusu, 'MEGA') AS usuinc,
         cab.codcencus,
         cc.descrcencus,
         cab.codtipoper,
         top.descroper AS desctipoper,
         cab.nunota,
         item.sequencia AS sequencia,
         cab.dtneg,
         coalesce(cab.ad_diassemcompra, cab_orig.ad_diassemcompra) AS ad_diassemcompra,
         coalesce(cab.ad_dtultimacompra, cab_orig.ad_dtultimacompra) AS ad_dtultimacompra,
         cab.codparc,
         prod.codprod,
         prod.descrprod || prod.compldesc AS descrprod,
         prod.codgrupoprod,
         item.aliqicms,
         item.qtdneg,
         item.qtdentregue,
         item.pendente,
         item.ad_vlrliq,
         item.vlricms,
         item.perccom,
         item.nupromocao,
         CASE
            WHEN item.nupromocao IS NULL THEN
             'N'
            ELSE
             'S'
         END AS promo,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percom,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percentual_comissao,
         NVL(item.qtdneg, 0) AS qtd_considerada,
         CASE
            WHEN cab.codtipoper IN (1200, 1201, 1202, 1209, 9200) THEN
             -1
            ELSE
             1
         END AS fator_operacao,
         item.ad_vlrliq / NULLIF(item.qtdneg, 0) AS vlr_unitario_calculado,
         coalesce(item.qtdneg, 0) AS qtd_negociada,
         coalesce(preco.vlrvenda, 0) AS preco_tabela,
         CASE
            WHEN coalesce(preco.ad_vlrfrete, 0) = 0 THEN
             preco_orig.ad_vlrfrete
            ELSE
             preco.ad_vlrfrete
         END AS frete_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN custo_mes.CUSSEMICM
              WHEN item.VLRUNIT > 0 THEN item.VLRUNIT
              ELSE NULL END AS custo_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN
              CASE WHEN custo_mes.DTATUAL >= ADD_MONTHS(TRUNC(cab.DTNEG,'MM'),-1)
                         AND custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '01_MES_ANTERIOR'
                   WHEN custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '02_HISTORICO_ANTERIOR'
                   ELSE '03_ATUAL_CONTINGENCIA' END
              WHEN item.VLRUNIT > 0 THEN '04_VLRUNIT_CONTINGENCIA'
              ELSE 'SEM_REFERENCIA' END AS origem_custo,
         TO_CHAR(custo_mes.DTATUAL,'YYYY-MM-DD') AS data_custo_referencia,
         prazo.dividendo,
         prazo.divisor
    FROM SANKHYA.TGFCAB cab
    LEFT JOIN historico_gerentes ger
      ON ger.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN vend
      ON vend.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN gerente
      ON gerente.codvend = ger.codger
    LEFT JOIN SANKHYA.TGFITE item
      ON item.nunota = cab.nunota
    LEFT JOIN SANKHYA.TGFPRO prod
      ON prod.codprod = item.codprod
    OUTER APPLY (
      SELECT E.VLRVENDA, E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = item.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco
    LEFT JOIN SANKHYA.TSIUSU usu
      ON usu.codusu = cab.codusuinc
    LEFT JOIN SANKHYA.TSICUS cc
      ON cc.codcencus = cab.codcencus
    LEFT JOIN variacoes_nota var
      ON var.nunota = item.nunota
     AND var.sequencia = item.sequencia
    LEFT JOIN itens_originais item_orig
      ON item_orig.nunota = var.nunota
     AND item_orig.sequencia = var.sequencia
    LEFT JOIN cabecalhos_originais cab_orig
      ON cab_orig.nunota = var.nunota
     AND cab_orig.sequencia = var.sequencia
    LEFT JOIN SANKHYA.TSIUSU usu_orig
      ON usu_orig.codusu = cab_orig.codusuinc
    LEFT JOIN comissoes_originais com_orig
      ON com_orig.nunota = cab.nunota
     AND com_orig.sequencia = item.sequencia
     AND com_orig.nunotaorig = cab_orig.nunotaorig
     AND com_orig.sequenciaorig = item_orig.sequencia_item_origem
     AND com_orig.codprod = item.codprod
    LEFT JOIN variacoes_anteriores var_ant
      ON var_ant.nunota = var.nunotaorig
    LEFT JOIN SANKHYA.TGFCAB cab_ant
      ON cab_ant.nunota = var_ant.nunotaorig
    LEFT JOIN precos_originais tabela_orig
      ON tabela_orig.nunota = cab_ant.nunota
    OUTER APPLY (
      SELECT E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = tabela_orig.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco_orig
    LEFT JOIN SANKHYA.TGFTOP top
      ON top.codtipoper = cab.codtipoper
      AND top.dhalter = cab.dhtipoper
    LEFT JOIN valores_prazo_medio prazo
      ON prazo.nunota = cab.nunota
    OUTER APPLY (
      SELECT C.CUSSEMICM, C.DTATUAL
        FROM SANKHYA.TGFCUS C
       WHERE C.CODEMP = cab.CODEMP
         AND C.CODPROD = item.CODPROD
         AND C.CUSSEMICM > 0
       ORDER BY CASE WHEN C.DTATUAL < TRUNC(cab.DTNEG,'MM') THEN 0 ELSE 1 END,
                C.DTATUAL DESC, C.DHALTER DESC,
                C.CODLOCAL DESC, C.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) custo_mes
   CROSS JOIN parametros p
   WHERE
   CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END >= p.data_consulta_inicio
AND CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END < p.data_consulta_fim
 AND cab.codemp = 1
 AND cab.tipmov = 'P'
 AND cab.STATUSNOTA IN ('A','P','L')
 AND (cab.codtipoper IN (1000, 1001, 1005, 1007, 9000, 9001, 1002, 1003, 1006, 1009, 9002, 1004) OR (cab.codtipoper = 1100 AND prod.codgrupoprod = 40209001))
 AND cab.dtneg >= DATE '2026-09-01'
 AND cab.dtneg < DATE '2026-10-01'

),
calculos_comerciais AS
(SELECT b.*,
         b.qtd_considerada * b.fator_operacao AS qtdneg_calculada,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdaco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdalu,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlraco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlrapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlralu,
         b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao AS vlrtotal,
         (b.vlricms / NULLIF(b.qtdneg, 0)) * b.qtd_considerada * b.fator_operacao AS vlricms_calculado,
         coalesce(b.qtd_considerada * b.preco_tabela, 0) AS vlrtab,
         coalesce(b.qtd_considerada * b.frete_unitario, 0) AS ad_vlrfrete,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao
         END AS vlrcom,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao * 0.083333
         END AS x12avos,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165
         END AS vlrpis,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076
         END AS vlrcofins,
         b.qtd_considerada * b.custo_unitario * b.fator_operacao AS custo
    FROM base_vendas b),
resultado_final AS
(SELECT c.codgrv,
         c.codrca,
         c.codusuincped,
         c.usuincped,
         c.codusuinc,
         c.usuinc,
         c.codcencus,
         c.descrcencus,
         c.codtipoper,
         c.desctipoper,
         c.nunota,
         c.sequencia,
         c.dtneg,
         c.ad_diassemcompra,
         c.ad_dtultimacompra,
         c.codparc,
         c.promo,
         c.percom,
         c.codprod,
         c.descrprod,
         c.qtdaco,
         c.qtdapd,
         c.qtdalu,
         c.qtdneg_calculada  AS qtdneg,
         c.vlraco,
         c.vlrapd,
         c.vlralu,
         c.vlrtotal          AS vlrunit,
         c.vlricms_calculado AS vlricms,
         c.vlrtotal          AS vlrvenda,
         c.vlrtab,
         c.ad_vlrfrete,
         c.vlrcom,
         c.x12avos,
         c.vlrpis,
         c.vlrcofins,
         c.custo,
         c.custo_unitario,
         c.origem_custo,
         c.data_custo_referencia,
         coalesce(c.dividendo, 0) AS dividendo,
         coalesce(c.divisor, 0) AS divisor
    FROM calculos_comerciais c),
MARGEM_BRUTA AS (
    SELECT R.NUNOTA, R.SEQUENCIA, R.CODPARC,
           R.VLRVENDA, R.CUSTO, R.CUSTO_UNITARIO, R.ORIGEM_CUSTO, R.DATA_CUSTO_REFERENCIA, R.QTDNEG, R.VLRICMS, R.VLRPIS, R.VLRCOFINS,
           R.VLRCOM, R.X12AVOS, R.AD_VLRFRETE,
           ROW_NUMBER() OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
             ORDER BY R.NUNOTA
           ) RN,
           COUNT(*) OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
           ) N_VINCULOS
      FROM RESULTADO_FINAL R
),
MARGEM_ITENS AS (
    SELECT B.*,
           (NVL(B.VLRVENDA,0) -
            (NVL(B.CUSTO,0)+NVL(B.VLRICMS,0)+NVL(B.VLRPIS,0)+
             NVL(B.VLRCOFINS,0)+NVL(B.VLRCOM,0)+NVL(B.X12AVOS,0)+
             NVL(B.AD_VLRFRETE,0))) AS MARGEM
      FROM MARGEM_BRUTA B
     WHERE B.RN = 1
),
Q539_AGREGADO AS (
 SELECT M.NUNOTA AS PEDIDO_ID,
        I.CODPROD AS SKU,
        TO_CHAR(C.DTNEG,'YYYY-MM-DD') AS DIA,
        C.CODTIPOPER AS OPERACAO,
        NVL(C.CODVEND,-1) AS REPRESENTANTE,
        C.CODPARC AS CLIENTE,
        COUNT(*) AS ITENS,
        SUM(M.N_VINCULOS-1) AS DUPLICADOS,
        SUM(CASE WHEN (M.CUSTO_UNITARIO IS NULL OR M.CUSTO_UNITARIO<=0)
             AND NVL(I.QTDNEG,0)>0
             THEN 1 ELSE 0 END) AS SEM_CUSTO,
        SUM(NVL(M.VLRVENDA,0)) AS RECEITA,
        SUM(NVL(M.QTDNEG,0)) AS QUANTIDADE,
        SUM(NVL(M.CUSTO,0)) AS CUSTO,
        SUM(NVL(M.VLRICMS,0)) AS ICMS,
        SUM(NVL(M.VLRPIS,0)) AS PIS,
        SUM(NVL(M.VLRCOFINS,0)) AS COFINS,
        SUM(NVL(M.VLRCOM,0)) AS COMISSAO,
        SUM(NVL(M.X12AVOS,0)) AS REFLEXO_COMISSAO,
        SUM(NVL(M.AD_VLRFRETE,0)) AS FRETE,
        MAX(M.DATA_CUSTO_REFERENCIA) AS DATA_CUSTO,
        MAX(M.ORIGEM_CUSTO) AS ORIGEM_CUSTO,
        MAX(CASE WHEN NVL(I.NUPROMOCAO,0) > 0 THEN 1 ELSE 0 END) AS ITEM_PROMOCIONAL,
        SUM(NVL(M.MARGEM,0)) AS MARGEM
   FROM MARGEM_ITENS M
   JOIN SANKHYA.TGFCAB C ON C.NUNOTA=M.NUNOTA
   JOIN SANKHYA.TGFITE I ON I.NUNOTA=M.NUNOTA AND I.SEQUENCIA=M.SEQUENCIA
  GROUP BY M.NUNOTA,I.CODPROD,C.DTNEG,C.CODTIPOPER,C.CODVEND,C.CODPARC
)
SELECT PEDIDO_ID, SKU, DIA, OPERACAO, REPRESENTANTE, CLIENTE,
       ITENS, DUPLICADOS, SEM_CUSTO,
       ROUND(RECEITA,6) AS RECEITA,
       ROUND(QUANTIDADE,6) AS QUANTIDADE,
       ROUND(CUSTO,6) AS CUSTO,
       ROUND(ICMS,6) AS ICMS,
       ROUND(PIS,6) AS PIS,
       ROUND(COFINS,6) AS COFINS,
       ROUND(COMISSAO,6) AS COMISSAO,
       ROUND(REFLEXO_COMISSAO,6) AS REFLEXO_COMISSAO,
       ROUND(FRETE,6) AS FRETE,
       DATA_CUSTO,
       ORIGEM_CUSTO, ITEM_PROMOCIONAL,
       ROUND(MARGEM,6) AS MARGEM
  FROM Q539_AGREGADO
 ORDER BY PEDIDO_ID,SKU
</snk:query>
</c:catch>
<c:catch var="haialaFalhaQ539T10">
<snk:query var="haialaQ539T10">
WITH
parametros AS
(SELECT DATE '2026-01-01' AS data_inicial,
         TRUNC(SYSDATE) AS data_final,
         DATE '2026-10-01' AS data_consulta_inicio,
         DATE '2026-11-01' AS data_consulta_fim
    FROM dual),
historico_gerentes AS
(SELECT h.codger,
         h.codvend
    FROM SANKHYA.AD_HISGRVRCA h
   CROSS JOIN parametros p
   WHERE p.data_inicial BETWEEN h.dtinicial AND h.dtfinal),
variacoes_nota AS
(SELECT DISTINCT v.nunota,
                  v.sequencia,
                  v.nunotaorig,
                  v.sequenciaorig
    FROM SANKHYA.TGFVAR v),
itens_originais AS
(SELECT v.nunota,
         v.sequencia,
         v.nunotaorig,
         v.sequenciaorig,
         i.nunota        AS nunota_item_origem,
         i.sequencia     AS sequencia_item_origem
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunotaorig
     AND i.sequencia = v.sequenciaorig),
cabecalhos_originais AS
(SELECT i.nunota,
         i.sequencia,
         i.nunotaorig,
         i.sequenciaorig,
         c.nunota AS nunota_cab_origem,
         c.codusuinc,
         c.ad_diassemcompra,
         c.ad_dtultimacompra
    FROM itens_originais i
    LEFT JOIN SANKHYA.TGFCAB c
      ON c.nunota = i.nunota_item_origem),
comissoes_originais AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig,
                  v.sequencia,
                  v.sequenciaorig,
                  i.codprod,
                  i.perccom AS perccomf
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunota
     AND i.sequencia = v.sequencia),
variacoes_anteriores AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig
    FROM SANKHYA.TGFVAR v),
precos_originais AS
(SELECT DISTINCT i.nunota,
                  t.nutab
    FROM SANKHYA.TGFITE i
   INNER JOIN SANKHYA.TGFTAB t
      ON t.nutab = i.nutab),
valores_prazo_medio AS
(SELECT c.nunota,
         c.codtipvenda,
         coalesce(SUM((c.vlrliq * pg.percentual / 100) * CASE
                         WHEN pg.prazo = 0 THEN
                          1
                         ELSE
                          pg.prazo
                      END), 0) AS dividendo,
         coalesce(SUM(c.vlrliq * pg.percentual / 100), 0) AS divisor
    FROM (SELECT cab.nunota,
                 cab.codtipvenda,
                 SUM(ite.ad_vlrliq) AS vlrliq
            FROM SANKHYA.TGFCAB cab
            LEFT JOIN SANKHYA.TGFITE ite
              ON ite.nunota = cab.nunota
           CROSS JOIN parametros p
           WHERE cab.tipmov = 'P'
             AND cab.dtneg >= p.data_consulta_inicio
             AND cab.dtneg < p.data_consulta_fim
             AND cab.codtipoper > 999
             AND cab.codtipoper NOT IN (1002, 1003, 9002, 1006, 1009)
           GROUP BY cab.nunota,
                    cab.codtipvenda) c
    LEFT JOIN SANKHYA.TGFPPG pg
      ON pg.codtipvenda = c.codtipvenda
   GROUP BY c.nunota,
            c.codtipvenda),
base_vendas AS
(SELECT ger.codvend AS codgrv,
         cab.codvend AS codrca,
         item.nutab,
         coalesce(cab_orig.codusuinc, 0) AS codusuincped,
         coalesce(usu_orig.nomeusu, 'MEGA') AS usuincped,
         coalesce(cab.codusuinc, 0) AS codusuinc,
         coalesce(usu.nomeusu, 'MEGA') AS usuinc,
         cab.codcencus,
         cc.descrcencus,
         cab.codtipoper,
         top.descroper AS desctipoper,
         cab.nunota,
         item.sequencia AS sequencia,
         cab.dtneg,
         coalesce(cab.ad_diassemcompra, cab_orig.ad_diassemcompra) AS ad_diassemcompra,
         coalesce(cab.ad_dtultimacompra, cab_orig.ad_dtultimacompra) AS ad_dtultimacompra,
         cab.codparc,
         prod.codprod,
         prod.descrprod || prod.compldesc AS descrprod,
         prod.codgrupoprod,
         item.aliqicms,
         item.qtdneg,
         item.qtdentregue,
         item.pendente,
         item.ad_vlrliq,
         item.vlricms,
         item.perccom,
         item.nupromocao,
         CASE
            WHEN item.nupromocao IS NULL THEN
             'N'
            ELSE
             'S'
         END AS promo,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percom,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percentual_comissao,
         NVL(item.qtdneg, 0) AS qtd_considerada,
         CASE
            WHEN cab.codtipoper IN (1200, 1201, 1202, 1209, 9200) THEN
             -1
            ELSE
             1
         END AS fator_operacao,
         item.ad_vlrliq / NULLIF(item.qtdneg, 0) AS vlr_unitario_calculado,
         coalesce(item.qtdneg, 0) AS qtd_negociada,
         coalesce(preco.vlrvenda, 0) AS preco_tabela,
         CASE
            WHEN coalesce(preco.ad_vlrfrete, 0) = 0 THEN
             preco_orig.ad_vlrfrete
            ELSE
             preco.ad_vlrfrete
         END AS frete_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN custo_mes.CUSSEMICM
              WHEN item.VLRUNIT > 0 THEN item.VLRUNIT
              ELSE NULL END AS custo_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN
              CASE WHEN custo_mes.DTATUAL >= ADD_MONTHS(TRUNC(cab.DTNEG,'MM'),-1)
                         AND custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '01_MES_ANTERIOR'
                   WHEN custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '02_HISTORICO_ANTERIOR'
                   ELSE '03_ATUAL_CONTINGENCIA' END
              WHEN item.VLRUNIT > 0 THEN '04_VLRUNIT_CONTINGENCIA'
              ELSE 'SEM_REFERENCIA' END AS origem_custo,
         TO_CHAR(custo_mes.DTATUAL,'YYYY-MM-DD') AS data_custo_referencia,
         prazo.dividendo,
         prazo.divisor
    FROM SANKHYA.TGFCAB cab
    LEFT JOIN historico_gerentes ger
      ON ger.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN vend
      ON vend.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN gerente
      ON gerente.codvend = ger.codger
    LEFT JOIN SANKHYA.TGFITE item
      ON item.nunota = cab.nunota
    LEFT JOIN SANKHYA.TGFPRO prod
      ON prod.codprod = item.codprod
    OUTER APPLY (
      SELECT E.VLRVENDA, E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = item.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco
    LEFT JOIN SANKHYA.TSIUSU usu
      ON usu.codusu = cab.codusuinc
    LEFT JOIN SANKHYA.TSICUS cc
      ON cc.codcencus = cab.codcencus
    LEFT JOIN variacoes_nota var
      ON var.nunota = item.nunota
     AND var.sequencia = item.sequencia
    LEFT JOIN itens_originais item_orig
      ON item_orig.nunota = var.nunota
     AND item_orig.sequencia = var.sequencia
    LEFT JOIN cabecalhos_originais cab_orig
      ON cab_orig.nunota = var.nunota
     AND cab_orig.sequencia = var.sequencia
    LEFT JOIN SANKHYA.TSIUSU usu_orig
      ON usu_orig.codusu = cab_orig.codusuinc
    LEFT JOIN comissoes_originais com_orig
      ON com_orig.nunota = cab.nunota
     AND com_orig.sequencia = item.sequencia
     AND com_orig.nunotaorig = cab_orig.nunotaorig
     AND com_orig.sequenciaorig = item_orig.sequencia_item_origem
     AND com_orig.codprod = item.codprod
    LEFT JOIN variacoes_anteriores var_ant
      ON var_ant.nunota = var.nunotaorig
    LEFT JOIN SANKHYA.TGFCAB cab_ant
      ON cab_ant.nunota = var_ant.nunotaorig
    LEFT JOIN precos_originais tabela_orig
      ON tabela_orig.nunota = cab_ant.nunota
    OUTER APPLY (
      SELECT E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = tabela_orig.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco_orig
    LEFT JOIN SANKHYA.TGFTOP top
      ON top.codtipoper = cab.codtipoper
      AND top.dhalter = cab.dhtipoper
    LEFT JOIN valores_prazo_medio prazo
      ON prazo.nunota = cab.nunota
    OUTER APPLY (
      SELECT C.CUSSEMICM, C.DTATUAL
        FROM SANKHYA.TGFCUS C
       WHERE C.CODEMP = cab.CODEMP
         AND C.CODPROD = item.CODPROD
         AND C.CUSSEMICM > 0
       ORDER BY CASE WHEN C.DTATUAL < TRUNC(cab.DTNEG,'MM') THEN 0 ELSE 1 END,
                C.DTATUAL DESC, C.DHALTER DESC,
                C.CODLOCAL DESC, C.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) custo_mes
   CROSS JOIN parametros p
   WHERE
   CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END >= p.data_consulta_inicio
AND CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END < p.data_consulta_fim
 AND cab.codemp = 1
 AND cab.tipmov = 'P'
 AND cab.STATUSNOTA IN ('A','P','L')
 AND (cab.codtipoper IN (1000, 1001, 1005, 1007, 9000, 9001, 1002, 1003, 1006, 1009, 9002, 1004) OR (cab.codtipoper = 1100 AND prod.codgrupoprod = 40209001))
 AND cab.dtneg >= DATE '2026-10-01'
 AND cab.dtneg < DATE '2026-11-01'

),
calculos_comerciais AS
(SELECT b.*,
         b.qtd_considerada * b.fator_operacao AS qtdneg_calculada,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdaco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdalu,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlraco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlrapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlralu,
         b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao AS vlrtotal,
         (b.vlricms / NULLIF(b.qtdneg, 0)) * b.qtd_considerada * b.fator_operacao AS vlricms_calculado,
         coalesce(b.qtd_considerada * b.preco_tabela, 0) AS vlrtab,
         coalesce(b.qtd_considerada * b.frete_unitario, 0) AS ad_vlrfrete,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao
         END AS vlrcom,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao * 0.083333
         END AS x12avos,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165
         END AS vlrpis,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076
         END AS vlrcofins,
         b.qtd_considerada * b.custo_unitario * b.fator_operacao AS custo
    FROM base_vendas b),
resultado_final AS
(SELECT c.codgrv,
         c.codrca,
         c.codusuincped,
         c.usuincped,
         c.codusuinc,
         c.usuinc,
         c.codcencus,
         c.descrcencus,
         c.codtipoper,
         c.desctipoper,
         c.nunota,
         c.sequencia,
         c.dtneg,
         c.ad_diassemcompra,
         c.ad_dtultimacompra,
         c.codparc,
         c.promo,
         c.percom,
         c.codprod,
         c.descrprod,
         c.qtdaco,
         c.qtdapd,
         c.qtdalu,
         c.qtdneg_calculada  AS qtdneg,
         c.vlraco,
         c.vlrapd,
         c.vlralu,
         c.vlrtotal          AS vlrunit,
         c.vlricms_calculado AS vlricms,
         c.vlrtotal          AS vlrvenda,
         c.vlrtab,
         c.ad_vlrfrete,
         c.vlrcom,
         c.x12avos,
         c.vlrpis,
         c.vlrcofins,
         c.custo,
         c.custo_unitario,
         c.origem_custo,
         c.data_custo_referencia,
         coalesce(c.dividendo, 0) AS dividendo,
         coalesce(c.divisor, 0) AS divisor
    FROM calculos_comerciais c),
MARGEM_BRUTA AS (
    SELECT R.NUNOTA, R.SEQUENCIA, R.CODPARC,
           R.VLRVENDA, R.CUSTO, R.CUSTO_UNITARIO, R.ORIGEM_CUSTO, R.DATA_CUSTO_REFERENCIA, R.QTDNEG, R.VLRICMS, R.VLRPIS, R.VLRCOFINS,
           R.VLRCOM, R.X12AVOS, R.AD_VLRFRETE,
           ROW_NUMBER() OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
             ORDER BY R.NUNOTA
           ) RN,
           COUNT(*) OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
           ) N_VINCULOS
      FROM RESULTADO_FINAL R
),
MARGEM_ITENS AS (
    SELECT B.*,
           (NVL(B.VLRVENDA,0) -
            (NVL(B.CUSTO,0)+NVL(B.VLRICMS,0)+NVL(B.VLRPIS,0)+
             NVL(B.VLRCOFINS,0)+NVL(B.VLRCOM,0)+NVL(B.X12AVOS,0)+
             NVL(B.AD_VLRFRETE,0))) AS MARGEM
      FROM MARGEM_BRUTA B
     WHERE B.RN = 1
),
Q539_AGREGADO AS (
 SELECT M.NUNOTA AS PEDIDO_ID,
        I.CODPROD AS SKU,
        TO_CHAR(C.DTNEG,'YYYY-MM-DD') AS DIA,
        C.CODTIPOPER AS OPERACAO,
        NVL(C.CODVEND,-1) AS REPRESENTANTE,
        C.CODPARC AS CLIENTE,
        COUNT(*) AS ITENS,
        SUM(M.N_VINCULOS-1) AS DUPLICADOS,
        SUM(CASE WHEN (M.CUSTO_UNITARIO IS NULL OR M.CUSTO_UNITARIO<=0)
             AND NVL(I.QTDNEG,0)>0
             THEN 1 ELSE 0 END) AS SEM_CUSTO,
        SUM(NVL(M.VLRVENDA,0)) AS RECEITA,
        SUM(NVL(M.QTDNEG,0)) AS QUANTIDADE,
        SUM(NVL(M.CUSTO,0)) AS CUSTO,
        SUM(NVL(M.VLRICMS,0)) AS ICMS,
        SUM(NVL(M.VLRPIS,0)) AS PIS,
        SUM(NVL(M.VLRCOFINS,0)) AS COFINS,
        SUM(NVL(M.VLRCOM,0)) AS COMISSAO,
        SUM(NVL(M.X12AVOS,0)) AS REFLEXO_COMISSAO,
        SUM(NVL(M.AD_VLRFRETE,0)) AS FRETE,
        MAX(M.DATA_CUSTO_REFERENCIA) AS DATA_CUSTO,
        MAX(M.ORIGEM_CUSTO) AS ORIGEM_CUSTO,
        MAX(CASE WHEN NVL(I.NUPROMOCAO,0) > 0 THEN 1 ELSE 0 END) AS ITEM_PROMOCIONAL,
        SUM(NVL(M.MARGEM,0)) AS MARGEM
   FROM MARGEM_ITENS M
   JOIN SANKHYA.TGFCAB C ON C.NUNOTA=M.NUNOTA
   JOIN SANKHYA.TGFITE I ON I.NUNOTA=M.NUNOTA AND I.SEQUENCIA=M.SEQUENCIA
  GROUP BY M.NUNOTA,I.CODPROD,C.DTNEG,C.CODTIPOPER,C.CODVEND,C.CODPARC
)
SELECT PEDIDO_ID, SKU, DIA, OPERACAO, REPRESENTANTE, CLIENTE,
       ITENS, DUPLICADOS, SEM_CUSTO,
       ROUND(RECEITA,6) AS RECEITA,
       ROUND(QUANTIDADE,6) AS QUANTIDADE,
       ROUND(CUSTO,6) AS CUSTO,
       ROUND(ICMS,6) AS ICMS,
       ROUND(PIS,6) AS PIS,
       ROUND(COFINS,6) AS COFINS,
       ROUND(COMISSAO,6) AS COMISSAO,
       ROUND(REFLEXO_COMISSAO,6) AS REFLEXO_COMISSAO,
       ROUND(FRETE,6) AS FRETE,
       DATA_CUSTO,
       ORIGEM_CUSTO, ITEM_PROMOCIONAL,
       ROUND(MARGEM,6) AS MARGEM
  FROM Q539_AGREGADO
 ORDER BY PEDIDO_ID,SKU
</snk:query>
</c:catch>
<c:catch var="haialaFalhaQ539T11">
<snk:query var="haialaQ539T11">
WITH
parametros AS
(SELECT DATE '2026-01-01' AS data_inicial,
         TRUNC(SYSDATE) AS data_final,
         DATE '2026-11-01' AS data_consulta_inicio,
         DATE '2026-12-01' AS data_consulta_fim
    FROM dual),
historico_gerentes AS
(SELECT h.codger,
         h.codvend
    FROM SANKHYA.AD_HISGRVRCA h
   CROSS JOIN parametros p
   WHERE p.data_inicial BETWEEN h.dtinicial AND h.dtfinal),
variacoes_nota AS
(SELECT DISTINCT v.nunota,
                  v.sequencia,
                  v.nunotaorig,
                  v.sequenciaorig
    FROM SANKHYA.TGFVAR v),
itens_originais AS
(SELECT v.nunota,
         v.sequencia,
         v.nunotaorig,
         v.sequenciaorig,
         i.nunota        AS nunota_item_origem,
         i.sequencia     AS sequencia_item_origem
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunotaorig
     AND i.sequencia = v.sequenciaorig),
cabecalhos_originais AS
(SELECT i.nunota,
         i.sequencia,
         i.nunotaorig,
         i.sequenciaorig,
         c.nunota AS nunota_cab_origem,
         c.codusuinc,
         c.ad_diassemcompra,
         c.ad_dtultimacompra
    FROM itens_originais i
    LEFT JOIN SANKHYA.TGFCAB c
      ON c.nunota = i.nunota_item_origem),
comissoes_originais AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig,
                  v.sequencia,
                  v.sequenciaorig,
                  i.codprod,
                  i.perccom AS perccomf
    FROM variacoes_nota v
    LEFT JOIN SANKHYA.TGFITE i
      ON i.nunota = v.nunota
     AND i.sequencia = v.sequencia),
variacoes_anteriores AS
(SELECT DISTINCT v.nunota,
                  v.nunotaorig
    FROM SANKHYA.TGFVAR v),
precos_originais AS
(SELECT DISTINCT i.nunota,
                  t.nutab
    FROM SANKHYA.TGFITE i
   INNER JOIN SANKHYA.TGFTAB t
      ON t.nutab = i.nutab),
valores_prazo_medio AS
(SELECT c.nunota,
         c.codtipvenda,
         coalesce(SUM((c.vlrliq * pg.percentual / 100) * CASE
                         WHEN pg.prazo = 0 THEN
                          1
                         ELSE
                          pg.prazo
                      END), 0) AS dividendo,
         coalesce(SUM(c.vlrliq * pg.percentual / 100), 0) AS divisor
    FROM (SELECT cab.nunota,
                 cab.codtipvenda,
                 SUM(ite.ad_vlrliq) AS vlrliq
            FROM SANKHYA.TGFCAB cab
            LEFT JOIN SANKHYA.TGFITE ite
              ON ite.nunota = cab.nunota
           CROSS JOIN parametros p
           WHERE cab.tipmov = 'P'
             AND cab.dtneg >= p.data_consulta_inicio
             AND cab.dtneg < p.data_consulta_fim
             AND cab.codtipoper > 999
             AND cab.codtipoper NOT IN (1002, 1003, 9002, 1006, 1009)
           GROUP BY cab.nunota,
                    cab.codtipvenda) c
    LEFT JOIN SANKHYA.TGFPPG pg
      ON pg.codtipvenda = c.codtipvenda
   GROUP BY c.nunota,
            c.codtipvenda),
base_vendas AS
(SELECT ger.codvend AS codgrv,
         cab.codvend AS codrca,
         item.nutab,
         coalesce(cab_orig.codusuinc, 0) AS codusuincped,
         coalesce(usu_orig.nomeusu, 'MEGA') AS usuincped,
         coalesce(cab.codusuinc, 0) AS codusuinc,
         coalesce(usu.nomeusu, 'MEGA') AS usuinc,
         cab.codcencus,
         cc.descrcencus,
         cab.codtipoper,
         top.descroper AS desctipoper,
         cab.nunota,
         item.sequencia AS sequencia,
         cab.dtneg,
         coalesce(cab.ad_diassemcompra, cab_orig.ad_diassemcompra) AS ad_diassemcompra,
         coalesce(cab.ad_dtultimacompra, cab_orig.ad_dtultimacompra) AS ad_dtultimacompra,
         cab.codparc,
         prod.codprod,
         prod.descrprod || prod.compldesc AS descrprod,
         prod.codgrupoprod,
         item.aliqicms,
         item.qtdneg,
         item.qtdentregue,
         item.pendente,
         item.ad_vlrliq,
         item.vlricms,
         item.perccom,
         item.nupromocao,
         CASE
            WHEN item.nupromocao IS NULL THEN
             'N'
            ELSE
             'S'
         END AS promo,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percom,
         CASE
            WHEN item.nupromocao IS NOT NULL THEN
             vend.comvenda
            ELSE
             CASE
                WHEN coalesce(com_orig.perccomf, item.perccom) <> 0 THEN
                 coalesce(com_orig.perccomf, item.perccom)
                ELSE
                 vend.comvenda
             END
         END AS percentual_comissao,
         NVL(item.qtdneg, 0) AS qtd_considerada,
         CASE
            WHEN cab.codtipoper IN (1200, 1201, 1202, 1209, 9200) THEN
             -1
            ELSE
             1
         END AS fator_operacao,
         item.ad_vlrliq / NULLIF(item.qtdneg, 0) AS vlr_unitario_calculado,
         coalesce(item.qtdneg, 0) AS qtd_negociada,
         coalesce(preco.vlrvenda, 0) AS preco_tabela,
         CASE
            WHEN coalesce(preco.ad_vlrfrete, 0) = 0 THEN
             preco_orig.ad_vlrfrete
            ELSE
             preco.ad_vlrfrete
         END AS frete_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN custo_mes.CUSSEMICM
              WHEN item.VLRUNIT > 0 THEN item.VLRUNIT
              ELSE NULL END AS custo_unitario,
         CASE WHEN custo_mes.CUSSEMICM > 0 THEN
              CASE WHEN custo_mes.DTATUAL >= ADD_MONTHS(TRUNC(cab.DTNEG,'MM'),-1)
                         AND custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '01_MES_ANTERIOR'
                   WHEN custo_mes.DTATUAL < TRUNC(cab.DTNEG,'MM')
                   THEN '02_HISTORICO_ANTERIOR'
                   ELSE '03_ATUAL_CONTINGENCIA' END
              WHEN item.VLRUNIT > 0 THEN '04_VLRUNIT_CONTINGENCIA'
              ELSE 'SEM_REFERENCIA' END AS origem_custo,
         TO_CHAR(custo_mes.DTATUAL,'YYYY-MM-DD') AS data_custo_referencia,
         prazo.dividendo,
         prazo.divisor
    FROM SANKHYA.TGFCAB cab
    LEFT JOIN historico_gerentes ger
      ON ger.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN vend
      ON vend.codvend = cab.codvend
    LEFT JOIN SANKHYA.TGFVEN gerente
      ON gerente.codvend = ger.codger
    LEFT JOIN SANKHYA.TGFITE item
      ON item.nunota = cab.nunota
    LEFT JOIN SANKHYA.TGFPRO prod
      ON prod.codprod = item.codprod
    OUTER APPLY (
      SELECT E.VLRVENDA, E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = item.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco
    LEFT JOIN SANKHYA.TSIUSU usu
      ON usu.codusu = cab.codusuinc
    LEFT JOIN SANKHYA.TSICUS cc
      ON cc.codcencus = cab.codcencus
    LEFT JOIN variacoes_nota var
      ON var.nunota = item.nunota
     AND var.sequencia = item.sequencia
    LEFT JOIN itens_originais item_orig
      ON item_orig.nunota = var.nunota
     AND item_orig.sequencia = var.sequencia
    LEFT JOIN cabecalhos_originais cab_orig
      ON cab_orig.nunota = var.nunota
     AND cab_orig.sequencia = var.sequencia
    LEFT JOIN SANKHYA.TSIUSU usu_orig
      ON usu_orig.codusu = cab_orig.codusuinc
    LEFT JOIN comissoes_originais com_orig
      ON com_orig.nunota = cab.nunota
     AND com_orig.sequencia = item.sequencia
     AND com_orig.nunotaorig = cab_orig.nunotaorig
     AND com_orig.sequenciaorig = item_orig.sequencia_item_origem
     AND com_orig.codprod = item.codprod
    LEFT JOIN variacoes_anteriores var_ant
      ON var_ant.nunota = var.nunotaorig
    LEFT JOIN SANKHYA.TGFCAB cab_ant
      ON cab_ant.nunota = var_ant.nunotaorig
    LEFT JOIN precos_originais tabela_orig
      ON tabela_orig.nunota = cab_ant.nunota
    OUTER APPLY (
      SELECT E.AD_VLRFRETE
        FROM SANKHYA.TGFEXC E
       WHERE E.NUTAB = tabela_orig.NUTAB
         AND E.CODPROD = item.CODPROD
       ORDER BY CASE WHEN E.CODLOCAL = item.CODLOCALORIG
                          AND E.CONTROLE = item.CONTROLE THEN 0
                     WHEN E.CODLOCAL = item.CODLOCALORIG THEN 1
                     WHEN E.CONTROLE = item.CONTROLE THEN 2
                     ELSE 3 END,
                E.CODLOCAL DESC, E.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) preco_orig
    LEFT JOIN SANKHYA.TGFTOP top
      ON top.codtipoper = cab.codtipoper
      AND top.dhalter = cab.dhtipoper
    LEFT JOIN valores_prazo_medio prazo
      ON prazo.nunota = cab.nunota
    OUTER APPLY (
      SELECT C.CUSSEMICM, C.DTATUAL
        FROM SANKHYA.TGFCUS C
       WHERE C.CODEMP = cab.CODEMP
         AND C.CODPROD = item.CODPROD
         AND C.CUSSEMICM > 0
       ORDER BY CASE WHEN C.DTATUAL < TRUNC(cab.DTNEG,'MM') THEN 0 ELSE 1 END,
                C.DTATUAL DESC, C.DHALTER DESC,
                C.CODLOCAL DESC, C.CONTROLE DESC
       FETCH FIRST 1 ROW ONLY
    ) custo_mes
   CROSS JOIN parametros p
   WHERE
   CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END >= p.data_consulta_inicio
AND CASE
      WHEN cab.codtipoper IN (1200, 1201, 1209, 9200) THEN
       cab.dtmov
      ELSE
       cab.dtneg
   END < p.data_consulta_fim
 AND cab.codemp = 1
 AND cab.tipmov = 'P'
 AND cab.STATUSNOTA IN ('A','P','L')
 AND (cab.codtipoper IN (1000, 1001, 1005, 1007, 9000, 9001, 1002, 1003, 1006, 1009, 9002, 1004) OR (cab.codtipoper = 1100 AND prod.codgrupoprod = 40209001))
 AND cab.dtneg >= DATE '2026-11-01'
 AND cab.dtneg < DATE '2026-12-01'

),
calculos_comerciais AS
(SELECT b.*,
         b.qtd_considerada * b.fator_operacao AS qtdneg_calculada,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdaco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             CASE
                WHEN b.fator_operacao = -1 THEN
                 b.qtdneg * -1
                ELSE
                 b.qtd_considerada
             END
            ELSE
             0
         END AS qtdalu,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 401 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlraco,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 402 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlrapd,
         CASE
            WHEN substr(b.codgrupoprod, 1, 3) = 403 THEN
             b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao
            ELSE
             0
         END AS vlralu,
         b.qtd_considerada * b.vlr_unitario_calculado * b.fator_operacao AS vlrtotal,
         (b.vlricms / NULLIF(b.qtdneg, 0)) * b.qtd_considerada * b.fator_operacao AS vlricms_calculado,
         coalesce(b.qtd_considerada * b.preco_tabela, 0) AS vlrtab,
         coalesce(b.qtd_considerada * b.frete_unitario, 0) AS ad_vlrfrete,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao
         END AS vlrcom,
         CASE
            WHEN b.codtipoper IN (1002, 1003, 1006, 1009, 1106, 1107, 1109, 1113, 1117, 1119, 9002) THEN
             0
            ELSE
             b.qtd_considerada * b.vlr_unitario_calculado * b.percentual_comissao / 100 * b.fator_operacao * 0.083333
         END AS x12avos,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.0165
         END AS vlrpis,
         CASE
            WHEN b.codtipoper IN (1200, 1201, 1202, 1209) THEN
             (b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076) * -1
            WHEN b.codtipoper IN (9000, 9001, 9100, 9200) THEN
             0
            ELSE
             b.qtd_considerada * ((b.ad_vlrliq - b.vlricms) / NULLIF(b.qtdneg, 0)) * 0.076
         END AS vlrcofins,
         b.qtd_considerada * b.custo_unitario * b.fator_operacao AS custo
    FROM base_vendas b),
resultado_final AS
(SELECT c.codgrv,
         c.codrca,
         c.codusuincped,
         c.usuincped,
         c.codusuinc,
         c.usuinc,
         c.codcencus,
         c.descrcencus,
         c.codtipoper,
         c.desctipoper,
         c.nunota,
         c.sequencia,
         c.dtneg,
         c.ad_diassemcompra,
         c.ad_dtultimacompra,
         c.codparc,
         c.promo,
         c.percom,
         c.codprod,
         c.descrprod,
         c.qtdaco,
         c.qtdapd,
         c.qtdalu,
         c.qtdneg_calculada  AS qtdneg,
         c.vlraco,
         c.vlrapd,
         c.vlralu,
         c.vlrtotal          AS vlrunit,
         c.vlricms_calculado AS vlricms,
         c.vlrtotal          AS vlrvenda,
         c.vlrtab,
         c.ad_vlrfrete,
         c.vlrcom,
         c.x12avos,
         c.vlrpis,
         c.vlrcofins,
         c.custo,
         c.custo_unitario,
         c.origem_custo,
         c.data_custo_referencia,
         coalesce(c.dividendo, 0) AS dividendo,
         coalesce(c.divisor, 0) AS divisor
    FROM calculos_comerciais c),
MARGEM_BRUTA AS (
    SELECT R.NUNOTA, R.SEQUENCIA, R.CODPARC,
           R.VLRVENDA, R.CUSTO, R.CUSTO_UNITARIO, R.ORIGEM_CUSTO, R.DATA_CUSTO_REFERENCIA, R.QTDNEG, R.VLRICMS, R.VLRPIS, R.VLRCOFINS,
           R.VLRCOM, R.X12AVOS, R.AD_VLRFRETE,
           ROW_NUMBER() OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
             ORDER BY R.NUNOTA
           ) RN,
           COUNT(*) OVER (
             PARTITION BY R.NUNOTA, R.SEQUENCIA
           ) N_VINCULOS
      FROM RESULTADO_FINAL R
),
MARGEM_ITENS AS (
    SELECT B.*,
           (NVL(B.VLRVENDA,0) -
            (NVL(B.CUSTO,0)+NVL(B.VLRICMS,0)+NVL(B.VLRPIS,0)+
             NVL(B.VLRCOFINS,0)+NVL(B.VLRCOM,0)+NVL(B.X12AVOS,0)+
             NVL(B.AD_VLRFRETE,0))) AS MARGEM
      FROM MARGEM_BRUTA B
     WHERE B.RN = 1
),
Q539_AGREGADO AS (
 SELECT M.NUNOTA AS PEDIDO_ID,
        I.CODPROD AS SKU,
        TO_CHAR(C.DTNEG,'YYYY-MM-DD') AS DIA,
        C.CODTIPOPER AS OPERACAO,
        NVL(C.CODVEND,-1) AS REPRESENTANTE,
        C.CODPARC AS CLIENTE,
        COUNT(*) AS ITENS,
        SUM(M.N_VINCULOS-1) AS DUPLICADOS,
        SUM(CASE WHEN (M.CUSTO_UNITARIO IS NULL OR M.CUSTO_UNITARIO<=0)
             AND NVL(I.QTDNEG,0)>0
             THEN 1 ELSE 0 END) AS SEM_CUSTO,
        SUM(NVL(M.VLRVENDA,0)) AS RECEITA,
        SUM(NVL(M.QTDNEG,0)) AS QUANTIDADE,
        SUM(NVL(M.CUSTO,0)) AS CUSTO,
        SUM(NVL(M.VLRICMS,0)) AS ICMS,
        SUM(NVL(M.VLRPIS,0)) AS PIS,
        SUM(NVL(M.VLRCOFINS,0)) AS COFINS,
        SUM(NVL(M.VLRCOM,0)) AS COMISSAO,
        SUM(NVL(M.X12AVOS,0)) AS REFLEXO_COMISSAO,
        SUM(NVL(M.AD_VLRFRETE,0)) AS FRETE,
        MAX(M.DATA_CUSTO_REFERENCIA) AS DATA_CUSTO,
        MAX(M.ORIGEM_CUSTO) AS ORIGEM_CUSTO,
        MAX(CASE WHEN NVL(I.NUPROMOCAO,0) > 0 THEN 1 ELSE 0 END) AS ITEM_PROMOCIONAL,
        SUM(NVL(M.MARGEM,0)) AS MARGEM
   FROM MARGEM_ITENS M
   JOIN SANKHYA.TGFCAB C ON C.NUNOTA=M.NUNOTA
   JOIN SANKHYA.TGFITE I ON I.NUNOTA=M.NUNOTA AND I.SEQUENCIA=M.SEQUENCIA
  GROUP BY M.NUNOTA,I.CODPROD,C.DTNEG,C.CODTIPOPER,C.CODVEND,C.CODPARC
)
SELECT PEDIDO_ID, SKU, DIA, OPERACAO, REPRESENTANTE, CLIENTE,
       ITENS, DUPLICADOS, SEM_CUSTO,
       ROUND(RECEITA,6) AS RECEITA,
       ROUND(QUANTIDADE,6) AS QUANTIDADE,
       ROUND(CUSTO,6) AS CUSTO,
       ROUND(ICMS,6) AS ICMS,
       ROUND(PIS,6) AS PIS,
       ROUND(COFINS,6) AS COFINS,
       ROUND(COMISSAO,6) AS COMISSAO,
       ROUND(REFLEXO_COMISSAO,6) AS REFLEXO_COMISSAO,
       ROUND(FRETE,6) AS FRETE,
       DATA_CUSTO,
       ORIGEM_CUSTO, ITEM_PROMOCIONAL,
       ROUND(MARGEM,6) AS MARGEM
  FROM Q539_AGREGADO
 ORDER BY PEDIDO_ID,SKU
</snk:query>
</c:catch>
<c:catch var="haialaFalhaQ476IPI">
<snk:query var="haialaQ476IPI">
SELECT ROUND(SUM(NVL(CAB.VLRIPI,0)),2) AS IPI_CAB
FROM SANKHYA.TGFCAB CAB
WHERE CAB.CODEMP = 1
  AND CAB.DTNEG >= DATE '2026-01-01'
  AND CAB.DTNEG < TRUNC(SYSDATE)+1
  AND CAB.TIPMOV = 'P'
  AND CAB.CODTIPOPER IN (1000, 1001, 1005, 1007, 9000, 9001)
  AND CAB.STATUSNOTA IN ('A','P','L')
</snk:query>
</c:catch>
<!-- v23: tipo de negociação por pedido, uma linha por NUNOTA. -->
<c:catch var="haialaFalhaTipoNegociacaoV23">
<snk:query var="haialaTipoNegociacaoV23">
SELECT CAB.NUNOTA AS PEDIDO_ID,
       CAB.CODTIPVENDA AS CODTIPVENDA,
       NVL(TPV.DESCRTIPVENDA,'(SEM DESCRICAO)') AS DESCRTIPVENDA
FROM SANKHYA.TGFCAB CAB
LEFT JOIN SANKHYA.TGFTPV TPV ON TPV.CODTIPVENDA=CAB.CODTIPVENDA
WHERE CAB.CODEMP=1
  AND CAB.TIPMOV='P'
  AND CAB.CODTIPOPER IN (1000, 1001, 1005, 1007, 9000, 9001)
  AND CAB.STATUSNOTA IN ('A','P','L')
  AND CAB.DTNEG>=DATE '2026-01-01'
  AND CAB.DTNEG<TRUNC(SYSDATE)+1
</snk:query>
</c:catch>
<c:catch var="haialaFalhaNomesClientes">
<snk:query var="haialaNomesClientes">
SELECT PAR.CODPARC AS CODIGO,
       PAR.NOMEPARC AS NOME,
       NVL(CID.NOMECID,'(SEM CIDADE)') AS CIDADE,
       NVL(UFS.UF,'(SEM UF)') AS UF
FROM SANKHYA.TGFPAR PAR
LEFT JOIN SANKHYA.TSICID CID ON CID.CODCID = PAR.CODCID
LEFT JOIN SANKHYA.TSIUFS UFS ON UFS.CODUF = CID.UF
WHERE PAR.CODPARC IN (
  SELECT DISTINCT CAB.CODPARC
  FROM SANKHYA.TGFCAB CAB
  WHERE CAB.CODEMP = 1
    AND CAB.DTNEG >= DATE '2026-01-01'
    AND CAB.DTNEG < TRUNC(SYSDATE) + 1
    AND CAB.TIPMOV = 'P'
    AND CAB.CODTIPOPER IN (1000, 1001, 1005, 1007, 9000, 9001)
    AND CAB.STATUSNOTA IN ('A','P','L')
)
ORDER BY PAR.CODPARC
</snk:query>
</c:catch>

<c:catch var="haialaFalhaOpcoesTipologia">
<snk:query var="haialaOpcoesTipologia">
SELECT OPC.VALOR AS CODIGO,
       OPC.OPCAO AS DESCRICAO
FROM SANKHYA.TDDCAM CAM
JOIN SANKHYA.TDDOPC OPC ON OPC.NUCAMPO = CAM.NUCAMPO
WHERE CAM.NOMETAB = 'TGFPRO'
  AND CAM.NOMECAMPO = 'AD_TIPOLOGIA'
ORDER BY OPC.ORDEM, OPC.VALOR
</snk:query>
</c:catch>
<c:catch var="haialaFalhaNomesProdutos">
<snk:query var="haialaNomesProdutos">
SELECT PRO.CODPROD AS CODIGO, PRO.DESCRPROD AS NOME
FROM SANKHYA.TGFPRO PRO
WHERE PRO.CODPROD IN (
  SELECT DISTINCT ITE.CODPROD
  FROM SANKHYA.TGFITE ITE
  JOIN SANKHYA.TGFCAB CAB ON CAB.NUNOTA = ITE.NUNOTA
  WHERE CAB.CODEMP = 1
    AND CAB.DTNEG >= DATE '2026-01-01'
    AND CAB.DTNEG < TRUNC(SYSDATE) + 1
    AND CAB.TIPMOV = 'P'
    AND CAB.CODTIPOPER IN (1000, 1001, 1005, 1007, 9000, 9001)
    AND CAB.STATUSNOTA IN ('A','P','L')
)
ORDER BY PRO.CODPROD
</snk:query>
</c:catch>

<c:catch var="haialaFalhaRepGerV477">
<snk:query var="haialaRepGerV477">
SELECT V.CODVEND AS CODIGO, V.APELIDO AS NOME,
       NVL(V.CODGER,-1) AS GERENTE,
       NVL(G.APELIDO,'(SEM GERENCIA)') AS NOME_GERENTE
FROM SANKHYA.TGFVEN V
LEFT JOIN SANKHYA.TGFVEN G ON G.CODVEND = V.CODGER
WHERE V.CODVEND IN (
 SELECT DISTINCT CAB.CODVEND FROM SANKHYA.TGFCAB CAB
 WHERE CAB.CODEMP=1 AND CAB.DTNEG >= DATE '2026-01-01'
 AND CAB.DTNEG < TRUNC(SYSDATE)+1 AND CAB.TIPMOV='P'
 AND CAB.CODTIPOPER IN (1000, 1001, 1005, 1007, 9000, 9001) AND CAB.STATUSNOTA IN ('A','P','L')
)
ORDER BY V.CODVEND
</snk:query>
</c:catch>
<!-- v6.0.3: tipos R/V do cadastro exclusivos do bloco gerencial; ATIVO controla inclusao sem vendas. Nao altera V477. -->
<c:catch var="haialaFalhaRepAtivosV601">
<snk:query var="haialaRepAtivosV601">
SELECT V.CODVEND AS CODIGO, V.APELIDO AS NOME,
       NVL(V.CODGER,-1) AS GERENTE,
       NVL(G.APELIDO,'(SEM GERENCIA)') AS NOME_GERENTE,
       V.TIPVEND AS TIPO_VENDEDOR,
       V.ATIVO AS STATUS_ATIVO
  FROM SANKHYA.TGFVEN V
  LEFT JOIN SANKHYA.TGFVEN G ON G.CODVEND = V.CODGER
 WHERE UPPER(TRIM(V.TIPVEND)) IN ('R','V')
   AND (V.CODEMP = 1 OR V.CODEMP IS NULL)
 ORDER BY V.CODGER, V.CODVEND
</snk:query>
</c:catch>
<c:catch var="haialaFalhaUfsV477">
<snk:query var="haialaUfsV477">
SELECT DISTINCT PAR.CODPARC AS CLIENTE,
       NVL(UFS.UF, '(SEM UF)') AS SIGLA
FROM SANKHYA.TGFPAR PAR
LEFT JOIN SANKHYA.TSICID CID ON CID.CODCID=PAR.CODCID
LEFT JOIN SANKHYA.TSIUFS UFS ON UFS.CODUF=CID.UF
WHERE PAR.CODPARC IN (
 SELECT DISTINCT CAB.CODPARC FROM SANKHYA.TGFCAB CAB
 WHERE CAB.CODEMP=1 AND CAB.DTNEG>=DATE '2026-01-01'
 AND CAB.DTNEG<TRUNC(SYSDATE)+1 AND CAB.TIPMOV='P'
 AND CAB.CODTIPOPER IN (1000, 1001, 1005, 1007, 9000, 9001) AND CAB.STATUSNOTA IN ('A','P','L')
)
ORDER BY SIGLA, CLIENTE
</snk:query>
</c:catch>

<c:catch var="haialaFalhaCarteiraV478">
<snk:query var="haialaCarteiraV478">
SELECT PAR.CODPARC AS CLIENTE,
       NVL(PAR.CODVEND,-1) AS RESPONSAVEL_ATUAL,
       NVL(VEN.APELIDO,'(SEM RESPONSÁVEL)') AS APELIDO_ATUAL
FROM SANKHYA.TGFPAR PAR
LEFT JOIN SANKHYA.TGFVEN VEN ON VEN.CODVEND = PAR.CODVEND
WHERE PAR.CODPARC IN (
 SELECT DISTINCT CAB.CODPARC
 FROM SANKHYA.TGFCAB CAB
 WHERE CAB.CODEMP = 1
   AND CAB.DTNEG >= DATE '2026-01-01'
   AND CAB.DTNEG < TRUNC(SYSDATE) + 1
   AND CAB.TIPMOV = 'P'
   AND CAB.CODTIPOPER IN (1000, 1001, 1005, 1007, 9000, 9001)
   AND CAB.STATUSNOTA IN ('A','P','L')
)
ORDER BY PAR.CODPARC
</snk:query>
</c:catch>

<!-- v4.7.9: carteira comercial completa, inclusive parceiros sem compra no recorte. -->
<c:catch var="haialaFalhaCarteiraCompletaV479">
<snk:query var="haialaCarteiraCompletaV479">
SELECT PAR.CODPARC AS CLIENTE,
       PAR.NOMEPARC AS NOME,
       NVL(PAR.CODVEND, -1) AS RESPONSAVEL,
       CASE WHEN NVL(PAR.CODVEND,-1) = 4
                  OR NVL(REP_CARD.CODGER,-1) = 4
            THEN 'N' ELSE 'S' END AS CARD_CLIENTE_ELEGIVEL,
       NVL(PAR.CLIENTE, 'N') AS E_CLIENTE,
       NVL(PAR.ATIVO, 'N') AS ATIVO,
       NVL(PAR.BLOQUEAR, 'N') AS BLOQUEADO,
       CASE WHEN UPPER(TRIM(NVL(PAR.AD_STATUSSHOWROOM,'NAO'))) IN ('SIM','S') THEN 'S' ELSE 'N' END AS TEM_SHOWROOM,
       NVL(UFS.UF, '(SEM UF)') AS UF,
       NVL(TO_CHAR(H.ULTIMA_COMPRA,'YYYY-MM-DD'), '') AS ULTIMA_COMPRA,
       CASE WHEN H.ULTIMA_COMPRA IS NULL THEN 'S' ELSE 'N' END AS SEM_HISTORICO,
       CASE WHEN H.ULTIMA_COMPRA IS NOT NULL
                  AND H.ULTIMA_COMPRA < TRUNC(SYSDATE) - 90
            THEN 'S' ELSE 'N' END AS SEM_COMPRA_90D
FROM SANKHYA.TGFPAR PAR
LEFT JOIN (
 SELECT CAB.CODPARC, MAX(CAB.DTNEG) AS ULTIMA_COMPRA
 FROM SANKHYA.TGFCAB CAB
 WHERE CAB.CODEMP = 1 AND CAB.TIPMOV = 'P'
   AND CAB.CODTIPOPER IN (1000, 1001, 1005, 1007, 9000, 9001) AND CAB.STATUSNOTA IN ('A','P','L')
   AND CAB.DTNEG < TRUNC(SYSDATE) + 1
 GROUP BY CAB.CODPARC
) H ON H.CODPARC = PAR.CODPARC
LEFT JOIN SANKHYA.TGFVEN REP_CARD ON REP_CARD.CODVEND = PAR.CODVEND
LEFT JOIN SANKHYA.TSICID CID ON CID.CODCID = PAR.CODCID
LEFT JOIN SANKHYA.TSIUFS UFS ON UFS.CODUF = CID.UF
WHERE NVL(PAR.CLIENTE,'N') = 'S' OR H.CODPARC IS NOT NULL
ORDER BY PAR.CODPARC
</snk:query>
</c:catch>
<c:catch var="haialaFalhaQ483">
<snk:query var="haialaQ483">
SELECT TO_CHAR(CAB.DTNEG,'YYYY-MM') AS MES,
       CAB.CODPARC AS CLIENTE,
       NVL(CAB.CODVEND,-1) AS REPRESENTANTE,
       NVL(TRIM(PRO.AD_TIPOLOGIA),'(SEM TIPOLOGIA)') AS TIPOLOGIA,
       NVL(ITE.CODVOL,'(SEM UNIDADE)') AS UNIDADE,
       SUM(NVL(ITE.QTDNEG,0)) AS QUANTIDADE,
       SUM(NVL(ITE.VLRTOT,0)-NVL(ITE.VLRDESC,0)-NVL(ITE.VLRDESCRAT,0)) AS VALOR_COMERCIAL,
       COUNT(DISTINCT CAB.NUNOTA) AS PEDIDOS
FROM SANKHYA.TGFCAB CAB
JOIN SANKHYA.TGFITE ITE ON ITE.NUNOTA = CAB.NUNOTA
LEFT JOIN SANKHYA.TGFPRO PRO ON PRO.CODPROD = ITE.CODPROD
WHERE CAB.CODEMP = 1
  AND CAB.DTNEG >= DATE '2026-01-01'
  AND CAB.DTNEG < TRUNC(SYSDATE)+1
  AND CAB.TIPMOV = 'P'
  AND CAB.CODTIPOPER IN (1000, 1001, 1005, 1007, 9000, 9001)
  AND CAB.STATUSNOTA IN ('A','P','L')
GROUP BY TO_CHAR(CAB.DTNEG,'YYYY-MM'), CAB.CODPARC, NVL(CAB.CODVEND,-1),
         NVL(TRIM(PRO.AD_TIPOLOGIA),'(SEM TIPOLOGIA)'),NVL(ITE.CODVOL,'(SEM UNIDADE)')
ORDER BY MES, CLIENTE, TIPOLOGIA, UNIDADE
</snk:query>
</c:catch>

<!-- v5.3.3.1: Classificacao real SKU > grupo > ancestral por TGFGRU. -->
<c:catch var="haialaFalhaQ533">
<snk:query var="haialaQ533">
WITH ARVORE_FAMILIA AS (
    SELECT CONNECT_BY_ROOT G.CODGRUPOPROD AS RAIZ,
           G.CODGRUPOPROD
    FROM SANKHYA.TGFGRU G
    START WITH G.CODGRUPOPROD IN (40100000,40200000,40300000)
    CONNECT BY NOCYCLE PRIOR G.CODGRUPOPROD = G.CODGRUPAI
)
SELECT CAB.NUNOTA AS PEDIDO_ID,
       TO_CHAR(CAB.DTNEG,'YYYY-MM-DD') AS DIA,
       CAB.CODTIPOPER AS OPERACAO,
       NVL(CAB.CODVEND,-1) AS REPRESENTANTE,
       CAB.CODPARC AS CLIENTE,
       ITE.CODPROD AS SKU,
       CASE AF.RAIZ WHEN 40100000 THEN 'PRIMER'
                    WHEN 40200000 THEN 'APD'
                    WHEN 40300000 THEN 'ALUMINIO'
                    ELSE 'OUTRAS' END AS FAMILIA,
       NVL(TRIM(PRO.AD_TIPOLOGIA),'(SEM TIPOLOGIA)') AS TIPOLOGIA,
       SUM(CASE WHEN UPPER(TRIM(ITE.CODVOL))='PC'
                THEN NVL(ITE.QTDNEG,0) ELSE 0 END) AS QTD_PC,
       SUM(CASE WHEN UPPER(TRIM(ITE.CODVOL))<>'PC' OR ITE.CODVOL IS NULL
                THEN 1 ELSE 0 END) AS ITENS_OUTRA_UNIDADE,
       ROUND(SUM(CASE WHEN UPPER(TRIM(ITE.CODVOL))='PC' THEN NVL(ITE.VLRTOT,0)-NVL(ITE.VLRDESC,0)-NVL(ITE.VLRDESCRAT,0) ELSE 0 END),2) AS VENDAS_PC,
       ROUND(SUM(NVL(ITE.VLRTOT,0)-NVL(ITE.VLRDESC,0)-NVL(ITE.VLRDESCRAT,0)),2) AS VENDAS_ITEM
FROM SANKHYA.TGFCAB CAB
JOIN SANKHYA.TGFITE ITE ON ITE.NUNOTA=CAB.NUNOTA
LEFT JOIN SANKHYA.TGFPRO PRO ON PRO.CODPROD=ITE.CODPROD
LEFT JOIN ARVORE_FAMILIA AF ON AF.CODGRUPOPROD=PRO.CODGRUPOPROD
WHERE CAB.CODEMP=1
  AND CAB.DTNEG>=DATE '2026-01-01'
  AND CAB.DTNEG<TRUNC(SYSDATE)+1
  AND CAB.TIPMOV='P'
  AND CAB.CODTIPOPER IN (1000, 1001, 1005, 1007, 9000, 9001)
  AND CAB.STATUSNOTA IN ('A','P','L')
GROUP BY CAB.NUNOTA,TO_CHAR(CAB.DTNEG,'YYYY-MM-DD'),
         CAB.CODTIPOPER,NVL(CAB.CODVEND,-1),CAB.CODPARC,
         ITE.CODPROD,AF.RAIZ,
         NVL(TRIM(PRO.AD_TIPOLOGIA),'(SEM TIPOLOGIA)')
ORDER BY DIA,PEDIDO_ID,SKU
</snk:query>
</c:catch>


<!-- v5.3.3.14.6.4: devolucoes comerciais TOP 1200/1201/1209/9200 aprovadas; referencia da versao em TGFTOP. -->
<c:catch var="haialaFalhaQ535D">
<snk:query var="haialaQ535D">
SELECT C.NUNOTA AS DEV_ID,
       TO_CHAR(C.DTNEG, 'YYYY-MM-DD') AS DIA,
       C.CODTIPOPER AS OPERACAO,
       NVL(C.CODVEND,-1) AS REPRESENTANTE,
       C.CODPARC AS CLIENTE,
       NVL(P.CODVEND,-1) AS RESPONSAVEL_ATUAL,
       NVL(U.UF,'(SEM UF)') AS UF,
       ROUND(NVL(C.VLRNOTA,0)-NVL(C.VLRSUBST,0),2) AS DEVOLUCAO_RS
FROM SANKHYA.TGFCAB C
INNER JOIN SANKHYA.TGFTOP TOP ON TOP.CODTIPOPER=C.CODTIPOPER AND TOP.DHALTER=C.DHTIPOPER
LEFT JOIN SANKHYA.TGFPAR P ON P.CODPARC=C.CODPARC
LEFT JOIN SANKHYA.TSICID CID ON CID.CODCID=P.CODCID
LEFT JOIN SANKHYA.TSIUFS U ON U.CODUF=CID.UF
WHERE C.CODEMP=1
  AND C.TIPMOV='D'
  AND C.CODTIPOPER IN (1200,1201,1209,9200)
  AND C.STATUSNOTA IN ('A','P','L')
  AND C.DTNEG>=DATE '2026-01-01'
  AND C.DTNEG<TRUNC(SYSDATE)+1
ORDER BY DIA, DEV_ID
</snk:query>
</c:catch>

<!-- v5.3.3.9: prazo financeiro ponderado preliminar por valor de parcela. Consulta isolada, nao altera Q43/Q471. -->
<c:catch var="haialaFalhaQ534P">
<snk:query var="haialaQ534P">
WITH BASE_PEDIDOS AS (
 SELECT C.NUNOTA,C.DTNEG
 FROM SANKHYA.TGFCAB C
 WHERE C.CODEMP=1
   AND C.TIPMOV='P'
   AND C.CODTIPOPER IN (1000, 1001, 1005, 1007, 9000, 9001)
   AND C.STATUSNOTA IN ('A','P','L')
   AND C.DTNEG>=DATE '2026-01-01'
   AND C.DTNEG<TRUNC(SYSDATE)+1
), PRAZO AS (
 SELECT B.NUNOTA,
        COUNT(F.NUFIN) AS PARCELAS_VALIDAS,
        SUM(NVL(F.VLRDESDOB,0)) AS VALOR_PARCELAS,
        SUM((TRUNC(F.DTVENC)-TRUNC(B.DTNEG))*NVL(F.VLRDESDOB,0)) AS DIAS_X_VALOR
 FROM BASE_PEDIDOS B
 JOIN SANKHYA.TGFFIN F ON F.NUNOTA=B.NUNOTA
 WHERE F.RECDESP=1
   AND F.DTVENC IS NOT NULL
   AND NVL(F.VLRDESDOB,0)>0
 GROUP BY B.NUNOTA
)
SELECT NUNOTA, PARCELAS_VALIDAS, ROUND(VALOR_PARCELAS,2) AS VALOR_PARCELAS,
       DIAS_X_VALOR
FROM PRAZO
ORDER BY NUNOTA
</snk:query>
</c:catch>
<style>
/* v5.0: abas das paginas consolidadas */
.v5-tabs{display:flex;flex-wrap:wrap;gap:6px;margin:10px 0 0}
.v5-tab{border:1px solid #c9dbe7;background:#edf4f8;color:#274a63;border-radius:8px;padding:7px 11px;font-size:12px;font-weight:700;cursor:pointer}
.v5-tab-active{background:#21445e;color:#fff;border-color:#21445e}
.v5-tab:focus-visible{outline:3px solid #71a4c4;outline-offset:2px}
</style>
<style id="haialaV612InvoiceBlankStyle">
body.haiala-invoice-blank main.main > :not(#haialaInvoicePlaceholder){display:none !important}
body.haiala-invoice-blank main.main > #haialaInvoicePlaceholder{display:block !important;min-height:55vh;padding:30px 0}
#haialaInvoicePlaceholder[hidden]{display:none !important}
</style>
<style id="v511GlobalClean">
/* v5.1.1 - limpeza VISUAL global. Manter DOM e consultas para nao quebrar controladores. */
main.main > .notice,
main.main > section.haiala-diagnostics,
main.main > div.haiala-diagnostics,
main.main > .haiala-diagnostics,
main.main #cl03Origins,
main.main #cl04Origins { display:none !important; }
/* Nunca ocultar as mensagens de erro dentro dos cards e secoes funcionais. */
#v511Exception { display:none; margin:10px 0 12px; padding:10px 13px; background:#fff4dd; border:1px solid #e5c884; color:#6f4e17; border-radius:9px; font-size:12px; }
#v511Exception[data-visible="true"] {display:block;}
</style>
<style id="q533Styles">
/* v5.3.3.3 - tabela de Familia x Tipologia com altura automatica e colunas fluidas.
   Sem scroll interno; todas as tipologias e o total aparecem no fluxo da pagina. */
#q533FamilyPanel .q533-scroll{width:100%;max-width:none;max-height:none;overflow:visible;border:1px solid #e2e9ef;border-radius:8px;margin-bottom:12px}
#q533FamilyPanel .q533-unified{width:100%;min-width:0;table-layout:fixed;border-collapse:collapse;font-size:clamp(9px,.72vw,11px)}
#q533FamilyPanel .q533-unified col.q533-typecol{width:25%}
#q533FamilyPanel .q533-unified col.q533-qtycol{width:6%}
#q533FamilyPanel .q533-unified col.q533-valuecol{width:12.75%}
#q533FamilyPanel .q533-unified th,#q533FamilyPanel .q533-unified td{padding:8px 5px;border-bottom:1px solid #e4ebf2;min-width:0;vertical-align:middle;overflow-wrap:anywhere}
#q533FamilyPanel .q533-unified th{position:static;background:#edf2f7;color:#36526b;z-index:auto}
#q533FamilyPanel .q533-unified td:first-child,#q533FamilyPanel .q533-unified th:first-child{text-align:left;white-space:normal}
#q533FamilyPanel .q533-unified td:not(:first-child),#q533FamilyPanel .q533-unified th:not(:first-child){text-align:right;font-variant-numeric:tabular-nums;white-space:normal}
#q533FamilyPanel .q533-tophead th{text-align:center!important;border-bottom:1px solid #cad8e3}
#q533FamilyPanel .q533-tophead th:first-child{text-align:left!important}
#q533FamilyPanel .q533-subhead th{text-align:right!important}
/* v5.3.3.4 - guias entre familias no cabecalho duplo e em todas as linhas.
   Colunas reais: Tipologia | Primer QTE/VLR | APD QTE/VLR | Aluminio QTE/VLR | Total QTE/VLR. */
#q533FamilyPanel .q533-unified tbody tr > :nth-child(4),
#q533FamilyPanel .q533-unified tbody tr > :nth-child(6),
#q533FamilyPanel .q533-unified tbody tr > :nth-child(8),
#q533FamilyPanel .q533-unified thead .q533-subhead > :nth-child(3),
#q533FamilyPanel .q533-unified thead .q533-subhead > :nth-child(5),
#q533FamilyPanel .q533-unified thead .q533-subhead > :nth-child(7),
#q533FamilyPanel .q533-unified thead .q533-tophead > :nth-child(3),
#q533FamilyPanel .q533-unified thead .q533-tophead > :nth-child(4),
#q533FamilyPanel .q533-unified thead .q533-tophead > :nth-child(5){border-left:2px solid #9fb1c2;}
#q533FamilyPanel .q533-total{font-weight:700;background:#e8f1f7}
#q533FamilyPanel .q533-bold{font-weight:700}
#q533FamilyPanel .q533-note{font-size:12px;color:#56728b;margin:8px 0 14px;line-height:1.6}
#q533FamilyPanel .q533-unclassified{margin:12px 0;padding:11px 13px;border:1px solid #f1b6b6;background:#fff0f0;color:#b42318;font-weight:600;border-radius:7px}
#q533FamilyPanel .q533-alert{background:#fff4db;border:1px solid #e9ce8e;color:#825b21;padding:12px;border-radius:7px}
@media(max-width:900px){#q533FamilyPanel .q533-unified{font-size:9px}#q533FamilyPanel .q533-unified td,#q533FamilyPanel .q533-unified th{padding:6px 3px}}
</style>
<style id="acClientSecondRowStyles">
/* v5.3.3.14.6.10 - Clientes e ShowRoom unificados; Margem preservada */
.ac-client-second-row{display:grid;grid-template-columns:minmax(0,3fr) minmax(0,1fr);gap:10px;margin:10px 0 14px;align-items:stretch}
.ac-client-card{border:1px solid #d9e5ef;background:#fff;border-radius:11px;padding:11px 11px 10px;min-width:0;box-shadow:0 2px 7px rgba(20,52,77,.035);display:flex;flex-direction:column;gap:8px}
.ac-client-card h3{font-size:12px;line-height:1.3;color:#1d374e;margin:0;font-weight:700;min-height:31px}
.ac-client-metrics{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:5px;min-width:0}
.ac-client-metric{min-width:0;padding:7px 6px;background:#f5f8fb;border:1px solid #e1e9f1;border-radius:7px;display:flex;flex-direction:column;gap:4px}
.ac-client-metric span{font-size:10px;color:#637a91;line-height:1.25;min-height:26px;overflow-wrap:anywhere}
.ac-client-metric strong{font-size:18px;line-height:1.15;color:#203a51;font-variant-numeric:tabular-nums;overflow-wrap:anywhere;font-weight:750}
.ac-client-metric small{font-size:9px;color:#6a8196;line-height:1.25;overflow-wrap:anywhere}
.ac-client-note{font-size:9px;color:#658096;margin:0;line-height:1.3}
.ac-client-pending{color:#925b20}
.ac-client-card--margin .ac-client-metrics{grid-template-columns:repeat(2,minmax(0,1fr))}
/* primeira linha com mesma hierarquia tipografica, sem alterar a largura */
body .ac-summary-compact .kpi{padding:11px 10px;min-height:0}
body .ac-summary-compact .kpi span{font-size:10px;line-height:1.25}
body .ac-summary-compact .kpi strong{font-size:18px;line-height:1.15;margin:7px 0 4px;overflow-wrap:normal;word-break:normal}
body .ac-summary-compact .kpi small{font-size:9px;line-height:1.25}
@media(max-width:1350px){.ac-client-second-row{grid-template-columns:repeat(2,minmax(0,1fr))}.ac-client-card h3{min-height:0}}
@media(max-width:760px){.ac-client-second-row{grid-template-columns:1fr}}
@media(max-width:410px){.ac-client-metrics{grid-template-columns:repeat(3,minmax(0,1fr));gap:3px}.ac-client-metric{padding:6px 4px}.ac-client-metric strong{font-size:16px}}

.ac-client-card--combined .ac-client-metrics{grid-template-columns:repeat(5,minmax(0,1fr));gap:7px}
.ac-client-card--combined .ac-client-metric{min-height:77px}
.ac-client-card--combined .ac-client-metric span{min-height:26px}
.ac-client-card--combined h3,.ac-client-card--margin h3,.ac-client-card--freight h3{min-height:0}
@media(max-width:1350px){.ac-client-second-row{grid-template-columns:1fr}.ac-client-card--combined .ac-client-metrics{grid-template-columns:repeat(5,minmax(0,1fr))}}
@media(max-width:760px){.ac-client-card--combined .ac-client-metrics{grid-template-columns:repeat(3,minmax(0,1fr))}}
@media(max-width:480px){.ac-client-card--combined .ac-client-metrics{grid-template-columns:repeat(2,minmax(0,1fr))}}

.haiala-v615-diagnostic{margin-top:12px;padding:10px;border:1px solid #d5e3ed;border-radius:8px;background:#f7fafc;color:#243f59;font-size:11px}
.haiala-v615-diagnostic summary{cursor:pointer;font-weight:bold}.haiala-v615-diagnostic li{margin:3px 0}
.haiala-v615-diagnostic th,.haiala-v615-diagnostic td{text-align:right;padding:5px;border-bottom:1px solid #dfe9ef;white-space:nowrap}
.haiala-v615-diagnostic th:first-child,.haiala-v615-diagnostic td:first-child{text-align:left}

/* v6.1.11: TOP da composicao clicavel, totais e separadores nao clicaveis. */
.tax-compact tr.tax-top-click{cursor:pointer}
.tax-compact tr.tax-top-click:hover td{background:#dcecf7!important}
.tax-compact tr.tax-top-click:focus-visible{outline:2px solid #32749a;outline-offset:-2px}
.tax-group-info td{background:#e9f1f7;color:#1c415d;font-weight:750;padding:10px 9px!important;border-top:2px solid #bfd4e3;text-align:left!important}
.tax-info-row td{background:#fafcff}
/* v6.1.9: grupo PEDIDOS e totalizadores por grupo. */
.tax-group-total td{background:#f0f6fa;color:#173c57;font-weight:750;padding:9px 8px!important;border-top:1px solid #bfd4e3;border-bottom:2px solid #bfd4e3}
.tax-group-total td:not(:first-child){text-align:right;font-variant-numeric:tabular-nums}
/* v6.1.8 — agrupamentos informativos da composicao; KPIs preservados. */
/* v6.1.4: tabela de MC segregada por grupo na pagina Pedido */
.ac-client-card--margin .mc614-scroll{width:100%;overflow-x:auto}
.ac-client-card--margin .mc614-table{width:100%;border-collapse:collapse;font-size:11px;min-width:420px}
.ac-client-card--margin .mc614-table th,.ac-client-card--margin .mc614-table td{padding:8px 7px;border-bottom:1px solid #e1e9f1}
.ac-client-card--margin .mc614-table th{background:#f1f6fa;color:#36526b;text-align:right}
.ac-client-card--margin .mc614-table th:first-child,.ac-client-card--margin .mc614-table td:first-child{text-align:left}
.ac-client-card--margin .mc614-table td:not(:first-child){text-align:right;font-variant-numeric:tabular-nums;white-space:nowrap}
.ac-client-card--margin .mc614-total td{font-weight:700;background:#edf5fa}
.ac-client-card--margin{min-width:0}
.ac-client-card--margin .mc614-table{min-width:520px}
.ac-client-card--margin .mc614-note{font-size:10px;line-height:1.35}
.ac-client-card--combined .ac-client-note{max-width:92%}

/* v23: memória fluida, máximo dez SKUs por página, sem quebra no componente. */
.haiala-mc-memory-modal{width:min(calc(315px + var(--mc-visible-skus, 1) * 124px), 98vw);max-width:98vw;padding:12px 16px}
.haiala-mc-memory-modal .haiala-mc-scroll{max-height:none;overflow-y:visible;overflow-x:auto}
.haiala-mc-memory-modal .haiala-mc-scroll table{width:100%;min-width:0;table-layout:auto;font-size:11px}
.haiala-mc-memory-modal .haiala-mc-scroll th,.haiala-mc-memory-modal .haiala-mc-scroll td{font-size:11px;line-height:1.35;padding:4px 5px;white-space:nowrap;overflow-wrap:normal;word-break:normal}
.haiala-mc-memory-modal .haiala-mc-scroll th:first-child,.haiala-mc-memory-modal .haiala-mc-scroll td:first-child{min-width:198px;width:198px;text-align:left}
.haiala-mc-memory-modal .haiala-mc-scroll th:not(:first-child),.haiala-mc-memory-modal .haiala-mc-scroll td:not(:first-child){min-width:94px;text-align:right}
.haiala-mc-memory-modal .haiala-mc-scroll th:last-child,.haiala-mc-memory-modal .haiala-mc-scroll td:last-child{min-width:105px}
.haiala-mc-pages{display:flex;justify-content:flex-end;align-items:center;gap:8px;margin:5px 0;font-size:11px}
.haiala-mc-pages .btn{padding:4px 8px;font-size:11px}
@media(max-width:740px){.haiala-mc-memory-modal{width:98vw}.haiala-mc-memory-modal .haiala-mc-scroll table{min-width:max-content}}

/* v25: primeira coluna fixa na memoria, inclusive pedidos com muitos SKUs. */
.haiala-mc-memory-modal .haiala-mc-scroll th:first-child,
.haiala-mc-memory-modal .haiala-mc-scroll td:first-child{
 position:sticky;left:0;z-index:3;background:#fff;
 box-shadow:2px 0 4px rgba(35,70,98,.11)
}
.haiala-mc-memory-modal .haiala-mc-scroll th:first-child{z-index:5;background:#eaf2f8}
.haiala-mc-memory-modal .haiala-mc-scroll tbody tr:nth-child(even) td:first-child{background:#f7fafc}
/* v25: tres cards na segunda linha da visao executiva. */
/* v6.1.7: reduzir Clientes e ShowRoom e ampliar Margem de Contribuição. */
.ac-client-second-row{grid-template-columns:minmax(0,1.65fr) minmax(250px,.78fr) minmax(380px,1.35fr)}
.ac-client-card--freight .ac-client-metrics{grid-template-columns:1fr}
.ac-client-card--freight .ac-client-metric strong{font-size:17px}
@media(max-width:1450px){.ac-client-second-row{grid-template-columns:1fr 1fr}.ac-client-card--combined{grid-column:1/-1}}
@media(max-width:760px){.ac-client-second-row{grid-template-columns:1fr}.ac-client-card--combined{grid-column:auto}}
/* v25: cabecalhos do Bloco 04 em duas linhas e destaque de hover. */
body.ac535-detail #tablePanel table{table-layout:auto}
body.ac535-detail #tablePanel table thead th{white-space:normal;line-height:1.2;vertical-align:middle;max-width:104px;min-width:65px;padding:9px 6px;height:40px}
body.ac535-detail #tablePanel table thead th:first-child{min-width:90px}
body.ac535-detail #tablePanel table thead th:nth-child(4),body.ac535-detail #tablePanel table thead th:nth-child(5),body.ac535-detail #tablePanel table thead th:nth-child(6){min-width:104px}
body.ac535-detail #tablePanel table tbody tr:hover td{background:#dcebf7!important;color:#153e59}

/* v26: três cards executivos na mesma linha e dois blocos horizontais no Frete. */
@media(min-width:1200px){
 .ac-client-second-row{grid-template-columns:minmax(0,1.55fr) minmax(295px,.78fr) minmax(430px,1.45fr)!important}
 .ac-client-card--combined{grid-column:auto!important}
 .ac-client-card--freight .ac-client-metrics{grid-template-columns:repeat(2,minmax(0,1fr))!important}
 .ac-client-card--freight .ac-client-metric{min-width:0}
 .ac-client-card--freight .ac-client-metric strong{font-size:15px;overflow-wrap:anywhere}
}
@media(min-width:760px) and (max-width:1199px){
 .ac-client-card--freight .ac-client-metrics{grid-template-columns:repeat(2,minmax(0,1fr))}
}
/* v26: dimensões proporcionais ao número de SKUs; sem rolagem horizontal com até 8 SKUs quando couber na janela. */
.haiala-mc-memory-modal .haiala-mc-scroll table{min-width:0!important;width:100%;table-layout:fixed}
.haiala-mc-memory-modal .haiala-mc-scroll th:first-child,
.haiala-mc-memory-modal .haiala-mc-scroll td:first-child{min-width:0!important;width:220px!important;max-width:220px!important;white-space:nowrap}
.haiala-mc-memory-modal .haiala-mc-scroll th:not(:first-child),
.haiala-mc-memory-modal .haiala-mc-scroll td:not(:first-child){min-width:0!important;width:auto!important;white-space:nowrap}
.haiala-mc-memory-modal .haiala-mc-scroll th:last-child,
.haiala-mc-memory-modal .haiala-mc-scroll td:last-child{width:100px!important}
.haiala-mc-memory-modal.haiala-mc-many-skus .haiala-mc-scroll table{min-width:1200px!important;table-layout:auto}
.haiala-mc-memory-modal.haiala-mc-many-skus .haiala-mc-scroll th:not(:first-child),
.haiala-mc-memory-modal.haiala-mc-many-skus .haiala-mc-scroll td:not(:first-child){min-width:88px!important}
@media(max-width:760px){.haiala-mc-memory-modal .haiala-mc-scroll table{min-width:660px!important;table-layout:auto}}
/* v26: hover azul mais escuro e consistente em tabelas, incluindo a coluna fixa. */
table tbody tr:hover>td,
.tablewrap table tbody tr:hover>td,
.ac-order-table tbody tr:hover>td,
.haiala-mc-memory-modal .haiala-mc-scroll tbody tr:hover>td,
.haiala-mc-memory-modal .haiala-mc-scroll tbody tr:hover>td:first-child,
.cl02-wide-table table tbody tr:hover>td:first-child{background:#d4e7f5!important;color:#163d58!important}
body.ac535-detail #tablePanel table tbody tr:hover td{background:#d4e7f5!important}
.ac-header-break{display:block;white-space:nowrap}
body.ac535-detail #tablePanel table thead th:nth-child(10){min-width:94px;white-space:normal}

/* v6.0.9 - tarja de teste somente na navegação; não altera módulos internos. */
.haiala-test-label{display:inline-block;margin-left:6px;padding:2px 5px;border-radius:2px;background:#b42331;color:#fff;font-size:9px;line-height:1.15;font-weight:800;letter-spacing:.02em;vertical-align:middle;white-space:nowrap}
/* Carteira: esconder apenas as apresentações redundantes, sem desligar consultas comuns. */
body.haiala-v609-carteira #taxReferencePanel,
body.haiala-v609-carteira #q12Real,
body.haiala-v609-carteira #cl01Sec01,
body.haiala-v609-carteira #kpis,
body.haiala-v609-carteira #acClientSecondRow{display:none!important}
</style>
</head><body><div id="app"><aside class="sidebar"><div class="brand"><div><strong>HAIALA</strong><small>GESTÃO COMERCIAL</small></div></div><div class="modhead" id="haialaVersionHeader">VERSÃO 6.1.5</div><span class="haiala-load-meter" id="haialaLoadMeter" role="status" aria-live="polite" title="Tempo da carga inicial da página">Carga: medindo...</span><div id="navigation"></div></aside><main class="main"><div class="top"><div class="page-heading"><div class="eyebrow" id="crumb"></div><h1 class="title" id="pageTitle"></h1><p class="subtitle" id="pageDesc"></p><div class="v5-tabs" id="v5TabsHost" style="display:none"></div></div><div class="filter-dock"><div class="filter-dock-head"><strong>Filtros de análise</strong><span class="status" id="scopeLabel"></span></div><div class="box filters" id="filters"></div></div></div><div class="notice">HOMOLOGAÇÃO: seis páginas (AC-01 a AC-04, VD-01 e VD-03) apresentam dados Oracle quando conciliados. O recorte e a fonte são identificados nos resultados. Falhas podem ativar snapshot histórico, identificado. Páginas CL-01 a CL-04 utilizam dados Oracle quando as consultas forem válidas; outras páginas podem ser demonstrativas. Permissões ainda não homologadas.</div><section class="haiala-diagnostics" aria-label="Diagnóstico de dados"><strong>ORIGEM DOS INDICADORES: VER STATUS DA FONTE ATIVA</strong>O Oracle consulta 2026 até o dia atual e concilia com contagem independente. Se houver erro, o painel informa o uso do snapshot histórico jan-out/2026.<div class="haiala-oracle-test" role="status">
<c:choose>
<c:when test="${not empty haialaFalhaOracle}">
 <strong style="color:#9d3434">ORACLE: ERRO NA EXECUÇÃO DA CONSULTA.</strong>
 <span>Se a leitura diária falhar, o painel exibirá snapshot Q12 identificado.</span>
</c:when>
<c:otherwise>
 <c:forEach items="${haialaTesteOracle.rows}" var="haialaLinha">
 <strong style="color:#23623a">ORACLE: CONSULTA EXECUTADA.</strong>
 <span>Documentos da empresa 1 em 2026 até hoje: <c:out value="${haialaLinha.TOTAL}"/>. A fonte ativa dos indicadores é informada na faixa abaixo.</span>
 </c:forEach>
</c:otherwise>
</c:choose>
</div></section><div id="v511Exception" role="status" aria-live="polite"></div><details class="tax-compact" id="taxReferencePanel">
<summary><span class="tax-summary">Composição financeira e tributária <span class="tax-pill" id="taxSourcePill">Aguardando dados</span></span><small id="taxScope">Acompanhando os filtros comerciais disponíveis</small></summary>
<div class="tax-content" id="taxContent">
<p class="tax-notice">Calculando a composição para o período selecionado.</p>
</div></details><div id="haialaOriginV43" class="haiala-diagnostics">Verificando origem dos indicadores...</div><div id="haialaQ43Result" hidden
 data-reference-total="<c:forEach items="${haialaTesteOracle.rows}" var="res"><c:out value="${res.TOTAL}"/></c:forEach>"
 data-test-ok="<c:out value="${empty haialaFalhaQ43}"/>"
 data-error="<c:out value="${haialaFalhaQ43.message}"/>">
<c:if test="${empty haialaFalhaQ43}">
<c:forEach items="${haialaQ43.rows}" var="item">
<span class="haiala-q43-row"
 data-dia="<c:out value="${item.DIA}"/>"
 data-op="<c:out value="${item.OPERACAO}"/>"
 data-qtd="<c:out value="${item.PEDIDOS}"/>"
 data-vlc="<c:out value="${item.VLC}"/>"
 data-st="<c:out value="${item.ST}"/>"
 data-icms="<c:out value="${item.ICMS}"/>"
 data-desc="<c:out value="${item.DESCONTOS}"/>"></span>
</c:forEach></c:if>
</div><div id="haialaQ618InformativoResult" hidden
 data-ok="<c:out value="${empty haialaFalhaQ618Informativo}"/>"
 data-error="<c:out value="${haialaFalhaQ618Informativo.message}"/>">
<c:if test="${empty haialaFalhaQ618Informativo}">
<c:forEach items="${haialaQ618Informativo.rows}" var="item">
<span class="haiala-q618-informativo"
 data-dia="<c:out value="${item.DIA}"/>"
 data-group="<c:out value="${item.GRUPO}"/>"
 data-op="<c:out value="${item.OPERACAO}"/>"
 data-description="<c:out value="${item.DESCRICAO}"/>"
 data-rep="<c:out value="${item.REPRESENTANTE}"/>"
 data-client="<c:out value="${item.CLIENTE}"/>"
 data-qty="<c:out value="${item.DOCUMENTOS}"/>"
 data-vlc="<c:out value="${item.VLC}"/>"
 data-st="<c:out value="${item.ST}"/>"></span>
</c:forEach></c:if>
</div>
<div id="haialaQ6111DocsResult" hidden
 data-ok="<c:out value="${empty haialaFalhaQ6111DocsTOP}"/>"
 data-error="<c:out value="${haialaFalhaQ6111DocsTOP.message}"/>">
<c:if test="${empty haialaFalhaQ6111DocsTOP}">
<c:forEach items="${haialaQ6111DocsTOP.rows}" var="item">
<span class="haiala-q6111-doc"
 data-id="<c:out value="${item.PEDIDO_ID}"/>"
 data-day="<c:out value="${item.DIA}"/>"
 data-group="<c:out value="${item.GRUPO}"/>"
 data-op="<c:out value="${item.OPERACAO}"/>"
 data-rep="<c:out value="${item.REPRESENTANTE}"/>"
 data-client="<c:out value="${item.CLIENTE}"/>"
 data-status="<c:out value="${item.STATUSNOTA}"/>"
 data-vlc="<c:out value="${item.VLC}"/>"
 data-st="<c:out value="${item.ST}"/>"></span>
</c:forEach></c:if>
</div>
<div id="haialaQ616SemItensZero" hidden
 data-ok="<c:out value="${empty haialaFalhaQ616SemItensZero}"/>"
 data-error="<c:out value="${haialaFalhaQ616SemItensZero.message}"/>">
<c:if test="${empty haialaFalhaQ616SemItensZero}"><c:forEach items="${haialaQ616SemItensZero.rows}" var="item">
<span class="haiala-q616-zero" data-dia="<c:out value="${item.DIA}"/>"
 data-op="<c:out value="${item.OPERACAO}"/>"
 data-qtd="<c:out value="${item.QTD_SEM_ITENS_ZERO}"/>"></span>
</c:forEach></c:if>
</div>
<div id="haialaRepV45" class="haiala-diagnostics">Verificando filtro de representante...</div><div id="haialaQ45Result" hidden data-test-ok="<c:out value="${empty haialaFalhaQ45}"/>" data-error="<c:out value="${haialaFalhaQ45.message}"/>">
<c:if test="${empty haialaFalhaQ45}">
<c:forEach items="${haialaQ45.rows}" var="item">
<span class="haiala-q45-row"
 data-dia="<c:out value="${item.DIA}"/>"
 data-op="<c:out value="${item.OPERACAO}"/>"
 data-rep="<c:out value="${item.REPRESENTANTE}"/>"
 data-qtd="<c:out value="${item.PEDIDOS}"/>"
 data-vlc="<c:out value="${item.VLC}"/>"
 data-st="<c:out value="${item.ST}"/>"
 data-icms="<c:out value="${item.ICMS}"/>"
 data-desc="<c:out value="${item.DESCONTOS}"/>"></span>
</c:forEach></c:if>
</div><div id="haialaClientV46" class="haiala-diagnostics">Verificando dimensão cliente do pedido...</div>
<div id="haialaQ46Result" hidden data-test-ok="<c:out value="${empty haialaFalhaQ46}"/>"
 data-error="<c:out value="${haialaFalhaQ46.message}"/>">
<c:if test="${empty haialaFalhaQ46}">
<c:forEach items="${haialaQ46.rows}" var="item">
<span class="haiala-q46-row"
 data-dia="<c:out value="${item.DIA}"/>"
 data-op="<c:out value="${item.OPERACAO}"/>"
 data-rep="<c:out value="${item.REPRESENTANTE}"/>"
 data-client="<c:out value="${item.CLIENTE}"/>"
 data-qtd="<c:out value="${item.PEDIDOS}"/>"
 data-vlc="<c:out value="${item.VLC}"/>"
 data-st="<c:out value="${item.ST}"/>"
 data-icms="<c:out value="${item.ICMS}"/>"
 data-desc="<c:out value="${item.DESCONTOS}"/>"></span>
</c:forEach></c:if>
</div>
<div id="haialaQ539TResult" hidden
 data-ok-01="<c:out value="${empty haialaFalhaQ539T01}"/>"
 data-ok-02="<c:out value="${empty haialaFalhaQ539T02}"/>"
 data-ok-03="<c:out value="${empty haialaFalhaQ539T03}"/>"
 data-ok-04="<c:out value="${empty haialaFalhaQ539T04}"/>"
 data-ok-05="<c:out value="${empty haialaFalhaQ539T05}"/>"
 data-ok-06="<c:out value="${empty haialaFalhaQ539T06}"/>"
 data-ok-07="<c:out value="${empty haialaFalhaQ539T07}"/>"
 data-ok-08="<c:out value="${empty haialaFalhaQ539T08}"/>"
 data-ok-09="<c:out value="${empty haialaFalhaQ539T09}"/>"
 data-ok-10="<c:out value="${empty haialaFalhaQ539T10}"/>"
 data-ok-11="<c:out value="${empty haialaFalhaQ539T11}"/>"
 data-ok="<c:out value="${empty haialaFalhaQ539T01 and empty haialaFalhaQ539T02 and empty haialaFalhaQ539T03 and empty haialaFalhaQ539T04 and empty haialaFalhaQ539T05 and empty haialaFalhaQ539T06 and empty haialaFalhaQ539T07 and empty haialaFalhaQ539T08 and empty haialaFalhaQ539T09 and empty haialaFalhaQ539T10 and empty haialaFalhaQ539T11 }"/>"
 data-error="01:<c:out value="${haialaFalhaQ539T01.message}"/> 02:<c:out value="${haialaFalhaQ539T02.message}"/> 03:<c:out value="${haialaFalhaQ539T03.message}"/> 04:<c:out value="${haialaFalhaQ539T04.message}"/> 05:<c:out value="${haialaFalhaQ539T05.message}"/> 06:<c:out value="${haialaFalhaQ539T06.message}"/> 07:<c:out value="${haialaFalhaQ539T07.message}"/> 08:<c:out value="${haialaFalhaQ539T08.message}"/> 09:<c:out value="${haialaFalhaQ539T09.message}"/> 10:<c:out value="${haialaFalhaQ539T10.message}"/> 11:<c:out value="${haialaFalhaQ539T11.message}"/>">
<c:if test="${empty haialaFalhaQ539T01}"><c:forEach items="${haialaQ539T01.rows}" var="item">
<span class="haiala-q539t-row"
 data-id="<c:out value="${item.PEDIDO_ID}"/>"
 data-sku="<c:out value="${item.SKU}"/>"
 data-dia="<c:out value="${item.DIA}"/>"
 data-op="<c:out value="${item.OPERACAO}"/>"
 data-rep="<c:out value="${item.REPRESENTANTE}"/>"
 data-client="<c:out value="${item.CLIENTE}"/>"
 data-duplicados="<c:out value="${item.DUPLICADOS}"/>"
 data-sem-custo="<c:out value="${item.SEM_CUSTO}"/>"
 data-receita="<c:out value="${item.RECEITA}"/>"
 data-quantidade="<c:out value="${item.QUANTIDADE}"/>"
 data-custo="<c:out value="${item.CUSTO}"/>"
 data-icms="<c:out value="${item.ICMS}"/>"
 data-pis="<c:out value="${item.PIS}"/>"
 data-cofins="<c:out value="${item.COFINS}"/>"
 data-comissao="<c:out value="${item.COMISSAO}"/>"
 data-reflexo-comissao="<c:out value="${item.REFLEXO_COMISSAO}"/>"
 data-frete="<c:out value="${item.FRETE}"/>"
 data-data-custo="<c:out value="${item.DATA_CUSTO}"/>"
 data-origem-custo="<c:out value="${item.ORIGEM_CUSTO}"/>"
 data-item-promocional="<c:out value="${item.ITEM_PROMOCIONAL}"/>"
 data-margem="<c:out value="${item.MARGEM}"/>"></span>
</c:forEach></c:if>
<c:if test="${empty haialaFalhaQ539T02}"><c:forEach items="${haialaQ539T02.rows}" var="item">
<span class="haiala-q539t-row"
 data-id="<c:out value="${item.PEDIDO_ID}"/>"
 data-sku="<c:out value="${item.SKU}"/>"
 data-dia="<c:out value="${item.DIA}"/>"
 data-op="<c:out value="${item.OPERACAO}"/>"
 data-rep="<c:out value="${item.REPRESENTANTE}"/>"
 data-client="<c:out value="${item.CLIENTE}"/>"
 data-duplicados="<c:out value="${item.DUPLICADOS}"/>"
 data-sem-custo="<c:out value="${item.SEM_CUSTO}"/>"
 data-receita="<c:out value="${item.RECEITA}"/>"
 data-quantidade="<c:out value="${item.QUANTIDADE}"/>"
 data-custo="<c:out value="${item.CUSTO}"/>"
 data-icms="<c:out value="${item.ICMS}"/>"
 data-pis="<c:out value="${item.PIS}"/>"
 data-cofins="<c:out value="${item.COFINS}"/>"
 data-comissao="<c:out value="${item.COMISSAO}"/>"
 data-reflexo-comissao="<c:out value="${item.REFLEXO_COMISSAO}"/>"
 data-frete="<c:out value="${item.FRETE}"/>"
 data-data-custo="<c:out value="${item.DATA_CUSTO}"/>"
 data-origem-custo="<c:out value="${item.ORIGEM_CUSTO}"/>"
 data-item-promocional="<c:out value="${item.ITEM_PROMOCIONAL}"/>"
 data-margem="<c:out value="${item.MARGEM}"/>"></span>
</c:forEach></c:if>
<c:if test="${empty haialaFalhaQ539T03}"><c:forEach items="${haialaQ539T03.rows}" var="item">
<span class="haiala-q539t-row"
 data-id="<c:out value="${item.PEDIDO_ID}"/>"
 data-sku="<c:out value="${item.SKU}"/>"
 data-dia="<c:out value="${item.DIA}"/>"
 data-op="<c:out value="${item.OPERACAO}"/>"
 data-rep="<c:out value="${item.REPRESENTANTE}"/>"
 data-client="<c:out value="${item.CLIENTE}"/>"
 data-duplicados="<c:out value="${item.DUPLICADOS}"/>"
 data-sem-custo="<c:out value="${item.SEM_CUSTO}"/>"
 data-receita="<c:out value="${item.RECEITA}"/>"
 data-quantidade="<c:out value="${item.QUANTIDADE}"/>"
 data-custo="<c:out value="${item.CUSTO}"/>"
 data-icms="<c:out value="${item.ICMS}"/>"
 data-pis="<c:out value="${item.PIS}"/>"
 data-cofins="<c:out value="${item.COFINS}"/>"
 data-comissao="<c:out value="${item.COMISSAO}"/>"
 data-reflexo-comissao="<c:out value="${item.REFLEXO_COMISSAO}"/>"
 data-frete="<c:out value="${item.FRETE}"/>"
 data-data-custo="<c:out value="${item.DATA_CUSTO}"/>"
 data-origem-custo="<c:out value="${item.ORIGEM_CUSTO}"/>"
 data-item-promocional="<c:out value="${item.ITEM_PROMOCIONAL}"/>"
 data-margem="<c:out value="${item.MARGEM}"/>"></span>
</c:forEach></c:if>
<c:if test="${empty haialaFalhaQ539T04}"><c:forEach items="${haialaQ539T04.rows}" var="item">
<span class="haiala-q539t-row"
 data-id="<c:out value="${item.PEDIDO_ID}"/>"
 data-sku="<c:out value="${item.SKU}"/>"
 data-dia="<c:out value="${item.DIA}"/>"
 data-op="<c:out value="${item.OPERACAO}"/>"
 data-rep="<c:out value="${item.REPRESENTANTE}"/>"
 data-client="<c:out value="${item.CLIENTE}"/>"
 data-duplicados="<c:out value="${item.DUPLICADOS}"/>"
 data-sem-custo="<c:out value="${item.SEM_CUSTO}"/>"
 data-receita="<c:out value="${item.RECEITA}"/>"
 data-quantidade="<c:out value="${item.QUANTIDADE}"/>"
 data-custo="<c:out value="${item.CUSTO}"/>"
 data-icms="<c:out value="${item.ICMS}"/>"
 data-pis="<c:out value="${item.PIS}"/>"
 data-cofins="<c:out value="${item.COFINS}"/>"
 data-comissao="<c:out value="${item.COMISSAO}"/>"
 data-reflexo-comissao="<c:out value="${item.REFLEXO_COMISSAO}"/>"
 data-frete="<c:out value="${item.FRETE}"/>"
 data-data-custo="<c:out value="${item.DATA_CUSTO}"/>"
 data-origem-custo="<c:out value="${item.ORIGEM_CUSTO}"/>"
 data-item-promocional="<c:out value="${item.ITEM_PROMOCIONAL}"/>"
 data-margem="<c:out value="${item.MARGEM}"/>"></span>
</c:forEach></c:if>
<c:if test="${empty haialaFalhaQ539T05}"><c:forEach items="${haialaQ539T05.rows}" var="item">
<span class="haiala-q539t-row"
 data-id="<c:out value="${item.PEDIDO_ID}"/>"
 data-sku="<c:out value="${item.SKU}"/>"
 data-dia="<c:out value="${item.DIA}"/>"
 data-op="<c:out value="${item.OPERACAO}"/>"
 data-rep="<c:out value="${item.REPRESENTANTE}"/>"
 data-client="<c:out value="${item.CLIENTE}"/>"
 data-duplicados="<c:out value="${item.DUPLICADOS}"/>"
 data-sem-custo="<c:out value="${item.SEM_CUSTO}"/>"
 data-receita="<c:out value="${item.RECEITA}"/>"
 data-quantidade="<c:out value="${item.QUANTIDADE}"/>"
 data-custo="<c:out value="${item.CUSTO}"/>"
 data-icms="<c:out value="${item.ICMS}"/>"
 data-pis="<c:out value="${item.PIS}"/>"
 data-cofins="<c:out value="${item.COFINS}"/>"
 data-comissao="<c:out value="${item.COMISSAO}"/>"
 data-reflexo-comissao="<c:out value="${item.REFLEXO_COMISSAO}"/>"
 data-frete="<c:out value="${item.FRETE}"/>"
 data-data-custo="<c:out value="${item.DATA_CUSTO}"/>"
 data-origem-custo="<c:out value="${item.ORIGEM_CUSTO}"/>"
 data-item-promocional="<c:out value="${item.ITEM_PROMOCIONAL}"/>"
 data-margem="<c:out value="${item.MARGEM}"/>"></span>
</c:forEach></c:if>
<c:if test="${empty haialaFalhaQ539T06}"><c:forEach items="${haialaQ539T06.rows}" var="item">
<span class="haiala-q539t-row"
 data-id="<c:out value="${item.PEDIDO_ID}"/>"
 data-sku="<c:out value="${item.SKU}"/>"
 data-dia="<c:out value="${item.DIA}"/>"
 data-op="<c:out value="${item.OPERACAO}"/>"
 data-rep="<c:out value="${item.REPRESENTANTE}"/>"
 data-client="<c:out value="${item.CLIENTE}"/>"
 data-duplicados="<c:out value="${item.DUPLICADOS}"/>"
 data-sem-custo="<c:out value="${item.SEM_CUSTO}"/>"
 data-receita="<c:out value="${item.RECEITA}"/>"
 data-quantidade="<c:out value="${item.QUANTIDADE}"/>"
 data-custo="<c:out value="${item.CUSTO}"/>"
 data-icms="<c:out value="${item.ICMS}"/>"
 data-pis="<c:out value="${item.PIS}"/>"
 data-cofins="<c:out value="${item.COFINS}"/>"
 data-comissao="<c:out value="${item.COMISSAO}"/>"
 data-reflexo-comissao="<c:out value="${item.REFLEXO_COMISSAO}"/>"
 data-frete="<c:out value="${item.FRETE}"/>"
 data-data-custo="<c:out value="${item.DATA_CUSTO}"/>"
 data-origem-custo="<c:out value="${item.ORIGEM_CUSTO}"/>"
 data-item-promocional="<c:out value="${item.ITEM_PROMOCIONAL}"/>"
 data-margem="<c:out value="${item.MARGEM}"/>"></span>
</c:forEach></c:if>
<c:if test="${empty haialaFalhaQ539T07}"><c:forEach items="${haialaQ539T07.rows}" var="item">
<span class="haiala-q539t-row"
 data-id="<c:out value="${item.PEDIDO_ID}"/>"
 data-sku="<c:out value="${item.SKU}"/>"
 data-dia="<c:out value="${item.DIA}"/>"
 data-op="<c:out value="${item.OPERACAO}"/>"
 data-rep="<c:out value="${item.REPRESENTANTE}"/>"
 data-client="<c:out value="${item.CLIENTE}"/>"
 data-duplicados="<c:out value="${item.DUPLICADOS}"/>"
 data-sem-custo="<c:out value="${item.SEM_CUSTO}"/>"
 data-receita="<c:out value="${item.RECEITA}"/>"
 data-quantidade="<c:out value="${item.QUANTIDADE}"/>"
 data-custo="<c:out value="${item.CUSTO}"/>"
 data-icms="<c:out value="${item.ICMS}"/>"
 data-pis="<c:out value="${item.PIS}"/>"
 data-cofins="<c:out value="${item.COFINS}"/>"
 data-comissao="<c:out value="${item.COMISSAO}"/>"
 data-reflexo-comissao="<c:out value="${item.REFLEXO_COMISSAO}"/>"
 data-frete="<c:out value="${item.FRETE}"/>"
 data-data-custo="<c:out value="${item.DATA_CUSTO}"/>"
 data-origem-custo="<c:out value="${item.ORIGEM_CUSTO}"/>"
 data-item-promocional="<c:out value="${item.ITEM_PROMOCIONAL}"/>"
 data-margem="<c:out value="${item.MARGEM}"/>"></span>
</c:forEach></c:if>
<c:if test="${empty haialaFalhaQ539T08}"><c:forEach items="${haialaQ539T08.rows}" var="item">
<span class="haiala-q539t-row"
 data-id="<c:out value="${item.PEDIDO_ID}"/>"
 data-sku="<c:out value="${item.SKU}"/>"
 data-dia="<c:out value="${item.DIA}"/>"
 data-op="<c:out value="${item.OPERACAO}"/>"
 data-rep="<c:out value="${item.REPRESENTANTE}"/>"
 data-client="<c:out value="${item.CLIENTE}"/>"
 data-duplicados="<c:out value="${item.DUPLICADOS}"/>"
 data-sem-custo="<c:out value="${item.SEM_CUSTO}"/>"
 data-receita="<c:out value="${item.RECEITA}"/>"
 data-quantidade="<c:out value="${item.QUANTIDADE}"/>"
 data-custo="<c:out value="${item.CUSTO}"/>"
 data-icms="<c:out value="${item.ICMS}"/>"
 data-pis="<c:out value="${item.PIS}"/>"
 data-cofins="<c:out value="${item.COFINS}"/>"
 data-comissao="<c:out value="${item.COMISSAO}"/>"
 data-reflexo-comissao="<c:out value="${item.REFLEXO_COMISSAO}"/>"
 data-frete="<c:out value="${item.FRETE}"/>"
 data-data-custo="<c:out value="${item.DATA_CUSTO}"/>"
 data-origem-custo="<c:out value="${item.ORIGEM_CUSTO}"/>"
 data-item-promocional="<c:out value="${item.ITEM_PROMOCIONAL}"/>"
 data-margem="<c:out value="${item.MARGEM}"/>"></span>
</c:forEach></c:if>
<c:if test="${empty haialaFalhaQ539T09}"><c:forEach items="${haialaQ539T09.rows}" var="item">
<span class="haiala-q539t-row"
 data-id="<c:out value="${item.PEDIDO_ID}"/>"
 data-sku="<c:out value="${item.SKU}"/>"
 data-dia="<c:out value="${item.DIA}"/>"
 data-op="<c:out value="${item.OPERACAO}"/>"
 data-rep="<c:out value="${item.REPRESENTANTE}"/>"
 data-client="<c:out value="${item.CLIENTE}"/>"
 data-duplicados="<c:out value="${item.DUPLICADOS}"/>"
 data-sem-custo="<c:out value="${item.SEM_CUSTO}"/>"
 data-receita="<c:out value="${item.RECEITA}"/>"
 data-quantidade="<c:out value="${item.QUANTIDADE}"/>"
 data-custo="<c:out value="${item.CUSTO}"/>"
 data-icms="<c:out value="${item.ICMS}"/>"
 data-pis="<c:out value="${item.PIS}"/>"
 data-cofins="<c:out value="${item.COFINS}"/>"
 data-comissao="<c:out value="${item.COMISSAO}"/>"
 data-reflexo-comissao="<c:out value="${item.REFLEXO_COMISSAO}"/>"
 data-frete="<c:out value="${item.FRETE}"/>"
 data-data-custo="<c:out value="${item.DATA_CUSTO}"/>"
 data-origem-custo="<c:out value="${item.ORIGEM_CUSTO}"/>"
 data-item-promocional="<c:out value="${item.ITEM_PROMOCIONAL}"/>"
 data-margem="<c:out value="${item.MARGEM}"/>"></span>
</c:forEach></c:if>
<c:if test="${empty haialaFalhaQ539T10}"><c:forEach items="${haialaQ539T10.rows}" var="item">
<span class="haiala-q539t-row"
 data-id="<c:out value="${item.PEDIDO_ID}"/>"
 data-sku="<c:out value="${item.SKU}"/>"
 data-dia="<c:out value="${item.DIA}"/>"
 data-op="<c:out value="${item.OPERACAO}"/>"
 data-rep="<c:out value="${item.REPRESENTANTE}"/>"
 data-client="<c:out value="${item.CLIENTE}"/>"
 data-duplicados="<c:out value="${item.DUPLICADOS}"/>"
 data-sem-custo="<c:out value="${item.SEM_CUSTO}"/>"
 data-receita="<c:out value="${item.RECEITA}"/>"
 data-quantidade="<c:out value="${item.QUANTIDADE}"/>"
 data-custo="<c:out value="${item.CUSTO}"/>"
 data-icms="<c:out value="${item.ICMS}"/>"
 data-pis="<c:out value="${item.PIS}"/>"
 data-cofins="<c:out value="${item.COFINS}"/>"
 data-comissao="<c:out value="${item.COMISSAO}"/>"
 data-reflexo-comissao="<c:out value="${item.REFLEXO_COMISSAO}"/>"
 data-frete="<c:out value="${item.FRETE}"/>"
 data-data-custo="<c:out value="${item.DATA_CUSTO}"/>"
 data-origem-custo="<c:out value="${item.ORIGEM_CUSTO}"/>"
 data-item-promocional="<c:out value="${item.ITEM_PROMOCIONAL}"/>"
 data-margem="<c:out value="${item.MARGEM}"/>"></span>
</c:forEach></c:if>
<c:if test="${empty haialaFalhaQ539T11}"><c:forEach items="${haialaQ539T11.rows}" var="item">
<span class="haiala-q539t-row"
 data-id="<c:out value="${item.PEDIDO_ID}"/>"
 data-sku="<c:out value="${item.SKU}"/>"
 data-dia="<c:out value="${item.DIA}"/>"
 data-op="<c:out value="${item.OPERACAO}"/>"
 data-rep="<c:out value="${item.REPRESENTANTE}"/>"
 data-client="<c:out value="${item.CLIENTE}"/>"
 data-duplicados="<c:out value="${item.DUPLICADOS}"/>"
 data-sem-custo="<c:out value="${item.SEM_CUSTO}"/>"
 data-receita="<c:out value="${item.RECEITA}"/>"
 data-quantidade="<c:out value="${item.QUANTIDADE}"/>"
 data-custo="<c:out value="${item.CUSTO}"/>"
 data-icms="<c:out value="${item.ICMS}"/>"
 data-pis="<c:out value="${item.PIS}"/>"
 data-cofins="<c:out value="${item.COFINS}"/>"
 data-comissao="<c:out value="${item.COMISSAO}"/>"
 data-reflexo-comissao="<c:out value="${item.REFLEXO_COMISSAO}"/>"
 data-frete="<c:out value="${item.FRETE}"/>"
 data-data-custo="<c:out value="${item.DATA_CUSTO}"/>"
 data-origem-custo="<c:out value="${item.ORIGEM_CUSTO}"/>"
 data-item-promocional="<c:out value="${item.ITEM_PROMOCIONAL}"/>"
 data-margem="<c:out value="${item.MARGEM}"/>"></span>
</c:forEach></c:if>
</div>
<div id="haialaQ471Result" hidden data-test-ok="<c:out value="${empty haialaFalhaQ471}"/>"
 data-error="<c:out value="${haialaFalhaQ471.message}"/>">
<c:if test="${empty haialaFalhaQ471}">
<c:forEach items="${haialaQ471.rows}" var="item">
<span class="haiala-q471-row"
 data-nunota="<c:out value="${item.PEDIDO_ID}"/>"
 data-dia="<c:out value="${item.DIA}"/>"
 data-op="<c:out value="${item.OPERACAO}"/>"
 data-rep="<c:out value="${item.REPRESENTANTE}"/>"
 data-client="<c:out value="${item.CLIENTE}"/>"
 data-sku="<c:out value="${item.SKU}"/>"
 data-tipologia="<c:out value="${item.TIPOLOGIA}"/>"
 data-vendas="<c:out value="${item.VENDAS_SKU}"/>"
 data-desconto="<c:out value="${item.DESCONTO_SKU}"/>"
 data-icms="<c:out value="${item.ICMS_SKU}"/>"
 data-st="<c:out value="${item.ST_SKU}"/>"
 data-ipi="<c:out value="${item.IPI_SKU}"/>"></span>
</c:forEach></c:if>
</div>


<div id="haialaQ533Result" hidden
 data-ok="<c:out value="${empty haialaFalhaQ533}"/>"
 data-error="<c:out value="${haialaFalhaQ533.message}"/>">
<c:if test="${empty haialaFalhaQ533}"><c:forEach items="${haialaQ533.rows}" var="item">
<span class="haiala-q533-row"
 data-nunota="<c:out value="${item.PEDIDO_ID}"/>"
 data-dia="<c:out value="${item.DIA}"/>"
 data-op="<c:out value="${item.OPERACAO}"/>"
 data-rep="<c:out value="${item.REPRESENTANTE}"/>"
 data-client="<c:out value="${item.CLIENTE}"/>"
 data-sku="<c:out value="${item.SKU}"/>"
 data-family="<c:out value="${item.FAMILIA}"/>"
 data-type="<c:out value="${item.TIPOLOGIA}"/>"
 data-qty="<c:out value="${item.QTD_PC}"/>"
 data-other="<c:out value="${item.ITENS_OUTRA_UNIDADE}"/>"
 data-sales-pc="<c:out value="${item.VENDAS_PC}"/>" data-sales="<c:out value="${item.VENDAS_ITEM}"/>"></span>
</c:forEach></c:if></div>
<div id="haialaQ535Returns" hidden data-ok="<c:out value="${empty haialaFalhaQ535D}"/>" data-error="<c:out value="${haialaFalhaQ535D.message}"/>">
<c:if test="${empty haialaFalhaQ535D}"><c:forEach items="${haialaQ535D.rows}" var="item">
<span class="haiala-q535-return" data-id="<c:out value="${item.DEV_ID}"/>" data-day="<c:out value="${item.DIA}"/>" data-op="<c:out value="${item.OPERACAO}"/>" data-rep="<c:out value="${item.REPRESENTANTE}"/>" data-client="<c:out value="${item.CLIENTE}"/>" data-owner="<c:out value="${item.RESPONSAVEL_ATUAL}"/>" data-uf="<c:out value="${item.UF}"/>" data-value="<c:out value="${item.DEVOLUCAO_RS}"/>"></span>
</c:forEach></c:if></div>
<div id="haialaQ534PrazoResult" hidden data-ok="<c:out value="${empty haialaFalhaQ534P}"/>" data-error="<c:out value="${haialaFalhaQ534P.message}"/>">
<c:if test="${empty haialaFalhaQ534P}"><c:forEach items="${haialaQ534P.rows}" var="item">
<span class="haiala-q534-prazo" data-id="<c:out value="${item.NUNOTA}"/>" data-parcelas="<c:out value="${item.PARCELAS_VALIDAS}"/>" data-valor="<c:out value="${item.VALOR_PARCELAS}"/>" data-diasvalor="<c:out value="${item.DIAS_X_VALOR}"/>"></span>
</c:forEach></c:if></div>


<div id="haialaTipoNegociacaoV23" hidden
 data-ok="<c:out value="${empty haialaFalhaTipoNegociacaoV23}"/>"
 data-error="<c:out value="${haialaFalhaTipoNegociacaoV23.message}"/>">
<c:if test="${empty haialaFalhaTipoNegociacaoV23}"><c:forEach items="${haialaTipoNegociacaoV23.rows}" var="item">
<span class="haiala-tipo-negociacao-v23"
 data-id="<c:out value="${item.PEDIDO_ID}"/>"
 data-code="<c:out value="${item.CODTIPVENDA}"/>"
 data-desc="<c:out value="${item.DESCRTIPVENDA}"/>"></span>
</c:forEach></c:if></div>
<div id="haialaQ483Result" hidden data-test-ok="<c:out value="${empty haialaFalhaQ483}"/>" data-error="<c:out value="${haialaFalhaQ483.message}"/>">
<c:if test="${empty haialaFalhaQ483}"><c:forEach items="${haialaQ483.rows}" var="item">
<span class="haiala-q483-row" data-mes="<c:out value="${item.MES}"/>"
 data-client="<c:out value="${item.CLIENTE}"/>"
 data-rep="<c:out value="${item.REPRESENTANTE}"/>"
 data-tipologia="<c:out value="${item.TIPOLOGIA}"/>"
 data-unidade="<c:out value="${item.UNIDADE}"/>"
 data-quantidade="<c:out value="${item.QUANTIDADE}"/>"
 data-valor="<c:out value="${item.VALOR_COMERCIAL}"/>"
 data-pedidos="<c:out value="${item.PEDIDOS}"/>"></span>
</c:forEach></c:if></div>
<div id="haialaQ476IPIResult" hidden
 data-test-ok="<c:out value="${empty haialaFalhaQ476IPI}"/>"
 data-ipi="<c:forEach items="${haialaQ476IPI.rows}" var="item"><c:out value="${item.IPI_CAB}"/></c:forEach>"></div>
<div id="haialaNomesCadastros" hidden
 data-clientes-ok="<c:out value="${empty haialaFalhaNomesClientes}"/>"
 data-produtos-ok="<c:out value="${empty haialaFalhaNomesProdutos}"/>"
 data-tipologia-ok="<c:out value="${empty haialaFalhaOpcoesTipologia}"/>">
<c:if test="${empty haialaFalhaNomesClientes}">
<c:forEach items="${haialaNomesClientes.rows}" var="item">
<span class="haiala-nome-cliente"
 data-code="<c:out value="${item.CODIGO}"/>"
 data-name="<c:out value="${item.NOME}"/>"
 data-city="<c:out value="${item.CIDADE}"/>"
 data-uf="<c:out value="${item.UF}"/>"></span>
</c:forEach></c:if>
<c:if test="${empty haialaFalhaNomesProdutos}">
<c:forEach items="${haialaNomesProdutos.rows}" var="item">
<span class="haiala-nome-produto"
 data-code="<c:out value="${item.CODIGO}"/>"
 data-name="<c:out value="${item.NOME}"/>"></span>
</c:forEach></c:if>
<c:if test="${empty haialaFalhaOpcoesTipologia}">
<c:forEach items="${haialaOpcoesTipologia.rows}" var="item">
<span class="haiala-opcao-tipologia"
 data-code="<c:out value="${item.CODIGO}"/>"
 data-description="<c:out value="${item.DESCRICAO}"/>"></span>
</c:forEach></c:if>
</div>

<div id="haialaV477Metadata" hidden
 data-reps-ok="<c:out value="${empty haialaFalhaRepGerV477}"/>"
 data-ufs-ok="<c:out value="${empty haialaFalhaUfsV477}"/>">
<c:if test="${empty haialaFalhaRepGerV477}"><c:forEach items="${haialaRepGerV477.rows}" var="item">
<span class="haiala-v477-rep"
 data-id="<c:out value="${item.CODIGO}"/>"
 data-name="<c:out value="${item.NOME}"/>"
 data-ger="<c:out value="${item.GERENTE}"/>"
 data-ger-name="<c:out value="${item.NOME_GERENTE}"/>"></span>
</c:forEach></c:if>
<c:if test="${empty haialaFalhaUfsV477}"><c:forEach items="${haialaUfsV477.rows}" var="item">
<span class="haiala-v477-uf"
 data-id="<c:out value="${item.CLIENTE}"/>"
 data-uf="<c:out value="${item.SIGLA}"/>"></span>
</c:forEach></c:if>
</div>
<div id="haialaV601RepAtivosMetadata" hidden
 data-ok="<c:out value="${empty haialaFalhaRepAtivosV601}"/>"
 data-error="<c:out value="${haialaFalhaRepAtivosV601.message}"/>">
<c:if test="${empty haialaFalhaRepAtivosV601}"><c:forEach items="${haialaRepAtivosV601.rows}" var="item">
<span class="haiala-v601-active-rep"
 data-id="<c:out value="${item.CODIGO}"/>"
 data-name="<c:out value="${item.NOME}"/>"
 data-ger="<c:out value="${item.GERENTE}"/>"
 data-ger-name="<c:out value="${item.NOME_GERENTE}"/>"
 data-type="<c:out value="${item.TIPO_VENDEDOR}"/>"
 data-active="<c:out value="${item.STATUS_ATIVO}"/>"></span>
</c:forEach></c:if>
</div>
<div id="haialaCarteiraV478Metadata" hidden
 data-ok="<c:out value="${empty haialaFalhaCarteiraV478}"/>"
 data-error="<c:out value="${haialaFalhaCarteiraV478.message}"/>">
<c:if test="${empty haialaFalhaCarteiraV478}"><c:forEach items="${haialaCarteiraV478.rows}" var="item">
<span class="haiala-carteira-v478"
 data-client="<c:out value="${item.CLIENTE}"/>"
 data-owner="<c:out value="${item.RESPONSAVEL_ATUAL}"/>"
 data-owner-name="<c:out value="${item.APELIDO_ATUAL}"/>"></span>
</c:forEach></c:if>
</div>
<div id="haialaCarteiraCompletaV479" hidden
 data-ok="<c:out value="${empty haialaFalhaCarteiraCompletaV479}"/>"
 data-error="<c:out value="${haialaFalhaCarteiraCompletaV479.message}"/>">
<c:if test="${empty haialaFalhaCarteiraCompletaV479}"><c:forEach items="${haialaCarteiraCompletaV479.rows}" var="item">
<span class="haiala-cadastro-v479"
 data-client="<c:out value="${item.CLIENTE}"/>"
 data-name="<c:out value="${item.NOME}"/>"
 data-owner="<c:out value="${item.RESPONSAVEL}"/>"
 data-card-eligible="<c:out value="${item.CARD_CLIENTE_ELEGIVEL}"/>"
 data-uf="<c:out value="${item.UF}"/>"
 data-is-client="<c:out value="${item.E_CLIENTE}"/>"
 data-active="<c:out value="${item.ATIVO}"/>"
 data-block="<c:out value="${item.BLOQUEADO}"/>"
 data-showroom="<c:out value="${item.TEM_SHOWROOM}"/>"
 data-last="<c:out value="${item.ULTIMA_COMPRA}"/>"
 data-never="<c:out value="${item.SEM_HISTORICO}"/>"
 data-inactive90="<c:out value="${item.SEM_COMPRA_90D}"/>"></span>
</c:forEach></c:if>
</div>
<div id="haialaCarteiraCompletaNotice" class="haiala-diagnostics" role="status">Verificando cadastro comercial completo...</div>
<div id="haialaCarteiraNotice" class="haiala-diagnostics" role="status">Verificando carteira atual...</div>
<div id="haialaV477Notice" class="haiala-diagnostics" role="status">Verificando gerência e UF no Oracle...</div>
<div id="haialaSkuNotice" class="haiala-diagnostics" role="status">Verificando dados de SKU...</div>
<section class="box" id="haialaCarteiraCompletaPanel" style="display:none;margin-top:16px"></section><div id="q12Real" aria-label="Dados comerciais por período"></div><div class="section" id="cl01Sec01"><h2>01 - Visão executiva</h2><small id="kpiHint"></small></div><div class="kpis" id="kpis"></div><div id="acClientSecondRow" class="ac-client-second-row" style="display:none" aria-label="Indicadores de clientes e ShowRoom"></div><section id="haialaV6GerRep" class="v6-gerrep" style="display:none" aria-label="Desempenho por gerente e representante"></section><div class="section" id="cl01Sec02"><h2>02 - Inteligência comercial</h2><small>Visualização por página</small></div><div class="analytics"><section class="box" id="primaryPanel"></section><section class="box" id="secondaryPanel"></section></div><div class="section" id="cl01Sec03"><h2>03 - Regras e cenários funcionais</h2><small>Calculados a partir da amostra sintética</small></div><section class="box" id="rulesPanel"></section><div class="section" id="q533FamilyTitle" style="display:none"><h2>03 - Vendas por Família x Tipologia</h2><small id="q533FamilyStatus">Fonte: Oracle | Empresa 1</small></div><section class="box" id="q533FamilyPanel" style="display:none" aria-label="Vendas por família e tipologia"></section><div class="section" id="cl01Sec04"><h2>04 - Análise detalhada</h2><div class="actions"><button class="btn" id="exportBtn">Exportar CSV</button><button class="btn" id="testBtn">Executar autotestes</button></div></div><section class="box" id="cl01DetailContainer"><div class="chips" id="activeFilters"></div><div class="tablewrap" id="tablePanel"></div><p class="note" id="tableHelp"></p></section><div class="footer" id="haialaVersionFooter">HAIALA - V6.1.11 | 5 menus | Fonte e período identificados nos indicadores; limitações sinalizadas quando aplicáveis.</div></main></div><div id="modalHost"></div><script>
/* Versao centralizada para cabecalho e rodape. Sem alterar os indicadores. */
const HAIALA_VERSION = '6.1.11';
document.getElementById('haialaVersionHeader').textContent = 'Versão ' + HAIALA_VERSION;
document.getElementById('haialaVersionFooter').textContent = document.getElementById('haialaVersionFooter').textContent.replace(/V\d+\.\d+\.\d+(?:\.\d+)?/, 'V' + HAIALA_VERSION);
const SNAPSHOT_Q12 = [["2026-01-02",1001,1,5617.8,0.0,1067.38,991.35],["2026-01-06",1000,1,1542.47,198.55,185.1,200.43],["2026-01-06",1001,3,27152.27,1231.29,4489.38,4343.38],["2026-01-07",1000,4,14918.45,44.58,2810.25,2215.6],["2026-01-07",1001,9,87841.74,4192.03,14635.04,10807.64],["2026-01-08",1000,2,2182.1,0.0,414.6,120.31],["2026-01-08",1001,19,208379.75,7592.82,30577.03,28398.66],["2026-01-09",1000,10,60860.38,3710.85,9813.42,11475.23],["2026-01-09",1001,19,223537.66,5683.67,32561.34,26764.08],["2026-01-10",1001,4,83496.72,0.0,10667.0,12707.38],["2026-01-12",1000,2,15080.45,194.32,2759.62,2641.31],["2026-01-12",1001,3,23647.58,1762.94,3584.91,3913.97],["2026-01-13",1000,3,7845.21,372.75,1317.12,1179.11],["2026-01-13",1001,13,89037.94,0.0,15527.13,9745.06],["2026-01-14",1000,4,24332.63,0.0,4623.2,3947.11],["2026-01-14",1001,10,158548.25,1034.78,27072.56,18271.18],["2026-01-15",1000,5,10596.25,0.0,1894.31,1833.3],["2026-01-15",1001,8,89261.9,0.0,16232.65,11282.67],["2026-01-16",1000,7,36246.16,2934.3,5291.14,1329.97],["2026-01-16",1001,5,39826.23,1756.85,6611.63,5629.33],["2026-01-19",1000,3,95683.4,0.0,13363.18,13524.28],["2026-01-19",1001,7,85384.27,3450.1,14346.89,7249.7],["2026-01-20",1000,2,6214.89,0.0,745.79,309.76],["2026-01-20",1001,8,54773.59,344.03,9669.55,4637.41],["2026-01-21",1000,6,19424.35,0.0,3216.28,3091.48],["2026-01-21",1001,25,283853.78,1350.64,47231.89,42092.16],["2026-01-22",1000,3,8014.5,0.0,1522.76,1076.28],["2026-01-22",1001,15,184258.41,5406.13,31085.24,24582.49],["2026-01-23",1000,2,9004.58,0.0,1568.0,1162.58],["2026-01-23",1001,14,271078.84,11491.66,40775.6,39730.35],["2026-01-24",1001,1,4482.0,0.0,851.58,791.0],["2026-01-26",1000,2,14614.32,0.0,2776.72,2579.08],["2026-01-26",1001,20,231663.11,829.25,39745.87,31184.6],["2026-01-27",1000,2,23400.25,0.0,4446.05,4129.65],["2026-01-27",1001,17,158661.51,8588.46,23438.48,22643.79],["2026-01-28",1000,9,25590.95,1502.48,4024.33,8519.78],["2026-01-28",1001,17,170575.37,1520.4,30285.11,21825.7],["2026-01-29",1000,4,7959.92,0.0,1512.38,1260.05],["2026-01-29",1001,30,361201.52,2180.6,59645.5,43958.63],["2026-01-30",1000,3,15688.2,0.0,2980.75,1584.32],["2026-01-30",1001,41,644768.74,3356.05,111418.05,90406.25],["2026-01-31",1000,2,2520.75,0.0,478.94,381.49],["2026-01-31",1001,13,215130.39,0.0,33640.99,22691.58],["2026-02-01",1000,1,22794.6,2934.3,2735.34,0.0],["2026-02-01",1001,2,28985.23,2489.43,3478.22,4174.97],["2026-02-02",1001,6,81568.16,2448.53,13581.77,11500.24],["2026-02-03",1000,2,19242.26,0.0,3305.99,2135.52],["2026-02-03",1001,6,172245.84,0.0,32726.74,28925.33],["2026-02-04",1000,3,10361.77,0.0,1807.64,1277.62],["2026-02-04",1001,6,53142.18,2751.46,8366.76,5024.9],["2026-02-05",1000,2,4364.78,0.0,829.3,776.93],["2026-02-05",1001,11,93429.13,0.0,17751.54,13538.03],["2026-02-06",1000,3,5807.84,149.0,575.98,486.58],["2026-02-06",1001,10,88669.86,0.0,16847.32,12424.42],["2026-02-07",1001,3,26550.68,0.0,5044.62,587.72],["2026-02-09",1000,1,620.79,0.0,117.95,109.55],["2026-02-09",1001,11,113981.41,396.74,21066.15,14826.19],["2026-02-10",1000,2,3878.4,116.38,465.4,503.94],["2026-02-10",1001,11,139714.12,2403.52,24424.19,17685.08],["2026-02-11",1001,12,73207.2,2357.99,11769.61,7202.41],["2026-02-12",1001,8,66369.6,2737.8,11336.22,6931.56],["2026-02-13",1000,1,149.86,0.0,28.47,49.95],["2026-02-13",1001,7,60931.28,0.0,10807.48,5121.65],["2026-02-14",1001,1,2116.92,0.0,402.21,275.08],["2026-02-15",1001,1,13176.11,0.0,2503.47,1337.25],["2026-02-16",1001,4,20093.29,0.0,3817.72,2925.75],["2026-02-18",1000,2,41029.86,0.0,5066.29,5493.77],["2026-02-18",1001,2,8577.13,0.0,1629.67,1334.02],["2026-02-19",1000,3,3696.91,0.0,685.74,610.42],["2026-02-19",1001,8,43419.01,1251.79,7619.15,6156.01],["2026-02-20",1000,3,24829.48,3413.76,3129.08,4215.92],["2026-02-20",1001,7,42580.63,679.9,7177.87,6033.9],["2026-02-21",1001,2,27913.61,0.0,5303.57,4734.69],["2026-02-23",1000,1,546.28,82.18,65.55,70.98],["2026-02-23",1001,9,98044.29,2284.03,15452.9,10319.93],["2026-02-24",1000,1,3816.34,0.0,725.11,495.91],["2026-02-24",1001,12,172829.04,6861.33,23074.52,20293.79],["2026-02-25",1001,8,59769.78,0.0,11037.98,6114.03],["2026-02-26",1000,4,26498.85,2651.27,3593.05,3524.61],["2026-02-26",1001,13,172064.83,2278.46,31632.11,15130.97],["2026-02-27",1000,8,52538.65,315.4,9835.57,9055.44],["2026-02-27",1001,34,360702.98,3689.22,66621.81,48744.78],["2026-02-28",1000,9,54824.72,0.0,10391.16,9981.78],["2026-02-28",1001,25,318414.96,6428.89,56025.75,44023.83],["2026-03-02",1001,7,44095.42,0.0,8050.68,6455.75],["2026-03-03",1000,2,5046.5,0.0,958.83,263.43],["2026-03-03",1001,14,88486.09,1530.16,14891.44,7192.41],["2026-03-04",1000,1,2151.43,0.0,408.77,279.57],["2026-03-04",1001,12,153277.05,0.0,24747.11,14264.05],["2026-03-05",1000,4,6368.51,0.0,1187.78,860.59],["2026-03-05",1001,13,126248.37,0.0,22182.5,7604.36],["2026-03-06",1000,2,2908.33,0.0,552.58,552.66],["2026-03-06",1001,8,51520.34,1537.03,7461.33,3587.58],["2026-03-09",1000,2,4198.18,0.0,797.65,545.52],["2026-03-09",1001,8,69124.02,0.0,11645.43,6992.28],["2026-03-10",1000,2,2371.65,0.0,392.17,298.42],["2026-03-10",1001,6,37105.08,0.0,5235.34,3562.83],["2026-03-11",1000,2,8644.48,0.0,1437.93,1123.3],["2026-03-11",1001,12,113839.67,4751.36,16527.7,11008.82],["2026-03-12",1000,3,14653.35,0.0,2784.13,2202.19],["2026-03-12",1001,9,106534.86,5509.98,15760.86,10140.95],["2026-03-13",1000,5,20592.88,759.49,2716.92,5519.11],["2026-03-13",1001,9,81091.75,2889.72,12998.01,7492.99],["2026-03-16",1000,1,1418.44,0.0,170.21,184.32],["2026-03-16",1001,5,31643.54,3109.33,4565.42,2472.98],["2026-03-17",1000,1,3358.9,0.0,638.19,0.0],["2026-03-17",1001,19,186643.7,4260.86,32579.55,17015.25],["2026-03-18",1000,3,4979.76,0.0,845.4,647.09],["2026-03-18",1001,16,98028.15,1064.9,17915.19,8342.73],["2026-03-19",1000,3,110352.0,0.0,20966.88,4803.8],["2026-03-19",1001,14,117039.35,0.0,20231.84,12030.18],["2026-03-20",1000,3,9141.55,0.0,1686.33,5120.67],["2026-03-20",1001,13,104495.06,1089.5,16652.24,11973.41],["2026-03-21",1001,3,29290.54,1750.6,4613.25,2382.31],["2026-03-23",1000,1,49500.0,0.0,9405.0,10980.2],["2026-03-23",1001,5,37656.6,1515.26,6330.79,4381.71],["2026-03-24",1000,6,30950.99,0.0,5126.73,22452.94],["2026-03-24",1001,16,99137.68,1214.43,16061.15,9112.67],["2026-03-25",1000,3,8475.41,748.18,1203.47,1423.9],["2026-03-25",1001,13,101237.42,867.33,16496.58,8629.47],["2026-03-26",1000,5,22407.15,892.2,3772.19,6387.88],["2026-03-26",1001,18,177857.54,2623.46,28785.04,18556.2],["2026-03-27",1000,3,60395.88,0.0,11475.21,15533.86],["2026-03-27",1001,6,132733.1,0.0,25219.31,11543.86],["2026-03-28",1001,1,2015.46,0.0,382.94,0.0],["2026-03-30",1000,5,29260.19,0.0,5559.44,7368.22],["2026-03-30",1001,4,13692.25,0.0,2601.51,1106.3],["2026-03-31",1000,6,21633.76,555.83,3728.09,2993.88],["2026-03-31",1001,29,356401.54,11088.82,58451.76,39518.51],["2026-04-01",1000,3,9461.59,173.64,1703.27,1666.26],["2026-04-02",1000,4,15141.65,0.0,2876.91,2830.66],["2026-04-02",1001,3,42066.37,0.0,5600.84,5858.44],["2026-04-06",1000,2,2147.94,0.0,408.11,364.38],["2026-04-06",1001,5,37216.87,0.0,5427.54,6567.76],["2026-04-07",1001,10,59932.42,0.0,10308.99,6116.33],["2026-04-08",1000,1,4873.02,0.0,584.76,859.98],["2026-04-08",1001,8,72827.23,3718.23,11106.44,6282.62],["2026-04-09",1000,4,26181.64,0.0,4822.45,4590.59],["2026-04-09",1001,7,40443.57,0.0,7684.27,5201.88],["2026-04-10",1001,7,90962.89,695.22,16238.45,14584.73],["2026-04-13",1000,1,1550.4,0.0,294.58,273.6],["2026-04-13",1001,8,94425.37,3400.04,16030.74,9101.91],["2026-04-14",1000,5,8092.53,331.8,1132.17,1611.73],["2026-04-14",1001,16,108685.9,0.0,19641.17,12751.2],["2026-04-15",1000,3,21116.72,0.0,4012.18,3640.35],["2026-04-15",1001,22,284615.1,569.79,37852.43,35807.42],["2026-04-16",1000,4,27780.07,0.0,4673.79,6151.27],["2026-04-16",1001,22,190186.41,3385.19,30205.22,18854.66],["2026-04-17",1001,10,83166.42,2960.14,12912.31,7942.92],["2026-04-20",1000,1,398.43,0.0,47.81,70.31],["2026-04-20",1001,10,85874.89,558.61,12460.21,10401.14],["2026-04-22",1000,5,26331.44,0.0,5002.98,3130.53],["2026-04-22",1001,15,209011.19,4471.42,34668.56,22479.69],["2026-04-23",1000,4,11219.14,328.76,1978.65,2480.03],["2026-04-23",1001,16,177634.15,0.0,32216.06,11245.03],["2026-04-24",1000,3,58905.47,7810.19,7557.75,11866.73],["2026-04-24",1001,15,140503.19,0.0,26078.75,14908.79],["2026-04-27",1001,22,259844.76,4278.4,45286.46,22498.13],["2026-04-28",1000,4,27333.06,0.0,5193.29,4938.7],["2026-04-28",1001,26,365695.86,4864.21,63223.15,36761.57],["2026-04-29",1000,3,6204.53,0.0,1020.91,1233.48],["2026-04-29",1001,12,111577.03,2319.48,19356.76,17983.0],["2026-04-30",1000,7,276348.67,1602.12,34475.48,51297.8],["2026-04-30",1001,21,209912.17,3539.02,36542.16,22546.82],["2026-05-02",1001,1,8749.7,0.0,1662.46,584.4],["2026-05-04",1000,3,11690.36,0.0,2221.17,4614.63],["2026-05-04",1001,8,57622.44,735.63,10045.84,8436.97],["2026-05-05",1000,2,8704.15,0.0,1653.78,1062.15],["2026-05-05",1001,5,30526.51,1328.09,4019.33,2438.68],["2026-05-06",1000,3,6985.48,0.0,999.43,572.92],["2026-05-06",1001,9,79107.79,0.0,12357.41,10664.89],["2026-05-07",1000,2,7640.59,0.0,1002.95,1851.41],["2026-05-07",1001,13,200287.06,4716.98,30793.3,23870.2],["2026-05-08",1000,6,23048.2,155.33,4306.86,10296.84],["2026-05-08",1001,16,151018.59,11394.45,22942.68,21656.42],["2026-05-11",1000,1,2504.64,0.0,475.87,509.4],["2026-05-11",1001,6,25635.74,380.3,4664.01,3003.05],["2026-05-12",1000,4,33211.58,1482.82,5620.22,7800.42],["2026-05-12",1001,19,233428.42,6721.42,36978.72,30384.6],["2026-05-13",1000,3,8342.74,307.47,1117.11,1603.85],["2026-05-13",1001,12,81837.12,1730.37,13671.34,11310.25],["2026-05-14",1000,8,51408.83,0.0,9102.36,8135.18],["2026-05-14",1001,11,84138.29,2591.8,11788.47,8904.95],["2026-05-15",1000,7,51726.9,0.0,9598.93,6134.27],["2026-05-15",1001,27,274805.77,1492.86,47493.24,26078.84],["2026-05-16",1001,4,17285.47,0.0,3284.23,1928.27],["2026-05-18",1000,2,2133.89,0.0,256.06,376.56],["2026-05-18",1001,16,159986.22,4779.33,26544.17,17804.99],["2026-05-19",1000,6,10449.05,0.0,1700.06,1393.37],["2026-05-19",1001,9,101015.81,1259.14,18607.09,14038.63],["2026-05-20",1000,4,7106.24,955.52,879.12,1627.68],["2026-05-20",1001,20,180060.19,5550.85,29158.05,24082.59],["2026-05-21",1000,2,1329.92,0.0,252.69,426.74],["2026-05-21",1001,16,109394.02,389.14,20603.76,15429.53],["2026-05-22",1000,5,42298.39,5255.18,5506.72,8722.95],["2026-05-22",1001,4,34468.47,308.47,5141.75,4556.65],["2026-05-23",1001,2,12143.57,0.0,2307.28,2224.59],["2026-05-25",1000,3,14300.83,20.65,2404.18,2523.71],["2026-05-25",1001,8,76145.59,1224.53,13801.78,9527.92],["2026-05-26",1000,7,102309.88,0.0,13998.72,16402.07],["2026-05-26",1001,14,105710.01,2980.24,15445.92,15181.86],["2026-05-27",1000,6,28612.07,2888.97,4068.19,4251.32],["2026-05-27",1001,12,191641.23,817.1,23663.15,23411.26],["2026-05-28",1000,6,16681.15,1514.51,2355.42,3715.55],["2026-05-28",1001,22,242514.83,434.54,44022.07,33301.12],["2026-05-29",1000,7,252771.42,160.48,47951.92,36890.42],["2026-05-29",1001,17,227896.6,1521.97,36692.98,33154.0],["2026-05-30",1001,1,4447.38,0.0,845.01,29.69],["2026-06-01",1000,5,24280.26,2507.7,3446.36,8431.34],["2026-06-01",1001,17,138850.66,6308.39,22367.33,15687.15],["2026-06-02",1000,1,3295.1,0.0,395.41,581.5],["2026-06-02",1001,10,97781.0,0.0,17611.34,8256.9],["2026-06-03",1000,4,5326.63,0.0,948.37,1398.7],["2026-06-03",1001,23,182634.54,5333.54,28205.13,21574.55],["2026-06-04",1000,1,353.39,0.0,67.14,88.35],["2026-06-05",1000,9,25045.0,102.26,4432.69,4434.76],["2026-06-05",1001,5,100083.18,0.0,13113.03,13658.31],["2026-06-07",1001,3,22300.17,0.0,2676.02,3486.29],["2026-06-08",1000,2,23952.86,0.0,2874.34,4226.93],["2026-06-08",1001,6,72605.44,2527.41,12027.08,9213.81],["2026-06-09",1000,4,34445.65,102.26,6497.1,7421.44],["2026-06-09",1001,12,82610.14,1856.48,13757.9,10498.58],["2026-06-10",1000,10,86020.7,890.76,13129.18,27979.06],["2026-06-10",1001,20,201400.48,3894.7,33206.49,22525.14],["2026-06-11",1000,4,63926.49,6608.76,9070.8,11714.73],["2026-06-11",1001,15,147904.2,2674.46,26274.55,19855.76],["2026-06-12",1000,7,22152.93,421.89,3979.64,8340.94],["2026-06-12",1001,13,115039.4,3543.2,19093.3,14627.59],["2026-06-15",1000,3,2922.58,113.53,493.56,530.98],["2026-06-15",1001,7,53823.05,763.06,9093.6,5257.92],["2026-06-16",1000,1,4603.76,692.54,552.46,812.43],["2026-06-16",1001,13,121211.63,0.0,21006.72,13668.64],["2026-06-17",1000,5,20431.55,0.0,3499.05,10628.63],["2026-06-17",1001,15,85755.73,2156.27,15211.01,10511.35],["2026-06-18",1000,3,17738.57,102.33,3314.7,3160.21],["2026-06-18",1001,18,151654.52,0.0,28230.38,18142.26],["2026-06-19",1000,2,8426.68,0.0,1601.07,1622.3],["2026-06-19",1001,15,123243.66,601.56,21728.46,13434.35],["2026-06-20",1001,1,7246.55,0.0,1376.84,997.37],["2026-06-22",1000,5,26322.62,0.0,5001.3,6060.87],["2026-06-22",1001,9,161349.39,0.0,26436.17,23839.27],["2026-06-23",1000,7,42245.78,2706.75,6554.8,14140.2],["2026-06-23",1001,14,152274.17,1155.24,23149.5,17337.16],["2026-06-24",1000,2,6477.62,0.0,1230.75,794.69],["2026-06-24",1001,23,233593.88,3814.45,42395.55,29779.09],["2026-06-25",1000,3,10359.75,0.0,1826.06,1828.15],["2026-06-25",1001,12,134961.13,4050.12,17739.77,19317.76],["2026-06-26",1000,2,5082.24,262.54,822.85,1007.57],["2026-06-26",1001,13,132391.1,2213.22,23244.65,16376.8],["2026-06-29",1000,4,8221.3,0.0,1562.04,1955.26],["2026-06-29",1001,9,104188.17,1033.68,19233.65,12899.57],["2026-06-30",1000,8,63891.5,218.78,11761.92,26089.6],["2026-06-30",1001,49,487414.85,7352.83,76462.14,63590.55],["2026-07-01",1000,3,3190.71,0.0,606.23,563.06],["2026-07-01",1001,6,33196.84,453.32,5221.14,3741.23],["2026-07-02",1000,3,17503.83,845.78,2932.17,3316.23],["2026-07-02",1001,1,4986.51,0.0,947.44,343.69],["2026-07-03",1000,5,148935.51,1022.64,27821.89,29049.59],["2026-07-03",1001,13,118905.89,0.0,21440.54,15287.43],["2026-07-06",1000,5,23961.13,0.0,4552.59,2942.55],["2026-07-06",1001,9,53697.91,2177.14,9126.53,5996.47],["2026-07-07",1000,2,2793.0,315.49,383.86,122.78],["2026-07-07",1001,6,98123.75,0.0,18643.53,9999.39],["2026-07-08",1000,3,8988.45,844.24,1248.71,2072.04],["2026-07-08",1001,7,45186.95,0.0,8585.52,3700.17],["2026-07-09",1000,6,22599.8,0.0,3518.92,7690.23],["2026-07-09",1001,13,256796.78,0.0,47878.16,36940.54],["2026-07-10",1000,3,1998.88,154.36,295.85,466.04],["2026-07-10",1001,7,87531.71,0.0,15487.97,11586.6],["2026-07-11",1001,3,13027.28,0.0,2475.17,1103.14],["2026-07-13",1000,1,2039.42,0.0,387.48,0.0],["2026-07-13",1001,8,83975.41,0.0,13126.37,9932.12],["2026-07-14",1000,3,22602.48,2379.13,2712.28,2417.41],["2026-07-14",1001,11,98609.83,7415.57,15002.21,9434.58],["2026-07-15",1000,5,18826.21,1363.8,2465.0,3638.07],["2026-07-15",1001,8,77952.45,1715.15,11400.88,4789.35],["2026-07-16",1000,2,20581.82,2583.72,2505.55,3939.41],["2026-07-16",1001,6,84764.6,814.4,11521.5,11160.65],["2026-07-17",1000,4,16449.44,0.0,3094.29,1813.67],["2026-07-17",1001,14,126797.36,3420.74,20494.4,13052.59],["2026-07-18",1001,2,21550.0,0.0,2814.74,1717.36],["2026-07-19",1001,1,14465.7,0.0,2748.48,767.57],["2026-07-20",1000,3,2344.83,0.0,445.51,430.45],["2026-07-20",1001,8,126831.1,0.0,21918.24,13718.47],["2026-07-21",1000,6,25740.38,0.0,4414.43,4375.99],["2026-07-21",1001,13,165395.95,1584.47,28774.44,19595.98],["2026-07-22",1000,3,14490.46,0.0,2731.47,4723.59],["2026-07-22",1001,18,149178.35,3773.01,24441.18,16526.7],["2026-07-23",1000,10,57217.94,818.16,10490.73,17402.63],["2026-07-23",1001,17,249637.11,1521.35,39204.96,27160.28],["2026-07-24",1000,6,44497.45,4630.73,5422.95,9881.28],["2026-07-24",1001,8,80875.07,1212.52,13735.82,7788.3],["2026-07-25",1001,1,4147.34,0.0,788.0,459.23],["2026-07-27",1000,1,471.48,0.0,56.58,600.05],["2026-07-27",1001,13,116192.5,4537.71,19764.84,11296.36],["2026-07-28",1000,4,4167.18,0.0,767.97,635.78],["2026-07-28",1001,18,159076.37,1575.97,26412.0,17491.35],["2026-07-29",1000,3,3183.51,60.02,512.53,661.21],["2026-07-29",1001,25,286833.32,3364.39,47647.08,32322.21],["2026-07-30",1000,4,4799.42,106.65,853.9,1350.38],["2026-07-30",1001,24,311348.43,4425.29,53177.84,38943.77],["2026-07-31",1000,25,383278.46,7017.11,66343.47,86470.35],["2026-07-31",1001,43,430778.3,1572.88,76597.99,52046.92],["2026-08-01",1001,2,18266.3,0.0,3470.59,2490.95],["2026-08-03",1000,2,6338.81,232.78,1077.81,1422.9],["2026-08-03",1001,10,85202.42,0.0,14621.4,9403.4],["2026-08-04",1000,5,9176.44,977.68,1266.19,2093.05],["2026-08-04",1001,15,102081.61,3535.34,16913.99,12713.68],["2026-08-05",1000,3,20559.58,222.78,3802.65,3023.55],["2026-08-05",1001,8,74409.54,3322.98,12161.05,8356.35],["2026-08-06",1000,5,16860.83,369.72,3002.5,2908.6],["2026-08-06",1001,16,137151.78,894.04,23916.67,17173.48],["2026-08-07",1000,2,4233.9,0.0,804.44,2683.78],["2026-08-07",1001,22,229059.47,2157.01,36955.47,28392.06],["2026-08-08",1001,1,4515.9,0.0,858.03,427.92],["2026-08-10",1000,1,2666.7,0.0,506.67,470.58],["2026-08-10",1001,8,45714.99,897.2,6767.94,3798.89],["2026-08-11",1000,3,40938.3,3001.02,6146.36,7313.51],["2026-08-11",1001,18,140131.2,1083.34,25241.65,16862.01],["2026-08-12",1000,1,2790.35,0.0,530.17,98.5],["2026-08-12",1001,17,118228.91,3014.97,19799.49,13579.1],["2026-08-13",1000,4,13372.2,312.94,2370.55,1172.37],["2026-08-13",1001,15,122064.99,1865.76,20137.64,12748.43],["2026-08-14",1000,1,17369.68,0.0,3300.23,1929.92],["2026-08-14",1001,11,89041.27,2368.15,15302.59,13654.44],["2026-08-15",1001,3,22779.06,0.0,4328.01,1457.74],["2026-08-17",1000,1,8967.82,1154.4,1076.13,1582.58],["2026-08-17",1001,18,243329.7,336.48,36872.24,38982.45],["2026-08-18",1000,6,55003.24,0.0,10163.13,9305.72],["2026-08-18",1001,12,214933.27,1401.82,31708.62,22511.4],["2026-08-19",1000,2,11075.0,136.92,2029.79,2321.83],["2026-08-19",1001,13,102029.68,5353.1,15938.34,12753.63],["2026-08-20",1000,3,21380.61,0.0,3991.39,3733.33],["2026-08-20",1001,16,124478.77,3330.94,17688.2,12726.33],["2026-08-21",1000,3,6879.0,262.13,825.48,1251.48],["2026-08-21",1001,17,199727.82,803.1,29078.9,26783.77],["2026-08-22",1001,1,3643.12,0.0,692.19,642.88],["2026-08-24",1000,2,22135.74,0.0,2667.37,2692.82],["2026-08-24",1001,15,154666.44,2680.53,25397.45,19550.87],["2026-08-25",1000,4,21794.21,144.84,3396.82,4524.85],["2026-08-25",1001,16,143767.11,4468.5,24945.08,20878.52],["2026-08-26",1000,4,16000.05,93.9,2519.53,2636.47],["2026-08-26",1001,12,99231.35,7160.39,15218.97,9642.09],["2026-08-27",1000,9,207047.49,2697.61,38083.71,39875.49],["2026-08-27",1001,6,49350.03,2344.56,8218.15,6012.14],["2026-08-28",1000,2,16736.65,224.31,3057.98,3010.6],["2026-08-28",1001,7,88849.95,2953.07,12895.96,11409.06],["2026-08-31",1000,11,313224.6,794.18,43927.65,52077.03],["2026-08-31",1001,12,156311.3,1859.4,25314.6,19291.01],["2026-09-01",1000,9,121152.02,311.43,16084.36,24858.71],["2026-09-01",1001,6,44531.35,464.53,8208.38,4544.12],["2026-09-02",1000,3,7698.15,0.0,1046.48,1621.17],["2026-09-02",1001,6,51845.21,0.0,9573.56,7743.89],["2026-09-03",1001,8,45824.65,2846.44,7246.67,5097.79],["2026-09-04",1000,5,32724.94,0.0,5842.02,6332.46],["2026-09-04",1001,4,29064.59,1290.49,4296.34,2432.98],["2026-09-05",1001,1,9688.46,0.0,1840.82,1217.77],["2026-09-08",1000,2,3529.14,0.0,670.54,622.78],["2026-09-08",1001,17,136916.69,0.0,23745.51,19228.14],["2026-09-09",1000,1,1387.34,0.0,263.59,244.84],["2026-09-09",1001,10,116044.9,2549.57,19821.81,14408.11],["2026-09-10",1000,3,7416.7,0.0,1409.17,1308.86],["2026-09-10",1001,11,102653.61,684.24,17037.19,10633.67],["2026-09-11",1000,2,23789.65,0.0,4520.04,4473.65],["2026-09-11",1001,12,95642.04,7121.73,14406.27,12648.72],["2026-09-12",1000,1,382.24,57.5,45.87,67.44],["2026-09-12",1001,1,17722.28,2665.99,2126.68,993.1],["2026-09-14",1000,5,15365.01,1211.24,2260.69,3017.71],["2026-09-14",1001,8,133209.54,1345.84,17897.51,12959.7],["2026-09-15",1000,5,6194.09,0.0,1176.87,1592.24],["2026-09-15",1001,18,203032.93,2955.31,35404.06,26842.85],["2026-09-16",1000,3,8721.08,0.0,1542.25,989.27],["2026-09-16",1001,22,193533.36,0.0,36771.37,21493.94],["2026-09-17",1000,4,5707.47,0.0,1084.42,772.92],["2026-09-17",1001,16,207524.04,2301.41,36506.75,26556.44],["2026-09-18",1000,6,49954.41,397.3,6319.75,10737.49],["2026-09-18",1001,23,187563.32,3790.56,31813.34,24014.15],["2026-09-19",1001,2,6417.71,0.0,1219.37,825.1],["2026-09-21",1000,6,85664.77,0.0,16276.31,12682.97],["2026-09-21",1001,12,77391.33,0.0,13929.77,8668.67],["2026-09-22",1000,4,10445.02,912.45,1550.67,1844.88],["2026-09-22",1001,15,158455.06,2428.95,22680.82,18399.92],["2026-09-23",1000,3,25433.14,175.1,4737.07,5118.35],["2026-09-23",1001,7,121890.32,1177.89,19333.18,12438.17],["2026-09-24",1000,2,16319.73,0.0,3100.75,3696.93],["2026-09-24",1001,10,96968.01,4328.43,12978.46,9915.84],["2026-09-25",1000,7,244363.69,0.0,45168.99,50226.23],["2026-09-25",1001,14,198670.51,1656.83,36344.14,28240.32],["2026-09-26",1001,1,2611.6,0.0,496.2,356.1],["2026-09-28",1000,6,33758.82,3590.06,4410.57,8072.91],["2026-09-28",1001,14,93729.77,527.65,16342.28,11171.44],["2026-09-29",1000,1,1167.84,0.0,221.89,206.16],["2026-09-29",1001,16,167207.44,2628.97,29791.9,19108.2],["2026-09-30",1000,8,65458.24,0.0,11666.79,14394.36],["2026-09-30",1001,24,181689.92,1700.64,31953.86,21901.23],["2026-10-01",1001,13,135352.15,5505.89,20979.92,19821.19],["2026-10-02",1000,5,95722.55,0.0,17756.34,18650.0],["2026-10-02",1001,9,71917.01,2037.68,12556.18,10369.15],["2026-10-05",1000,5,21156.05,375.9,3844.73,20090.82],["2026-10-05",1001,4,32815.52,3697.81,4450.89,3794.08],["2026-10-06",1000,3,20657.22,1891.66,2896.23,4712.92],["2026-10-06",1001,7,25479.38,415.83,4340.96,3128.66],["2026-10-07",1000,3,37453.7,4539.74,4647.57,7139.71],["2026-10-07",1001,9,72433.62,5015.69,11120.43,6149.04],["2026-10-08",1000,2,3725.08,342.47,548.4,698.43],["2026-10-08",1001,4,21856.13,1696.58,3137.13,1721.8],["2026-10-09",1000,4,10258.74,0.0,1893.37,1083.76],["2026-10-09",1001,4,26286.39,0.0,4994.44,3068.58],["2026-10-13",1000,3,7059.63,0.0,1301.62,1616.93],["2026-10-13",1001,8,147194.0,0.0,24520.43,16543.11],["2026-10-14",1000,2,303.12,0.0,57.6,53.49],["2026-10-14",1001,14,167245.14,0.0,26052.87,20190.41],["2026-10-15",1000,5,21022.07,1507.07,3174.67,4433.97],["2026-10-15",1001,10,157468.42,0.0,25980.99,23281.22],["2026-10-16",1000,2,3395.12,0.0,645.07,599.14],["2026-10-16",1001,11,116028.65,2620.16,16800.72,12698.72],["2026-10-19",1000,5,10353.83,291.32,1808.82,2124.37],["2026-10-19",1001,8,45678.88,0.0,8679.01,5093.6],["2026-10-20",1000,5,31578.33,0.0,5999.91,3296.32],["2026-10-20",1001,8,95477.08,0.0,14686.51,9439.51],["2026-10-21",1000,7,65078.52,2075.38,8541.66,13821.43],["2026-10-21",1001,19,203994.73,1168.21,32054.43,25140.18],["2026-10-22",1000,8,27746.74,0.0,5120.99,5070.8],["2026-10-22",1001,18,205820.15,0.0,35073.39,17194.83],["2026-10-23",1000,4,72300.62,0.0,13737.13,9545.5],["2026-10-23",1001,13,154588.11,3577.87,26768.73,8714.67],["2026-10-26",1000,6,43753.99,55.39,8287.49,8214.44],["2026-10-26",1001,17,212258.74,9832.62,31950.37,23475.82],["2026-10-27",1000,2,35025.73,0.0,4203.08,6126.13],["2026-10-27",1001,16,179211.25,5177.24,30344.14,11509.87],["2026-10-28",1000,1,890.66,0.0,169.22,606.24],["2026-10-28",1001,17,150058.74,1196.63,27504.39,10172.91],["2026-10-29",1000,3,11558.83,1409.85,1525.35,1509.08],["2026-10-29",1001,15,134254.49,3216.23,22520.12,16768.63],["2026-10-30",1000,2,4003.54,0.0,760.67,739.65],["2026-10-30",1001,5,43396.21,435.54,8008.43,4448.99]];
const Q43_RAW=document.getElementById('haialaQ43Result');
function q43num(value){
  let v=String(value==null?'':value).trim().replace(/\s/g,'');
  if(v.includes(','))v=v.replace(/\./g,'').replace(',','.');
  return Number(v);
}
const Q43_ATTEMPTED=!!Q43_RAW && Q43_RAW.dataset.testOk==='true';
const Q43_ROWS=Q43_RAW?Array.from(Q43_RAW.querySelectorAll('.haiala-q43-row')).map(el=>{
  const d=el.dataset;
  return [d.dia,q43num(d.op),q43num(d.qtd),q43num(d.vlc),q43num(d.st),q43num(d.icms),q43num(d.desc)];
}):[];
/* v6.1.8: dados auxiliares de informacao, totalmente segregados de Q43/Q471/Q539. */
const Q618_INFO_HOST=document.getElementById('haialaQ618InformativoResult');
const Q618_INFO_OK=!!Q618_INFO_HOST && Q618_INFO_HOST.dataset.ok==='true';
const Q618_INFO_ROWS=Q618_INFO_HOST?Array.from(Q618_INFO_HOST.querySelectorAll('.haiala-q618-informativo')).map(el=>({
 day:el.dataset.dia,group:Number(el.dataset.group),op:Number(el.dataset.op),
 description:el.dataset.description,rep:String(el.dataset.rep),client:String(el.dataset.client),
 qty:q43num(el.dataset.qty),vlc:q43num(el.dataset.vlc),st:q43num(el.dataset.st)
})):[];
const Q618_INFO_VALID=Q618_INFO_OK && Q618_INFO_ROWS.every(x=>
 /^2026-\d{2}-\d{2}$/.test(x.day)&&[3,4,5].includes(x.group)&&
 [x.op,x.qty,x.vlc,x.st].every(Number.isFinite));
/* v6.1.11: fonte exclusiva de documentos do popup por TOP. */
const Q6111_DOC_HOST=document.getElementById('haialaQ6111DocsResult');
const Q6111_DOC_ROWS=Q6111_DOC_HOST?[...Q6111_DOC_HOST.querySelectorAll('.haiala-q6111-doc')].map(el=>({
 id:q43num(el.dataset.id),day:el.dataset.day,group:Number(el.dataset.group),op:Number(el.dataset.op),
 rep:String(el.dataset.rep),client:String(el.dataset.client),status:el.dataset.status,
 vlc:q43num(el.dataset.vlc),st:q43num(el.dataset.st)
})):[];
const Q6111_DOC_VALID=!!Q6111_DOC_HOST&&Q6111_DOC_HOST.dataset.ok==='true'&&Q6111_DOC_ROWS.every(x=>
 Number.isInteger(x.id)&&x.id>0&&/^2026-\d{2}-\d{2}$/.test(x.day)&&
 [1,3,4,5].includes(x.group)&&['A','P','L'].includes(x.status)&&
 [x.op,x.vlc,x.st].every(Number.isFinite));
const Q43_VALID=Q43_ATTEMPTED && Q43_ROWS.length>0 && Q43_ROWS.every(r=>
  /^2026-\d{2}-\d{2}$/.test(r[0]) && [1000,1001,1005,1007,9000,9001].includes(r[1]) && r.slice(1).every(Number.isFinite)
);
const Q43_PEDIDOS=Q43_ROWS.reduce((a,r)=>a+r[2],0);
const Q43_REF=Q43_RAW?q43num(Q43_RAW.dataset.referenceTotal):NaN;
const Q43_CONSISTENTE=Q43_VALID && Number.isFinite(Q43_REF) && Q43_REF>0 && Q43_PEDIDOS===Q43_REF;
const DATA_ORIGIN=Q43_CONSISTENTE?'ORACLE':'SNAPSHOT';
const REAL_Q12=Q43_CONSISTENTE?Q43_ROWS:SNAPSHOT_Q12;
/* v4.5 - representante do pedido. Sem controles de acesso homologados: TESTE SOMENTE. */
const Q45_RAW=document.getElementById('haialaQ45Result');
const Q45_ATTEMPTED=!!Q45_RAW && Q45_RAW.dataset.testOk==='true';
const Q45_ROWS=Q45_RAW?Array.from(Q45_RAW.querySelectorAll('.haiala-q45-row')).map(el=>{
 const d=el.dataset;
 return [d.dia,q43num(d.op),q43num(d.qtd),q43num(d.vlc),q43num(d.st),q43num(d.icms),q43num(d.desc),q43num(d.rep)];
}):[];
const Q45_COUNT=Q45_ROWS.reduce((a,r)=>a+r[2],0);
const Q45_VALID=Q43_CONSISTENTE && Q45_ATTEMPTED && Q45_ROWS.length>0 &&
 Q45_ROWS.every(r=>/^2026-\d{2}-\d{2}$/.test(r[0]) && [1000,1001,1005,1007,9000,9001].includes(r[1]) && r.slice(1).every(Number.isFinite)) &&
 Q45_COUNT===Q43_PEDIDOS;
const REAL_PAGES=['AC-01','AC-02','AC-03','AC-04','VD-01','VD-02','VD-03'];
function isRealPage(){return REAL_PAGES.includes(state.page)}
function availableReps(){return Q45_VALID?[...new Set(Q45_ROWS.map(r=>r[7]))].sort((a,b)=>a-b):[]}

/* v4.6 - dimensionamento CODPARC do pedido (nao carteira atual).
   O cliente so pode ser escolhido quando a base detalhada Q46
   concilia com a base geral Q43. Sem permissao real: homologacao. */
const Q46_RAW=document.getElementById('haialaQ46Result');
const Q46_ATTEMPTED=!!Q46_RAW && Q46_RAW.dataset.testOk==='true';
const Q46_ROWS=Q46_RAW?Array.from(Q46_RAW.querySelectorAll('.haiala-q46-row')).map(el=>{
 const d=el.dataset;
 return [d.dia,q43num(d.op),q43num(d.qtd),q43num(d.vlc),
         q43num(d.st),q43num(d.icms),q43num(d.desc),
         q43num(d.rep),q43num(d.client)];
}):[];
const Q46_PEDIDOS=Q46_ROWS.reduce((t,r)=>t+r[2],0);
const Q46_SUM=(arr,index)=>Math.round(arr.reduce((t,r)=>t+r[index],0)*100);
const Q46_VALID=Q43_CONSISTENTE && Q46_ATTEMPTED && Q46_ROWS.length>0 &&
 Q46_ROWS.every(r=>/^2026-\d{2}-\d{2}$/.test(r[0]) &&
 [1000,1001,1005,1007,9000,9001].includes(r[1]) && r.slice(1).every(Number.isFinite)) &&
 Q46_PEDIDOS===Q43_PEDIDOS &&
 [3,4,5,6].every(i=>Math.abs(Q46_SUM(Q46_ROWS,i)-Q46_SUM(Q43_ROWS,i))<=1);
/* Tipo de negociação por NUNOTA: não interfere nos cálculos financeiros. */
const TIPO_NEG_V23_EL=document.getElementById('haialaTipoNegociacaoV23');
const TIPO_NEG_V23_OK=!!TIPO_NEG_V23_EL && TIPO_NEG_V23_EL.dataset.ok==='true';
const TIPO_NEG_V23_MAP=new Map(TIPO_NEG_V23_OK?[...TIPO_NEG_V23_EL.querySelectorAll('.haiala-tipo-negociacao-v23')].map(el=>[String(el.dataset.id),{code:el.dataset.code,desc:el.dataset.desc}]):[]);
function prazoNegociacaoPedido(id){const t=TIPO_NEG_V23_MAP.get(String(id));return t?(t.code+' - '+t.desc):'N/D';}
const Q471_EL=document.getElementById('haialaQ471Result');
const Q471_ATTEMPTED=!!Q471_EL && Q471_EL.dataset.testOk==='true';
const Q471_ROWS=Q471_EL?Array.from(Q471_EL.querySelectorAll('.haiala-q471-row')).map(el=>{
 const d=el.dataset;
 return {id:q43num(d.nunota),dia:d.dia,op:q43num(d.op),rep:q43num(d.rep),client:q43num(d.client),sku:q43num(d.sku),typology:String(d.tipologia||'(SEM TIPOLOGIA)').trim(),sales:q43num(d.vendas),discount:q43num(d.desconto),icms:q43num(d.icms),st:q43num(d.st),ipi:q43num(d.ipi)};
}):[];
const Q471_ORDERS=new Set(Q471_ROWS.map(r=>r.id));
const Q471_CENTS=Math.round(Q471_ROWS.reduce((a,r)=>a+r.sales,0)*100);
const Q471_REF_CENTS=Math.round(Q43_ROWS.reduce((a,r)=>a+r[3],0)*100);
/* v6.1.6 — Pedidos sem itens e valores zerados permanecem no universo Q43.
   Aceitar somente a diferença de quantidade explicada por consulta Oracle independente,
   no MESMO dia/TOP; nunca aceitar diferença financeira ou itens fictícios. */
const Q616_ZERO_EL=document.getElementById('haialaQ616SemItensZero');
const Q616_ZERO_OK=!!Q616_ZERO_EL && Q616_ZERO_EL.dataset.ok==='true';
const Q616_ZERO_ROWS=Q616_ZERO_EL?Array.from(Q616_ZERO_EL.querySelectorAll('.haiala-q616-zero')).map(el=>({
 dia:el.dataset.dia,op:q43num(el.dataset.op),qtd:q43num(el.dataset.qtd)
})):[];
const Q616_ZERO_VALID=Q616_ZERO_OK && Q616_ZERO_ROWS.every(r=>/^2026-\d{2}-\d{2}$/.test(r.dia)&&
 [1000,1001,1005,1007,9000,9001].includes(r.op)&&Number.isSafeInteger(r.qtd)&&r.qtd>0);
const Q616_Q43_BY_DAY_TOP=new Map(Q43_ROWS.map(r=>[r[0]+'|'+r[1],r[2]]));
const Q616_Q471_BY_DAY_TOP=new Map();
for(const r of Q471_ROWS){const k=r.dia+'|'+r.op;
 if(!Q616_Q471_BY_DAY_TOP.has(k))Q616_Q471_BY_DAY_TOP.set(k,new Set());
 Q616_Q471_BY_DAY_TOP.get(k).add(r.id);
}
const Q616_ZERO_BY_DAY_TOP=new Map(Q616_ZERO_ROWS.map(r=>[r.dia+'|'+r.op,r.qtd]));
const Q616_ZERO_TOTAL=Q616_ZERO_ROWS.reduce((n,r)=>n+r.qtd,0);
const Q616_COUNT_RECONCILED=Q616_ZERO_VALID && Q616_ZERO_BY_DAY_TOP.size===Q616_ZERO_ROWS.length &&
 Q616_ZERO_ROWS.every(r=>Q616_Q43_BY_DAY_TOP.has(r.dia+'|'+r.op)) &&
 [...Q616_Q43_BY_DAY_TOP].every(([k,qty])=>
  qty===(Q616_Q471_BY_DAY_TOP.get(k)?.size||0)+(Q616_ZERO_BY_DAY_TOP.get(k)||0)) &&
 Q471_ORDERS.size+Q616_ZERO_TOTAL===Q43_PEDIDOS;

const Q471_VALID=Q43_CONSISTENTE && Q471_ATTEMPTED && Q471_ROWS.length>0 &&
 Q471_ROWS.every(r=>Number.isFinite(r.id)&&r.id>0&&/^2026-\d{2}-\d{2}$/.test(r.dia)&&[1000,1001,1005,1007,9000,9001].includes(r.op)&&
 Number.isFinite(r.rep)&&Number.isFinite(r.client)&&Number.isFinite(r.sku)&&r.typology.length>0&&Number.isFinite(r.sales)&&Number.isFinite(r.discount)) &&
 Q616_COUNT_RECONCILED && Math.abs(Q471_CENTS-Q471_REF_CENTS)<=2;
/* v5.3.3.1: Familia real por ancestral TGFGRU e quantidade em unidade PC.
   Publicar apenas quando 100% dos pares pedido-SKU e seus valores
   conciliarem com Q471, que por sua vez ja concilia com Q43. */
/* Q539-T | Margem dimensional por pedido/SKU; nunca aplicar os valores fixos da auditoria. */
function q539RequiredNumber(v){
 // Em Oracle, campo NULL serializado como string vazia não é zero financeiro.
 return v==null||String(v).trim()===''?NaN:q43num(v);
}
const Q539T_EL=document.getElementById('haialaQ539TResult');
const Q539T_ALL_ROWS=Q539T_EL?Array.from(Q539T_EL.querySelectorAll('.haiala-q539t-row')).map(el=>{
 const d=el.dataset;
 return {id:q43num(d.id),sku:q43num(d.sku),dia:d.dia,op:q43num(d.op),rep:q43num(d.rep),client:q43num(d.client),
  duplicados:q539RequiredNumber(d.duplicados),semCusto:q539RequiredNumber(d.semCusto),
  receita:q539RequiredNumber(d.receita),margem:q539RequiredNumber(d.margem),
  quantidade:q539RequiredNumber(d.quantidade),custo:q539RequiredNumber(d.custo),icms:q539RequiredNumber(d.icms),
  pis:q539RequiredNumber(d.pis),cofins:q539RequiredNumber(d.cofins),
  comissao:q539RequiredNumber(d.comissao),reflexo:q539RequiredNumber(d.reflexoComissao),
  frete:q539RequiredNumber(d.frete),dataCusto:d.dataCusto||'',origemCusto:d.origemCusto||'',itemPromocional:String(d.itemPromocional)==='1'};
}):[];
const Q539T_NONCOMM_ROWS=Q539T_ALL_ROWS.filter(r=>[1002,1003,1004,1006,1009,9002].includes(r.op));
const Q539T_ROWS=Q539T_ALL_ROWS.filter(r=>[1000,1001,1005,1007,9000,9001].includes(r.op));
const Q539T_OK=!!Q539T_EL && Q539T_EL.dataset.ok==='true' && Q43_CONSISTENTE && Q471_VALID && Q539T_ROWS.length>0 &&
 Q539T_ROWS.every(r=>r.id>0&&r.sku>0&&/^2026-\d{2}-\d{2}$/.test(r.dia)&&[1000,1001,1005,1007,9000,9001].includes(r.op)&&
 [r.rep,r.client,r.duplicados,r.semCusto,r.receita,r.margem,r.custo,r.icms,r.pis,r.cofins,r.comissao,r.reflexo,r.frete].every(Number.isFinite)&&r.duplicados===0&&r.semCusto===0&&Math.abs(r.receita-r.custo-r.icms-r.pis-r.cofins-r.comissao-r.reflexo-r.frete-r.margem)<0.05);
const Q539T_MAP=new Map(Q539T_ROWS.map(r=>[String(r.id)+'|'+String(r.sku),r]));
const Q539T_UNIQUE=Q539T_MAP.size===Q539T_ROWS.length;
const Q539T_BASE_KEYS=new Set(Q471_ROWS.map(q=>String(q.id)+'|'+String(q.sku)));
/* v5.3.3.14.6.10: conciliação mensal independente; falhas em outubro/novembro
   não invalidam automaticamente meses anteriores. Jamais transformar falta de
   custo/registro em margem zero. Nenhum cálculo Oracle é alterado. */
const Q539T_MONTH_STATUS=new Map();
for(let month=1;month<=11;month++){
 const num=String(month).padStart(2,'0');
 Q539T_MONTH_STATUS.set(num, Q539T_EL?.getAttribute('data-ok-'+num)==='true');
}
const Q539T_BY_MONTH=new Map();
const Q539T_BASE_BY_MONTH=new Map();
for(const r of Q539T_ROWS){const mon=r.dia?.slice(5,7);if(!Q539T_BY_MONTH.has(mon))Q539T_BY_MONTH.set(mon,[]);Q539T_BY_MONTH.get(mon).push(r);}
for(const r of Q471_ROWS){const mon=r.dia?.slice(5,7);if(!Q539T_BASE_BY_MONTH.has(mon))Q539T_BASE_BY_MONTH.set(mon,new Set());Q539T_BASE_BY_MONTH.get(mon).add(String(r.id)+'|'+String(r.sku));}
function q539MonthValidation(mon){
 const base=Q539T_BASE_BY_MONTH.get(mon)||new Set();
 const rows=Q539T_BY_MONTH.get(mon)||[];
 if(!base.size)return {ok:true,reason:'sem pedidos no mês'};
 if(!Q539T_MONTH_STATUS.get(mon))return {ok:false,reason:'consulta Q539-T '+mon+' indisponível'};
 if(!Q471_VALID)return {ok:false,reason:'Q471 não conciliada'};
 const keys=new Set();
 for(const r of rows){
  const key=String(r.id)+'|'+String(r.sku);
  if(keys.has(key)||!base.has(key))return {ok:false,reason:'chave duplicada/fora da Q471: '+key};
  keys.add(key);
  if(!(r.id>0&&r.sku>0&&/^2026-\d{2}-\d{2}$/.test(r.dia)&&[1000,1001,1005,1007,9000,9001].includes(r.op)&&
   [r.rep,r.client,r.duplicados,r.semCusto,r.receita,r.margem,r.custo,r.icms,r.pis,r.cofins,r.comissao,r.reflexo,r.frete].every(Number.isFinite)&&
   r.duplicados===0&&Math.abs(r.receita-r.custo-r.icms-r.pis-r.cofins-r.comissao-r.reflexo-r.frete-r.margem)<0.05))return {ok:false,reason:'componentes/dados inválidos: '+key};
  const source=Q471_BY_KEY.get(key);
  if(!source||source.dia!==r.dia||source.client!==r.client||source.rep!==r.rep||source.op!==r.op)
   return {ok:false,reason:'dimensões divergentes: '+key};
 }
 // Um mês inteiro com receita positiva e todas as margens exatamente zero
 // não pode ser publicado como margem reconciliada sem auditoria de custo.
 // Margem legítima de um item pode ser zero; esta trava é somente mensal.
 if(rows.length>0 && rows.some(r=>r.receita>0) && rows.every(r=>r.margem===0))
  return {ok:false,reason:'margem integralmente zerada: validar custos e funções Oracle'};
 const missing=base.size-keys.size;
 // A tolerância histórica é limitada: não expandir cobertura sem provar exclusões.
 if(missing!==0)return {ok:false,reason:'pares sem correspondência='+missing};
 return {ok:true,missing};
}
const Q471_BY_KEY=new Map(Q471_ROWS.map(r=>[String(r.id)+'|'+String(r.sku),r]));
const Q539T_MONTH_CHECKS=new Map([...Q539T_BASE_BY_MONTH.keys()].map(mon=>[mon,q539MonthValidation(mon)]));
const Q539T_COVERAGE=Q471_VALID && [...Q539T_MONTH_CHECKS.values()].every(x=>x.ok) &&
 Q539T_UNIQUE && Q539T_BASE_KEYS.size-Q539T_ROWS.length>=0 &&
 Q539T_BASE_KEYS.size-Q539T_ROWS.length<=2;
function q539ScopeValid(items){
 if(!Q471_VALID||!Q539T_UNIQUE)return false;
 const months=new Set(items.map(r=>r.dia.slice(5,7)));
 return [...months].every(mon=>Q539T_MONTH_CHECKS.get(mon)?.ok===true);
}

/* Cache determinístico por recorte: evita repetir dezenas de milhares de filtros
   entre cards, tabela e detalhamento. Os dados Oracle são imutáveis na página. */
let haialaScopeCacheKey = null;
let haialaScopeItems = null;
let haialaScopeMargin = undefined;
let haialaScopeMarginIndex = null;
function haialaScopeKey(){
 return JSON.stringify([state.page,state.profile,state.period,state.manager,state.rep,
  state.carteira,state.uf,state.type,state.focus,state.sku]);
}
function haialaEnsureScope(){
 const key=haialaScopeKey();
 if(key!==haialaScopeCacheKey){
  haialaScopeCacheKey=key;haialaScopeItems=null;haialaScopeMargin=undefined;
  haialaScopeMarginIndex=null;
 }
}
function q539TFiltered(){
 haialaEnsureScope();
 if(haialaScopeMargin!==undefined)return haialaScopeMargin;
 if(!isRealPage()||state.profile!=='director'){
  haialaScopeMargin=null;return null;
 }
 const sourceItems=skuItemsFiltered();
 if(!q539ScopeValid(sourceItems)){
  haialaScopeMargin=null;return null;
 }
 // Mapa refeito a cada mudança do recorte (mês, cliente, SKU etc.).
 const rows=[];const index=new Map();
 for(const source of sourceItems){
  const key=String(source.id)+'|'+String(source.sku);
  const m=Q539T_MAP.get(key);
  if(!m)continue; // v20: grupo 40209001 elegivel quando TOP 1000, 1001 ou 1100
  if(m.dia!==source.dia||m.client!==source.client||m.rep!==source.rep||m.op!==source.op){
   haialaScopeMargin=null;haialaScopeMarginIndex=null;return null;
  }
  // Invalidez financeira é por pedido-SKU, não por mês inteiro.
  if(m.semCusto!==0 || m.duplicados!==0 ||
     ![m.receita,m.margem,m.custo,m.icms,m.pis,m.cofins,m.comissao,m.reflexo,m.frete].every(Number.isFinite) ||
     Math.abs(m.receita-m.custo-m.icms-m.pis-m.cofins-m.comissao-m.reflexo-m.frete-m.margem)>0.05){
    haialaScopeMargin=null;haialaScopeMarginIndex=null;return null;
  }
  rows.push(m);index.set(key,m);
 }
 haialaScopeMargin=rows;haialaScopeMarginIndex=index;
 return rows;
}
/* v6.1.4: leitura separada da MC por grupo de TOP da pagina Pedido.
   Nao modifica as formulas SQL Q539-T nem a conciliacao comercial homologada.
   Se a fonte nao suportar algum filtro, retorna N/D em vez de um numero incorreto. */
function q539V614GroupMetrics(source, group){
 const empty={valid:false,receita:null,margem:null,count:0,note:''};
 if(!isRealPage() || state.profile!=='director')return {...empty,note:'Pagina/perfil sem apuracao Oracle'};
 if(state.type!=='all')return {...empty,note:'Tipologia indisponivel na fonte Q539-T para grupos nao comerciais'};
 const period=state.period;
 const months=period==='all'?Array.from({length:11},(_,i)=>String(i+1).padStart(2,'0')):[String(period).padStart(2,'0')];
 if(months.some(m=>!Q539T_MONTH_STATUS.get(m)))return {...empty,note:'Consulta Q539-T indisponivel em mes do recorte'};
 const rows=source.filter(r=>
  (period==='all'||r.dia.slice(5,7)===String(period).padStart(2,'0')) &&
  regionAllowed(r) && (state.rep==='all'||String(r.rep)===String(state.rep)) &&
  clientMatches(r.client) &&
  (!skuSelected()||String(r.sku)===String(state.sku)));
 if(rows.length===0)return {valid:true,receita:0,margem:0,count:0,note:'Sem operacoes no recorte'};
 const keys=new Set();
 for(const r of rows){
  const key=String(r.id)+'|'+String(r.sku);
  if(keys.has(key)||r.duplicados!==0||r.semCusto!==0||r.id<=0||r.sku<=0||
    ![r.receita,r.margem,r.custo,r.icms,r.pis,r.cofins,r.comissao,r.reflexo,r.frete].every(Number.isFinite)||
    Math.abs(r.receita-r.custo-r.icms-r.pis-r.cofins-r.comissao-r.reflexo-r.frete-r.margem)>0.05)
   return {...empty,note:'Item sem custo, duplicado ou sem conciliacao financeira'};
  keys.add(key);
 }
 return {valid:true,receita:rows.reduce((v,r)=>v+r.receita,0),margem:rows.reduce((v,r)=>v+r.margem,0),count:rows.length,note:'Fonte Q539-T Oracle'};
}
function q539V614Summary(){
 const commercial=q539TFiltered();
 const mc=q539TCard();
 const venda=commercial!==null&&mc.valor!=='N/D'?{
  valid:true,receita:commercial.reduce((v,r)=>v+r.receita,0),
  margem:commercial.reduce((v,r)=>v+r.margem,0),count:commercial.length,note:mc.note
 }:{valid:false,receita:null,margem:null,count:0,note:mc.note};
 const investimento=q539V614GroupMetrics(Q539T_NONCOMM_ROWS.filter(r=>[1002,1003,1006,1009,9002].includes(r.op)),'INVESTIMENTO');
 const defeitos=q539V614GroupMetrics(Q539T_NONCOMM_ROWS.filter(r=>r.op===1004),'PEQUENOS DEFEITOS');
 const groups=[['Venda / Pedido',venda],['Investimento',investimento],['Pequenos Defeitos',defeitos]];
 const valid=groups.every(g=>g[1].valid);
 const total=valid?{valid:true,
  receita:groups.reduce((v,g)=>v+g[1].receita,0),
  margem:groups.reduce((v,g)=>v+g[1].margem,0),
  count:groups.reduce((v,g)=>v+g[1].count,0),note:'Somente grupos da pagina Pedido'
 }:{valid:false,receita:null,margem:null,count:0,note:'Consolidacao indisponivel: ao menos um grupo nao conciliado'};
 return {groups,total};
}
function q539V614Table(){
 const summary=q539V614Summary();
 const rows=[...summary.groups,['Consolidado',summary.total]];
 const pct=r=>r.valid&&r.receita!==0?(100*r.margem/r.receita).toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2})+'%':'N/D';
 return '<div class="mc614-scroll"><table class="mc614-table"><thead><tr><th>Grupo</th><th>Receita elegivel</th><th>MC R$</th><th>MC %</th></tr></thead><tbody>'+rows.map(([name,r],i)=>
  '<tr'+(i===rows.length-1?' class="mc614-total"':'')+'><td>'+esc(name)+'</td><td>'+(r.valid?esc(money(r.receita)):'N/D')+'</td><td>'+(r.valid?esc(money(r.margem)):'N/D')+'</td><td>'+esc(pct(r))+'</td></tr>'
 ).join('')+'</tbody></table></div>'+
 '<p class="ac-client-note">MC Projetada por grupo da pagina Pedido. Consolidado = soma das MC em R$; percentual = MC total / receita elegivel total. N/D indica falta de dados ou conciliacao.</p>'+
 (rows.some(([,r])=>!r.valid)?'<p class="ac-client-note ac-client-pending">'+esc(rows.filter(([,r])=>!r.valid).map(([name,r])=>name+': '+r.note).join(' | '))+'</p>':'')+ (rows.some(([,r])=>!r.valid)?haialaV615DiagnosticHTML():'');
}
function q539TCard(){
 const rows=q539TFiltered();
 if(rows===null){
  // Diagnostico rastreavel: nao revelar ou inventar margem antes da conciliacao.
  const failed=Q539T_EL && String(Q539T_EL.dataset.error||'').trim();
  const reasons=[];
  if(!Q539T_EL)reasons.push('contêiner Q539 ausente');
  else if(Q539T_EL.dataset.ok!=='true')reasons.push('falha no SQL JSP'+(failed?' ('+failed.slice(0,180)+')':''));
  if(!Q43_CONSISTENTE)reasons.push('Q43 não conciliada');
  if(!Q471_VALID)reasons.push('Q471 não conciliada');
  if(Q539T_ROWS.length===0)reasons.push('Q539 sem linhas carregadas');
  if(Q539T_ROWS.length && !Q539T_OK)reasons.push('existem SKUs com custo/componente financeiro pendente; consultar o pedido individualmente');
  if(!Q539T_UNIQUE)reasons.push('par pedido-SKU duplicado');
  for(const [mon,check] of Q539T_MONTH_CHECKS)if(!check.ok)reasons.push('mês '+mon+': '+check.reason);
  const outside=Q539T_ROWS.filter(r=>!Q539T_BASE_KEYS.has(String(r.id)+'|'+String(r.sku))).length;
  const remaining=Q539T_BASE_KEYS.size-Q539T_ROWS.length;
  if(outside)reasons.push('pares fora da Q471='+outside);
  if(remaining<0||remaining>2)reasons.push('diferença de pares='+remaining);
  if(!isRealPage())reasons.push('página não integrada');
  if(state.profile!=='director')reasons.push('perfil sem fonte Oracle');
  // v18: reveal exact coverage gaps; never substitute zeros for missing costs.
  const incidentes=[];
  for(const [mon, base] of Q539T_BASE_BY_MONTH){
   let faltantes=0,semCusto=0,duplicados=0,componentes=0,exemplos=[];
   for(const key of base){
    const m=Q539T_MAP.get(key);
    if(!m){faltantes++;if(exemplos.length<3)exemplos.push(key);continue;}
    if(m.semCusto!==0){semCusto++;if(exemplos.length<3)exemplos.push(key);}
    if(m.duplicados!==0)duplicados++;
    if(![m.receita,m.margem,m.custo,m.icms,m.pis,m.cofins,m.comissao,m.reflexo,m.frete].every(Number.isFinite) ||
       Math.abs(m.receita-m.custo-m.icms-m.pis-m.cofins-m.comissao-m.reflexo-m.frete-m.margem)>0.05)componentes++;
   }
   if(faltantes||semCusto||duplicados||componentes)
    incidentes.push('2026-'+mon+': ausentes='+faltantes+', sem custo='+semCusto+', duplicados='+duplicados+', componentes inválidos='+componentes+(exemplos.length?' [ex.: '+exemplos.join(', ')+']':''));
  }
  if(incidentes.length)reasons.push('Auditoria mensal '+incidentes.join(' | '));
  const metrics=' [Q539='+Q539T_ROWS.length+', Q471='+Q539T_BASE_KEYS.size+']';
  return {valor:'N/D',pct:'N/D',note:'Diagnóstico Q539: '+(reasons.join('; ')||'validação dimensional não atendida')+metrics};
 }

 const receita=rows.reduce((t,r)=>t+r.receita,0);
 const margem=rows.reduce((t,r)=>t+r.margem,0);
 if(!Number.isFinite(receita)||!Number.isFinite(margem))return {valor:'N/D',pct:'N/D',note:'Totais inválidos no Oracle'};
 if(rows.length===0)return {valor:'N/D',pct:'N/D',note:'Sem itens elegíveis no recorte'};
 return {valor:money(margem),pct:receita!==0?(100*margem/receita).toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2})+'%':'N/D',
  note:'Oracle | TGFCUS.CUSSEMICM de referência mensal (último custo anterior ao mês) | '+rows.length+' pares pedido-SKU'};
}
const Q533_EL=document.getElementById('haialaQ533Result');
const Q533_OK=!!Q533_EL && Q533_EL.dataset.ok==='true';
const Q533_ROWS=Q533_EL?Array.from(Q533_EL.querySelectorAll('.haiala-q533-row')).map(el=>{
 const d=el.dataset;
 return {id:q43num(d.nunota),day:d.dia,op:q43num(d.op),rep:q43num(d.rep),client:q43num(d.client),sku:q43num(d.sku),family:String(d.family||'OUTRAS').trim(),type:String(d.type||'(SEM TIPOLOGIA)').trim(),qty:q43num(d.qty),other:q43num(d.other),sales:q43num(d.sales),salesPC:q43num(d.salesPc)};
}):[];
const Q533_ORDER_SKU=new Map();
for(const r of Q533_ROWS){const key=String(r.id)+'|'+String(r.sku);if(!Q533_ORDER_SKU.has(key))Q533_ORDER_SKU.set(key,r);}
const Q533_EXPECTED=new Map(Q471_ROWS.map(r=>[String(r.id)+'|'+String(r.sku),r]));
const Q533_VALID=Q533_OK && Q471_VALID && Q533_ROWS.length>0 &&
 Q533_ROWS.length===Q533_ORDER_SKU.size &&
 Q533_ROWS.length===Q533_EXPECTED.size &&
 Q533_ROWS.every(r=>{
  const old=Q533_EXPECTED.get(String(r.id)+'|'+String(r.sku));
  return old && /^2026-\d{2}-\d{2}$/.test(r.day) &&
   [1000,1001,1005,1007,9000,9001].includes(r.op) && ['PRIMER','APD','ALUMINIO','OUTRAS'].includes(r.family) &&
   [r.id,r.rep,r.client,r.sku,r.qty,r.other,r.sales,r.salesPC].every(Number.isFinite) &&
   r.id===old.id && r.day===old.dia && r.op===old.op &&
   r.rep===old.rep && r.client===old.client &&
   r.type===old.typology && Math.abs(Math.round(r.sales*100)-Math.round(old.sales*100))<=1;
 }) && Math.abs(Math.round(Q533_ROWS.reduce((a,r)=>a+r.sales,0)*100)-Q471_CENTS)<=2;

/* v6.1.5 — auditoria read-only das divergencias, sem liberar numeros nao conciliados.
   Compara apenas dimensoes ja retornadas pelo JSP; nenhuma nova regra financeira. */
function haialaV615DiagnosticHTML(){
 const escD=x=>esc(String(x));
 const formatC=c=>Number.isFinite(c)?(c/100).toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2}):'N/D';
 const sumC=arr=>Math.round(arr.reduce((a,v)=>a+v,0)*100);
 const ops=[1000,1001,1005,1007,9000,9001];
 const baseRows=ops.map(op=>{
  const hdr=Q43_ROWS.filter(r=>r[1]===op);
  const its=Q471_ROWS.filter(r=>r.op===op);
  const ids=new Set(its.map(r=>r.id));
  const headN=hdr.reduce((t,r)=>t+r[2],0);
  const headC=sumC(hdr.map(r=>r[3]));
  const itemC=sumC(its.map(r=>r.sales));
  return {op,headN,itemN:ids.size,headC,itemC,delta:itemC-headC};
 });
 const tr=baseRows.map(r=>'<tr><td>'+r.op+'</td><td>'+r.headN+'</td><td>'+r.itemN+'</td><td>'+formatC(r.headC)+'</td><td>'+formatC(r.itemC)+'</td><td>'+formatC(r.delta)+'</td></tr>').join('');
 const q533Keys=new Set(Q533_ROWS.map(r=>String(r.id)+'|'+String(r.sku)));
 const q471Keys=new Set(Q471_ROWS.map(r=>String(r.id)+'|'+String(r.sku)));
 const missing533=[...q471Keys].filter(k=>!q533Keys.has(k));
 const extra533=[...q533Keys].filter(k=>!q471Keys.has(k));
 const missing539=[...q471Keys].filter(k=>!Q539T_MAP.has(k));
 const duplicate471=Q471_ROWS.length-q471Keys.size;
 const q533Delta=sumC(Q533_ROWS.map(r=>r.sales))-Q471_CENTS;
 const q539Extra=Q539T_ROWS.filter(r=>!q471Keys.has(String(r.id)+'|'+String(r.sku))).length;
 const problems=['Q471 SQL: '+(Q471_ATTEMPTED?'executou':'falha/indisponivel'),
  'Q471 pares: '+Q471_ROWS.length+', distintos '+q471Keys.size+', duplicados '+duplicate471,
  'Q43 pedidos: '+Q43_PEDIDOS+'; Q471 pedidos com itens: '+Q471_ORDERS.size+'; sem itens e zero (Oracle): '+Q616_ZERO_TOTAL+'; quantidade conciliada: '+Q616_COUNT_RECONCILED,
  'Diferenca global Q471 - Q43 (R$): '+formatC(Q471_CENTS-Q471_REF_CENTS),
  'Q533 SQL: '+(Q533_OK?'executou':'falha/indisponivel')+', pares '+Q533_ROWS.length+', ausentes '+missing533.length+', extras '+extra533.length+', diferenca Q533 - Q471 (R$) '+formatC(q533Delta),
  'Q539 pares comerciais: '+Q539T_ROWS.length+', ausentes '+missing539.length+', extras '+q539Extra,
  'Amostra pares ausentes Q533: '+(missing533.slice(0,5).join(', ')||'nenhum'),
  'Amostra pares ausentes Q539: '+(missing539.slice(0,5).join(', ')||'nenhum')];
 return '<details class="haiala-v615-diagnostic"><summary>Auditoria de conciliacao — Q43 x Q471 x Q533 x Q539 (clique para expandir)</summary>'+ 
 '<p>Somente diagnostico. Diferencas exibidas em R$; nao altera indicadores nem autoriza valores N/D.</p>'+ 
 '<div style="overflow-x:auto"><table style="width:100%;font-size:11px"><thead><tr><th>TOP</th><th>Pedidos Q43</th><th>Pedidos Q471</th><th>Vendas Q43</th><th>Vendas Q471</th><th>Dif. itens - cab.</th></tr></thead><tbody>'+tr+'</tbody></table></div>'+ 
 '<ul>'+problems.map(t=>'<li>'+escD(t)+'</li>').join('')+'</ul></details>';
}
/* v4.7.7: reconcile fiscal item totals to independent header sums.
   Reject fiscal values if any mismatch; keep Q471 commercial calculations active. */
const Q476_IPI_EL=document.getElementById('haialaQ476IPIResult');
const Q476_IPI_OK=!!Q476_IPI_EL && Q476_IPI_EL.dataset.testOk==='true';
const Q476_IPI_CAB=Q476_IPI_EL?q43num(Q476_IPI_EL.dataset.ipi):NaN;
const Q476_CENTS=key=>Math.round(Q471_ROWS.reduce((v,r)=>v+r[key],0)*100);
const Q476_ICMS_REF=Math.round(Q43_ROWS.reduce((v,r)=>v+r[5],0)*100);
const Q476_ST_REF=Math.round(Q43_ROWS.reduce((v,r)=>v+r[4],0)*100);
const Q476_FISCAL_VALID=Q471_VALID && Q476_IPI_OK && Number.isFinite(Q476_IPI_CAB) &&
 Q471_ROWS.every(r=>[r.icms,r.st,r.ipi].every(Number.isFinite)) &&
 Math.abs(Q476_CENTS('icms')-Q476_ICMS_REF)<=2 &&
 Math.abs(Q476_CENTS('st')-Q476_ST_REF)<=2 &&
 Math.abs(Q476_CENTS('ipi')-Math.round(Q476_IPI_CAB*100))<=2;
function fiscalFilterActive(){return skuSelected()||typeSelected()||managerActive()||ufActive()||carteiraActive();}
function fiscalRecorte(){
 if(!Q476_FISCAL_VALID)return null;
 const itens=skuItemsFiltered();
 return {icms:itens.reduce((s,r)=>s+r.icms,0),st:itens.reduce((s,r)=>s+r.st,0),ipi:itens.reduce((s,r)=>s+r.ipi,0)};
}

/* v4.7.7: classificacao ATUAL, não altera o representante ORIGINAL do pedido.
   Perfil visual removido. Permissao de acesso deve ser implementada no servidor. */
const META477=document.getElementById('haialaV477Metadata');
const V477_REP_MAP=new Map(), V477_UF_MAP=new Map();
if(META477){
 META477.querySelectorAll('.haiala-v477-rep').forEach(el=>{
  const d=el.dataset;V477_REP_MAP.set(String(d.id),{name:String(d.name||'').trim(),manager:String(d.ger),managerName:String(d.gerName||'').trim()});
 });
 META477.querySelectorAll('.haiala-v477-uf').forEach(el=>{
  const d=el.dataset;V477_UF_MAP.set(String(d.id),String(d.uf||'(SEM UF)').trim());
 });
}
const V477_REP_OK=!!META477&&META477.dataset.repsOk==='true'&&Q471_VALID&&
 [...new Set(Q471_ROWS.map(r=>String(r.rep)))].every(id=>id==='-1'||V477_REP_MAP.has(id));
const V477_UF_OK=!!META477&&META477.dataset.ufsOk==='true'&&Q471_VALID&&
 [...new Set(Q471_ROWS.map(r=>String(r.client)))].every(id=>V477_UF_MAP.has(id));
/* v4.7.8: responsabilidade ATUAL do cliente, distinta de CAB.CODVEND.
   Somente clientes COM vendas integram este primeiro recorte; elegibilidade e carteira sem vendas aguardam outra consulta.
   Este dropdown NÃO implementa permissões de acesso. */
const CARTEIRA478_EL=document.getElementById('haialaCarteiraV478Metadata');
const CARTEIRA478_MAP=new Map(),CARTEIRA478_NAMES=new Map();
if(CARTEIRA478_EL){
 CARTEIRA478_EL.querySelectorAll('.haiala-carteira-v478').forEach(el=>{
  const id=String(el.dataset.client||'').trim(), owner=String(el.dataset.owner||'').trim();
  if(id&&owner){CARTEIRA478_MAP.set(id,owner);const nome=String(el.dataset.ownerName||'').trim();if(nome)CARTEIRA478_NAMES.set(owner,nome);}
 });
}
const CARTEIRA478_VALID=!!CARTEIRA478_EL && CARTEIRA478_EL.dataset.ok==='true' && Q471_VALID &&
 [...new Set(Q471_ROWS.map(r=>String(r.client)))].every(id=>CARTEIRA478_MAP.has(id)) &&
 CARTEIRA478_MAP.size===[...new Set(Q471_ROWS.map(r=>String(r.client)))].length;

/* v4.7.9 - carteira de clientes cadastrados independente de compras no período.
   Apenas consulta; não autoriza usuários e não altera os dados fiscais homologados. */
const CAD479_EL=document.getElementById('haialaCarteiraCompletaV479');
const CAD479_OK=!!CAD479_EL && CAD479_EL.dataset.ok==='true';
const CAD479_ROWS=CAD479_EL?[...CAD479_EL.querySelectorAll('.haiala-cadastro-v479')].map(x=>({
  client:String(x.dataset.client||''),name:String(x.dataset.name||''),
  owner:String(x.dataset.owner||'-1'),cardEligible:x.dataset.cardEligible==='S',uf:String(x.dataset.uf||'(SEM UF)'),
  commercial:x.dataset.isClient==='S',active:x.dataset.active==='S',
  blocked:x.dataset.block==='S',showroom:x.dataset.showroom==='S',last:String(x.dataset.last||''),
  never:x.dataset.never==='S',inactive90:x.dataset.inactive90==='S'
})):[];
const CAD479_MAP=new Map(CAD479_ROWS.map(r=>[r.client,r]));
const CAD479_VALID=CAD479_OK&&CAD479_ROWS.length>0&&CAD479_MAP.size===CAD479_ROWS.length&&
  (!Q46_VALID || [...new Set(Q46_ROWS.map(r=>String(r[8])))].every(id=>CAD479_MAP.has(id)));
function atualizarCarteiraCompleta(){
 const n=document.getElementById('haialaCarteiraCompletaNotice');
 if(!n)return;
 n.style.background=CAD479_VALID?'#eaf5ed':'#fff0d7';
 n.textContent=CAD479_VALID?'CARTEIRA COMPLETA: '+CAD479_ROWS.length+' cadastros comerciais/históricos consultados no Oracle (inclui sem compras). Elegibilidade preliminar CLIENTE=S, ATIVO=S, BLOQUEAR diferente de S; 90 dias desde última compra válida da empresa 1. Acesso por usuário NÃO homologado.':
 'CARTEIRA COMPLETA: consulta indisponível ou sem conciliação de clientes com compras. Não apresentar números de carteira como homologados.';
}
function renderCarteiraCompleta(){
 const container=document.getElementById('haialaCarteiraCompletaPanel');if(!container)return;
 const show=['CL-01','CL-04','RP-04'].includes(state.page);
 container.style.display=show?'block':'none';if(!show)return;
 if(!CAD479_VALID){container.innerHTML='<h3 class="paneltitle">Carteira comercial completa (Oracle)</h3><p class="notice">Consulta não conciliada ou indisponível. Esta seção não exibe números presumidos. As análises demonstrativas abaixo não representam a carteira real.</p>';return;}
 // Carteira e UF: cadastro atual. Gerência: do atual responsável da carteira, não do pedido.
 const clienteFiltro=clientIds();
 const rows=CAD479_ROWS.filter(c=>
  (state.carteira==='all'||c.owner===String(state.carteira))&&
  (state.uf==='all'||c.uf===state.uf)&&
  (state.manager==='all'||(V477_REP_MAP.get(c.owner)?.manager||'-1')===state.manager)&&
  (!clienteFiltro.length||clienteFiltro.includes(c.client))
 );
 // Clientes com compras no período: qualquer pedido do cliente na empresa 1. Filtro de representante restringe autoria da venda.
 // Tipologia e SKU: requerem itens conciliados e não eliminam cadastros do denominador.
 const compras=new Set();
 const dataFonte=Q46_VALID?Q46_ROWS:[];
 if(Q46_VALID)for(const r of dataFonte){
  if(state.period!=='all'&&Number(r[0].slice(5,7))!==Number(state.period))continue;
  if(state.rep!=='all'&&String(r[7])!==String(state.rep))continue;
  compras.add(String(r[8]));
 }
 const eligiveis=rows.filter(c=>c.commercial&&c.active&&!c.blocked);
 const compradores=eligiveis.filter(c=>compras.has(c.client));
 const inativos=eligiveis.filter(c=>c.inactive90);
 const nunca=eligiveis.filter(c=>c.never);
 const naoElegiveis=rows.length-eligiveis.length;
 const valorCompra=c=>compras.has(c.client)?'Sim':'Não';
 // Filtros de produto não participam da classificação de última compra histórica.
 const avisos=[];
 if(!Q46_VALID)avisos.push('Clientes com compras no período: consulta Q46 indisponível; valor não homologável');
 if(state.type!=='all'||state.sku!=='all')avisos.push('Tipologia/SKU não alteram a carteira cadastrada nem a última compra; clientes com compras consideram pedidos no período, sem restringir itens');
 if(state.rep!=='all')avisos.push('Representante da venda filtra somente compradores no período, não o universo cadastrado');
 avisos.push('Critério preliminar de elegibilidade: CLIENTE=S, ATIVO=S, BLOQUEAR diferente de S. Sujeito à homologação comercial');
 avisos.push('Última compra e inatividade usam pedidos comerciais válidos (TOP 1000,1001,1005,1007,9000,9001) da empresa 1, com histórico até hoje');
 const card=(label,value)=>'<div class="tax-metric"><span>'+label+'</span><strong>'+value+'</strong></div>';
 let resumo='<div class="tax-grid">'+card('Clientes no cadastro comercial',fmt(rows.length))+card('Elegíveis (preliminar)',fmt(eligiveis.length))+
 card('Clientes com compras no período',Q46_VALID?fmt(compradores.length):'N/D')+card('Sem compra há 90 dias ou mais',fmt(inativos.length))+
 card('Sem histórico de compras',fmt(nunca.length))+card('Não elegíveis',fmt(naoElegiveis))+'</div>';
 const sorted=rows.slice().sort((a,b)=>a.client.localeCompare(b.client,'pt-BR',{numeric:true}));
 const tableRows=sorted.slice(0,150).map(c=>{
  const elegivel=c.commercial&&c.active&&!c.blocked;
  const situacao=c.never?'Sem histórico':c.inactive90?'Inativo (90+ dias)':'Compra recente';
  return '<tr><td>'+esc(c.client)+'</td><td>'+esc(c.name)+'</td><td>'+esc(c.owner)+'</td><td>'+esc(c.uf)+'</td><td>'+(elegivel?'Sim':'Não')+'</td><td>'+(Q46_VALID?valorCompra(c):'N/D')+'</td><td>'+esc(situacao)+'</td><td>'+esc(c.last||'Nunca')+'</td></tr>';
 }).join('');
 container.innerHTML='<h3 class="paneltitle">Carteira comercial completa - Oracle | Empresa 1</h3>'+resumo+
 '<p class="note">'+esc(avisos.join(' • '))+'</p>'+
 '<div class="tablewrap"><table><thead><tr><th>Cód.</th><th>Cliente</th><th>Responsável atual</th><th>UF</th><th>Elegível</th><th>Com compras no período</th><th>Situação (histórico)</th><th>Última compra</th></tr></thead><tbody>'+tableRows+'</tbody></table></div>'+
 '<p class="note">Exibindo '+fmt(Math.min(150,sorted.length))+' de '+fmt(sorted.length)+' clientes; indicadores consideram todo o recorte. As seções demonstrativas seguintes não substituem esta consulta Oracle.</p>';
}

function carteiraActive(){return isRealPage() && state.carteira!=='all';}
function carteiraAllowed(r){return !carteiraActive()||(CARTEIRA478_VALID&&CARTEIRA478_MAP.get(String(r.client))===String(state.carteira));}
function carteiraName(id){return id==='-1'?'(SEM RESPONSÁVEL)':String(id)+' - '+(CARTEIRA478_NAMES.get(String(id))||V477_REP_MAP.get(String(id))?.name||'Apelido indisponível');}
function updateCarteiraNotice(){
 const el=document.getElementById('haialaCarteiraNotice');if(!el)return;
 el.style.background=CARTEIRA478_VALID?'#eaf5ed':'#fff0d7';
 el.textContent=CARTEIRA478_VALID ?
 'CARTEIRA ATUAL: '+CARTEIRA478_MAP.size+' clientes com compras conciliados com Oracle. Responsável atual = TGFPAR.CODVEND, representante da venda = TGFCAB.CODVEND. Acesso por usuário NÃO homologado.' :
 'CARTEIRA ATUAL: consulta indisponível ou não conciliada; filtro bloqueado. Não confundir responsáveis atuais com vendedores dos pedidos.';
}
function managerActive(){return isRealPage()&&state.manager!=='all';}
function ufActive(){return isRealPage()&&state.uf!=='all';}
function regionAllowed(r){
 return (!managerActive()||(V477_REP_OK&&(V477_REP_MAP.get(String(r.rep))?.manager||'-1')===state.manager)) &&
 (!ufActive()||(V477_UF_OK&&(V477_UF_MAP.get(String(r.client))||'(SEM UF)')===state.uf)) &&
 carteiraAllowed(r);
}
function labelManager(id){
 const pair=[...V477_REP_MAP.values()].find(x=>x.manager===String(id));
 return id==='-1'?'(SEM GERÊNCIA)':String(id)+' - '+(pair?.managerName||'Nome não disponível');
}
function repName(id){const v=V477_REP_MAP.get(String(id));return id===-1?'Sem representante':String(id)+' - '+(v?.name||'Apelido indisponível');}
function update477Status(){
 const box=document.getElementById('haialaV477Notice');if(!box)return;
 box.style.background=V477_REP_OK&&V477_UF_OK?'#eaf5ed':'#fff0d7';
 box.textContent='GERÊNCIA: '+(V477_REP_OK?'Cadastro TGFVEN.CODGER conciliado':'NÃO disponível - seleção bloqueada')+
 ' | REPRESENTANTE: código + apelido | UF: '+(V477_UF_OK?'somente estados com clientes que venderam':'NÃO disponível - seleção bloqueada')+
 ' | PERFIL: removido da interface; PERMISSÕES do Oracle NÃO homologadas; uso exclusivo em teste.';
}

function typeSelected(){return state.type!=='all' && isRealPage();}
function skuSelected(){return state.sku!=='all';}
const Q471_BY_MONTH=new Map();
for(const item of Q471_ROWS){
 const month=Number(item.dia.slice(5,7));
 if(!Q471_BY_MONTH.has(month))Q471_BY_MONTH.set(month,[]);
 Q471_BY_MONTH.get(month).push(item);
}
function skuItemsFiltered(){
 haialaEnsureScope();
 if(haialaScopeItems!==null)return haialaScopeItems;
 if(!Q471_VALID || !isRealPage() || state.profile!=='director'){
  haialaScopeItems=[];return haialaScopeItems;
 }
 // Pré-seleção pelo período evita percorrer todos os meses a cada card.
 const source=state.period==='all'?Q471_ROWS:
  (Q471_BY_MONTH.get(Number(state.period))||[]);
 haialaScopeItems=source.filter(r=>regionAllowed(r) &&
  (state.rep==='all'||String(r.rep)===String(state.rep)) &&
  clientMatches(r.client) &&
  (!skuSelected()||String(r.sku)===String(state.sku)) &&
  (!typeSelected()||r.typology===state.type));
 return haialaScopeItems;
}
function distinctSkusPeriod(groupId, groupKeyFn){
 if(!Q471_VALID)return null;
 return new Set(skuItemsFiltered().filter(r=>groupKeyFn(r.dia)===groupId).map(r=>r.sku)).size;
}
function updateSkuNotice(){
 const el=document.getElementById('haialaSkuNotice');if(!el)return;
 if(Q471_VALID){
 el.style.background='#eff6fb';
 el.textContent='SKU (CODPROD) e TIPOLOGIA (AD_TIPOLOGIA): '+Q471_ROWS.length+' pares pedido/produto validados no Oracle; '+Q471_ORDERS.size+' pedidos únicos. Qtd. SKUs = códigos distintos por período. '+(Q476_FISCAL_VALID?'Tributos dos itens (ICMS/ST/IPI) conciliados com cabeçalho Oracle.':'Tributos dos itens NÃO conciliados; apresentar N/D em recortes por item.');
 }else{
 el.style.background='#fff1d6';
 el.textContent='SKU/Tipologia: consulta de itens não conciliada ou indisponível. Qtd. SKUs aparece como N/D; filtros SKU e Tipologia desativados. Os demais indicadores não serão alterados.';
 }
}
function clientIds(){
 const raw=String(state.focus||'');
 return raw.startsWith('CLI:')?raw.slice(4).split(',').filter(Boolean):[];
}
function clientSelected(){return clientIds().length>0;}
function clientMatches(id){return !clientSelected()||clientIds().includes(String(id));}
function clientLabel(){return clientIds().length===1?'Cliente '+clientIds()[0]:clientIds().length+' clientes selecionados';}

function availableClients(){return Q46_VALID?[...new Set(Q46_ROWS.map(r=>r[8]))].sort((a,b)=>a-b):[];}
function realFiltered(){
 if(skuSelected() || typeSelected() || managerActive() || ufActive() || carteiraActive()){
  if(!Q471_VALID || !isRealPage() || state.profile!=='director')return [];
  const pedidos=new Map();
  for(const r of skuItemsFiltered()){
   let o=pedidos.get(r.id);
   if(!o){o=[r.dia,r.op,1,0,0,0,0,r.rep,r.client,r.sku,r.id];pedidos.set(r.id,o);}
   o[3]+=r.sales;o[6]+=r.discount;if(Q476_FISCAL_VALID){o[4]+=r.st;o[5]+=r.icms;}
  }
  return [...pedidos.values()];
 }
 const client=clientIds();
 if(client.length){
   if(!Q46_VALID || !isRealPage() || state.profile!=='director')return [];
   return Q46_ROWS.filter(r=>(state.rep==='all'||String(r[7])===String(state.rep))&&clientMatches(r[8]));
 }
 if(state.rep==='all')return REAL_Q12;
 if(!Q45_VALID || !isRealPage() || state.profile!=='director')return [];
 return Q45_ROWS.filter(r=>String(r[7])===String(state.rep));
}
function updateClientNotice(){
 const x=document.getElementById('haialaClientV46');if(!x)return;
 let label='CLIENTE DO PEDIDO (CODPARC): ';
 if(Q46_VALID)label+='consulta Oracle conciliada - '+Q46_ROWS.length+' combinações; '+Q46_PEDIDOS+' pedidos. Filtro disponível em seis páginas reais, para homologação com perfil Diretoria.';
 else label+='filtro desativado: consulta Q46 não executada ou divergência nos totais Oracle. Não serão apresentados valores do cliente como se fossem filtrados.';
 if(clientSelected())label+=' Seleção: '+clientLabel()+'; representante '+(state.rep==='all'?'Todos':state.rep)+'.';
 label+=' Acesso por perfil ainda não homologado.';
 x.textContent=label;
 x.style.background=Q46_VALID?'#eff6fb':'#fff1d6';
}
function updateRepNotice(){
 const x=document.getElementById('haialaRepV45');if(!x)return;
 x.textContent=Q45_VALID ? 'REPRESENTANTE DO PEDIDO: filtro Oracle disponível somente nas seis páginas reais. Acesso por perfil ainda NÃO homologado; uso exclusivo em teste. Consulta: '+Q45_ROWS.length+' linhas; '+Q45_COUNT+' pedidos conciliados.'
 : 'REPRESENTANTE DO PEDIDO: filtro real bloqueado - consulta dimensional não conciliada ou indisponível. Indicadores gerais continuam em '+DATA_ORIGIN+'.';
 x.style.background=Q45_VALID?'#eff6fb':'#fff1d6';
}


/* v4.5.1 - Composicao tributaria sempre derivada do mesmo recorte ativo dos KPIs.
   Fonte sem representante: Oracle Q43 validado ou snapshot explicitamente identificado.
   Com representante: somente Oracle Q45 conciliado, perfil visual diretor, paginas reais.
   Filtros nao integrados NAO alteram esses resultados; informado explicitamente. */
/* v6.1.8: grupos extras apenas informativos, sem alteracao de totals ou KPIs. */
function q618InformativeRows(){
 const names=[[3,'INVESTIMENTO'],[4,'PEQ DEFEITOS'],[5,'DEVOLUÇÃO']];
 const fmtCents=x=>money(Math.round((x+Number.EPSILON)*100)/100);
 const unavailable=(msg)=>names.map(([group,label])=>
  '<tr class="tax-group-info"><td colspan="5">'+group+' - '+esc(label)+' | Somente informativo</td></tr>'+
  '<tr><td>'+esc(msg)+'</td><td>N/D</td><td>N/D</td><td>N/D</td><td>N/D</td></tr>').join('');
 if(!Q618_INFO_VALID)return unavailable('Consulta informativa indisponível ou sem classificação válida');
 // Os filtros por item alteram a parcela financeira da operacao. O cabecalho nao permite rateio seguro.
 if(skuSelected()||typeSelected())return unavailable('Filtro SKU/Tipologia não conciliado para os grupos informativos');
 if((managerActive()&&!V477_REP_OK)||(ufActive()&&!V477_UF_OK)||(carteiraActive()&&!CARTEIRA478_VALID))
  return unavailable('Dimensão gerencial, UF ou carteira não conciliada');
 if((state.rep!=='all'||clientSelected())&&(!isRealPage()||state.profile!=='director'))
  return unavailable('Perfil ou dimensão do filtro não disponível para dados informativos');
 const data=Q618_INFO_ROWS.filter(r=>
  (state.period==='all'||Number(r.day.slice(5,7))===Number(state.period))&&
  (state.rep==='all'||r.rep===String(state.rep))&&
  clientMatches(r.client)&&
  (state.manager==='all'||String(V477_REP_MAP.get(r.rep)?.manager||'-1')===String(state.manager))&&
  (state.uf==='all'||String(V477_UF_MAP.get(r.client)||'(SEM UF)')===String(state.uf))&&
  (state.carteira==='all'||String(CARTEIRA478_MAP.get(r.client)||'-1')===String(state.carteira))
 );
 const grouped=new Map();
 for(const r of data){const key=r.group+'|'+r.op;let x=grouped.get(key);
  if(!x){x={...r,qty:0,vlc:0,st:0};grouped.set(key,x)}
  x.qty+=r.qty;x.vlc+=r.vlc;x.st+=r.st;
 }
 return names.map(([group,label])=>{
  const rows=[...grouped.values()].filter(x=>x.group===group).sort((a,b)=>a.op-b.op);
  const title='<tr class="tax-group-info"><td colspan="5">'+group+' - '+esc(label)+' | Somente informativo</td></tr>';
  const subtotal=rows.reduce((acc,r)=>{acc.qty+=r.qty;acc.vlc+=r.vlc;acc.st+=r.st;return acc;},{qty:0,vlc:0,st:0});
  const detail=rows.length?rows.map(r=>'<tr class="tax-info-row tax-top-click" data-tax-top="'+r.op+'" data-tax-group="'+group+'" role="button" tabindex="0" aria-label="Abrir pedidos da TOP '+r.op+'"><td>'+esc(String(r.op)+' - '+r.description)+'</td><td>'+fmt(r.qty)+'</td><td>'+fmtCents(r.vlc)+'</td><td>'+fmtCents(r.st)+'</td><td>'+fmtCents(r.vlc+r.st)+'</td></tr>').join(''):
   '<tr class="tax-info-row"><td>Sem movimentação no período selecionado</td><td>0</td><td>'+fmtCents(0)+'</td><td>'+fmtCents(0)+'</td><td>'+fmtCents(0)+'</td></tr>';
  const total='<tr class="tax-group-total"><td>TOTAL '+esc(label)+'</td><td>'+fmt(subtotal.qty)+'</td><td>'+fmtCents(subtotal.vlc)+'</td><td>'+fmtCents(subtotal.st)+'</td><td>'+fmtCents(subtotal.vlc+subtotal.st)+'</td></tr>';
  return title+detail+total;
 }).join('');
}
function renderTaxComposition(){
 const panel=byId('taxReferencePanel'), content=byId('taxContent'),
       source=byId('taxSourcePill'), scope=byId('taxScope');
 if(!panel||!content||!source||!scope)return;
 const repSelected=state.rep!=='all';
 const clSelected=clientSelected();
 const activeRealPage=isRealPage();
 const repAllowed=(!repSelected || (Q45_VALID&&activeRealPage&&state.profile==='director')) &&
                  (!clSelected || (Q46_VALID&&activeRealPage&&state.profile==='director')) &&
                  (!managerActive() || V477_REP_OK) && (!ufActive() || V477_UF_OK) && (!carteiraActive() || CARTEIRA478_VALID);
 const rows=repAllowed?realFiltered().filter(r=>state.period==='all'||Number(r[0].slice(5,7))===Number(state.period)):[];
 const srcLabel=(!repAllowed)?'NÃO DISPONÍVEL':clSelected?'ORACLE - CLIENTE':repSelected?'ORACLE - REPRESENTANTE':(Q43_CONSISTENTE?'ORACLE':'SNAPSHOT Q12');
 const per=state.period==='all'?'2026 - acumulado até a consulta':String(state.period).padStart(2,'0')+'/2026';
 const recorte=(repSelected?'Representante do pedido '+state.rep:'Todos os representantes')+(clSelected?' | '+clientLabel():' | Todos os clientes');
 source.textContent=srcLabel;
 scope.textContent=recorte+' | '+per+' | Empresa 1';
 const fmtCents=x=>money(Math.round((x+Number.EPSILON)*100)/100);
 // v4.8.5.2: CL-02 tem consulta Oracle real propria. A regra antiga
 // isRealPage() inclui somente AC/VD e bloqueava indevidamente esta secao.
 // Usar Q46 (cabecalho por cliente/dia/TOP/representante), conciliada a Q43.
 if(state.page==='CL-02'){
  if(!clSelected){
   source.textContent='SELECIONE UM CLIENTE';
   content.innerHTML='<p class="tax-notice">Selecione um cliente para visualizar sua composição financeira e tributária real.</p>';
   return;
  }
  if(!Q46_VALID || state.profile!=='director'){
   source.textContent='NÃO DISPONÍVEL';
   content.innerHTML='<p class="tax-notice"><strong>Composição não disponível:</strong> consulta Q46 de pedidos por cliente não conciliada ou perfil de homologação não habilitado. Nenhum valor estimado será exibido.</p>';
   return;
  }
  if(clientIds().length!==1){source.textContent='SELEÇÃO MÚLTIPLA';content.innerHTML='<p class="tax-notice">A Ficha 360º exige um único cliente. Selecione apenas um código no filtro Cliente.</p>';return;}
  const cid=clientIds()[0];
  const cart=state.carteira==='all' || (CARTEIRA478_VALID && CARTEIRA478_MAP.get(cid)===String(state.carteira));
  if(!cart){
   source.textContent='SEM CLIENTE NO RECORTE';
   content.innerHTML='<p class="tax-notice">O cliente selecionado não pertence à carteira atual filtrada. Selecione uma carteira compatível ou todas as carteiras.</p>';
   return;
  }
  if((state.manager!=='all'&&!V477_REP_OK)||(state.uf!=='all'&&!V477_UF_OK)){
   source.textContent='FILTRO NÃO CONCILIADO';
   content.innerHTML='<p class="tax-notice">Gerência ou UF sem cadastro dimensional conciliado. Não serão exibidos valores parciais como completos.</p>';
   return;
  }
  const cliRows=Q46_ROWS.filter(r=>String(r[8])===cid &&
   (state.rep==='all'||String(r[7])===String(state.rep)) &&
   (state.period==='all'||Number(r[0].slice(5,7))===Number(state.period)) &&
   (state.manager==='all'||(V477_REP_MAP.get(String(r[7]))?.manager||'-1')===String(state.manager)) &&
   (state.uf==='all'||(V477_UF_MAP.get(cid)||'(SEM UF)')===String(state.uf)));
  const stats=new Map([[1000,{n:0,v:0,st:0,icms:0,desc:0}],[1001,{n:0,v:0,st:0,icms:0,desc:0}],[1005,{n:0,v:0,st:0,icms:0,desc:0}],[1007,{n:0,v:0,st:0,icms:0,desc:0}],[9000,{n:0,v:0,st:0,icms:0,desc:0}],[9001,{n:0,v:0,st:0,icms:0,desc:0}]]);
  for(const r of cliRows){const o=stats.get(r[1]);if(!o)continue;
   o.n+=r[2];o.v+=r[3];o.st+=r[4];o.icms+=r[5];o.desc+=r[6];}
  const totals={n:0,v:0,st:0,icms:0,desc:0};
  stats.forEach(o=>Object.keys(totals).forEach(k=>totals[k]+=o[k]));
  const it=Q476_FISCAL_VALID?Q471_ROWS.filter(r=>String(r.client)===cid &&
   (state.rep==='all'||String(r.rep)===String(state.rep)) &&
   (state.period==='all'||Number(r.dia.slice(5,7))===Number(state.period)) &&
   (state.manager==='all'||(V477_REP_MAP.get(String(r.rep))?.manager||'-1')===String(state.manager)) &&
   (state.uf==='all'||(V477_UF_MAP.get(cid)||'(SEM UF)')===String(state.uf))):null;
  // IPI so e exibido quando a fonte de itens tambem esta conciliada
  // e o subtotal de vendas coincide com os pedidos do mesmo cliente.
  const ipiOk=it && Math.abs(Math.round(it.reduce((a,r)=>a+r.sales,0)*100)-Math.round(totals.v*100))<=2;
  const ipi=ipiOk?it.reduce((a,r)=>a+r.ipi,0):null;
  source.textContent='ORACLE - CLIENTE (Q46)';
  scope.textContent='Cliente '+cid+' | '+(state.rep==='all'?'Todos os representantes':'Representante da venda '+state.rep)+' | '+
    (state.carteira==='all'?'Todas as carteiras':'Carteira atual '+state.carteira)+' | '+per+' | Empresa 1';
  const metric=(label,value)=>'<div class="tax-metric"><span>'+label+'</span><strong>'+value+'</strong></div>';
  content.innerHTML='<div class="tax-grid">'+
   metric('Vendas sem ST',fmtCents(totals.v))+
   metric('Pedidos distintos',fmt(Math.round(totals.n)))+
   metric('ICMS informativo',fmtCents(totals.icms))+
   metric('Substituição tributária (ST)',fmtCents(totals.st))+
   metric('IPI informativo',ipiOk?fmtCents(ipi):'N/D - itens não conciliados neste recorte')+
   metric('Descontos dos itens (Q46)',fmtCents(totals.desc))+
   metric('Vendas + ST',fmtCents(totals.v+totals.st))+
   metric('Ticket médio',totals.n?fmtCents(totals.v/totals.n):'-')+'</div>'+
   '<table aria-label="Composição financeira por operação do cliente"><thead><tr><th>TOP</th><th>Pedidos</th><th>Vendas</th><th>ICMS</th><th>ST</th><th>Vendas + ST</th></tr></thead><tbody>'+
   [1000,1001,1005,1007,9000,9001].map(op=>{const o=stats.get(op);return '<tr><td>'+op+'</td><td>'+fmt(o.n)+'</td><td>'+fmtCents(o.v)+'</td><td>'+fmtCents(o.icms)+'</td><td>'+fmtCents(o.st)+'</td><td>'+fmtCents(o.v+o.st)+'</td></tr>'}).join('')+'</tbody></table>'+
   '<p class="tax-notice"><strong>Fonte: TGFCAB - consulta Q46 conciliada com Q43.</strong> Empresa 1, pedidos TOP 1000,1001,1005,1007,9000,9001, situação A/P/L, data de negociação (DTNEG). Valores por cliente e filtros selecionados. ICMS informativo; ST em separado, sem dedução adicional das vendas. IPI depende de itens conciliados. Não inclui devoluções. Acesso por usuário ainda não homologado.</p>';
  return;
 }
 if(!repAllowed){
  content.innerHTML='<p class="tax-notice"><strong>Composição indisponível:</strong> seleção de representante e/ou cliente exige consulta Oracle dimensional conciliada, perfil de homologação Diretoria e página com dados reais. Nenhum valor histórico será mostrado como se fosse filtrado.</p>';
  return;
 }
 if(fiscalFilterActive()){
  source.textContent=Q476_FISCAL_VALID?'ORACLE - TRIBUTOS DOS ITENS':'ORACLE - VENDAS / TRIBUTOS N/D';
  scope.textContent=(managerActive()?'Gerência '+labelManager(state.manager)+' | ':'')+(ufActive()?'UF '+state.uf+' | ':'')+(carteiraActive()?'Carteira atual '+carteiraName(state.carteira)+' | ':'')+(typeSelected()?'Tipologia '+rotuloTipologia(state.type)+' | ':'')+(skuSelected()?'SKU '+rotuloSKU(state.sku)+' | ':'')+per+' | Empresa 1';
  const skuRows=skuItemsFiltered();
  const vendas=skuRows.reduce((a,r)=>a+r.sales,0);
  const descontos=skuRows.reduce((a,r)=>a+r.discount,0);
  const distintos=new Set(skuRows.map(r=>r.id)).size;
  const fisc=fiscalRecorte();
  const f=x=>fisc?fmtCents(fisc[x]):'N/D - não conciliado';
  const total=fisc?fmtCents(vendas+fisc.st):'N/D';
  const byTop=new Map([[1000,{n:new Set(),v:0,st:0,icms:0,ipi:0}],[1001,{n:new Set(),v:0,st:0,icms:0,ipi:0}],[1005,{n:new Set(),v:0,st:0,icms:0,ipi:0}],[1007,{n:new Set(),v:0,st:0,icms:0,ipi:0}],[9000,{n:new Set(),v:0,st:0,icms:0,ipi:0}],[9001,{n:new Set(),v:0,st:0,icms:0,ipi:0}]]);
  skuRows.forEach(r=>{let x=byTop.get(r.op);if(x){x.n.add(r.id);x.v+=r.sales;if(fisc){x.st+=r.st;x.icms+=r.icms;x.ipi+=r.ipi}}});
  const topRows=[1000,1001,1005,1007,9000,9001].map(code=>{
   const x=byTop.get(code);
   return '<tr><td>'+code+'</td><td>'+fmt(x.n.size)+'</td><td>'+fmtCents(x.v)+'</td><td>'+(fisc?fmtCents(x.icms):'N/D')+'</td><td>'+(fisc?fmtCents(x.st):'N/D')+'</td><td>'+(fisc?fmtCents(x.ipi):'N/D')+'</td></tr>';
  }).join('');
  content.innerHTML='<div class="tax-grid">'+
   '<div class="tax-metric"><span>Vendas dos itens</span><strong>'+fmtCents(vendas)+'</strong></div>'+
   '<div class="tax-metric"><span>Pedidos distintos</span><strong>'+fmt(distintos)+'</strong></div>'+
   '<div class="tax-metric"><span>Qtd. SKUs distintos</span><strong>'+fmt(new Set(skuRows.map(r=>r.sku)).size)+'</strong></div>'+
   '<div class="tax-metric"><span>ICMS dos itens</span><strong>'+f('icms')+'</strong></div>'+
   '<div class="tax-metric"><span>ST dos itens</span><strong>'+f('st')+'</strong></div>'+
   '<div class="tax-metric"><span>IPI dos itens</span><strong>'+f('ipi')+'</strong></div>'+
   '<div class="tax-metric"><span>Descontos dos itens</span><strong>'+fmtCents(descontos)+'</strong></div>'+
   '<div class="tax-metric"><span>Vendas + ST dos itens</span><strong>'+total+'</strong></div></div>'+
   '<table aria-label="Composição fiscal dos itens por operação"><thead><tr><td>TOP</td><td>Pedidos</td><td>Vendas</td><td>ICMS</td><td>ST</td><td>IPI</td></tr></thead><tbody>'+topRows+'</tbody></table>'+
   '<p class="tax-notice"><strong>Fonte: TGFITE - valores registrados nos itens.</strong> '+(fisc?'ICMS e ST conciliados com o cabeçalho no mesmo universo Oracle.':'A conciliação fiscal não passou; valores fiscais indisponíveis.')+' ICMS e IPI são informativos e não são deduzidos novamente das Vendas; ST está separada. Devoluções permanecem fora deste recorte. Permissões por perfil ainda não homologadas.</p>';
  return;
 }

 const byOp=new Map([[1000,{n:0,vlc:0,st:0,icms:0,disc:0}],[1001,{n:0,vlc:0,st:0,icms:0,disc:0}],[1005,{n:0,vlc:0,st:0,icms:0,disc:0}],[1007,{n:0,vlc:0,st:0,icms:0,disc:0}],[9000,{n:0,vlc:0,st:0,icms:0,disc:0}],[9001,{n:0,vlc:0,st:0,icms:0,disc:0}]]);
 for(const row of rows){
  const op=byOp.get(row[1]);if(!op)continue;
  op.n+=row[2];op.vlc+=row[3];op.st+=row[4];op.icms+=row[5];op.disc+=row[6];
 }
 const sumKey=k=>[...byOp.values()].reduce((t,x)=>t+x[k],0);
 const vlc=sumKey('vlc'),st=sumKey('st'),icms=sumKey('icms'),desc=sumKey('disc'),ped=sumKey('n');
 const topDesc={1000:'Pedido de Venda',1001:'Pedido de Venda LANDIX',1005:'Pedido de Venda - Exportação',1007:'Pedido de Venda - Cheque Moradia',9000:'Pedido de Venda Z3',9001:'Pedido de Venda Z3 - LANDIX'};
 const topTable='<tr class="tax-group-info"><td colspan="5">1 - PEDIDOS</td></tr>'+[1000,1001,1005,1007,9000,9001].map(code=>{
  const o=byOp.get(code);
  return '<tr class="tax-top-click" data-tax-top="'+code+'" data-tax-group="1" role="button" tabindex="0" aria-label="Abrir pedidos da TOP '+code+'"><td>'+code+' - '+topDesc[code]+'</td><td>'+fmt(o.n)+'</td><td>'+fmtCents(o.vlc)+'</td><td>'+fmtCents(o.st)+'</td><td>'+fmtCents(o.vlc+o.st)+'</td></tr>';
 }).join('')+
 '<tr class="tax-group-total"><td>TOTAL PEDIDOS</td><td>'+fmt(ped)+'</td><td>'+fmtCents(vlc)+'</td><td>'+fmtCents(st)+'</td><td>'+fmtCents(vlc+st)+'</td></tr>';
 const extra=(!activeRealPage?'Esta página ainda usa indicadores sintéticos. A composição considera somente o recorte Oracle disponível, não os gráficos demonstrativos. ':'')
  ''
  +'ICMS é apenas informativo e não deve ser abatido novamente das vendas. Metas e devoluções não integram esta composição.';
 const provenance=Q43_CONSISTENTE?'Consulta Oracle no carregamento do componente.':'Snapshot histórico Q12, sem atualização automática.';
 content.innerHTML=
  '<div class="tax-grid">'+
   '<div class="tax-metric"><span>Vendas sem ST</span><strong>'+fmtCents(vlc)+'</strong></div>'+
   '<div class="tax-metric"><span>Substituição tributária (ST)</span><strong>'+fmtCents(st)+'</strong></div>'+
   '<div class="tax-metric"><span>Total dos pedidos com ST</span><strong>'+fmtCents(vlc+st)+'</strong></div>'+
   '<div class="tax-metric"><span>Pedidos distintos no recorte</span><strong>'+fmt(ped)+'</strong></div>'+
   '<div class="tax-metric"><span>ICMS informativo</span><strong>'+fmtCents(icms)+'</strong></div>'+
   '<div class="tax-metric"><span>Descontos dos itens</span><strong>'+fmtCents(desc)+'</strong></div>'+
  '</div>'+
  '<table aria-label="Composição tributária por operação filtrada"><thead><tr><td>Operação</td><td>Pedidos</td><td>Vendas</td><td>ST</td><td>Total com ST</td></tr></thead><tbody>'+topTable+q618InformativeRows()+'</tbody></table>'+
  '<p class="tax-notice"><strong>Fonte: '+srcLabel+'.</strong> '+provenance+' '+extra+' Os grupos INVESTIMENTO, PEQ DEFEITOS e DEVOLUÇÃO são exclusivamente informativos e não integram totais de PEDIDOS, KPIs, MC ou outras apurações. Os valores são exibidos pelo cabeçalho da operação e não representam contabilização adicional. O cálculo de vendas ainda está em homologação quanto à elegibilidade e alterações históricas.</p>';
 const taxTable=content.querySelector('table[aria-label="Composição tributária por operação filtrada"]');
 if(taxTable){
  const openTOP=tr=>abrirPedidosPorTOP(Number(tr.dataset.taxTop),Number(tr.dataset.taxGroup));
  taxTable.addEventListener('click',ev=>{const tr=ev.target.closest('tr[data-tax-top]');if(tr&&taxTable.contains(tr))openTOP(tr)});
  taxTable.addEventListener('keydown',ev=>{if(ev.key!=='Enter'&&ev.key!==' ')return;
   const tr=ev.target.closest('tr[data-tax-top]');if(tr&&taxTable.contains(tr)){ev.preventDefault();openTOP(tr)}});
 }

}

function atualizarOrigem(){
 const box=document.getElementById('haialaOriginV43');if(!box)return;
 let texto='';
 if(Q43_CONSISTENTE){box.style.background='#e8f5eb';box.style.borderColor='#b4d8bd';
 texto='FONTE ATIVA: ORACLE - '+Q43_ROWS.length+' registros diários; '+Q43_PEDIDOS+' pedidos. Período: 2026 até hoje. Atualiza ao abrir/recarregar o componente.';}
 else{box.style.background='#fff1d6';box.style.borderColor='#edce86';
 const motivo=Q43_ATTEMPTED?('Consulta recebida, mas nao validada ('+Q43_ROWS.length+' linhas, '+Q43_PEDIDOS+' pedidos).'):
 'Consulta Q43 nao executada ou apresentou erro.';
 texto='FONTE ATIVA: SNAPSHOT Q12 - '+motivo+' Os KPIs usam a extração fixa jan-out/2026, NÃO o Oracle.';}
 box.textContent=texto;
}
atualizarOrigem();
function renderQ12(){
 const host=byId('q12Real');if(!host)return;
 if(!['AC-01','AC-02','AC-03','AC-04','VD-01','VD-03'].includes(state.page)){host.style.display='none';return}
 host.style.display='none';
 const all=realFiltered().filter(r=>state.period==='all'||Number(r[0].slice(5,7))===Number(state.period));
 const month={};const days={};let v=0,ped=0,st=0,icms=0,disc=0;
 all.forEach(r=>{const m=r[0].slice(0,7);(month[m]??={n:0,v:0,st:0,icms:0,disc:0});(days[r[0]]??={n:0,v:0,st:0,icms:0,disc:0});for(const x of [month[m],days[r[0]]]){x.n+=r[2];x.v+=r[3];x.st+=r[4];x.icms+=r[5];x.disc+=r[6]};ped+=r[2];v+=r[3];st+=r[4];icms+=r[5];disc+=r[6]});
 const r2=n=>Math.round((n+Number.EPSILON)*100)/100;const per=state.period==='all'?'2026 - até a data da consulta':String(state.period).padStart(2,'0')+'/2026';
 const list=state.page==='AC-01'?Object.entries(days).slice(-25).reverse():Object.entries(month);
 const table=list.map(([k,x])=>`<tr><td>\${esc(k)}</td><td style="text-align:right">\${fmt(x.n)}</td><td style="text-align:right">\${money(r2(x.v))}</td><td style="text-align:right">\${money(r2(x.st))}</td><td style="text-align:right">\${money(r2(x.icms))}</td></tr>`).join('');
 host.innerHTML=`<div class="q12-head"><strong>DADOS COMERCIAIS - \${per}</strong><small>\${esc(origemRecorte().linha)}</small></div><div class="q12-values"><div><small>Vendas</small><strong>\${money(r2(v))}</strong></div><div><small>Pedidos distintos no recorte</small><strong>\${fmt(ped)}</strong></div><div><small>Ticket candidato</small><strong>\${ped?money(r2(v/ped)):' - '}</strong></div><div><small>ST informativa</small><strong>\${money(r2(st))}</strong></div></div><details><summary>Detalhamento real por \${state.page==='AC-01'?'dia (últimos 25 dias)':'mês'} - ICMS e ST</summary><div class="q12-scroll"><table><thead><tr><th>Período</th><th>Pedidos</th><th>Vendas</th><th>ST</th><th>ICMS</th></tr></thead><tbody>\${table}</tbody></table></div></details><p class="q12-disclaimer">Dados reais apenas neste bloco e na composição tributária. Os indicadores, gráficos e tabelas das demais seções continuam <strong>sintéticos</strong>. Filtros de perfil, gerência, representante, UF e tipologia <strong>não se aplicam</strong> a esta extração agregada; apenas o filtro de mês é aplicado. Semana ISO e dia corrente exigem extração contextual para uso operacional.</p>`;
}
const DB={"modules":[{"id":"AC","name":"Acompanhamento","pages":[{"id":"AC-01","name":"Resumo Diário","description":"Vendas e pedidos por dia","kind":"day","codes":"VEN-03, VEN-04, MET-05, DER-08"},{"id":"AC-02","name":"Resumo Semanal","description":"Vendas e dias comerciais por semana","kind":"week","codes":"VEN-03, DER-01, DER-08"},{"id":"AC-03","name":"Resumo Mensal","description":"Resultado, meta e composição mensal","kind":"month","codes":"VEN-03, CLI-07, MET-01, MET-05"},{"id":"AC-04","name":"Resumo Anual","description":"Evolução e projeção anual","kind":"year","codes":"VEN-03, DER-04, DER-06"},{"id":"AC-05","name":"Metas Comerciais","description":"Atingimento por responsável e tipologia","kind":"goals","codes":"MET-01 a MET-06"}]},{"id":"VD","name":"Vendas","pages":[{"id":"VD-01","name":"Análise de Vendas","description":"Vendas, pedidos, ticket e tipologias","kind":"sales","codes":"VEN-01 a VEN-06"},{"id":"VD-02","name":"Pedidos de Venda","description":"Pedidos válidos e itens","kind":"orders","codes":"VEN-03, VEN-04"},{"id":"VD-03","name":"Evolução de Vendas","description":"Série temporal e comparação","kind":"trend","codes":"VEN-03, DER-01, DER-04"},{"id":"VD-04","name":"Inteligência Comercial","description":"Concentração, lacunas e oportunidades","kind":"intelligence","codes":"DER-05, PN-05, PN-06"},{"id":"VD-05","name":"Consultas","description":"Consulta dinâmica e agrupamentos","kind":"query","codes":"VEN, CLI, PRO, REP, GEO"}]},{"id":"CL","name":"Clientes","pages":[{"id":"CL-01","name":"Visão Geral da Carteira","description":"Elegíveis, atendidos e cobertura","kind":"portfolio","codes":"CLI-01 a CLI-08"},{"id":"CL-02","name":"Ficha 360º do Cliente","description":"Histórico de compras e cadastro","kind":"client360","codes":"CLI, VEN, DER-02, DER-03"},{"id":"CL-03","name":"Comportamento","description":"Recorrência e frequência de compra","kind":"behavior","codes":"CLI, DER-02, DER-04"},{"id":"CL-04","name":"Oportunidades e Recuperação","description":"Clientes inativos e oportunidades","kind":"recovery","codes":"CLI-05, DER-03, DER-09"}]},{"id":"PD","name":"Produtos","pages":[{"id":"PD-01","name":"Visão Geral","description":"SKUs comerciais e cobertura de mix","kind":"products","codes":"PRO-01 a PRO-06, DER-07"},{"id":"PD-02","name":"Análise por Tipologia","description":"Portfólio e contribuição por tipologia","kind":"typology","codes":"PRO-02, PRO-05"},{"id":"PD-03","name":"Ficha 360º do Produto","description":"Histórico e clientes do SKU","kind":"sku360","codes":"PRO, VEN, DER-01"},{"id":"PD-04","name":"Inteligência de Produtos","description":"Curva ABC e baixa penetração","kind":"productIntel","codes":"PRO-05, DER-05, DER-07"}]},{"id":"RP","name":"Representantes","pages":[{"id":"RP-01","name":"Visão Geral","description":"Equipe, ranking e produtividade","kind":"reps","codes":"REP-01 a REP-05"},{"id":"RP-02","name":"Ficha 360º do Representante","description":"Vendas e carteira individual","kind":"rep360","codes":"REP, MET, CLI"},{"id":"RP-03","name":"Metas e Desempenho","description":"Atingimento por representante","kind":"repgoals","codes":"REP-02, MET"},{"id":"RP-04","name":"Carteira, Cobertura e Oportunidades","description":"Cobertura e recuperação por representante","kind":"repportfolio","codes":"REP-03, REP-04, CLI"}]},{"id":"GM","name":"Geomarketing","pages":[{"id":"GM-01","name":"Visão Geral Geográfica","description":"Vendas, clientes, UFs e municípios","kind":"geo","codes":"GEO-01 a GEO-05"},{"id":"GM-02","name":"Mapas de Vendas e Clientes","description":"Distribuição por UF e cidade","kind":"map","codes":"GEO-01, GEO-02, GEO-D01"},{"id":"GM-03","name":"Desempenho Regional","description":"Crescimento e participação regional","kind":"region","codes":"GEO-D02, GEO-D03"},{"id":"GM-04","name":"Cobertura e Expansão","description":"Municípios com e sem vendas","kind":"expansion","codes":"GEO-05, GEO-D01"}]}],"reps":[{"id":"R01","name":"Ana Lima","manager":"Norte"},{"id":"R02","name":"Bruno Rocha","manager":"Norte"},{"id":"R03","name":"Camila Alves","manager":"Norte"},{"id":"R04","name":"Daniel Costa","manager":"Centro"},{"id":"R05","name":"Elisa Souza","manager":"Centro"},{"id":"R06","name":"Fábio Pereira","manager":"Centro"},{"id":"R07","name":"Gabriela Martins","manager":"Sul"},{"id":"R08","name":"Henrique Dias","manager":"Sul"},{"id":"R09","name":"Isabela Moraes","manager":"Sul"}],"clients":[{"id":"C001","name":"Cliente Comercial 001","rep":"R06","uf":"MT","city":"Rondonópolis","eligible":true,"active":true},{"id":"C002","name":"Cliente Comercial 002","rep":"R02","uf":"MG","city":"Belo Horizonte","eligible":true,"active":true},{"id":"C003","name":"Cliente Comercial 003","rep":"R07","uf":"GO","city":"Goiânia","eligible":true,"active":true},{"id":"C004","name":"Cliente Comercial 004","rep":"R03","uf":"MS","city":"Campo Grande","eligible":true,"active":true},{"id":"C005","name":"Cliente Comercial 005","rep":"R08","uf":"SP","city":"Campinas","eligible":true,"active":true},{"id":"C006","name":"Cliente Comercial 006","rep":"R04","uf":"GO","city":"Jataí","eligible":true,"active":true},{"id":"C007","name":"Cliente Comercial 007","rep":"R09","uf":"PR","city":"Londrina","eligible":true,"active":true},{"id":"C008","name":"Cliente Comercial 008","rep":"R05","uf":"SP","city":"Ribeirão Preto","eligible":true,"active":true},{"id":"C009","name":"Cliente Comercial 009","rep":"R01","uf":"MG","city":"Uberlândia","eligible":true,"active":true},{"id":"C010","name":"Cliente Comercial 010","rep":"R06","uf":"GO","city":"Rio Verde","eligible":true,"active":true},{"id":"C011","name":"Cliente Comercial 011","rep":"R02","uf":"MT","city":"Rondonópolis","eligible":false,"active":true},{"id":"C012","name":"Cliente Comercial 012","rep":"R07","uf":"MG","city":"Belo Horizonte","eligible":true,"active":true},{"id":"C013","name":"Cliente Comercial 013","rep":"R03","uf":"GO","city":"Goiânia","eligible":true,"active":false},{"id":"C014","name":"Cliente Comercial 014","rep":"R08","uf":"MS","city":"Campo Grande","eligible":true,"active":true},{"id":"C015","name":"Cliente Comercial 015","rep":"R04","uf":"SP","city":"Campinas","eligible":true,"active":true},{"id":"C016","name":"Cliente Comercial 016","rep":"R09","uf":"GO","city":"Jataí","eligible":true,"active":true},{"id":"C017","name":"Cliente Comercial 017","rep":"R05","uf":"PR","city":"Londrina","eligible":true,"active":true},{"id":"C018","name":"Cliente Comercial 018","rep":"R01","uf":"SP","city":"Ribeirão Preto","eligible":true,"active":true},{"id":"C019","name":"Cliente Comercial 019","rep":"R06","uf":"MG","city":"Uberlândia","eligible":true,"active":true},{"id":"C020","name":"Cliente Comercial 020","rep":"R02","uf":"GO","city":"Rio Verde","eligible":true,"active":true},{"id":"C021","name":"Cliente Comercial 021","rep":"R07","uf":"MT","city":"Rondonópolis","eligible":true,"active":true},{"id":"C022","name":"Cliente Comercial 022","rep":"R03","uf":"MG","city":"Belo Horizonte","eligible":false,"active":true},{"id":"C023","name":"Cliente Comercial 023","rep":"R08","uf":"GO","city":"Goiânia","eligible":true,"active":true},{"id":"C024","name":"Cliente Comercial 024","rep":"R04","uf":"MS","city":"Campo Grande","eligible":true,"active":true},{"id":"C025","name":"Cliente Comercial 025","rep":"R09","uf":"SP","city":"Campinas","eligible":true,"active":true},{"id":"C026","name":"Cliente Comercial 026","rep":"R05","uf":"GO","city":"Jataí","eligible":true,"active":false},{"id":"C027","name":"Cliente Comercial 027","rep":"R01","uf":"PR","city":"Londrina","eligible":true,"active":true},{"id":"C028","name":"Cliente Comercial 028","rep":"R06","uf":"SP","city":"Ribeirão Preto","eligible":true,"active":true},{"id":"C029","name":"Cliente Comercial 029","rep":"R02","uf":"MG","city":"Uberlândia","eligible":true,"active":true},{"id":"C030","name":"Cliente Comercial 030","rep":"R07","uf":"GO","city":"Rio Verde","eligible":true,"active":true},{"id":"C031","name":"Cliente Comercial 031","rep":"R03","uf":"MT","city":"Rondonópolis","eligible":true,"active":true},{"id":"C032","name":"Cliente Comercial 032","rep":"R08","uf":"MG","city":"Belo Horizonte","eligible":true,"active":true},{"id":"C033","name":"Cliente Comercial 033","rep":"R04","uf":"GO","city":"Goiânia","eligible":false,"active":true},{"id":"C034","name":"Cliente Comercial 034","rep":"R09","uf":"MS","city":"Campo Grande","eligible":true,"active":true},{"id":"C035","name":"Cliente Comercial 035","rep":"R05","uf":"SP","city":"Campinas","eligible":true,"active":true},{"id":"C036","name":"Cliente Comercial 036","rep":"R01","uf":"GO","city":"Jataí","eligible":true,"active":true},{"id":"C037","name":"Cliente Comercial 037","rep":"R06","uf":"PR","city":"Londrina","eligible":true,"active":true},{"id":"C038","name":"Cliente Comercial 038","rep":"R02","uf":"SP","city":"Ribeirão Preto","eligible":true,"active":true},{"id":"C039","name":"Cliente Comercial 039","rep":"R07","uf":"MG","city":"Uberlândia","eligible":true,"active":false},{"id":"C040","name":"Cliente Comercial 040","rep":"R03","uf":"GO","city":"Rio Verde","eligible":true,"active":true},{"id":"C041","name":"Cliente Comercial 041","rep":"R08","uf":"MT","city":"Rondonópolis","eligible":true,"active":true},{"id":"C042","name":"Cliente Comercial 042","rep":"R04","uf":"MG","city":"Belo Horizonte","eligible":true,"active":true},{"id":"C043","name":"Cliente Comercial 043","rep":"R09","uf":"GO","city":"Goiânia","eligible":true,"active":true},{"id":"C044","name":"Cliente Comercial 044","rep":"R05","uf":"MS","city":"Campo Grande","eligible":false,"active":true},{"id":"C045","name":"Cliente Comercial 045","rep":"R01","uf":"SP","city":"Campinas","eligible":true,"active":true},{"id":"C046","name":"Cliente Comercial 046","rep":"R06","uf":"GO","city":"Jataí","eligible":true,"active":true},{"id":"C047","name":"Cliente Comercial 047","rep":"R02","uf":"PR","city":"Londrina","eligible":true,"active":true},{"id":"C048","name":"Cliente Comercial 048","rep":"R07","uf":"SP","city":"Ribeirão Preto","eligible":true,"active":true},{"id":"C049","name":"Cliente Comercial 049","rep":"R03","uf":"MG","city":"Uberlândia","eligible":true,"active":true},{"id":"C050","name":"Cliente Comercial 050","rep":"R08","uf":"GO","city":"Rio Verde","eligible":true,"active":true},{"id":"C051","name":"Cliente Comercial 051","rep":"R04","uf":"MT","city":"Rondonópolis","eligible":true,"active":true},{"id":"C052","name":"Cliente Comercial 052","rep":"R09","uf":"MG","city":"Belo Horizonte","eligible":true,"active":false},{"id":"C053","name":"Cliente Comercial 053","rep":"R05","uf":"GO","city":"Goiânia","eligible":true,"active":true},{"id":"C054","name":"Cliente Comercial 054","rep":"R01","uf":"MS","city":"Campo Grande","eligible":true,"active":true},{"id":"C055","name":"Cliente Comercial 055","rep":"R06","uf":"SP","city":"Campinas","eligible":false,"active":true},{"id":"C056","name":"Cliente Comercial 056","rep":"R02","uf":"GO","city":"Jataí","eligible":true,"active":true},{"id":"C057","name":"Cliente Comercial 057","rep":"R07","uf":"PR","city":"Londrina","eligible":true,"active":true},{"id":"C058","name":"Cliente Comercial 058","rep":"R03","uf":"SP","city":"Ribeirão Preto","eligible":true,"active":true},{"id":"C059","name":"Cliente Comercial 059","rep":"R08","uf":"MG","city":"Uberlândia","eligible":true,"active":true},{"id":"C060","name":"Cliente Comercial 060","rep":"R04","uf":"GO","city":"Rio Verde","eligible":true,"active":true},{"id":"C061","name":"Cliente Comercial 061","rep":"R09","uf":"MT","city":"Rondonópolis","eligible":true,"active":true},{"id":"C062","name":"Cliente Comercial 062","rep":"R05","uf":"MG","city":"Belo Horizonte","eligible":true,"active":true},{"id":"C063","name":"Cliente Comercial 063","rep":"R01","uf":"GO","city":"Goiânia","eligible":true,"active":true},{"id":"C064","name":"Cliente Comercial 064","rep":"R06","uf":"MS","city":"Campo Grande","eligible":true,"active":true},{"id":"C065","name":"Cliente Comercial 065","rep":"R02","uf":"SP","city":"Campinas","eligible":true,"active":false},{"id":"C066","name":"Cliente Comercial 066","rep":"R07","uf":"GO","city":"Jataí","eligible":false,"active":true},{"id":"C067","name":"Cliente Comercial 067","rep":"R03","uf":"PR","city":"Londrina","eligible":true,"active":true},{"id":"C068","name":"Cliente Comercial 068","rep":"R08","uf":"SP","city":"Ribeirão Preto","eligible":true,"active":true},{"id":"C069","name":"Cliente Comercial 069","rep":"R04","uf":"MG","city":"Uberlândia","eligible":true,"active":true},{"id":"C070","name":"Cliente Comercial 070","rep":"R09","uf":"GO","city":"Rio Verde","eligible":true,"active":true},{"id":"C071","name":"Cliente Comercial 071","rep":"R05","uf":"MT","city":"Rondonópolis","eligible":true,"active":true},{"id":"C072","name":"Cliente Comercial 072","rep":"R01","uf":"MG","city":"Belo Horizonte","eligible":true,"active":true}],"products":[{"id":"SKU0001","name":"Janelas Modelo 001","type":"Janelas","unit":"UN","active":true},{"id":"SKU0002","name":"Maxim-ar Modelo 002","type":"Maxim-ar","unit":"UN","active":true},{"id":"SKU0003","name":"Portões Modelo 003","type":"Portões","unit":"UN","active":true},{"id":"SKU0004","name":"Acessórios Modelo 004","type":"Acessórios","unit":"UN","active":true},{"id":"SKU0005","name":"Portas Modelo 005","type":"Portas","unit":"UN","active":true},{"id":"SKU0006","name":"Janelas Modelo 006","type":"Janelas","unit":"UN","active":true},{"id":"SKU0007","name":"Maxim-ar Modelo 007","type":"Maxim-ar","unit":"UN","active":true},{"id":"SKU0008","name":"Portões Modelo 008","type":"Portões","unit":"UN","active":true},{"id":"SKU0009","name":"Acessórios Modelo 009","type":"Acessórios","unit":"UN","active":true},{"id":"SKU0010","name":"Portas Modelo 010","type":"Portas","unit":"UN","active":true},{"id":"SKU0011","name":"Janelas Modelo 011","type":"Janelas","unit":"UN","active":true},{"id":"SKU0012","name":"Maxim-ar Modelo 012","type":"Maxim-ar","unit":"UN","active":true},{"id":"SKU0013","name":"Portões Modelo 013","type":"Portões","unit":"UN","active":true},{"id":"SKU0014","name":"Acessórios Modelo 014","type":"Acessórios","unit":"UN","active":true},{"id":"SKU0015","name":"Portas Modelo 015","type":"Portas","unit":"UN","active":true},{"id":"SKU0016","name":"Janelas Modelo 016","type":"Janelas","unit":"UN","active":true},{"id":"SKU0017","name":"Maxim-ar Modelo 017","type":"Maxim-ar","unit":"UN","active":true},{"id":"SKU0018","name":"Portões Modelo 018","type":"Portões","unit":"UN","active":true},{"id":"SKU0019","name":"Acessórios Modelo 019","type":"Acessórios","unit":"UN","active":false},{"id":"SKU0020","name":"Portas Modelo 020","type":"Portas","unit":"UN","active":true},{"id":"SKU0021","name":"Janelas Modelo 021","type":"Janelas","unit":"UN","active":true},{"id":"SKU0022","name":"Maxim-ar Modelo 022","type":"Maxim-ar","unit":"UN","active":true},{"id":"SKU0023","name":"Portões Modelo 023","type":"Portões","unit":"UN","active":true},{"id":"SKU0024","name":"Acessórios Modelo 024","type":"Acessórios","unit":"UN","active":true},{"id":"SKU0025","name":"Portas Modelo 025","type":"Portas","unit":"UN","active":true},{"id":"SKU0026","name":"Janelas Modelo 026","type":"Janelas","unit":"UN","active":true},{"id":"SKU0027","name":"Maxim-ar Modelo 027","type":"Maxim-ar","unit":"UN","active":true},{"id":"SKU0028","name":"Portões Modelo 028","type":"Portões","unit":"UN","active":true},{"id":"SKU0029","name":"Acessórios Modelo 029","type":"Acessórios","unit":"UN","active":true},{"id":"SKU0030","name":"Portas Modelo 030","type":"Portas","unit":"UN","active":true},{"id":"SKU0031","name":"Janelas Modelo 031","type":"Janelas","unit":"UN","active":true},{"id":"SKU0032","name":"Maxim-ar Modelo 032","type":"Maxim-ar","unit":"UN","active":true},{"id":"SKU0033","name":"Portões Modelo 033","type":"Portões","unit":"UN","active":true},{"id":"SKU0034","name":"Acessórios Modelo 034","type":"Acessórios","unit":"UN","active":true},{"id":"SKU0035","name":"Portas Modelo 035","type":"Portas","unit":"UN","active":true},{"id":"SKU0036","name":"Janelas Modelo 036","type":"Janelas","unit":"UN","active":true},{"id":"SKU0037","name":"Maxim-ar Modelo 037","type":"Maxim-ar","unit":"UN","active":true},{"id":"SKU0038","name":"Portões Modelo 038","type":"Portões","unit":"UN","active":false},{"id":"SKU0039","name":"Acessórios Modelo 039","type":"Acessórios","unit":"UN","active":true},{"id":"SKU0040","name":"Portas Modelo 040","type":"Portas","unit":"UN","active":true},{"id":"SKU0041","name":"Janelas Modelo 041","type":"Janelas","unit":"UN","active":true},{"id":"SKU0042","name":"Maxim-ar Modelo 042","type":"Maxim-ar","unit":"UN","active":true},{"id":"SKU0043","name":"Portões Modelo 043","type":"Portões","unit":"UN","active":true},{"id":"SKU0044","name":"Acessórios Modelo 044","type":"Acessórios","unit":"UN","active":true},{"id":"SKU0045","name":"Portas Modelo 045","type":"Portas","unit":"UN","active":true},{"id":"SKU0046","name":"Janelas Modelo 046","type":"Janelas","unit":"UN","active":true},{"id":"SKU0047","name":"Maxim-ar Modelo 047","type":"Maxim-ar","unit":"UN","active":true},{"id":"SKU0048","name":"Portões Modelo 048","type":"Portões","unit":"UN","active":true},{"id":"SKU0049","name":"Acessórios Modelo 049","type":"Acessórios","unit":"UN","active":true},{"id":"SKU0050","name":"Portas Modelo 050","type":"Portas","unit":"UN","active":true},{"id":"SKU0051","name":"Janelas Modelo 051","type":"Janelas","unit":"UN","active":true},{"id":"SKU0052","name":"Maxim-ar Modelo 052","type":"Maxim-ar","unit":"UN","active":true},{"id":"SKU0053","name":"Portões Modelo 053","type":"Portões","unit":"UN","active":true},{"id":"SKU0054","name":"Acessórios Modelo 054","type":"Acessórios","unit":"UN","active":true},{"id":"SKU0055","name":"Portas Modelo 055","type":"Portas","unit":"UN","active":true},{"id":"SKU0056","name":"Janelas Modelo 056","type":"Janelas","unit":"UN","active":true},{"id":"SKU0057","name":"Maxim-ar Modelo 057","type":"Maxim-ar","unit":"UN","active":false},{"id":"SKU0058","name":"Portões Modelo 058","type":"Portões","unit":"UN","active":true},{"id":"SKU0059","name":"Acessórios Modelo 059","type":"Acessórios","unit":"UN","active":true},{"id":"SKU0060","name":"Portas Modelo 060","type":"Portas","unit":"UN","active":true},{"id":"SKU0061","name":"Janelas Modelo 061","type":"Janelas","unit":"UN","active":true},{"id":"SKU0062","name":"Maxim-ar Modelo 062","type":"Maxim-ar","unit":"UN","active":true},{"id":"SKU0063","name":"Portões Modelo 063","type":"Portões","unit":"UN","active":true},{"id":"SKU0064","name":"Acessórios Modelo 064","type":"Acessórios","unit":"UN","active":true},{"id":"SKU0065","name":"Portas Modelo 065","type":"Portas","unit":"UN","active":true}],"orders":[{"id":"PV00001","date":"2026-07-23","client":"C025","rep":"R06","sku":"SKU0024","qty":11,"gross":5269,"discount":526.9,"vlc":4742.1,"status":"Válido"},{"id":"PV00002","date":"2026-01-05","client":"C044","rep":"R08","sku":"SKU0018","qty":4,"gross":3684,"discount":92.1,"vlc":3591.9,"status":"Válido"},{"id":"PV00003","date":"2026-03-30","client":"C057","rep":"R07","sku":"SKU0042","qty":11,"gross":24255,"discount":606.38,"vlc":23648.62,"status":"Válido"},{"id":"PV00004","date":"2026-06-06","client":"C021","rep":"R02","sku":"SKU0060","qty":6,"gross":4002,"discount":100.05,"vlc":3901.95,"status":"Válido"},{"id":"PV00005","date":"2026-05-07","client":"C057","rep":"R04","sku":"SKU0029","qty":3,"gross":1443,"discount":36.08,"vlc":1406.92,"status":"Válido"},{"id":"PV00006","date":"2026-09-26","client":"C059","rep":"R09","sku":"SKU0004","qty":8,"gross":15744,"discount":1574.4,"vlc":14169.6,"status":"Válido"},{"id":"PV00007","date":"2026-07-17","client":"C061","rep":"R09","sku":"SKU0009","qty":8,"gross":8168,"discount":653.44,"vlc":7514.56,"status":"Válido"},{"id":"PV00008","date":"2026-01-07","client":"C018","rep":"R03","sku":"SKU0055","qty":5,"gross":15340,"discount":0,"vlc":15340,"status":"Válido"},{"id":"PV00009","date":"2026-03-10","client":"C014","rep":"R09","sku":"SKU0011","qty":7,"gross":11130,"discount":556.5,"vlc":10573.5,"status":"Válido"},{"id":"PV00010","date":"2026-04-21","client":"C056","rep":"R06","sku":"SKU0004","qty":8,"gross":15112,"discount":1511.2,"vlc":13600.8,"status":"Válido"},{"id":"PV00011","date":"2026-06-17","client":"C050","rep":"R03","sku":"SKU0045","qty":5,"gross":10895,"discount":1089.5,"vlc":9805.5,"status":"Válido"},{"id":"PV00012","date":"2026-10-20","client":"C043","rep":"R07","sku":"SKU0061","qty":1,"gross":2999,"discount":149.95,"vlc":2849.05,"status":"Válido"},{"id":"PV00013","date":"2026-08-11","client":"C029","rep":"R07","sku":"SKU0045","qty":1,"gross":628,"discount":31.4,"vlc":596.6,"status":"Válido"},{"id":"PV00014","date":"2026-05-04","client":"C066","rep":"R08","sku":"SKU0037","qty":2,"gross":5386,"discount":0,"vlc":5386,"status":"Válido"},{"id":"PV00015","date":"2026-06-08","client":"C019","rep":"R01","sku":"SKU0046","qty":9,"gross":11151,"discount":278.78,"vlc":10872.22,"status":"Válido"},{"id":"PV00016","date":"2026-01-09","client":"C056","rep":"R08","sku":"SKU0018","qty":11,"gross":21945,"discount":0,"vlc":21945,"status":"Válido"},{"id":"PV00017","date":"2026-09-21","client":"C018","rep":"R08","sku":"SKU0039","qty":11,"gross":32318,"discount":3231.8,"vlc":29086.2,"status":"Cancelado"},{"id":"PV00018","date":"2026-05-25","client":"C012","rep":"R05","sku":"SKU0057","qty":4,"gross":6072,"discount":0,"vlc":6072,"status":"Válido"},{"id":"PV00019","date":"2026-01-22","client":"C042","rep":"R03","sku":"SKU0026","qty":7,"gross":20286,"discount":507.15,"vlc":19778.85,"status":"Válido"},{"id":"PV00020","date":"2026-09-01","client":"C068","rep":"R07","sku":"SKU0050","qty":4,"gross":12380,"discount":0,"vlc":12380,"status":"Válido"},{"id":"PV00021","date":"2026-06-03","client":"C047","rep":"R06","sku":"SKU0052","qty":6,"gross":11592,"discount":927.36,"vlc":10664.64,"status":"Válido"},{"id":"PV00022","date":"2026-07-20","client":"C052","rep":"R09","sku":"SKU0043","qty":10,"gross":20350,"discount":508.75,"vlc":19841.25,"status":"Válido"},{"id":"PV00023","date":"2026-06-09","client":"C025","rep":"R06","sku":"SKU0024","qty":5,"gross":12255,"discount":612.75,"vlc":11642.25,"status":"Válido"},{"id":"PV00024","date":"2026-07-28","client":"C067","rep":"R07","sku":"SKU0027","qty":1,"gross":1787,"discount":44.68,"vlc":1742.32,"status":"Válido"},{"id":"PV00025","date":"2026-01-09","client":"C024","rep":"R02","sku":"SKU0058","qty":7,"gross":22337,"discount":1116.85,"vlc":21220.15,"status":"Válido"},{"id":"PV00026","date":"2026-04-16","client":"C042","rep":"R08","sku":"SKU0017","qty":8,"gross":24400,"discount":610.0,"vlc":23790.0,"status":"Válido"},{"id":"PV00027","date":"2026-04-15","client":"C021","rep":"R05","sku":"SKU0021","qty":6,"gross":19200,"discount":1920.0,"vlc":17280.0,"status":"Válido"},{"id":"PV00028","date":"2026-01-25","client":"C015","rep":"R05","sku":"SKU0022","qty":2,"gross":2694,"discount":134.7,"vlc":2559.3,"status":"Válido"},{"id":"PV00029","date":"2026-10-18","client":"C071","rep":"R07","sku":"SKU0033","qty":5,"gross":6400,"discount":512.0,"vlc":5888.0,"status":"Válido"},{"id":"PV00030","date":"2026-07-17","client":"C054","rep":"R01","sku":"SKU0040","qty":9,"gross":12942,"discount":323.55,"vlc":12618.45,"status":"Válido"},{"id":"PV00031","date":"2026-02-06","client":"C051","rep":"R01","sku":"SKU0009","qty":3,"gross":5139,"discount":0,"vlc":5139,"status":"Válido"},{"id":"PV00032","date":"2026-04-16","client":"C065","rep":"R06","sku":"SKU0054","qty":8,"gross":25488,"discount":2039.04,"vlc":23448.96,"status":"Válido"},{"id":"PV00033","date":"2026-08-08","client":"C016","rep":"R04","sku":"SKU0016","qty":7,"gross":11788,"discount":294.7,"vlc":11493.3,"status":"Válido"},{"id":"PV00034","date":"2026-05-31","client":"C049","rep":"R05","sku":"SKU0037","qty":6,"gross":5070,"discount":126.75,"vlc":4943.25,"status":"Cancelado"},{"id":"PV00035","date":"2026-07-10","client":"C065","rep":"R08","sku":"SKU0028","qty":10,"gross":17120,"discount":856.0,"vlc":16264.0,"status":"Válido"},{"id":"PV00036","date":"2026-02-13","client":"C048","rep":"R04","sku":"SKU0024","qty":7,"gross":3549,"discount":283.92,"vlc":3265.08,"status":"Válido"},{"id":"PV00037","date":"2026-05-04","client":"C056","rep":"R02","sku":"SKU0037","qty":1,"gross":2240,"discount":224.0,"vlc":2016.0,"status":"Válido"},{"id":"PV00038","date":"2026-06-03","client":"C038","rep":"R09","sku":"SKU0034","qty":6,"gross":3090,"discount":247.2,"vlc":2842.8,"status":"Válido"},{"id":"PV00039","date":"2026-04-08","client":"C042","rep":"R01","sku":"SKU0047","qty":6,"gross":9882,"discount":988.2,"vlc":8893.8,"status":"Válido"},{"id":"PV00040","date":"2026-09-05","client":"C070","rep":"R09","sku":"SKU0041","qty":5,"gross":2415,"discount":120.75,"vlc":2294.25,"status":"Válido"},{"id":"PV00041","date":"2026-07-09","client":"C057","rep":"R06","sku":"SKU0022","qty":11,"gross":34452,"discount":861.3,"vlc":33590.7,"status":"Válido"},{"id":"PV00042","date":"2026-05-19","client":"C005","rep":"R02","sku":"SKU0039","qty":11,"gross":25608,"discount":0,"vlc":25608,"status":"Válido"},{"id":"PV00043","date":"2026-07-15","client":"C072","rep":"R03","sku":"SKU0017","qty":2,"gross":5096,"discount":254.8,"vlc":4841.2,"status":"Válido"},{"id":"PV00044","date":"2026-08-05","client":"C047","rep":"R03","sku":"SKU0064","qty":4,"gross":5796,"discount":289.8,"vlc":5506.2,"status":"Válido"},{"id":"PV00045","date":"2026-04-23","client":"C064","rep":"R04","sku":"SKU0004","qty":8,"gross":11664,"discount":583.2,"vlc":11080.8,"status":"Válido"},{"id":"PV00046","date":"2026-06-30","client":"C033","rep":"R02","sku":"SKU0028","qty":2,"gross":2188,"discount":109.4,"vlc":2078.6,"status":"Válido"},{"id":"PV00047","date":"2026-06-26","client":"C045","rep":"R08","sku":"SKU0048","qty":7,"gross":6048,"discount":604.8,"vlc":5443.2,"status":"Válido"},{"id":"PV00048","date":"2026-02-09","client":"C032","rep":"R03","sku":"SKU0030","qty":8,"gross":19280,"discount":1928.0,"vlc":17352.0,"status":"Válido"},{"id":"PV00049","date":"2026-08-26","client":"C028","rep":"R08","sku":"SKU0008","qty":2,"gross":972,"discount":77.76,"vlc":894.24,"status":"Válido"},{"id":"PV00050","date":"2026-08-08","client":"C018","rep":"R07","sku":"SKU0032","qty":11,"gross":15873,"discount":0,"vlc":15873,"status":"Válido"},{"id":"PV00051","date":"2026-05-19","client":"C026","rep":"R09","sku":"SKU0022","qty":11,"gross":12056,"discount":964.48,"vlc":11091.52,"status":"Cancelado"},{"id":"PV00052","date":"2026-07-07","client":"C061","rep":"R06","sku":"SKU0003","qty":4,"gross":8676,"discount":694.08,"vlc":7981.92,"status":"Válido"},{"id":"PV00053","date":"2026-09-11","client":"C066","rep":"R06","sku":"SKU0050","qty":8,"gross":10856,"discount":0,"vlc":10856,"status":"Válido"},{"id":"PV00054","date":"2026-01-09","client":"C068","rep":"R07","sku":"SKU0022","qty":5,"gross":10385,"discount":519.25,"vlc":9865.75,"status":"Válido"},{"id":"PV00055","date":"2026-01-09","client":"C063","rep":"R04","sku":"SKU0035","qty":7,"gross":18851,"discount":942.55,"vlc":17908.45,"status":"Válido"},{"id":"PV00056","date":"2026-09-09","client":"C040","rep":"R01","sku":"SKU0042","qty":10,"gross":9400,"discount":940.0,"vlc":8460.0,"status":"Válido"},{"id":"PV00057","date":"2026-08-12","client":"C021","rep":"R08","sku":"SKU0052","qty":7,"gross":10458,"discount":261.45,"vlc":10196.55,"status":"Válido"},{"id":"PV00058","date":"2026-06-01","client":"C071","rep":"R01","sku":"SKU0019","qty":9,"gross":12627,"discount":1010.16,"vlc":11616.84,"status":"Válido"},{"id":"PV00059","date":"2026-01-18","client":"C039","rep":"R07","sku":"SKU0024","qty":11,"gross":13398,"discount":334.95,"vlc":13063.05,"status":"Válido"},{"id":"PV00060","date":"2026-01-20","client":"C037","rep":"R06","sku":"SKU0033","qty":1,"gross":1342,"discount":107.36,"vlc":1234.64,"status":"Válido"},{"id":"PV00061","date":"2026-01-10","client":"C031","rep":"R03","sku":"SKU0065","qty":6,"gross":6564,"discount":164.1,"vlc":6399.9,"status":"Válido"},{"id":"PV00062","date":"2026-05-03","client":"C015","rep":"R02","sku":"SKU0002","qty":9,"gross":25884,"discount":1294.2,"vlc":24589.8,"status":"Válido"},{"id":"PV00063","date":"2026-06-24","client":"C017","rep":"R04","sku":"SKU0004","qty":7,"gross":7007,"discount":0,"vlc":7007,"status":"Válido"},{"id":"PV00064","date":"2026-07-22","client":"C066","rep":"R04","sku":"SKU0010","qty":7,"gross":19117,"discount":1911.7,"vlc":17205.3,"status":"Válido"},{"id":"PV00065","date":"2026-01-01","client":"C045","rep":"R05","sku":"SKU0023","qty":8,"gross":4224,"discount":337.92,"vlc":3886.08,"status":"Válido"},{"id":"PV00066","date":"2026-10-03","client":"C067","rep":"R03","sku":"SKU0002","qty":5,"gross":3750,"discount":300.0,"vlc":3450.0,"status":"Válido"},{"id":"PV00067","date":"2026-01-13","client":"C035","rep":"R08","sku":"SKU0060","qty":2,"gross":2632,"discount":263.2,"vlc":2368.8,"status":"Válido"},{"id":"PV00068","date":"2026-02-18","client":"C015","rep":"R05","sku":"SKU0021","qty":6,"gross":14142,"discount":707.1,"vlc":13434.9,"status":"Cancelado"},{"id":"PV00069","date":"2026-10-08","client":"C046","rep":"R09","sku":"SKU0012","qty":7,"gross":5236,"discount":418.88,"vlc":4817.12,"status":"Válido"},{"id":"PV00070","date":"2026-08-11","client":"C052","rep":"R03","sku":"SKU0015","qty":11,"gross":17292,"discount":1383.36,"vlc":15908.64,"status":"Válido"},{"id":"PV00071","date":"2026-08-04","client":"C009","rep":"R09","sku":"SKU0032","qty":8,"gross":15200,"discount":1520.0,"vlc":13680.0,"status":"Válido"},{"id":"PV00072","date":"2026-05-18","client":"C006","rep":"R09","sku":"SKU0029","qty":9,"gross":6093,"discount":487.44,"vlc":5605.56,"status":"Válido"},{"id":"PV00073","date":"2026-09-20","client":"C016","rep":"R09","sku":"SKU0042","qty":10,"gross":17600,"discount":1408.0,"vlc":16192.0,"status":"Válido"},{"id":"PV00074","date":"2026-03-08","client":"C001","rep":"R04","sku":"SKU0013","qty":1,"gross":2531,"discount":126.55,"vlc":2404.45,"status":"Válido"},{"id":"PV00075","date":"2026-09-28","client":"C015","rep":"R03","sku":"SKU0021","qty":4,"gross":11196,"discount":559.8,"vlc":10636.2,"status":"Válido"},{"id":"PV00076","date":"2026-04-10","client":"C048","rep":"R05","sku":"SKU0059","qty":8,"gross":13232,"discount":1323.2,"vlc":11908.8,"status":"Válido"},{"id":"PV00077","date":"2026-02-12","client":"C071","rep":"R08","sku":"SKU0056","qty":8,"gross":7072,"discount":353.6,"vlc":6718.4,"status":"Válido"},{"id":"PV00078","date":"2026-03-18","client":"C059","rep":"R02","sku":"SKU0062","qty":6,"gross":9246,"discount":924.6,"vlc":8321.4,"status":"Válido"},{"id":"PV00079","date":"2026-06-24","client":"C058","rep":"R02","sku":"SKU0003","qty":5,"gross":6590,"discount":527.2,"vlc":6062.8,"status":"Válido"},{"id":"PV00080","date":"2026-08-25","client":"C064","rep":"R06","sku":"SKU0053","qty":9,"gross":9738,"discount":973.8,"vlc":8764.2,"status":"Válido"},{"id":"PV00081","date":"2026-05-25","client":"C051","rep":"R09","sku":"SKU0033","qty":5,"gross":14235,"discount":0,"vlc":14235,"status":"Válido"},{"id":"PV00082","date":"2026-07-30","client":"C016","rep":"R02","sku":"SKU0028","qty":6,"gross":13836,"discount":1106.88,"vlc":12729.12,"status":"Válido"},{"id":"PV00083","date":"2026-10-28","client":"C071","rep":"R06","sku":"SKU0054","qty":8,"gross":16704,"discount":835.2,"vlc":15868.8,"status":"Válido"},{"id":"PV00084","date":"2026-08-21","client":"C072","rep":"R09","sku":"SKU0034","qty":5,"gross":4540,"discount":454.0,"vlc":4086.0,"status":"Válido"},{"id":"PV00085","date":"2026-08-06","client":"C049","rep":"R01","sku":"SKU0054","qty":8,"gross":24696,"discount":1975.68,"vlc":22720.32,"status":"Cancelado"},{"id":"PV00086","date":"2026-02-07","client":"C064","rep":"R08","sku":"SKU0010","qty":3,"gross":9444,"discount":472.2,"vlc":8971.8,"status":"Válido"},{"id":"PV00087","date":"2026-06-27","client":"C007","rep":"R09","sku":"SKU0030","qty":6,"gross":3714,"discount":92.85,"vlc":3621.15,"status":"Válido"},{"id":"PV00088","date":"2026-07-07","client":"C029","rep":"R01","sku":"SKU0023","qty":9,"gross":26028,"discount":2602.8,"vlc":23425.2,"status":"Válido"},{"id":"PV00089","date":"2026-05-05","client":"C048","rep":"R05","sku":"SKU0002","qty":5,"gross":12630,"discount":631.5,"vlc":11998.5,"status":"Válido"},{"id":"PV00090","date":"2026-05-02","client":"C018","rep":"R01","sku":"SKU0032","qty":10,"gross":6000,"discount":600.0,"vlc":5400.0,"status":"Válido"},{"id":"PV00091","date":"2026-01-21","client":"C021","rep":"R05","sku":"SKU0035","qty":6,"gross":16812,"discount":840.6,"vlc":15971.4,"status":"Válido"},{"id":"PV00092","date":"2026-07-22","client":"C035","rep":"R03","sku":"SKU0036","qty":7,"gross":4053,"discount":324.24,"vlc":3728.76,"status":"Válido"},{"id":"PV00093","date":"2026-07-23","client":"C052","rep":"R02","sku":"SKU0014","qty":5,"gross":12380,"discount":1238.0,"vlc":11142.0,"status":"Válido"},{"id":"PV00094","date":"2026-01-27","client":"C031","rep":"R02","sku":"SKU0001","qty":10,"gross":14000,"discount":700.0,"vlc":13300.0,"status":"Válido"},{"id":"PV00095","date":"2026-08-02","client":"C021","rep":"R09","sku":"SKU0037","qty":6,"gross":6858,"discount":171.45,"vlc":6686.55,"status":"Válido"},{"id":"PV00096","date":"2026-09-06","client":"C017","rep":"R08","sku":"SKU0050","qty":8,"gross":24176,"discount":2417.6,"vlc":21758.4,"status":"Válido"},{"id":"PV00097","date":"2026-07-24","client":"C049","rep":"R06","sku":"SKU0045","qty":1,"gross":671,"discount":16.78,"vlc":654.22,"status":"Válido"},{"id":"PV00098","date":"2026-10-06","client":"C061","rep":"R01","sku":"SKU0008","qty":11,"gross":30745,"discount":0,"vlc":30745,"status":"Válido"},{"id":"PV00099","date":"2026-03-28","client":"C011","rep":"R04","sku":"SKU0057","qty":11,"gross":20515,"discount":2051.5,"vlc":18463.5,"status":"Válido"},{"id":"PV00100","date":"2026-07-16","client":"C047","rep":"R09","sku":"SKU0056","qty":9,"gross":8802,"discount":704.16,"vlc":8097.84,"status":"Válido"},{"id":"PV00101","date":"2026-05-08","client":"C072","rep":"R06","sku":"SKU0034","qty":2,"gross":6290,"discount":503.2,"vlc":5786.8,"status":"Válido"},{"id":"PV00102","date":"2026-10-15","client":"C033","rep":"R06","sku":"SKU0023","qty":2,"gross":3532,"discount":282.56,"vlc":3249.44,"status":"Cancelado"},{"id":"PV00103","date":"2026-07-27","client":"C031","rep":"R03","sku":"SKU0005","qty":4,"gross":1864,"discount":93.2,"vlc":1770.8,"status":"Válido"},{"id":"PV00104","date":"2026-09-13","client":"C031","rep":"R03","sku":"SKU0040","qty":7,"gross":15211,"discount":380.28,"vlc":14830.72,"status":"Válido"},{"id":"PV00105","date":"2026-07-07","client":"C062","rep":"R03","sku":"SKU0049","qty":3,"gross":4440,"discount":111.0,"vlc":4329.0,"status":"Válido"},{"id":"PV00106","date":"2026-08-10","client":"C006","rep":"R02","sku":"SKU0009","qty":3,"gross":7635,"discount":381.75,"vlc":7253.25,"status":"Válido"},{"id":"PV00107","date":"2026-01-17","client":"C044","rep":"R04","sku":"SKU0059","qty":11,"gross":18139,"discount":1813.9,"vlc":16325.1,"status":"Válido"},{"id":"PV00108","date":"2026-07-20","client":"C053","rep":"R01","sku":"SKU0049","qty":10,"gross":23490,"discount":0,"vlc":23490,"status":"Válido"},{"id":"PV00109","date":"2026-01-22","client":"C028","rep":"R05","sku":"SKU0047","qty":8,"gross":17928,"discount":0,"vlc":17928,"status":"Válido"},{"id":"PV00110","date":"2026-02-11","client":"C037","rep":"R02","sku":"SKU0055","qty":11,"gross":9977,"discount":498.85,"vlc":9478.15,"status":"Válido"},{"id":"PV00111","date":"2026-01-03","client":"C049","rep":"R06","sku":"SKU0048","qty":3,"gross":6945,"discount":0,"vlc":6945,"status":"Válido"},{"id":"PV00112","date":"2026-08-23","client":"C044","rep":"R08","sku":"SKU0026","qty":3,"gross":5385,"discount":538.5,"vlc":4846.5,"status":"Válido"},{"id":"PV00113","date":"2026-09-06","client":"C047","rep":"R06","sku":"SKU0023","qty":6,"gross":5094,"discount":509.4,"vlc":4584.6,"status":"Válido"},{"id":"PV00114","date":"2026-10-06","client":"C054","rep":"R07","sku":"SKU0014","qty":8,"gross":12928,"discount":1034.24,"vlc":11893.76,"status":"Válido"},{"id":"PV00115","date":"2026-01-30","client":"C039","rep":"R09","sku":"SKU0011","qty":1,"gross":1604,"discount":80.2,"vlc":1523.8,"status":"Válido"},{"id":"PV00116","date":"2026-05-18","client":"C013","rep":"R01","sku":"SKU0009","qty":1,"gross":2912,"discount":0,"vlc":2912,"status":"Válido"},{"id":"PV00117","date":"2026-04-26","client":"C024","rep":"R08","sku":"SKU0015","qty":10,"gross":17260,"discount":1726.0,"vlc":15534.0,"status":"Válido"},{"id":"PV00118","date":"2026-05-07","client":"C005","rep":"R06","sku":"SKU0063","qty":7,"gross":15722,"discount":0,"vlc":15722,"status":"Válido"},{"id":"PV00119","date":"2026-04-13","client":"C014","rep":"R03","sku":"SKU0013","qty":10,"gross":12040,"discount":301.0,"vlc":11739.0,"status":"Cancelado"},{"id":"PV00120","date":"2026-07-31","client":"C028","rep":"R06","sku":"SKU0051","qty":8,"gross":7056,"discount":705.6,"vlc":6350.4,"status":"Válido"},{"id":"PV00121","date":"2026-08-03","client":"C019","rep":"R02","sku":"SKU0056","qty":9,"gross":7371,"discount":368.55,"vlc":7002.45,"status":"Válido"},{"id":"PV00122","date":"2026-06-18","client":"C039","rep":"R07","sku":"SKU0042","qty":3,"gross":3255,"discount":81.38,"vlc":3173.62,"status":"Válido"},{"id":"PV00123","date":"2026-03-31","client":"C020","rep":"R07","sku":"SKU0018","qty":5,"gross":12580,"discount":1258.0,"vlc":11322.0,"status":"Válido"},{"id":"PV00124","date":"2026-01-05","client":"C016","rep":"R02","sku":"SKU0012","qty":11,"gross":12551,"discount":627.55,"vlc":11923.45,"status":"Válido"},{"id":"PV00125","date":"2026-05-05","client":"C060","rep":"R08","sku":"SKU0007","qty":4,"gross":8464,"discount":0,"vlc":8464,"status":"Válido"},{"id":"PV00126","date":"2026-06-05","client":"C060","rep":"R02","sku":"SKU0038","qty":9,"gross":7263,"discount":726.3,"vlc":6536.7,"status":"Válido"},{"id":"PV00127","date":"2026-08-24","client":"C008","rep":"R06","sku":"SKU0026","qty":10,"gross":14380,"discount":1150.4,"vlc":13229.6,"status":"Válido"},{"id":"PV00128","date":"2026-04-24","client":"C036","rep":"R01","sku":"SKU0010","qty":7,"gross":15470,"discount":1547.0,"vlc":13923.0,"status":"Válido"},{"id":"PV00129","date":"2026-03-12","client":"C014","rep":"R06","sku":"SKU0023","qty":8,"gross":16456,"discount":1316.48,"vlc":15139.52,"status":"Válido"},{"id":"PV00130","date":"2026-10-20","client":"C026","rep":"R08","sku":"SKU0039","qty":10,"gross":31730,"discount":3173.0,"vlc":28557.0,"status":"Válido"},{"id":"PV00131","date":"2026-06-12","client":"C071","rep":"R04","sku":"SKU0007","qty":11,"gross":19239,"discount":0,"vlc":19239,"status":"Válido"},{"id":"PV00132","date":"2026-03-30","client":"C050","rep":"R01","sku":"SKU0019","qty":6,"gross":10398,"discount":0,"vlc":10398,"status":"Válido"},{"id":"PV00133","date":"2026-08-31","client":"C042","rep":"R03","sku":"SKU0027","qty":10,"gross":29600,"discount":0,"vlc":29600,"status":"Válido"},{"id":"PV00134","date":"2026-03-23","client":"C063","rep":"R03","sku":"SKU0050","qty":7,"gross":3731,"discount":186.55,"vlc":3544.45,"status":"Válido"},{"id":"PV00135","date":"2026-04-04","client":"C049","rep":"R06","sku":"SKU0018","qty":4,"gross":12376,"discount":1237.6,"vlc":11138.4,"status":"Válido"},{"id":"PV00136","date":"2026-02-04","client":"C050","rep":"R02","sku":"SKU0018","qty":8,"gross":24312,"discount":1944.96,"vlc":22367.04,"status":"Cancelado"},{"id":"PV00137","date":"2026-08-21","client":"C066","rep":"R06","sku":"SKU0001","qty":9,"gross":16380,"discount":409.5,"vlc":15970.5,"status":"Válido"},{"id":"PV00138","date":"2026-05-04","client":"C042","rep":"R06","sku":"SKU0012","qty":2,"gross":2714,"discount":271.4,"vlc":2442.6,"status":"Válido"},{"id":"PV00139","date":"2026-01-04","client":"C024","rep":"R08","sku":"SKU0033","qty":3,"gross":5733,"discount":0,"vlc":5733,"status":"Válido"},{"id":"PV00140","date":"2026-10-09","client":"C054","rep":"R03","sku":"SKU0060","qty":8,"gross":7560,"discount":604.8,"vlc":6955.2,"status":"Válido"},{"id":"PV00141","date":"2026-03-28","client":"C061","rep":"R07","sku":"SKU0062","qty":6,"gross":14196,"discount":1135.68,"vlc":13060.32,"status":"Válido"},{"id":"PV00142","date":"2026-06-28","client":"C009","rep":"R07","sku":"SKU0018","qty":9,"gross":5625,"discount":450.0,"vlc":5175.0,"status":"Válido"},{"id":"PV00143","date":"2026-06-24","client":"C028","rep":"R04","sku":"SKU0050","qty":2,"gross":1026,"discount":82.08,"vlc":943.92,"status":"Válido"},{"id":"PV00144","date":"2026-04-28","client":"C057","rep":"R06","sku":"SKU0040","qty":8,"gross":25592,"discount":2559.2,"vlc":23032.8,"status":"Válido"},{"id":"PV00145","date":"2026-05-26","client":"C014","rep":"R01","sku":"SKU0061","qty":3,"gross":5544,"discount":443.52,"vlc":5100.48,"status":"Válido"},{"id":"PV00146","date":"2026-05-02","client":"C051","rep":"R09","sku":"SKU0039","qty":5,"gross":7740,"discount":193.5,"vlc":7546.5,"status":"Válido"},{"id":"PV00147","date":"2026-10-16","client":"C042","rep":"R05","sku":"SKU0018","qty":8,"gross":16760,"discount":838.0,"vlc":15922.0,"status":"Válido"},{"id":"PV00148","date":"2026-02-17","client":"C012","rep":"R02","sku":"SKU0016","qty":5,"gross":14400,"discount":1152.0,"vlc":13248.0,"status":"Válido"},{"id":"PV00149","date":"2026-06-08","client":"C059","rep":"R03","sku":"SKU0034","qty":2,"gross":3952,"discount":98.8,"vlc":3853.2,"status":"Válido"},{"id":"PV00150","date":"2026-04-05","client":"C012","rep":"R01","sku":"SKU0003","qty":3,"gross":8595,"discount":214.88,"vlc":8380.12,"status":"Válido"},{"id":"PV00151","date":"2026-06-02","client":"C024","rep":"R02","sku":"SKU0014","qty":1,"gross":2410,"discount":0,"vlc":2410,"status":"Válido"},{"id":"PV00152","date":"2026-08-03","client":"C035","rep":"R07","sku":"SKU0008","qty":11,"gross":12804,"discount":1024.32,"vlc":11779.68,"status":"Válido"},{"id":"PV00153","date":"2026-07-14","client":"C030","rep":"R07","sku":"SKU0022","qty":9,"gross":7092,"discount":567.36,"vlc":6524.64,"status":"Cancelado"},{"id":"PV00154","date":"2026-03-01","client":"C009","rep":"R08","sku":"SKU0064","qty":6,"gross":18354,"discount":917.7,"vlc":17436.3,"status":"Válido"},{"id":"PV00155","date":"2026-07-16","client":"C062","rep":"R06","sku":"SKU0027","qty":7,"gross":10143,"discount":253.58,"vlc":9889.42,"status":"Válido"},{"id":"PV00156","date":"2026-04-11","client":"C033","rep":"R03","sku":"SKU0024","qty":10,"gross":17730,"discount":443.25,"vlc":17286.75,"status":"Válido"},{"id":"PV00157","date":"2026-07-20","client":"C016","rep":"R05","sku":"SKU0037","qty":7,"gross":20643,"discount":0,"vlc":20643,"status":"Válido"},{"id":"PV00158","date":"2026-07-10","client":"C064","rep":"R04","sku":"SKU0007","qty":9,"gross":16065,"discount":1606.5,"vlc":14458.5,"status":"Válido"},{"id":"PV00159","date":"2026-05-24","client":"C062","rep":"R05","sku":"SKU0042","qty":4,"gross":8240,"discount":659.2,"vlc":7580.8,"status":"Válido"},{"id":"PV00160","date":"2026-10-25","client":"C017","rep":"R07","sku":"SKU0059","qty":10,"gross":16180,"discount":404.5,"vlc":15775.5,"status":"Válido"},{"id":"PV00161","date":"2026-06-01","client":"C044","rep":"R07","sku":"SKU0015","qty":7,"gross":7063,"discount":176.58,"vlc":6886.42,"status":"Válido"},{"id":"PV00162","date":"2026-05-09","client":"C051","rep":"R04","sku":"SKU0063","qty":10,"gross":6650,"discount":665.0,"vlc":5985.0,"status":"Válido"},{"id":"PV00163","date":"2026-03-16","client":"C006","rep":"R03","sku":"SKU0016","qty":8,"gross":15256,"discount":0,"vlc":15256,"status":"Válido"},{"id":"PV00164","date":"2026-01-07","client":"C039","rep":"R07","sku":"SKU0034","qty":11,"gross":15004,"discount":375.1,"vlc":14628.9,"status":"Válido"},{"id":"PV00165","date":"2026-04-06","client":"C025","rep":"R05","sku":"SKU0003","qty":1,"gross":2349,"discount":187.92,"vlc":2161.08,"status":"Válido"},{"id":"PV00166","date":"2026-05-29","client":"C059","rep":"R07","sku":"SKU0019","qty":2,"gross":2226,"discount":178.08,"vlc":2047.92,"status":"Válido"},{"id":"PV00167","date":"2026-06-19","client":"C022","rep":"R06","sku":"SKU0046","qty":2,"gross":5572,"discount":278.6,"vlc":5293.4,"status":"Válido"},{"id":"PV00168","date":"2026-01-13","client":"C033","rep":"R04","sku":"SKU0005","qty":10,"gross":15440,"discount":0,"vlc":15440,"status":"Válido"},{"id":"PV00169","date":"2026-10-18","client":"C058","rep":"R08","sku":"SKU0054","qty":5,"gross":10635,"discount":265.88,"vlc":10369.12,"status":"Válido"},{"id":"PV00170","date":"2026-07-16","client":"C065","rep":"R09","sku":"SKU0050","qty":4,"gross":12744,"discount":0,"vlc":12744,"status":"Cancelado"},{"id":"PV00171","date":"2026-05-26","client":"C020","rep":"R05","sku":"SKU0057","qty":5,"gross":15740,"discount":787.0,"vlc":14953.0,"status":"Válido"},{"id":"PV00172","date":"2026-01-27","client":"C025","rep":"R05","sku":"SKU0001","qty":8,"gross":14272,"discount":713.6,"vlc":13558.4,"status":"Válido"},{"id":"PV00173","date":"2026-06-04","client":"C070","rep":"R03","sku":"SKU0046","qty":1,"gross":1848,"discount":147.84,"vlc":1700.16,"status":"Válido"},{"id":"PV00174","date":"2026-08-14","client":"C018","rep":"R07","sku":"SKU0028","qty":11,"gross":9603,"discount":240.08,"vlc":9362.92,"status":"Válido"},{"id":"PV00175","date":"2026-02-24","client":"C061","rep":"R05","sku":"SKU0051","qty":2,"gross":1344,"discount":134.4,"vlc":1209.6,"status":"Válido"},{"id":"PV00176","date":"2026-06-10","client":"C004","rep":"R06","sku":"SKU0064","qty":6,"gross":5550,"discount":0,"vlc":5550,"status":"Válido"},{"id":"PV00177","date":"2026-04-21","client":"C038","rep":"R08","sku":"SKU0024","qty":7,"gross":21644,"discount":1731.52,"vlc":19912.48,"status":"Válido"},{"id":"PV00178","date":"2026-01-16","client":"C036","rep":"R09","sku":"SKU0007","qty":11,"gross":22044,"discount":1763.52,"vlc":20280.48,"status":"Válido"},{"id":"PV00179","date":"2026-10-26","client":"C002","rep":"R03","sku":"SKU0045","qty":6,"gross":6096,"discount":0,"vlc":6096,"status":"Válido"},{"id":"PV00180","date":"2026-10-03","client":"C052","rep":"R07","sku":"SKU0012","qty":4,"gross":6484,"discount":324.2,"vlc":6159.8,"status":"Válido"},{"id":"PV00181","date":"2026-09-21","client":"C055","rep":"R06","sku":"SKU0050","qty":11,"gross":25839,"discount":2067.12,"vlc":23771.88,"status":"Válido"},{"id":"PV00182","date":"2026-02-16","client":"C036","rep":"R07","sku":"SKU0041","qty":10,"gross":12460,"discount":1246.0,"vlc":11214.0,"status":"Válido"},{"id":"PV00183","date":"2026-05-02","client":"C072","rep":"R04","sku":"SKU0054","qty":6,"gross":15312,"discount":1531.2,"vlc":13780.8,"status":"Válido"},{"id":"PV00184","date":"2026-06-28","client":"C010","rep":"R05","sku":"SKU0047","qty":9,"gross":10872,"discount":869.76,"vlc":10002.24,"status":"Válido"},{"id":"PV00185","date":"2026-03-20","client":"C024","rep":"R06","sku":"SKU0064","qty":5,"gross":9125,"discount":228.12,"vlc":8896.88,"status":"Válido"},{"id":"PV00186","date":"2026-03-10","client":"C002","rep":"R03","sku":"SKU0048","qty":7,"gross":6895,"discount":689.5,"vlc":6205.5,"status":"Válido"},{"id":"PV00187","date":"2026-09-15","client":"C005","rep":"R04","sku":"SKU0002","qty":7,"gross":6601,"discount":660.1,"vlc":5940.9,"status":"Cancelado"},{"id":"PV00188","date":"2026-02-02","client":"C059","rep":"R08","sku":"SKU0008","qty":11,"gross":34958,"discount":1747.9,"vlc":33210.1,"status":"Válido"},{"id":"PV00189","date":"2026-02-24","client":"C072","rep":"R02","sku":"SKU0061","qty":4,"gross":5972,"discount":149.3,"vlc":5822.7,"status":"Válido"},{"id":"PV00190","date":"2026-08-15","client":"C019","rep":"R08","sku":"SKU0055","qty":1,"gross":3165,"discount":316.5,"vlc":2848.5,"status":"Válido"},{"id":"PV00191","date":"2026-01-07","client":"C065","rep":"R03","sku":"SKU0042","qty":2,"gross":5252,"discount":525.2,"vlc":4726.8,"status":"Válido"},{"id":"PV00192","date":"2026-08-06","client":"C002","rep":"R09","sku":"SKU0065","qty":9,"gross":27486,"discount":2748.6,"vlc":24737.4,"status":"Válido"},{"id":"PV00193","date":"2026-09-13","client":"C040","rep":"R01","sku":"SKU0047","qty":6,"gross":9090,"discount":0,"vlc":9090,"status":"Válido"},{"id":"PV00194","date":"2026-09-10","client":"C056","rep":"R09","sku":"SKU0057","qty":5,"gross":5655,"discount":141.38,"vlc":5513.62,"status":"Válido"},{"id":"PV00195","date":"2026-07-31","client":"C064","rep":"R05","sku":"SKU0048","qty":4,"gross":8364,"discount":836.4,"vlc":7527.6,"status":"Válido"},{"id":"PV00196","date":"2026-10-05","client":"C072","rep":"R02","sku":"SKU0029","qty":7,"gross":3689,"discount":184.45,"vlc":3504.55,"status":"Válido"},{"id":"PV00197","date":"2026-08-14","client":"C032","rep":"R09","sku":"SKU0048","qty":11,"gross":27698,"discount":692.45,"vlc":27005.55,"status":"Válido"},{"id":"PV00198","date":"2026-09-28","client":"C063","rep":"R04","sku":"SKU0060","qty":5,"gross":6055,"discount":151.38,"vlc":5903.62,"status":"Válido"},{"id":"PV00199","date":"2026-05-19","client":"C069","rep":"R07","sku":"SKU0037","qty":9,"gross":20772,"discount":0,"vlc":20772,"status":"Válido"},{"id":"PV00200","date":"2026-03-01","client":"C058","rep":"R08","sku":"SKU0005","qty":9,"gross":7551,"discount":377.55,"vlc":7173.45,"status":"Válido"},{"id":"PV00201","date":"2026-05-02","client":"C015","rep":"R05","sku":"SKU0040","qty":11,"gross":34144,"discount":853.6,"vlc":33290.4,"status":"Válido"},{"id":"PV00202","date":"2026-10-07","client":"C046","rep":"R04","sku":"SKU0064","qty":5,"gross":11065,"discount":0,"vlc":11065,"status":"Válido"},{"id":"PV00203","date":"2026-06-05","client":"C001","rep":"R02","sku":"SKU0058","qty":4,"gross":7380,"discount":0,"vlc":7380,"status":"Válido"},{"id":"PV00204","date":"2026-01-19","client":"C045","rep":"R08","sku":"SKU0042","qty":4,"gross":2564,"discount":64.1,"vlc":2499.9,"status":"Cancelado"},{"id":"PV00205","date":"2026-09-11","client":"C007","rep":"R07","sku":"SKU0055","qty":8,"gross":16680,"discount":0,"vlc":16680,"status":"Válido"},{"id":"PV00206","date":"2026-06-15","client":"C059","rep":"R09","sku":"SKU0004","qty":7,"gross":7987,"discount":798.7,"vlc":7188.3,"status":"Válido"},{"id":"PV00207","date":"2026-05-27","client":"C007","rep":"R06","sku":"SKU0038","qty":3,"gross":2853,"discount":142.65,"vlc":2710.35,"status":"Válido"},{"id":"PV00208","date":"2026-02-11","client":"C017","rep":"R03","sku":"SKU0002","qty":2,"gross":2664,"discount":66.6,"vlc":2597.4,"status":"Válido"},{"id":"PV00209","date":"2026-08-17","client":"C052","rep":"R09","sku":"SKU0005","qty":1,"gross":1462,"discount":36.55,"vlc":1425.45,"status":"Válido"},{"id":"PV00210","date":"2026-04-23","client":"C054","rep":"R01","sku":"SKU0047","qty":7,"gross":22001,"discount":1100.05,"vlc":20900.95,"status":"Válido"},{"id":"PV00211","date":"2026-06-28","client":"C033","rep":"R04","sku":"SKU0028","qty":9,"gross":25785,"discount":2062.8,"vlc":23722.2,"status":"Válido"},{"id":"PV00212","date":"2026-09-25","client":"C035","rep":"R04","sku":"SKU0065","qty":7,"gross":14910,"discount":372.75,"vlc":14537.25,"status":"Válido"},{"id":"PV00213","date":"2026-07-27","client":"C037","rep":"R06","sku":"SKU0033","qty":2,"gross":2914,"discount":291.4,"vlc":2622.6,"status":"Válido"},{"id":"PV00214","date":"2026-05-22","client":"C001","rep":"R01","sku":"SKU0012","qty":3,"gross":8814,"discount":705.12,"vlc":8108.88,"status":"Válido"},{"id":"PV00215","date":"2026-10-21","client":"C059","rep":"R06","sku":"SKU0013","qty":10,"gross":23900,"discount":1195.0,"vlc":22705.0,"status":"Válido"},{"id":"PV00216","date":"2026-03-28","client":"C047","rep":"R01","sku":"SKU0013","qty":4,"gross":9020,"discount":225.5,"vlc":8794.5,"status":"Válido"},{"id":"PV00217","date":"2026-09-19","client":"C002","rep":"R09","sku":"SKU0022","qty":10,"gross":14780,"discount":369.5,"vlc":14410.5,"status":"Válido"},{"id":"PV00218","date":"2026-10-04","client":"C006","rep":"R09","sku":"SKU0064","qty":4,"gross":6788,"discount":543.04,"vlc":6244.96,"status":"Válido"},{"id":"PV00219","date":"2026-10-05","client":"C062","rep":"R07","sku":"SKU0019","qty":9,"gross":10494,"discount":1049.4,"vlc":9444.6,"status":"Válido"},{"id":"PV00220","date":"2026-05-11","client":"C028","rep":"R05","sku":"SKU0002","qty":5,"gross":8890,"discount":0,"vlc":8890,"status":"Válido"},{"id":"PV00221","date":"2026-09-03","client":"C003","rep":"R03","sku":"SKU0060","qty":3,"gross":8892,"discount":0,"vlc":8892,"status":"Cancelado"},{"id":"PV00222","date":"2026-04-21","client":"C018","rep":"R05","sku":"SKU0042","qty":9,"gross":24984,"discount":1249.2,"vlc":23734.8,"status":"Válido"},{"id":"PV00223","date":"2026-06-11","client":"C048","rep":"R07","sku":"SKU0008","qty":8,"gross":14712,"discount":0,"vlc":14712,"status":"Válido"},{"id":"PV00224","date":"2026-05-15","client":"C056","rep":"R08","sku":"SKU0027","qty":1,"gross":2768,"discount":69.2,"vlc":2698.8,"status":"Válido"},{"id":"PV00225","date":"2026-02-13","client":"C036","rep":"R02","sku":"SKU0026","qty":1,"gross":2243,"discount":56.08,"vlc":2186.92,"status":"Válido"},{"id":"PV00226","date":"2026-03-14","client":"C030","rep":"R05","sku":"SKU0043","qty":3,"gross":8736,"discount":0,"vlc":8736,"status":"Válido"},{"id":"PV00227","date":"2026-08-31","client":"C072","rep":"R05","sku":"SKU0021","qty":11,"gross":10241,"discount":0,"vlc":10241,"status":"Válido"},{"id":"PV00228","date":"2026-03-19","client":"C052","rep":"R01","sku":"SKU0036","qty":5,"gross":5130,"discount":513.0,"vlc":4617.0,"status":"Válido"},{"id":"PV00229","date":"2026-07-31","client":"C019","rep":"R03","sku":"SKU0040","qty":3,"gross":2883,"discount":0,"vlc":2883,"status":"Válido"},{"id":"PV00230","date":"2026-09-02","client":"C014","rep":"R08","sku":"SKU0022","qty":11,"gross":30107,"discount":3010.7,"vlc":27096.3,"status":"Válido"},{"id":"PV00231","date":"2026-08-19","client":"C072","rep":"R08","sku":"SKU0056","qty":5,"gross":3350,"discount":167.5,"vlc":3182.5,"status":"Válido"},{"id":"PV00232","date":"2026-09-28","client":"C056","rep":"R03","sku":"SKU0016","qty":8,"gross":7752,"discount":0,"vlc":7752,"status":"Válido"},{"id":"PV00233","date":"2026-05-15","client":"C030","rep":"R06","sku":"SKU0007","qty":9,"gross":15822,"discount":0,"vlc":15822,"status":"Válido"},{"id":"PV00234","date":"2026-03-24","client":"C002","rep":"R05","sku":"SKU0054","qty":1,"gross":1933,"discount":48.33,"vlc":1884.67,"status":"Válido"},{"id":"PV00235","date":"2026-10-03","client":"C003","rep":"R02","sku":"SKU0029","qty":6,"gross":4020,"discount":321.6,"vlc":3698.4,"status":"Válido"},{"id":"PV00236","date":"2026-07-09","client":"C039","rep":"R01","sku":"SKU0060","qty":1,"gross":1459,"discount":116.72,"vlc":1342.28,"status":"Válido"},{"id":"PV00237","date":"2026-06-15","client":"C003","rep":"R08","sku":"SKU0025","qty":1,"gross":1024,"discount":81.92,"vlc":942.08,"status":"Válido"},{"id":"PV00238","date":"2026-05-22","client":"C034","rep":"R06","sku":"SKU0023","qty":8,"gross":16504,"discount":825.2,"vlc":15678.8,"status":"Cancelado"},{"id":"PV00239","date":"2026-01-10","client":"C041","rep":"R01","sku":"SKU0031","qty":9,"gross":26010,"discount":650.25,"vlc":25359.75,"status":"Válido"},{"id":"PV00240","date":"2026-09-15","client":"C031","rep":"R05","sku":"SKU0051","qty":1,"gross":1800,"discount":45.0,"vlc":1755.0,"status":"Válido"},{"id":"PV00241","date":"2026-04-18","client":"C055","rep":"R04","sku":"SKU0052","qty":9,"gross":27045,"discount":2163.6,"vlc":24881.4,"status":"Válido"},{"id":"PV00242","date":"2026-08-01","client":"C009","rep":"R09","sku":"SKU0010","qty":7,"gross":19572,"discount":1957.2,"vlc":17614.8,"status":"Válido"},{"id":"PV00243","date":"2026-04-11","client":"C053","rep":"R06","sku":"SKU0030","qty":10,"gross":19390,"discount":1939.0,"vlc":17451.0,"status":"Válido"},{"id":"PV00244","date":"2026-06-15","client":"C068","rep":"R08","sku":"SKU0036","qty":11,"gross":14894,"discount":1191.52,"vlc":13702.48,"status":"Válido"},{"id":"PV00245","date":"2026-04-06","client":"C028","rep":"R09","sku":"SKU0008","qty":6,"gross":12846,"discount":642.3,"vlc":12203.7,"status":"Válido"},{"id":"PV00246","date":"2026-09-24","client":"C052","rep":"R05","sku":"SKU0007","qty":3,"gross":4359,"discount":435.9,"vlc":3923.1,"status":"Válido"},{"id":"PV00247","date":"2026-10-19","client":"C070","rep":"R09","sku":"SKU0045","qty":4,"gross":11984,"discount":299.6,"vlc":11684.4,"status":"Válido"},{"id":"PV00248","date":"2026-08-09","client":"C036","rep":"R06","sku":"SKU0004","qty":3,"gross":4332,"discount":0,"vlc":4332,"status":"Válido"},{"id":"PV00249","date":"2026-04-08","client":"C052","rep":"R01","sku":"SKU0050","qty":2,"gross":5652,"discount":0,"vlc":5652,"status":"Válido"},{"id":"PV00250","date":"2026-08-23","client":"C011","rep":"R09","sku":"SKU0007","qty":3,"gross":4653,"discount":465.3,"vlc":4187.7,"status":"Válido"},{"id":"PV00251","date":"2026-08-20","client":"C022","rep":"R08","sku":"SKU0028","qty":5,"gross":12525,"discount":626.25,"vlc":11898.75,"status":"Válido"},{"id":"PV00252","date":"2026-03-12","client":"C060","rep":"R08","sku":"SKU0055","qty":6,"gross":15912,"discount":1591.2,"vlc":14320.8,"status":"Válido"},{"id":"PV00253","date":"2026-09-21","client":"C056","rep":"R06","sku":"SKU0010","qty":9,"gross":8505,"discount":425.25,"vlc":8079.75,"status":"Válido"},{"id":"PV00254","date":"2026-01-31","client":"C011","rep":"R06","sku":"SKU0041","qty":11,"gross":10285,"discount":822.8,"vlc":9462.2,"status":"Válido"},{"id":"PV00255","date":"2026-01-24","client":"C035","rep":"R08","sku":"SKU0030","qty":6,"gross":6528,"discount":163.2,"vlc":6364.8,"status":"Cancelado"},{"id":"PV00256","date":"2026-09-08","client":"C058","rep":"R06","sku":"SKU0039","qty":10,"gross":12490,"discount":624.5,"vlc":11865.5,"status":"Válido"},{"id":"PV00257","date":"2026-01-07","client":"C008","rep":"R01","sku":"SKU0057","qty":3,"gross":5169,"discount":516.9,"vlc":4652.1,"status":"Válido"},{"id":"PV00258","date":"2026-09-12","client":"C021","rep":"R08","sku":"SKU0004","qty":6,"gross":13698,"discount":1095.84,"vlc":12602.16,"status":"Válido"},{"id":"PV00259","date":"2026-03-31","client":"C039","rep":"R07","sku":"SKU0023","qty":8,"gross":21984,"discount":1758.72,"vlc":20225.28,"status":"Válido"},{"id":"PV00260","date":"2026-07-28","client":"C002","rep":"R01","sku":"SKU0017","qty":5,"gross":9590,"discount":0,"vlc":9590,"status":"Válido"},{"id":"PV00261","date":"2026-07-01","client":"C040","rep":"R06","sku":"SKU0030","qty":10,"gross":18470,"discount":1477.6,"vlc":16992.4,"status":"Válido"},{"id":"PV00262","date":"2026-06-10","client":"C018","rep":"R09","sku":"SKU0038","qty":3,"gross":1725,"discount":86.25,"vlc":1638.75,"status":"Válido"},{"id":"PV00263","date":"2026-03-12","client":"C048","rep":"R02","sku":"SKU0044","qty":11,"gross":6842,"discount":684.2,"vlc":6157.8,"status":"Válido"},{"id":"PV00264","date":"2026-01-12","client":"C072","rep":"R08","sku":"SKU0013","qty":10,"gross":25650,"discount":2052.0,"vlc":23598.0,"status":"Válido"},{"id":"PV00265","date":"2026-09-24","client":"C051","rep":"R04","sku":"SKU0006","qty":10,"gross":5170,"discount":129.25,"vlc":5040.75,"status":"Válido"},{"id":"PV00266","date":"2026-01-11","client":"C065","rep":"R06","sku":"SKU0055","qty":7,"gross":13839,"discount":1383.9,"vlc":12455.1,"status":"Válido"},{"id":"PV00267","date":"2026-07-26","client":"C041","rep":"R01","sku":"SKU0004","qty":8,"gross":5000,"discount":125.0,"vlc":4875.0,"status":"Válido"},{"id":"PV00268","date":"2026-08-01","client":"C066","rep":"R03","sku":"SKU0042","qty":6,"gross":18600,"discount":1860.0,"vlc":16740.0,"status":"Válido"},{"id":"PV00269","date":"2026-08-14","client":"C002","rep":"R07","sku":"SKU0054","qty":7,"gross":5712,"discount":571.2,"vlc":5140.8,"status":"Válido"},{"id":"PV00270","date":"2026-03-27","client":"C009","rep":"R02","sku":"SKU0007","qty":11,"gross":22880,"discount":2288.0,"vlc":20592.0,"status":"Válido"},{"id":"PV00271","date":"2026-06-16","client":"C029","rep":"R06","sku":"SKU0011","qty":7,"gross":9275,"discount":927.5,"vlc":8347.5,"status":"Válido"},{"id":"PV00272","date":"2026-06-06","client":"C026","rep":"R05","sku":"SKU0051","qty":9,"gross":20358,"discount":508.95,"vlc":19849.05,"status":"Cancelado"},{"id":"PV00273","date":"2026-08-30","client":"C019","rep":"R06","sku":"SKU0023","qty":11,"gross":13332,"discount":333.3,"vlc":12998.7,"status":"Válido"},{"id":"PV00274","date":"2026-01-29","client":"C011","rep":"R08","sku":"SKU0030","qty":9,"gross":23652,"discount":1892.16,"vlc":21759.84,"status":"Válido"},{"id":"PV00275","date":"2026-06-22","client":"C059","rep":"R05","sku":"SKU0043","qty":8,"gross":25344,"discount":1267.2,"vlc":24076.8,"status":"Válido"},{"id":"PV00276","date":"2026-05-06","client":"C052","rep":"R07","sku":"SKU0019","qty":2,"gross":1182,"discount":0,"vlc":1182,"status":"Válido"},{"id":"PV00277","date":"2026-02-27","client":"C017","rep":"R01","sku":"SKU0015","qty":6,"gross":3174,"discount":317.4,"vlc":2856.6,"status":"Válido"},{"id":"PV00278","date":"2026-09-17","client":"C068","rep":"R05","sku":"SKU0023","qty":8,"gross":21472,"discount":1073.6,"vlc":20398.4,"status":"Válido"},{"id":"PV00279","date":"2026-10-19","client":"C006","rep":"R05","sku":"SKU0012","qty":7,"gross":11116,"discount":277.9,"vlc":10838.1,"status":"Válido"},{"id":"PV00280","date":"2026-04-29","client":"C013","rep":"R03","sku":"SKU0012","qty":10,"gross":26640,"discount":1332.0,"vlc":25308.0,"status":"Válido"},{"id":"PV00281","date":"2026-05-07","client":"C070","rep":"R06","sku":"SKU0028","qty":3,"gross":9375,"discount":468.75,"vlc":8906.25,"status":"Válido"},{"id":"PV00282","date":"2026-01-28","client":"C017","rep":"R01","sku":"SKU0049","qty":4,"gross":10848,"discount":1084.8,"vlc":9763.2,"status":"Válido"},{"id":"PV00283","date":"2026-10-29","client":"C059","rep":"R02","sku":"SKU0043","qty":9,"gross":6354,"discount":508.32,"vlc":5845.68,"status":"Válido"},{"id":"PV00284","date":"2026-03-08","client":"C033","rep":"R04","sku":"SKU0051","qty":2,"gross":4172,"discount":417.2,"vlc":3754.8,"status":"Válido"},{"id":"PV00285","date":"2026-08-29","client":"C001","rep":"R04","sku":"SKU0002","qty":3,"gross":4566,"discount":114.15,"vlc":4451.85,"status":"Válido"},{"id":"PV00286","date":"2026-04-23","client":"C038","rep":"R06","sku":"SKU0004","qty":5,"gross":9495,"discount":949.5,"vlc":8545.5,"status":"Válido"},{"id":"PV00287","date":"2026-04-17","client":"C022","rep":"R04","sku":"SKU0044","qty":8,"gross":17624,"discount":881.2,"vlc":16742.8,"status":"Válido"},{"id":"PV00288","date":"2026-05-25","client":"C042","rep":"R07","sku":"SKU0028","qty":5,"gross":15020,"discount":1502.0,"vlc":13518.0,"status":"Válido"},{"id":"PV00289","date":"2026-07-04","client":"C044","rep":"R07","sku":"SKU0014","qty":1,"gross":603,"discount":30.15,"vlc":572.85,"status":"Cancelado"},{"id":"PV00290","date":"2026-05-04","client":"C003","rep":"R01","sku":"SKU0023","qty":9,"gross":4257,"discount":106.43,"vlc":4150.57,"status":"Válido"},{"id":"PV00291","date":"2026-09-16","client":"C003","rep":"R06","sku":"SKU0005","qty":11,"gross":9614,"discount":769.12,"vlc":8844.88,"status":"Válido"},{"id":"PV00292","date":"2026-05-16","client":"C001","rep":"R01","sku":"SKU0011","qty":1,"gross":1742,"discount":43.55,"vlc":1698.45,"status":"Válido"},{"id":"PV00293","date":"2026-03-29","client":"C017","rep":"R04","sku":"SKU0052","qty":9,"gross":5031,"discount":0,"vlc":5031,"status":"Válido"},{"id":"PV00294","date":"2026-07-20","client":"C033","rep":"R08","sku":"SKU0033","qty":7,"gross":18242,"discount":912.1,"vlc":17329.9,"status":"Válido"},{"id":"PV00295","date":"2026-07-22","client":"C023","rep":"R05","sku":"SKU0059","qty":11,"gross":17809,"discount":445.23,"vlc":17363.77,"status":"Válido"},{"id":"PV00296","date":"2026-05-08","client":"C004","rep":"R04","sku":"SKU0044","qty":2,"gross":3554,"discount":0,"vlc":3554,"status":"Válido"},{"id":"PV00297","date":"2026-02-12","client":"C016","rep":"R05","sku":"SKU0065","qty":11,"gross":23969,"discount":2396.9,"vlc":21572.1,"status":"Válido"},{"id":"PV00298","date":"2026-02-26","client":"C015","rep":"R09","sku":"SKU0004","qty":10,"gross":23840,"discount":2384.0,"vlc":21456.0,"status":"Válido"},{"id":"PV00299","date":"2026-09-25","client":"C051","rep":"R07","sku":"SKU0025","qty":6,"gross":3852,"discount":0,"vlc":3852,"status":"Válido"},{"id":"PV00300","date":"2026-01-31","client":"C001","rep":"R01","sku":"SKU0007","qty":10,"gross":6100,"discount":610.0,"vlc":5490.0,"status":"Válido"},{"id":"PV00301","date":"2026-09-08","client":"C022","rep":"R02","sku":"SKU0012","qty":11,"gross":19448,"discount":0,"vlc":19448,"status":"Válido"},{"id":"PV00302","date":"2026-10-29","client":"C029","rep":"R02","sku":"SKU0006","qty":11,"gross":34056,"discount":2724.48,"vlc":31331.52,"status":"Válido"},{"id":"PV00303","date":"2026-06-09","client":"C068","rep":"R01","sku":"SKU0057","qty":2,"gross":4974,"discount":248.7,"vlc":4725.3,"status":"Válido"},{"id":"PV00304","date":"2026-02-07","client":"C001","rep":"R07","sku":"SKU0042","qty":1,"gross":1589,"discount":0,"vlc":1589,"status":"Válido"},{"id":"PV00305","date":"2026-06-06","client":"C019","rep":"R09","sku":"SKU0029","qty":2,"gross":4006,"discount":400.6,"vlc":3605.4,"status":"Válido"},{"id":"PV00306","date":"2026-10-27","client":"C031","rep":"R06","sku":"SKU0001","qty":7,"gross":12061,"discount":1206.1,"vlc":10854.9,"status":"Cancelado"},{"id":"PV00307","date":"2026-08-05","client":"C064","rep":"R08","sku":"SKU0033","qty":5,"gross":9335,"discount":233.38,"vlc":9101.62,"status":"Válido"},{"id":"PV00308","date":"2026-06-03","client":"C043","rep":"R07","sku":"SKU0002","qty":1,"gross":1903,"discount":95.15,"vlc":1807.85,"status":"Válido"},{"id":"PV00309","date":"2026-04-19","client":"C044","rep":"R02","sku":"SKU0003","qty":8,"gross":20184,"discount":1009.2,"vlc":19174.8,"status":"Válido"},{"id":"PV00310","date":"2026-02-28","client":"C046","rep":"R03","sku":"SKU0002","qty":5,"gross":15070,"discount":376.75,"vlc":14693.25,"status":"Válido"},{"id":"PV00311","date":"2026-05-21","client":"C033","rep":"R05","sku":"SKU0010","qty":2,"gross":1890,"discount":189.0,"vlc":1701.0,"status":"Válido"},{"id":"PV00312","date":"2026-09-20","client":"C016","rep":"R01","sku":"SKU0012","qty":11,"gross":8866,"discount":443.3,"vlc":8422.7,"status":"Válido"},{"id":"PV00313","date":"2026-01-17","client":"C039","rep":"R07","sku":"SKU0018","qty":10,"gross":29230,"discount":0,"vlc":29230,"status":"Válido"},{"id":"PV00314","date":"2026-07-17","client":"C024","rep":"R09","sku":"SKU0060","qty":6,"gross":5280,"discount":0,"vlc":5280,"status":"Válido"},{"id":"PV00315","date":"2026-03-03","client":"C041","rep":"R01","sku":"SKU0031","qty":5,"gross":6985,"discount":0,"vlc":6985,"status":"Válido"},{"id":"PV00316","date":"2026-03-02","client":"C056","rep":"R01","sku":"SKU0025","qty":9,"gross":5931,"discount":0,"vlc":5931,"status":"Válido"},{"id":"PV00317","date":"2026-07-02","client":"C016","rep":"R09","sku":"SKU0020","qty":1,"gross":2336,"discount":186.88,"vlc":2149.12,"status":"Válido"},{"id":"PV00318","date":"2026-02-28","client":"C009","rep":"R03","sku":"SKU0048","qty":10,"gross":31370,"discount":0,"vlc":31370,"status":"Válido"},{"id":"PV00319","date":"2026-10-28","client":"C035","rep":"R06","sku":"SKU0026","qty":11,"gross":27269,"discount":0,"vlc":27269,"status":"Válido"},{"id":"PV00320","date":"2026-09-09","client":"C025","rep":"R09","sku":"SKU0026","qty":7,"gross":5663,"discount":141.58,"vlc":5521.42,"status":"Válido"},{"id":"PV00321","date":"2026-04-17","client":"C010","rep":"R08","sku":"SKU0006","qty":6,"gross":10668,"discount":1066.8,"vlc":9601.2,"status":"Válido"},{"id":"PV00322","date":"2026-07-24","client":"C014","rep":"R02","sku":"SKU0061","qty":6,"gross":13842,"discount":1384.2,"vlc":12457.8,"status":"Válido"},{"id":"PV00323","date":"2026-06-28","client":"C010","rep":"R04","sku":"SKU0016","qty":4,"gross":11708,"discount":585.4,"vlc":11122.6,"status":"Cancelado"},{"id":"PV00324","date":"2026-01-31","client":"C010","rep":"R02","sku":"SKU0045","qty":1,"gross":765,"discount":61.2,"vlc":703.8,"status":"Válido"},{"id":"PV00325","date":"2026-06-09","client":"C036","rep":"R06","sku":"SKU0037","qty":11,"gross":30404,"discount":0,"vlc":30404,"status":"Válido"},{"id":"PV00326","date":"2026-06-27","client":"C034","rep":"R05","sku":"SKU0061","qty":2,"gross":1610,"discount":128.8,"vlc":1481.2,"status":"Válido"},{"id":"PV00327","date":"2026-04-08","client":"C042","rep":"R07","sku":"SKU0046","qty":8,"gross":5120,"discount":409.6,"vlc":4710.4,"status":"Válido"},{"id":"PV00328","date":"2026-08-16","client":"C018","rep":"R05","sku":"SKU0055","qty":1,"gross":1762,"discount":140.96,"vlc":1621.04,"status":"Válido"},{"id":"PV00329","date":"2026-09-13","client":"C035","rep":"R05","sku":"SKU0025","qty":2,"gross":1878,"discount":93.9,"vlc":1784.1,"status":"Válido"},{"id":"PV00330","date":"2026-06-18","client":"C067","rep":"R07","sku":"SKU0004","qty":6,"gross":7470,"discount":597.6,"vlc":6872.4,"status":"Válido"},{"id":"PV00331","date":"2026-07-08","client":"C031","rep":"R07","sku":"SKU0011","qty":4,"gross":2112,"discount":211.2,"vlc":1900.8,"status":"Válido"},{"id":"PV00332","date":"2026-01-21","client":"C061","rep":"R03","sku":"SKU0035","qty":9,"gross":17298,"discount":1729.8,"vlc":15568.2,"status":"Válido"},{"id":"PV00333","date":"2026-01-01","client":"C042","rep":"R05","sku":"SKU0006","qty":5,"gross":7430,"discount":371.5,"vlc":7058.5,"status":"Válido"},{"id":"PV00334","date":"2026-09-08","client":"C014","rep":"R01","sku":"SKU0040","qty":11,"gross":7139,"discount":0,"vlc":7139,"status":"Válido"},{"id":"PV00335","date":"2026-06-10","client":"C012","rep":"R01","sku":"SKU0013","qty":7,"gross":3598,"discount":359.8,"vlc":3238.2,"status":"Válido"},{"id":"PV00336","date":"2026-02-20","client":"C020","rep":"R01","sku":"SKU0062","qty":7,"gross":21483,"discount":537.08,"vlc":20945.92,"status":"Válido"},{"id":"PV00337","date":"2026-04-16","client":"C048","rep":"R09","sku":"SKU0027","qty":10,"gross":30630,"discount":0,"vlc":30630,"status":"Válido"},{"id":"PV00338","date":"2026-04-07","client":"C008","rep":"R04","sku":"SKU0021","qty":7,"gross":5474,"discount":547.4,"vlc":4926.6,"status":"Válido"},{"id":"PV00339","date":"2026-03-05","client":"C025","rep":"R07","sku":"SKU0056","qty":10,"gross":8910,"discount":445.5,"vlc":8464.5,"status":"Válido"},{"id":"PV00340","date":"2026-04-05","client":"C028","rep":"R07","sku":"SKU0056","qty":2,"gross":6210,"discount":621.0,"vlc":5589.0,"status":"Cancelado"},{"id":"PV00341","date":"2026-01-27","client":"C007","rep":"R01","sku":"SKU0032","qty":4,"gross":4912,"discount":122.8,"vlc":4789.2,"status":"Válido"},{"id":"PV00342","date":"2026-06-12","client":"C037","rep":"R02","sku":"SKU0028","qty":9,"gross":25596,"discount":0,"vlc":25596,"status":"Válido"},{"id":"PV00343","date":"2026-08-18","client":"C045","rep":"R06","sku":"SKU0053","qty":9,"gross":4167,"discount":104.18,"vlc":4062.82,"status":"Válido"},{"id":"PV00344","date":"2026-02-06","client":"C060","rep":"R08","sku":"SKU0056","qty":11,"gross":13211,"discount":1321.1,"vlc":11889.9,"status":"Válido"},{"id":"PV00345","date":"2026-01-09","client":"C045","rep":"R06","sku":"SKU0031","qty":1,"gross":1841,"discount":46.03,"vlc":1794.97,"status":"Válido"},{"id":"PV00346","date":"2026-04-01","client":"C003","rep":"R06","sku":"SKU0065","qty":1,"gross":3010,"discount":150.5,"vlc":2859.5,"status":"Válido"},{"id":"PV00347","date":"2026-05-28","client":"C012","rep":"R03","sku":"SKU0012","qty":9,"gross":9324,"discount":0,"vlc":9324,"status":"Válido"},{"id":"PV00348","date":"2026-01-18","client":"C029","rep":"R05","sku":"SKU0049","qty":2,"gross":4432,"discount":443.2,"vlc":3988.8,"status":"Válido"},{"id":"PV00349","date":"2026-01-29","client":"C069","rep":"R09","sku":"SKU0011","qty":10,"gross":13070,"discount":0,"vlc":13070,"status":"Válido"},{"id":"PV00350","date":"2026-08-20","client":"C060","rep":"R03","sku":"SKU0058","qty":7,"gross":16912,"discount":845.6,"vlc":16066.4,"status":"Válido"},{"id":"PV00351","date":"2026-01-31","client":"C017","rep":"R06","sku":"SKU0058","qty":1,"gross":1408,"discount":70.4,"vlc":1337.6,"status":"Válido"},{"id":"PV00352","date":"2026-03-29","client":"C042","rep":"R06","sku":"SKU0034","qty":11,"gross":31086,"discount":1554.3,"vlc":29531.7,"status":"Válido"},{"id":"PV00353","date":"2026-09-22","client":"C021","rep":"R07","sku":"SKU0003","qty":3,"gross":2748,"discount":0,"vlc":2748,"status":"Válido"},{"id":"PV00354","date":"2026-08-16","client":"C024","rep":"R08","sku":"SKU0014","qty":8,"gross":5280,"discount":264.0,"vlc":5016.0,"status":"Válido"},{"id":"PV00355","date":"2026-09-11","client":"C055","rep":"R01","sku":"SKU0049","qty":10,"gross":17320,"discount":433.0,"vlc":16887.0,"status":"Válido"},{"id":"PV00356","date":"2026-10-10","client":"C064","rep":"R04","sku":"SKU0050","qty":5,"gross":12075,"discount":1207.5,"vlc":10867.5,"status":"Válido"},{"id":"PV00357","date":"2026-07-17","client":"C064","rep":"R01","sku":"SKU0037","qty":11,"gross":10934,"discount":1093.4,"vlc":9840.6,"status":"Cancelado"},{"id":"PV00358","date":"2026-07-05","client":"C017","rep":"R08","sku":"SKU0058","qty":2,"gross":3446,"discount":86.15,"vlc":3359.85,"status":"Válido"},{"id":"PV00359","date":"2026-09-03","client":"C029","rep":"R05","sku":"SKU0009","qty":4,"gross":10284,"discount":1028.4,"vlc":9255.6,"status":"Válido"},{"id":"PV00360","date":"2026-10-14","client":"C048","rep":"R07","sku":"SKU0029","qty":10,"gross":8580,"discount":429.0,"vlc":8151.0,"status":"Válido"},{"id":"PV00361","date":"2026-08-22","client":"C053","rep":"R07","sku":"SKU0034","qty":1,"gross":1334,"discount":0,"vlc":1334,"status":"Válido"},{"id":"PV00362","date":"2026-07-19","client":"C065","rep":"R08","sku":"SKU0050","qty":1,"gross":2340,"discount":58.5,"vlc":2281.5,"status":"Válido"},{"id":"PV00363","date":"2026-08-07","client":"C012","rep":"R06","sku":"SKU0032","qty":9,"gross":28701,"discount":0,"vlc":28701,"status":"Válido"},{"id":"PV00364","date":"2026-05-20","client":"C040","rep":"R04","sku":"SKU0047","qty":6,"gross":8958,"discount":447.9,"vlc":8510.1,"status":"Válido"},{"id":"PV00365","date":"2026-08-24","client":"C072","rep":"R08","sku":"SKU0026","qty":11,"gross":17919,"discount":895.95,"vlc":17023.05,"status":"Válido"},{"id":"PV00366","date":"2026-01-16","client":"C066","rep":"R05","sku":"SKU0002","qty":1,"gross":1872,"discount":187.2,"vlc":1684.8,"status":"Válido"},{"id":"PV00367","date":"2026-03-24","client":"C045","rep":"R04","sku":"SKU0055","qty":1,"gross":1939,"discount":96.95,"vlc":1842.05,"status":"Válido"},{"id":"PV00368","date":"2026-06-04","client":"C033","rep":"R02","sku":"SKU0061","qty":10,"gross":6380,"discount":159.5,"vlc":6220.5,"status":"Válido"},{"id":"PV00369","date":"2026-07-10","client":"C048","rep":"R06","sku":"SKU0021","qty":4,"gross":7468,"discount":0,"vlc":7468,"status":"Válido"},{"id":"PV00370","date":"2026-06-05","client":"C064","rep":"R02","sku":"SKU0039","qty":9,"gross":26298,"discount":2103.84,"vlc":24194.16,"status":"Válido"},{"id":"PV00371","date":"2026-03-26","client":"C031","rep":"R09","sku":"SKU0041","qty":9,"gross":4851,"discount":121.28,"vlc":4729.72,"status":"Válido"},{"id":"PV00372","date":"2026-06-20","client":"C042","rep":"R06","sku":"SKU0028","qty":5,"gross":15570,"discount":778.5,"vlc":14791.5,"status":"Válido"},{"id":"PV00373","date":"2026-07-27","client":"C068","rep":"R06","sku":"SKU0054","qty":9,"gross":24408,"discount":0,"vlc":24408,"status":"Válido"},{"id":"PV00374","date":"2026-09-20","client":"C062","rep":"R02","sku":"SKU0010","qty":6,"gross":18948,"discount":1515.84,"vlc":17432.16,"status":"Cancelado"},{"id":"PV00375","date":"2026-02-05","client":"C052","rep":"R07","sku":"SKU0014","qty":1,"gross":493,"discount":12.33,"vlc":480.67,"status":"Válido"},{"id":"PV00376","date":"2026-10-05","client":"C031","rep":"R06","sku":"SKU0063","qty":10,"gross":7140,"discount":0,"vlc":7140,"status":"Válido"},{"id":"PV00377","date":"2026-08-31","client":"C044","rep":"R02","sku":"SKU0020","qty":6,"gross":5634,"discount":450.72,"vlc":5183.28,"status":"Válido"},{"id":"PV00378","date":"2026-08-19","client":"C070","rep":"R05","sku":"SKU0035","qty":6,"gross":2892,"discount":289.2,"vlc":2602.8,"status":"Válido"},{"id":"PV00379","date":"2026-07-26","client":"C012","rep":"R09","sku":"SKU0055","qty":1,"gross":2099,"discount":209.9,"vlc":1889.1,"status":"Válido"},{"id":"PV00380","date":"2026-07-17","client":"C011","rep":"R05","sku":"SKU0043","qty":9,"gross":10440,"discount":261.0,"vlc":10179.0,"status":"Válido"},{"id":"PV00381","date":"2026-08-14","client":"C041","rep":"R03","sku":"SKU0037","qty":5,"gross":15770,"discount":394.25,"vlc":15375.75,"status":"Válido"},{"id":"PV00382","date":"2026-07-08","client":"C011","rep":"R01","sku":"SKU0017","qty":11,"gross":10780,"discount":862.4,"vlc":9917.6,"status":"Válido"},{"id":"PV00383","date":"2026-09-20","client":"C016","rep":"R08","sku":"SKU0005","qty":11,"gross":4829,"discount":241.45,"vlc":4587.55,"status":"Válido"},{"id":"PV00384","date":"2026-09-30","client":"C072","rep":"R01","sku":"SKU0004","qty":4,"gross":9552,"discount":764.16,"vlc":8787.84,"status":"Válido"},{"id":"PV00385","date":"2026-07-01","client":"C044","rep":"R04","sku":"SKU0053","qty":9,"gross":8703,"discount":870.3,"vlc":7832.7,"status":"Válido"},{"id":"PV00386","date":"2026-06-25","client":"C050","rep":"R05","sku":"SKU0001","qty":8,"gross":21352,"discount":533.8,"vlc":20818.2,"status":"Válido"},{"id":"PV00387","date":"2026-10-17","client":"C049","rep":"R03","sku":"SKU0004","qty":7,"gross":18298,"discount":0,"vlc":18298,"status":"Válido"},{"id":"PV00388","date":"2026-07-24","client":"C035","rep":"R03","sku":"SKU0004","qty":3,"gross":4224,"discount":422.4,"vlc":3801.6,"status":"Válido"},{"id":"PV00389","date":"2026-04-11","client":"C058","rep":"R05","sku":"SKU0011","qty":4,"gross":8836,"discount":220.9,"vlc":8615.1,"status":"Válido"},{"id":"PV00390","date":"2026-02-11","client":"C033","rep":"R03","sku":"SKU0015","qty":4,"gross":4160,"discount":104.0,"vlc":4056.0,"status":"Válido"},{"id":"PV00391","date":"2026-09-10","client":"C009","rep":"R03","sku":"SKU0022","qty":8,"gross":12128,"discount":0,"vlc":12128,"status":"Cancelado"},{"id":"PV00392","date":"2026-06-04","client":"C006","rep":"R08","sku":"SKU0029","qty":10,"gross":16440,"discount":1644.0,"vlc":14796.0,"status":"Válido"},{"id":"PV00393","date":"2026-01-08","client":"C068","rep":"R05","sku":"SKU0049","qty":8,"gross":5504,"discount":550.4,"vlc":4953.6,"status":"Válido"},{"id":"PV00394","date":"2026-07-28","client":"C044","rep":"R03","sku":"SKU0027","qty":1,"gross":2515,"discount":251.5,"vlc":2263.5,"status":"Válido"},{"id":"PV00395","date":"2026-02-12","client":"C015","rep":"R06","sku":"SKU0010","qty":3,"gross":3309,"discount":165.45,"vlc":3143.55,"status":"Válido"},{"id":"PV00396","date":"2026-07-19","client":"C017","rep":"R01","sku":"SKU0060","qty":4,"gross":8556,"discount":684.48,"vlc":7871.52,"status":"Válido"},{"id":"PV00397","date":"2026-08-02","client":"C048","rep":"R09","sku":"SKU0002","qty":9,"gross":7389,"discount":184.73,"vlc":7204.27,"status":"Válido"},{"id":"PV00398","date":"2026-07-13","client":"C050","rep":"R02","sku":"SKU0055","qty":11,"gross":25388,"discount":634.7,"vlc":24753.3,"status":"Válido"},{"id":"PV00399","date":"2026-05-01","client":"C061","rep":"R09","sku":"SKU0003","qty":5,"gross":6135,"discount":153.38,"vlc":5981.62,"status":"Válido"},{"id":"PV00400","date":"2026-02-16","client":"C059","rep":"R04","sku":"SKU0031","qty":10,"gross":10080,"discount":0,"vlc":10080,"status":"Válido"},{"id":"PV00401","date":"2026-03-04","client":"C037","rep":"R04","sku":"SKU0003","qty":7,"gross":15372,"discount":384.3,"vlc":14987.7,"status":"Válido"},{"id":"PV00402","date":"2026-03-15","client":"C037","rep":"R08","sku":"SKU0011","qty":1,"gross":1622,"discount":129.76,"vlc":1492.24,"status":"Válido"},{"id":"PV00403","date":"2026-06-03","client":"C015","rep":"R03","sku":"SKU0035","qty":4,"gross":3200,"discount":0,"vlc":3200,"status":"Válido"},{"id":"PV00404","date":"2026-07-26","client":"C051","rep":"R06","sku":"SKU0033","qty":10,"gross":27250,"discount":0,"vlc":27250,"status":"Válido"},{"id":"PV00405","date":"2026-10-25","client":"C017","rep":"R09","sku":"SKU0039","qty":3,"gross":3699,"discount":92.48,"vlc":3606.52,"status":"Válido"},{"id":"PV00406","date":"2026-02-04","client":"C026","rep":"R04","sku":"SKU0006","qty":3,"gross":1494,"discount":119.52,"vlc":1374.48,"status":"Válido"},{"id":"PV00407","date":"2026-05-09","client":"C063","rep":"R06","sku":"SKU0021","qty":8,"gross":5080,"discount":254.0,"vlc":4826.0,"status":"Válido"},{"id":"PV00408","date":"2026-07-08","client":"C014","rep":"R08","sku":"SKU0039","qty":3,"gross":1473,"discount":147.3,"vlc":1325.7,"status":"Cancelado"},{"id":"PV00409","date":"2026-07-31","client":"C059","rep":"R04","sku":"SKU0015","qty":7,"gross":18249,"discount":456.23,"vlc":17792.77,"status":"Válido"},{"id":"PV00410","date":"2026-06-22","client":"C003","rep":"R07","sku":"SKU0060","qty":10,"gross":11980,"discount":599.0,"vlc":11381.0,"status":"Válido"},{"id":"PV00411","date":"2026-06-12","client":"C017","rep":"R05","sku":"SKU0064","qty":9,"gross":5652,"discount":452.16,"vlc":5199.84,"status":"Válido"},{"id":"PV00412","date":"2026-04-17","client":"C031","rep":"R09","sku":"SKU0011","qty":1,"gross":2527,"discount":126.35,"vlc":2400.65,"status":"Válido"},{"id":"PV00413","date":"2026-10-16","client":"C040","rep":"R04","sku":"SKU0033","qty":2,"gross":1534,"discount":122.72,"vlc":1411.28,"status":"Válido"},{"id":"PV00414","date":"2026-03-06","client":"C059","rep":"R05","sku":"SKU0059","qty":6,"gross":8448,"discount":422.4,"vlc":8025.6,"status":"Válido"},{"id":"PV00415","date":"2026-03-04","client":"C008","rep":"R08","sku":"SKU0050","qty":6,"gross":4242,"discount":212.1,"vlc":4029.9,"status":"Válido"},{"id":"PV00416","date":"2026-07-19","client":"C061","rep":"R07","sku":"SKU0030","qty":11,"gross":19008,"discount":1900.8,"vlc":17107.2,"status":"Válido"},{"id":"PV00417","date":"2026-02-16","client":"C071","rep":"R09","sku":"SKU0038","qty":10,"gross":21350,"discount":1708.0,"vlc":19642.0,"status":"Válido"},{"id":"PV00418","date":"2026-03-05","client":"C017","rep":"R01","sku":"SKU0021","qty":1,"gross":1796,"discount":89.8,"vlc":1706.2,"status":"Válido"},{"id":"PV00419","date":"2026-08-06","client":"C052","rep":"R02","sku":"SKU0053","qty":5,"gross":10670,"discount":0,"vlc":10670,"status":"Válido"},{"id":"PV00420","date":"2026-10-10","client":"C055","rep":"R08","sku":"SKU0033","qty":7,"gross":5089,"discount":254.45,"vlc":4834.55,"status":"Válido"},{"id":"PV00421","date":"2026-06-10","client":"C005","rep":"R06","sku":"SKU0063","qty":1,"gross":1059,"discount":84.72,"vlc":974.28,"status":"Válido"},{"id":"PV00422","date":"2026-06-03","client":"C027","rep":"R02","sku":"SKU0006","qty":10,"gross":28850,"discount":2885.0,"vlc":25965.0,"status":"Válido"},{"id":"PV00423","date":"2026-03-29","client":"C006","rep":"R07","sku":"SKU0046","qty":8,"gross":9464,"discount":0,"vlc":9464,"status":"Válido"},{"id":"PV00424","date":"2026-02-08","client":"C064","rep":"R07","sku":"SKU0022","qty":7,"gross":12726,"discount":636.3,"vlc":12089.7,"status":"Válido"},{"id":"PV00425","date":"2026-06-06","client":"C007","rep":"R02","sku":"SKU0055","qty":11,"gross":17105,"discount":855.25,"vlc":16249.75,"status":"Cancelado"},{"id":"PV00426","date":"2026-02-24","client":"C057","rep":"R09","sku":"SKU0052","qty":1,"gross":1746,"discount":139.68,"vlc":1606.32,"status":"Válido"},{"id":"PV00427","date":"2026-01-18","client":"C012","rep":"R03","sku":"SKU0011","qty":11,"gross":23430,"discount":1874.4,"vlc":21555.6,"status":"Válido"},{"id":"PV00428","date":"2026-07-19","client":"C017","rep":"R06","sku":"SKU0064","qty":1,"gross":508,"discount":50.8,"vlc":457.2,"status":"Válido"},{"id":"PV00429","date":"2026-04-19","client":"C020","rep":"R03","sku":"SKU0026","qty":6,"gross":12642,"discount":1264.2,"vlc":11377.8,"status":"Válido"},{"id":"PV00430","date":"2026-06-12","client":"C050","rep":"R01","sku":"SKU0010","qty":7,"gross":12509,"discount":312.73,"vlc":12196.27,"status":"Válido"},{"id":"PV00431","date":"2026-04-15","client":"C041","rep":"R05","sku":"SKU0063","qty":3,"gross":7722,"discount":772.2,"vlc":6949.8,"status":"Válido"},{"id":"PV00432","date":"2026-07-21","client":"C017","rep":"R06","sku":"SKU0002","qty":8,"gross":11416,"discount":285.4,"vlc":11130.6,"status":"Válido"},{"id":"PV00433","date":"2026-05-03","client":"C063","rep":"R05","sku":"SKU0008","qty":10,"gross":21310,"discount":2131.0,"vlc":19179.0,"status":"Válido"},{"id":"PV00434","date":"2026-06-09","client":"C015","rep":"R02","sku":"SKU0041","qty":7,"gross":6510,"discount":520.8,"vlc":5989.2,"status":"Válido"},{"id":"PV00435","date":"2026-09-19","client":"C050","rep":"R08","sku":"SKU0001","qty":5,"gross":11205,"discount":1120.5,"vlc":10084.5,"status":"Válido"},{"id":"PV00436","date":"2026-06-12","client":"C001","rep":"R05","sku":"SKU0059","qty":3,"gross":8661,"discount":0,"vlc":8661,"status":"Válido"},{"id":"PV00437","date":"2026-02-03","client":"C036","rep":"R08","sku":"SKU0045","qty":2,"gross":3700,"discount":92.5,"vlc":3607.5,"status":"Válido"},{"id":"PV00438","date":"2026-01-01","client":"C067","rep":"R03","sku":"SKU0009","qty":3,"gross":2838,"discount":70.95,"vlc":2767.05,"status":"Válido"},{"id":"PV00439","date":"2026-08-18","client":"C040","rep":"R01","sku":"SKU0051","qty":11,"gross":27544,"discount":688.6,"vlc":26855.4,"status":"Válido"},{"id":"PV00440","date":"2026-01-03","client":"C028","rep":"R09","sku":"SKU0034","qty":9,"gross":22806,"discount":2280.6,"vlc":20525.4,"status":"Válido"},{"id":"PV00441","date":"2026-07-03","client":"C004","rep":"R06","sku":"SKU0028","qty":5,"gross":7990,"discount":0,"vlc":7990,"status":"Válido"},{"id":"PV00442","date":"2026-05-13","client":"C065","rep":"R08","sku":"SKU0044","qty":10,"gross":9500,"discount":0,"vlc":9500,"status":"Cancelado"},{"id":"PV00443","date":"2026-04-25","client":"C057","rep":"R06","sku":"SKU0030","qty":1,"gross":3047,"discount":152.35,"vlc":2894.65,"status":"Válido"},{"id":"PV00444","date":"2026-02-26","client":"C007","rep":"R01","sku":"SKU0053","qty":8,"gross":16744,"discount":837.2,"vlc":15906.8,"status":"Válido"},{"id":"PV00445","date":"2026-07-03","client":"C066","rep":"R06","sku":"SKU0055","qty":11,"gross":33924,"discount":0,"vlc":33924,"status":"Válido"},{"id":"PV00446","date":"2026-04-30","client":"C049","rep":"R09","sku":"SKU0005","qty":10,"gross":21520,"discount":1721.6,"vlc":19798.4,"status":"Válido"},{"id":"PV00447","date":"2026-05-16","client":"C034","rep":"R03","sku":"SKU0012","qty":10,"gross":15870,"discount":1269.6,"vlc":14600.4,"status":"Válido"},{"id":"PV00448","date":"2026-07-12","client":"C049","rep":"R05","sku":"SKU0037","qty":7,"gross":10101,"discount":505.05,"vlc":9595.95,"status":"Válido"},{"id":"PV00449","date":"2026-01-26","client":"C010","rep":"R09","sku":"SKU0051","qty":5,"gross":5920,"discount":296.0,"vlc":5624.0,"status":"Válido"},{"id":"PV00450","date":"2026-07-24","client":"C018","rep":"R04","sku":"SKU0014","qty":11,"gross":22792,"discount":0,"vlc":22792,"status":"Válido"},{"id":"PV00451","date":"2026-05-10","client":"C027","rep":"R02","sku":"SKU0051","qty":1,"gross":2339,"discount":116.95,"vlc":2222.05,"status":"Válido"},{"id":"PV00452","date":"2026-08-08","client":"C015","rep":"R03","sku":"SKU0051","qty":10,"gross":16660,"discount":1332.8,"vlc":15327.2,"status":"Válido"},{"id":"PV00453","date":"2026-03-05","client":"C049","rep":"R04","sku":"SKU0028","qty":6,"gross":11244,"discount":562.2,"vlc":10681.8,"status":"Válido"},{"id":"PV00454","date":"2026-02-25","client":"C042","rep":"R06","sku":"SKU0052","qty":1,"gross":998,"discount":24.95,"vlc":973.05,"status":"Válido"},{"id":"PV00455","date":"2026-03-24","client":"C054","rep":"R04","sku":"SKU0026","qty":11,"gross":12408,"discount":992.64,"vlc":11415.36,"status":"Válido"},{"id":"PV00456","date":"2026-04-23","client":"C032","rep":"R01","sku":"SKU0041","qty":11,"gross":24090,"discount":2409.0,"vlc":21681.0,"status":"Válido"},{"id":"PV00457","date":"2026-04-24","client":"C053","rep":"R01","sku":"SKU0005","qty":2,"gross":1594,"discount":0,"vlc":1594,"status":"Válido"},{"id":"PV00458","date":"2026-07-03","client":"C006","rep":"R07","sku":"SKU0014","qty":11,"gross":6237,"discount":155.93,"vlc":6081.07,"status":"Válido"},{"id":"PV00459","date":"2026-05-28","client":"C025","rep":"R01","sku":"SKU0003","qty":8,"gross":8520,"discount":213.0,"vlc":8307.0,"status":"Cancelado"},{"id":"PV00460","date":"2026-03-21","client":"C033","rep":"R07","sku":"SKU0011","qty":5,"gross":9660,"discount":0,"vlc":9660,"status":"Válido"},{"id":"PV00461","date":"2026-05-10","client":"C027","rep":"R03","sku":"SKU0017","qty":4,"gross":11768,"discount":588.4,"vlc":11179.6,"status":"Válido"},{"id":"PV00462","date":"2026-04-30","client":"C038","rep":"R02","sku":"SKU0049","qty":9,"gross":10341,"discount":827.28,"vlc":9513.72,"status":"Válido"},{"id":"PV00463","date":"2026-03-02","client":"C002","rep":"R03","sku":"SKU0060","qty":4,"gross":3644,"discount":364.4,"vlc":3279.6,"status":"Válido"},{"id":"PV00464","date":"2026-03-12","client":"C037","rep":"R02","sku":"SKU0027","qty":2,"gross":5728,"discount":458.24,"vlc":5269.76,"status":"Válido"},{"id":"PV00465","date":"2026-01-05","client":"C014","rep":"R05","sku":"SKU0018","qty":5,"gross":3530,"discount":282.4,"vlc":3247.6,"status":"Válido"},{"id":"PV00466","date":"2026-04-16","client":"C042","rep":"R05","sku":"SKU0006","qty":10,"gross":29770,"discount":1488.5,"vlc":28281.5,"status":"Válido"},{"id":"PV00467","date":"2026-03-06","client":"C069","rep":"R09","sku":"SKU0064","qty":2,"gross":5272,"discount":131.8,"vlc":5140.2,"status":"Válido"},{"id":"PV00468","date":"2026-01-22","client":"C036","rep":"R02","sku":"SKU0015","qty":3,"gross":5928,"discount":148.2,"vlc":5779.8,"status":"Válido"},{"id":"PV00469","date":"2026-08-17","client":"C062","rep":"R07","sku":"SKU0035","qty":7,"gross":18998,"discount":1899.8,"vlc":17098.2,"status":"Válido"},{"id":"PV00470","date":"2026-09-27","client":"C068","rep":"R03","sku":"SKU0053","qty":8,"gross":11568,"discount":0,"vlc":11568,"status":"Válido"},{"id":"PV00471","date":"2026-09-17","client":"C043","rep":"R09","sku":"SKU0010","qty":9,"gross":9081,"discount":454.05,"vlc":8626.95,"status":"Válido"},{"id":"PV00472","date":"2026-02-26","client":"C053","rep":"R04","sku":"SKU0031","qty":4,"gross":5008,"discount":500.8,"vlc":4507.2,"status":"Válido"},{"id":"PV00473","date":"2026-07-27","client":"C046","rep":"R01","sku":"SKU0058","qty":10,"gross":5360,"discount":268.0,"vlc":5092.0,"status":"Válido"},{"id":"PV00474","date":"2026-06-01","client":"C038","rep":"R09","sku":"SKU0038","qty":9,"gross":11475,"discount":1147.5,"vlc":10327.5,"status":"Válido"},{"id":"PV00475","date":"2026-05-15","client":"C023","rep":"R01","sku":"SKU0054","qty":11,"gross":27907,"discount":0,"vlc":27907,"status":"Válido"},{"id":"PV00476","date":"2026-10-11","client":"C051","rep":"R08","sku":"SKU0046","qty":2,"gross":6106,"discount":305.3,"vlc":5800.7,"status":"Cancelado"},{"id":"PV00477","date":"2026-05-02","client":"C033","rep":"R07","sku":"SKU0008","qty":6,"gross":10986,"discount":0,"vlc":10986,"status":"Válido"},{"id":"PV00478","date":"2026-09-12","client":"C021","rep":"R06","sku":"SKU0027","qty":2,"gross":3434,"discount":274.72,"vlc":3159.28,"status":"Válido"},{"id":"PV00479","date":"2026-06-09","client":"C037","rep":"R02","sku":"SKU0031","qty":11,"gross":15037,"discount":1202.96,"vlc":13834.04,"status":"Válido"},{"id":"PV00480","date":"2026-02-10","client":"C018","rep":"R05","sku":"SKU0026","qty":9,"gross":17010,"discount":850.5,"vlc":16159.5,"status":"Válido"},{"id":"PV00481","date":"2026-04-27","client":"C043","rep":"R09","sku":"SKU0046","qty":7,"gross":13013,"discount":0,"vlc":13013,"status":"Válido"},{"id":"PV00482","date":"2026-07-12","client":"C023","rep":"R04","sku":"SKU0054","qty":1,"gross":2571,"discount":64.28,"vlc":2506.72,"status":"Válido"},{"id":"PV00483","date":"2026-01-29","client":"C011","rep":"R01","sku":"SKU0027","qty":2,"gross":2168,"discount":54.2,"vlc":2113.8,"status":"Válido"},{"id":"PV00484","date":"2026-06-12","client":"C059","rep":"R01","sku":"SKU0004","qty":9,"gross":12015,"discount":0,"vlc":12015,"status":"Válido"},{"id":"PV00485","date":"2026-08-22","client":"C068","rep":"R04","sku":"SKU0013","qty":9,"gross":6588,"discount":329.4,"vlc":6258.6,"status":"Válido"},{"id":"PV00486","date":"2026-07-24","client":"C008","rep":"R02","sku":"SKU0033","qty":3,"gross":7041,"discount":176.03,"vlc":6864.97,"status":"Válido"},{"id":"PV00487","date":"2026-03-02","client":"C071","rep":"R03","sku":"SKU0044","qty":11,"gross":9713,"discount":485.65,"vlc":9227.35,"status":"Válido"},{"id":"PV00488","date":"2026-05-24","client":"C019","rep":"R07","sku":"SKU0036","qty":9,"gross":17631,"discount":0,"vlc":17631,"status":"Válido"},{"id":"PV00489","date":"2026-04-26","client":"C043","rep":"R02","sku":"SKU0041","qty":7,"gross":16625,"discount":0,"vlc":16625,"status":"Válido"}],"targets":{"1":625000,"2":650000,"3":675000,"4":700000,"5":725000,"6":750000,"7":775000,"8":800000,"9":825000,"10":850000,"11":875000,"12":900000}};
const pageMap=DB.modules.flatMap(m=>m.pages.map(p=>({...p,module:m.id,moduleName:m.name})));const state={page:'AC-01',period:String(new Date().getMonth()+1),profile:'director',manager:'all',rep:'all',carteira:'all',uf:'all',type:'all',focus:'all',sku:'all',search:''};const byId=(id)=>document.getElementById(id);const names={};DB.clients.forEach(x=>names[x.id]=x.name);DB.reps.forEach(x=>names[x.id]=x.name);DB.products.forEach(x=>names[x.id]=x.name);const reps=Object.fromEntries(DB.reps.map(r=>[r.id,r]));const clients=Object.fromEntries(DB.clients.map(c=>[c.id,c]));const skus=Object.fromEntries(DB.products.map(p=>[p.id,p]));const money=n=>new Intl.NumberFormat('pt-BR',{style:'currency',currency:'BRL',maximumFractionDigits:2}).format(n||0);const fmt=n=>new Intl.NumberFormat('pt-BR',{maximumFractionDigits:1}).format(n||0);const pct=n=>`\${fmt(n)}%`;const sum=(a,f)=>a.reduce((s,x)=>s+f(x),0);const uniq=a=>new Set(a).size;const esc=x=>String(x??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));const pnum=d=>Number(d.slice(5,7));const valid=()=>DB.orders.filter(o=>o.status==='Válido');let latestRows=[];let latestCols=[];const p=()=>pageMap.find(x=>x.id===state.page);const select=(name,opts)=>`<div class="field"><label>\${name}</label><select data-filter="\${name}">\${opts.map(([v,l])=>`<option value="\${esc(v)}">\${esc(l)}</option>`).join('')}</select></div>`;
function filtered(){return valid().filter(o=>{const r=reps[o.rep],c=clients[o.client],s=skus[o.sku];if(state.period!=='all'&&pnum(o.date)!==Number(state.period))return false;if(state.profile==='manager'&&r.manager!=='Norte')return false;if(state.profile==='rep'&&r.id!=='R01')return false;if(isRealPage()&&state.manager!=='all'&&r.manager!==state.manager)return false;if(isRealPage()&&state.rep!=='all'&&o.rep!==state.rep)return false;if(isRealPage()&&state.uf!=='all'&&c.uf!==state.uf)return false;if(isRealPage()&&state.type!=='all'&&s.type!==state.type)return false;if(state.focus!=='all'){if(state.focus.startsWith('C')&&o.client!==state.focus)return false;if(state.focus.startsWith('SKU')&&o.sku!==state.focus)return false;if(state.focus.startsWith('R')&&o.rep!==state.focus)return false}return true})}
function base(){let a=filtered();let v=sum(a,x=>x.vlc),orderCount=uniq(a.map(x=>x.id));return {a,v,orders:orderCount,customers:uniq(a.map(x=>x.client)),skus:uniq(a.map(x=>x.sku)),qty:sum(a,x=>x.qty),ticket:orderCount?v/orderCount:0}}
function group(a,fn){let map=new Map();a.forEach(o=>{let k=fn(o);if(!map.has(k))map.set(k,[]);map.get(k).push(o)});return [...map.entries()].map(([k,rows])=>({key:k,rows,vlc:sum(rows,o=>o.vlc),orders:uniq(rows.map(o=>o.id)),clients:uniq(rows.map(o=>o.client)),qty:sum(rows,o=>o.qty)})).sort((x,y)=>y.vlc-x.vlc)}
function groups(kind,a){const rules={day:o=>o.date,week:o=>{let d=new Date(o.date+'T12:00:00Z');d.setUTCDate(d.getUTCDate()+4-(d.getUTCDay()||7));let y=d.getUTCFullYear();let first=new Date(Date.UTC(y,0,1));return `\${y}-S\${String(Math.ceil((((d-first)/86400000)+1)/7)).padStart(2,'0')}`},month:o=>o.date.slice(0,7),year:o=>o.date.slice(0,4),goals:o=>reps[o.rep].name,sales:o=>skus[o.sku].type,orders:o=>o.id,trend:o=>o.date.slice(0,7),intelligence:o=>clients[o.client].uf,query:o=>state.queryGroup==='client'?clients[o.client].name:state.queryGroup==='sku'?skus[o.sku].name:state.queryGroup==='uf'?clients[o.client].uf:reps[o.rep].name,portfolio:o=>clients[o.client].rep,client360:o=>o.date,behavior:o=>o.client,recovery:o=>o.client,products:o=>skus[o.sku].type,typology:o=>skus[o.sku].type,sku360:o=>o.date,productIntel:o=>o.sku,reps:o=>o.rep,rep360:o=>o.date,repgoals:o=>o.rep,repportfolio:o=>o.client,geo:o=>clients[o.client].uf,map:o=>clients[o.client].city,region:o=>clients[o.client].uf,expansion:o=>clients[o.client].city};return group(a,rules[kind]||rules.sales)}

/* v4.7.2 - Nomes oficiais do cadastro Sankhya, apenas apresentação.
   Codigos CODPARC/CODPROD e consultas comerciais permanecem inalterados. */
const CADASTROS_NOMES=document.getElementById('haialaNomesCadastros');
function lerNomes(classe){
 const mapa=new Map();
 if(!CADASTROS_NOMES)return mapa;
 CADASTROS_NOMES.querySelectorAll(classe).forEach(el=>{
   const cod=String(el.dataset.code||'').trim();
   const nome=String(el.dataset.name||'').trim().replace(/\\s+/g,' ');
   if(cod && nome)mapa.set(cod,nome);
 });
 return mapa;
}
function lerClientesCadastro(){
 const mapa=new Map();
 if(!CADASTROS_NOMES)return mapa;
 CADASTROS_NOMES.querySelectorAll('.haiala-nome-cliente').forEach(el=>{
   const cod=String(el.dataset.code||'').trim();
   const nome=String(el.dataset.name||'').trim().replace(/\s+/g,' ');
   const cidade=String(el.dataset.city||'').trim().replace(/\s+/g,' ');
   const uf=String(el.dataset.uf||'').trim().replace(/\s+/g,' ');
   if(cod)mapa.set(cod,{nome,cidade,uf});
 });
 return mapa;
}
const CADASTRO_CLIENTES=lerClientesCadastro();
const NOMES_CLIENTES=new Map([...CADASTRO_CLIENTES.entries()].map(([cod,obj])=>[cod,obj.nome]));
const NOMES_SKUS=lerNomes('.haiala-nome-produto');
const DESCRICOES_TIPOLOGIA=(()=>{
 const m=new Map();
 if(!CADASTROS_NOMES)return m;
 CADASTROS_NOMES.querySelectorAll('.haiala-opcao-tipologia').forEach(el=>{
  const cod=String(el.dataset.code||'').trim();
  const descricao=String(el.dataset.description||'').trim().replace(/\s+/g,' ');
  if(cod && descricao)m.set(cod,descricao);
 });
 return m;
})();
function rotuloTipologia(codigo){
 if(codigo==='(SEM TIPOLOGIA)')return codigo;
 const descricao=DESCRICOES_TIPOLOGIA.get(String(codigo));
 return String(codigo)+(descricao?' - '+descricao:'');
}

function rotuloCliente(id){
 const cadastro=CADASTRO_CLIENTES.get(String(id));
 const nome=cadastro&&cadastro.nome?cadastro.nome:'';
 const cidade=cadastro&&cadastro.cidade&&cadastro.cidade!=='(SEM CIDADE)'?cadastro.cidade:'';
 return String(id)+(nome?' - '+nome:' - Nome indisponível')+(cidade?' - '+cidade:'');
}
// v22: UF somente na identificação do cliente do popup de Pedidos.
function rotuloClientePedido(id){
 const cadastro=CADASTRO_CLIENTES.get(String(id));
 const uf=cadastro&&cadastro.uf&&cadastro.uf!=='(SEM UF)'?cadastro.uf:'';
 return rotuloCliente(id)+(uf?' / '+uf:'');
}
function rotuloSKU(id){
 const nome=NOMES_SKUS.get(String(id));
 return String(id)+(nome?' - '+nome:' - Descrição indisponível');
}

/* v5.3.3.14.6.4 - Multiseleção de clientes por CODPARC.
   Todos => sem restrição; N códigos => união dos clientes, sem duplicar pedidos. */
function clientMultiHTML(opts){
 const allowed=opts.filter(([id])=>String(id).startsWith('CLI:'));
 const ids=clientIds();
 const summary=ids.length===0?'Todos os clientes':ids.length===1?(allowed.find(([id])=>id==='CLI:'+ids[0])?.[1]||ids[0]):ids.length+' clientes selecionados';
 const disabled=allowed.length===0;
 return '<div class="field haiala-client-field"><label>Cliente</label><div class="haiala-client-multi" id="haialaClientMulti">'+
 '<button type="button" class="haiala-client-toggle" id="haialaClientToggle" aria-expanded="false"'+(disabled?' disabled':'')+'><span class="haiala-client-summary">'+esc(summary)+'</span><span class="haiala-client-chevron" aria-hidden="true"></span></button>'+
 '<div class="haiala-client-popup" id="haialaClientPopup" hidden>'+
 '<input type="search" id="haialaClientSearch" placeholder="Buscar código ou cliente" autocomplete="off" aria-label="Buscar clientes">'+
 '<div class="haiala-client-matches" id="haialaClientMatches"></div>'+
 '<div class="haiala-client-actions"><div class="haiala-client-actions-left"><button type="button" id="haialaClientClear">Todos</button><button type="button" id="haialaClientClearDraft">Limpar seleção</button></div><button type="button" id="haialaClientApply">Aplicar seleção</button></div></div></div></div>';
}
function initClientMulti(){
 const wrap=byId('haialaClientMulti');if(!wrap)return;
 const popup=byId('haialaClientPopup'),toggle=byId('haialaClientToggle');
 const search=byId('haialaClientSearch'),list=byId('haialaClientMatches');
 if(!popup||!toggle||toggle.disabled)return;
 const clientOptions = (CAD479_VALID && ['CL-01','CL-02','CL-03','CL-04'].includes(state.page))
  ? CAD479_ROWS.filter(c =>
       (state.carteira === 'all' || c.owner === String(state.carteira)) &&
       (state.uf === 'all' || c.uf === state.uf)
     ).map(c => [String(c.client), String(c.client) + ' - ' + c.name])
  : (Q46_VALID
      ? availableClients().filter(id =>
          (state.rep === 'all' || Q46_ROWS.some(r =>
            String(r[8]) === String(id) && String(r[7]) === String(state.rep)
          )) &&
          (!ufActive() || V477_UF_MAP.get(String(id)) === state.uf)
        ).map(id => [String(id), rotuloCliente(id)])
      : []);
 const opts = [...new Map(clientOptions.map(item => [item[0], item])).values()];
 let selected=new Set(clientIds());
 const render=()=>{
  const q=(search.value||'').trim().toLocaleLowerCase('pt-BR');
  let showing=0;
  list.innerHTML='';
  for(const [id,name] of opts){
   if(q&&!name.toLocaleLowerCase('pt-BR').includes(q))continue;
   const el=document.createElement('label');el.className='haiala-client-option';
   const checkbox=document.createElement('input');checkbox.type='checkbox';checkbox.checked=selected.has(id);
   checkbox.onchange=()=>{if(checkbox.checked)selected.add(id);else selected.delete(id)};
   const txt=document.createElement('span');txt.textContent=name;el.append(checkbox,txt);list.append(el);
   showing++;if(showing>=250)break;
  }
  if(!showing)list.textContent='Nenhum cliente encontrado.';
 };
 const commit=()=>{
  const ids=[...selected].sort((a,b)=>Number(a)-Number(b));
  state.focus=ids.length?'CLI:'+ids.join(','):'all';
  draw();
 };
 toggle.onclick=(e)=>{e.stopPropagation();popup.hidden=!popup.hidden;toggle.setAttribute('aria-expanded',String(!popup.hidden));if(!popup.hidden){render();search.focus()}};
 search.oninput=render;
 byId('haialaClientApply').onclick=commit;
 byId('haialaClientClear').onclick=()=>{selected.clear();commit()};
 byId('haialaClientClearDraft').onclick=()=>{selected.clear();render()};
 document.addEventListener('click',function closeClientPopup(e){
  if(!wrap.isConnected){document.removeEventListener('click',closeClientPopup);return;}
  if(!wrap.contains(e.target)){popup.hidden=true;toggle.setAttribute('aria-expanded','false')}
 });
}
function options(){
const managerOptions=[['all','Todos'],...(V477_REP_OK?[...new Set([...V477_REP_MAP.values()].map(x=>x.manager))].sort((a,b)=>Number(a)-Number(b)).map(id=>[id,labelManager(id)]):[])];
const repO=[['all','Todos'],...(Q45_VALID?availableReps().map(id=>[String(id),repName(id)]):[])];
const carteiraOptions=[['all','Todos'],...(CARTEIRA478_VALID?[...new Set(CARTEIRA478_MAP.values())].sort((a,b)=>Number(a)-Number(b)).map(id=>[id,carteiraName(id)]):[])];
const focusO=(isRealPage()||['CL-01','CL-02','CL-03','CL-04'].includes(state.page))? [['all','Todos os clientes'],...(CAD479_VALID&&['CL-01','CL-02','CL-03','CL-04'].includes(state.page)?CAD479_ROWS.filter(c=>(state.carteira==='all'||c.owner===String(state.carteira))&&(state.uf==='all'||c.uf===state.uf)).sort((a,b)=>a.client.localeCompare(b.client,'pt-BR',{numeric:true})).map(c=>['CLI:'+c.client,c.client+' - '+c.name]):(state.profile==='director'&&Q46_VALID?availableClients().filter(id=>(state.rep==='all'||Q46_ROWS.some(r=>r[8]===id&&String(r[7])===String(state.rep)))&&(!ufActive()||V477_UF_MAP.get(String(id))===state.uf)).map(id=>['CLI:'+id,rotuloCliente(id)]):[]))]:[['all','Nenhum']];
const ufs=[['all','Todas'],...(V477_UF_OK?[...new Set(V477_UF_MAP.values())].sort((a,b)=>a.localeCompare(b,'pt-BR')).map(x=>[x,x]):[])];
return select('Período',[['all','2026 - acumulado até hoje'],...Array.from({length:12},(_,i)=>[String(i+1),new Date(2026,i,1).toLocaleString('pt-BR',{month:'long'})])])+
select('Gerência',managerOptions)+select('Representante da Base',carteiraOptions)+select('Representante da venda',repO)+select('UF',ufs)+select('Tipologia',isRealPage()?[['all','Todas'],...(Q471_VALID&&state.profile==='director'?[...new Set(Q471_ROWS.filter(r=>(state.rep==='all'||String(r.rep)===String(state.rep)) && clientMatches(r.client) && (!skuSelected()||String(r.sku)===String(state.sku))).map(r=>r.typology))].sort((a,b)=>a.localeCompare(b,'pt-BR')).map(t=>[t,rotuloTipologia(t)]):[])]:[['all','Não integrado nesta página']])+clientMultiHTML(focusO)+select('SKU',isRealPage()?[['all','Todos os SKUs'],...(Q471_VALID&&state.profile==='director'?[...new Set(Q471_ROWS.filter(r=>(state.rep==='all'||String(r.rep)===String(state.rep)) && clientMatches(r.client)).map(r=>r.sku))].sort((a,b)=>a-b).map(id=>[String(id),rotuloSKU(id)]):[])]:[['all','Não integrado nesta página']])}

/* HAIALA v5.0 - Arquitetura consolidada: 6 menus, 20 paginas.
   As 26 rotas historicas permanecem no DB legado para preservar as consultas.
   As abas em cada pagina fundida reutilizam os controladores homologados.
   Este bloco altera apenas a navegacao e a identificacao visual. */
const NAV_V50={"modules":[{"id":"AC","name":"Pedido","direct":true,"nameInPage":"Acompanhamento Comercial","description":"Resultados por dia, semana, mês, ano e evolução","pages":[{"id":"AC-01","name":"Por Dia","description":"Vendas e pedidos diários","legacy":["AC-01"],"tabs":["Por Dia"]},{"id":"AC-02","name":"Por Semana","description":"Vendas e pedidos semanais","legacy":["AC-02"],"tabs":["Por Semana"]},{"id":"AC-03","name":"Por Mês","description":"Vendas e pedidos mensais","legacy":["AC-03","AC-04","VD-03"],"tabs":["Por Mês"]}]},{"id":"VD","name":"Vendas","direct":true,"nameInPage":"Vendas","description":"Análise de vendas, pedidos, inteligência e consultas","pages":[{"id":"VD-01","name":"Análise","description":"Indicadores e composição das vendas","legacy":["VD-01"],"tabs":["Análise"]},{"id":"VD-02","name":"Pedidos","description":"Consulta comercial agrupada por cliente, data e operação","legacy":["VD-02"],"tabs":["Pedidos"]},{"id":"VD-03","name":"Inteligência","description":"Concentração e oportunidades; dados demonstrativos quando indicado","legacy":["VD-04"],"tabs":["Inteligência"]},{"id":"VD-04","name":"Consultas","description":"Consulta comercial e agrupamentos dinâmicos; dados demonstrativos quando indicado","legacy":["VD-05"],"tabs":["Consultas"]}]},{"id":"CL","name":"Clientes","direct":true,"nameInPage":"Clientes","description":"Carteira, ficha 360º, frequência e recuperação","pages":[{"id":"CL-01","name":"Carteira","description":"Visão geral da carteira e cobertura","legacy":["CL-01"],"tabs":["Carteira"]},{"id":"CL-02","name":"Ficha 360º","description":"Ficha 360º do cliente","legacy":["CL-02"],"tabs":["Ficha 360º"]},{"id":"CL-03","name":"Frequência","description":"Frequência e recorrência de compras","legacy":["CL-03"],"tabs":["Frequência"]},{"id":"CL-04","name":"Recuperação","description":"Oportunidades e recuperação de clientes","legacy":["CL-04"],"tabs":["Recuperação"]}]},{"id":"PD","name":"Produtos","direct":false,"pages":[{"id":"PD-01","name":"Portfólio e Tipologias","description":"Panorama de SKUs e tipologias","legacy":["PD-01","PD-02"],"tabs":["Portfólio","Tipologias"]},{"id":"PD-02","name":"Ficha 360º do Produto","description":"Ficha de produto","legacy":["PD-03"],"tabs":["Produto"]},{"id":"PD-03","name":"Inteligência de Produtos","description":"Inteligência de produtos","legacy":["PD-04"],"tabs":["Inteligência"]}]},{"id":"GM","name":"Geomarketing","direct":false,"pages":[{"id":"GM-01","name":"Desempenho Geográfico","description":"Indicadores e desempenho por região","legacy":["GM-01","GM-03"],"tabs":["Visão geográfica","Desempenho regional"]},{"id":"GM-02","name":"Mapas, Cobertura e Expansão","description":"Mapas e oportunidades territoriais","legacy":["GM-02","GM-04"],"tabs":["Mapas","Cobertura e expansão"]}]}]};const LEGACY_TO_V5={};
NAV_V50.modules.forEach(function(m){m.pages.forEach(function(pg){pg.legacy.forEach(function(old){LEGACY_TO_V5[old]={module:m,page:pg};});});});
function v5Current(){return LEGACY_TO_V5[state.page]||null;}
function v5Jump(legacy){haialaExitInvoiceBlank();if(!LEGACY_TO_V5[legacy])return;const enteringAC=legacy==='AC-01'&&!String(state.page).startsWith('AC-');const enteringCL=legacy==='CL-01'&&!String(state.page).startsWith('CL-');if(enteringAC||enteringCL)state.period=String(new Date().getMonth()+1);state.page=String(legacy).indexOf('VD-')===0?'AC-03':(legacy==='AC-04'?'AC-03':legacy);draw();}
function v5Esc(x){return esc(String(x));}
function v5Tabs(){
 const host=byId('v5TabsHost');if(!host)return;
 const route=v5Current();if(!route){host.innerHTML='';host.style.display='none';return;}
 const module=route.module, direct=!!module.direct;
 const choices=direct?module.pages:route.page.legacy.map((legacy,i)=>({name:route.page.tabs[i],legacy:[legacy]}));
 if(!direct&&choices.length<2){host.innerHTML='';host.style.display='none';return;}
 host.style.display='flex';host.setAttribute('aria-label',direct?'Visões de '+module.name:'Visões consolidadas');
 host.innerHTML=choices.map(function(pg){
  const old=pg.legacy[0], selected=direct?pg.legacy.indexOf(state.page)>=0:state.page===old;
  return '<button type="button" class="v5-tab '+(selected?'v5-tab-active':'')+'" data-v5-legacy="'+v5Esc(old)+'" aria-pressed="'+selected+'">'+v5Esc(pg.name)+'</button>';
 }).join('');
 host.querySelectorAll('[data-v5-legacy]').forEach(function(btn){btn.onclick=function(){v5Jump(btn.getAttribute('data-v5-legacy'));};});
}
function v5Presentation(){
 const r=v5Current();if(!r)return;
 const direct=!!r.module.direct;
 byId('crumb').textContent=r.module.name+' / '+r.page.id;
 byId('pageTitle').textContent=direct?r.module.nameInPage:r.page.name;
 byId('pageDesc').textContent=direct?r.module.description:r.page.description;
 v5Tabs();
 if(state.page==='VD-04'||state.page==='VD-05')byId('pageDesc').textContent+=' | Demonstração: integração Oracle pendente';
}
/* HAIALA V6.1.5: navegacao Pedido / Faturamento. Sem alteracao dos controladores homologados. */
function haialaExitInvoiceBlank(){
  document.body.classList.remove('haiala-invoice-blank');
  const host=document.getElementById('haialaInvoicePlaceholder');
  if(host)host.hidden=true;
}
function haialaShowInvoiceBlank(){
  let host=document.getElementById('haialaInvoicePlaceholder');
  if(!host){
    host=document.createElement('section');
    host.id='haialaInvoicePlaceholder';
    host.className='haiala-invoice-placeholder';
    host.setAttribute('aria-label','Faturamento');
    host.innerHTML='<div class="eyebrow">Faturamento</div><h1 class="title">Faturamento</h1>';
    document.querySelector('main.main').appendChild(host);
  }
  host.hidden=false;
  document.body.classList.add('haiala-invoice-blank');
  const nav=document.getElementById('navigation');
  if(nav){
    nav.querySelectorAll('.nav-direct-active').forEach(function(node){node.classList.remove('nav-direct-active');node.setAttribute('aria-current','false');});
    const invoice=nav.querySelector('[data-invoice-placeholder]');
    if(invoice){invoice.classList.add('nav-direct-active');invoice.setAttribute('aria-current','page');}
  }
}
function haialaAddInvoiceNav(nav){
  const group=nav.querySelector('.navgroups');
  if(!group)return;
  const btn=document.createElement('button');
  btn.type='button';
  btn.className='nav-direct';
  btn.setAttribute('data-invoice-placeholder','true');
  btn.textContent='Faturamento';
  btn.onclick=haialaShowInvoiceBlank;
  group.insertBefore(btn,group.children[1]||null);
}
function buildNav(){
 const n=byId('navigation');
 n.innerHTML='<div class="navgroups">'+NAV_V50.modules.filter(function(m){return m.id!=='VD';}).map(function(m){
  if(m.direct){
   const active=m.pages.some(pg=>pg.legacy.indexOf(state.page)>=0);
   return '<button type="button" class="nav-direct '+(active?'nav-direct-active':'')+'" data-module-direct="'+v5Esc(m.id)+'" data-v5-first="'+v5Esc(m.pages[0].legacy[0])+'" aria-current="'+(active?'page':'false')+'">'+v5Esc(m.name)+(m.id==='CL'?'<span class="haiala-test-label">Teste</span>':'')+'</button>';
  }
  return '<details class="navgroup"><summary>'+v5Esc(m.name)+((m.id==='PD'||m.id==='GM')?'<span class="haiala-test-label">Teste</span>':'')+'</summary><div class="dropdownmenu"><div class="groupcaption">'+v5Esc(m.name)+'</div>'+m.pages.map(function(pg){return '<button type="button" class="nav '+(pg.legacy.indexOf(state.page)>=0?'active':'')+'" data-v5-page="'+v5Esc(pg.id)+'" data-v5-first="'+v5Esc(pg.legacy[0])+'">'+v5Esc(pg.id)+' - '+v5Esc(pg.name)+'</button>';}).join('')+'</div></details>';
 }).join('')+'</div>';
 haialaAddInvoiceNav(n);
 n.querySelectorAll('[data-v5-first]').forEach(function(b){b.onclick=function(){v5Jump(b.getAttribute('data-v5-first'));};});
 n.querySelectorAll('.navgroup').forEach(function(d){d.addEventListener('toggle',function(){if(d.open)n.querySelectorAll('.navgroup').forEach(function(other){if(other!==d)other.removeAttribute('open');});});});
}
function kpisFor(kind,b,g){let avg=Object.values(DB.targets).reduce((x,y)=>x+y,0);let eligible=DB.clients.filter(c=>c.eligible&&(!state.uf||state.uf==='all'||c.uf===state.uf));let eligibleIds=new Set(eligible.map(c=>c.id));let served=uniq(b.a.filter(o=>eligibleIds.has(o.client)).map(o=>o.client));let target=state.period==='all'?sum(Object.values(DB.targets),x=>x):DB.targets[Number(state.period)]||0;const defaultK=[['Vendas confirmadas',money(b.v),'VEN-03'],['Pedidos válidos',fmt(b.orders),'VEN-04'],['Clientes com compras',fmt(b.customers),'CLI'],['Ticket médio',money(b.ticket),'VEN-05']];let k={day:defaultK,week:defaultK,month:[defaultK[0],['Meta de referência',money(target),'DEMO'],['Atingimento ilustrativo',pct(target?100*b.v/target:0),'DEMO'],defaultK[1]],year:[defaultK[0],['Pedidos',fmt(b.orders),'VEN-04'],['Média mensal',money(b.v/10),'DEMO'],['Meses com vendas',fmt(uniq(b.a.map(o=>pnum(o.date)))),'DEMO']],goals:[defaultK[0],['Meta de referência',money(target),'DEMO'],['Atingimento ilustrativo',pct(target?100*b.v/target:0),'DEMO'],['Desvio ilustrativo',money(b.v-target),'DEMO']],sales:[defaultK[0],defaultK[1],defaultK[3],['Quantidade (UN)',fmt(b.qty),'VEN-06']],orders:defaultK,trend:defaultK,intelligence:[defaultK[0],['Concentração maior grupo',pct(b.v?100*(g[0]?.vlc||0)/b.v:0),'DER-05'],defaultK[2],defaultK[3]],query:defaultK,portfolio:[['Clientes elegíveis',fmt(eligible.length),'CLI'],['Clientes atendidos',fmt(served),'CLI'],['Cobertura',eligible.length?pct(100*served/eligible.length):'Indisponível','CLI'],['Clientes com vendas',fmt(b.customers),'CLI']],client360:defaultK,behavior:[defaultK[2],['Clientes com repetição',fmt(group(b.a,o=>o.client).filter(x=>x.orders>1).length),'DEMO'],defaultK[0],defaultK[1]],recovery:[['Clientes elegíveis',fmt(eligible.length),'CLI'],['Sem compras no período',fmt(Math.max(0,eligible.length-served)),'CLI'],defaultK[2],defaultK[0]],products:[['SKUs comerciais',fmt(DB.products.length),'PRO'],['SKUs vendidos',fmt(b.skus),'PRO'],['Cobertura do mix',pct(100*b.skus/DB.products.length),'DER-07'],defaultK[0]],typology:[['Tipologias',fmt(uniq(g.map(x=>x.key))),'PRO'],['SKUs vendidos',fmt(b.skus),'PRO'],defaultK[0],defaultK[1]],sku360:defaultK,productIntel:[['SKUs vendidos',fmt(b.skus),'PRO'],['SKU com mais vendas',g[0]?.key||' - ','PRO'],defaultK[0],defaultK[1]],reps:[['Representantes com vendas',fmt(uniq(b.a.map(o=>o.rep))),'REP'],defaultK[0],defaultK[1],['Clientes atendidos',fmt(b.customers),'REP']],rep360:defaultK,repgoals:[defaultK[0],['Meta referência',money(target),'DEMO'],['Atingimento ilustrativo',pct(target?100*b.v/target:0),'DEMO'],defaultK[1]],repportfolio:[['Clientes com compras',fmt(b.customers),'CLI'],['Representantes ativos com vendas',fmt(uniq(b.a.map(o=>o.rep))),'REP'],defaultK[0],defaultK[1]],geo:[['UFs com vendas',fmt(uniq(b.a.map(o=>clients[o.client].uf))),'GEO'],['Municípios atendidos',fmt(uniq(b.a.map(o=>clients[o.client].city))),'GEO'],defaultK[0],defaultK[2]],map:[['Municípios atendidos',fmt(uniq(b.a.map(o=>clients[o.client].city))),'GEO'],defaultK[0],defaultK[2],defaultK[1]],region:[['UFs com vendas',fmt(uniq(g.map(x=>x.key))),'GEO'],defaultK[0],defaultK[1],defaultK[2]],expansion:[['Municípios cadastrados',fmt(uniq(DB.clients.map(x=>x.city))),'GEO'],['Municípios com vendas',fmt(uniq(b.a.map(o=>clients[o.client].city))),'GEO'],defaultK[0],defaultK[2]]};return (k[kind]||defaultK).slice(0,4)}
function plot(g){let d=g.slice(0,11).reverse();let max=Math.max(1,...d.map(x=>x.vlc));return `<h3 class="paneltitle">\${p().kind==='map'?'Distribuição de vendas por cidade':'Volume comercial por agrupamento'}</h3><div class="bars">\${d.length?d.map(x=>`<div class="barcol" title="\${esc(x.key)}: \${money(x.vlc)}"><em>\${fmt(x.vlc/1000)}k</em><div class="bar" style="height:\${Math.max(2,Math.round(x.vlc/max*160))}px"></div><span>\${esc(String(x.key).slice(-9))}</span></div>`).join(''):'<div class="empty">Nenhuma venda nesta seleção.</div>'}</div>`}
function rankings(g){let max=Math.max(1,...g.map(x=>x.vlc));return `<h3 class="paneltitle">Participação e concentração</h3>\${g.slice(0,6).map(x=>`<div class="minirow"><span class="minilabel" title="\${esc(x.key)}">\${esc(names[x.key]||x.key)}</span><div class="minirail"><div class="minifill" style="width:\${x.vlc/max*100}%"></div></div><span class="miniv">\${fmt(x.vlc/1000)} mil</span></div>`).join('')||'<p class="empty">Sem agrupamentos.</p>'}<p class="note">Ranking de grupos com vendas positivas. Não representa cálculo de classe ABC homologado.</p>`}
function mapGraphic(g){const ufs=group(filtered(),o=>clients[o.client].uf);const coords={GO:[105,85],MG:[225,116],SP:[214,156],MT:[112,38],MS:[137,124],PR:[215,186]};return `<h3 class="paneltitle">Visão territorial esquemática</h3><svg class="svgmap" viewBox="0 0 350 230" role="img" aria-label="Diagrama de unidades federativas, não um mapa geográfico"><rect x="0" y="0" width="350" height="230" fill="#f4f8fb"/><text x="14" y="21" fill="#648095" font-size="11">Diagrama ilustrativo - posição não geográfica</text>\${ufs.map(x=>{let c=coords[x.key]||[290,70];return `<circle cx="\${c[0]}" cy="\${c[1]}" r="\${Math.max(11,Math.min(33,13+x.vlc/250000))}" fill="#397b9d" opacity=".75"/><text text-anchor="middle" x="\${c[0]}" y="\${c[1]+4}" font-size="12" fill="white" font-weight="bold">\${x.key}</text>`}).join('')}</svg><p class="note">UFs posicionadas esquematicamente. O diagrama não representa limites municipais ou coordenadas reais.</p>`}
function tableFor(kind,b,g){if(kind==='orders'||kind==='client360'||kind==='sku360'||kind==='rep360'){return {cols:['Pedido','Data','Cliente','Representante','SKU','Qtd.','Vendas'],rows:b.a.slice().sort((x,y)=>y.date.localeCompare(x.date)).slice(0,160).map(o=>[o.id,o.date,names[o.client],names[o.rep],names[o.sku],o.qty,money(o.vlc)]),source:b.a.slice(0,160)}}if(kind==='recovery'||kind==='expansion'){let data=kind==='recovery'?DB.clients.filter(x=>x.eligible).map(c=>{let arr=b.a.filter(o=>o.client===c.id);let last=arr.reduce((s,o)=>s>o.date?s:o.date,'');return [c.id,c.name,names[c.rep],c.uf,last||'Nunca no recorte',arr.length,money(sum(arr,o=>o.vlc))]}):DB.clients.reduce((a,c)=>{let key=c.uf+' / '+c.city;let item=a.get(key)||{key,uf:c.uf,city:c.city,clients:0,orders:0,vlc:0};item.clients++;let ord=b.a.filter(o=>o.client===c.id);item.orders+=ord.length;item.vlc+=sum(ord,o=>o.vlc);a.set(key,item);return a},new Map());return kind==='recovery'?{cols:['ID','Cliente','Responsável','UF','Última compra no recorte','Pedidos','Vendas'],rows:data,source:[]}:{cols:['Município','Clientes cadastrados','Pedidos','Vendas','Status'],rows:[...data.values()].map(x=>[x.key,x.clients,x.orders,money(x.vlc),x.orders?'Atendido':'Sem vendas']),source:[]}}if(kind==='products'){let sold=new Set(b.a.map(o=>o.sku));return {cols:['SKU','Descrição','Tipologia','Situação','Vendido no recorte'],rows:DB.products.map(s=>[s.id,s.name,s.type,s.active?'Ativo':'Inativo',sold.has(s.id)?'Sim':'Não']),source:[]}}if(kind==='portfolio'||kind==='repportfolio'){let sold=new Set(b.a.map(o=>o.client));return {cols:['Cliente','UF','Cidade','Representante atual','Elegível','Atendido'],rows:DB.clients.map(c=>[c.name,c.uf,c.city,names[c.rep],c.eligible?'Sim':'Não',sold.has(c.id)?'Sim':'Não']),source:[]}}let sorted=kind==='day'||kind==='week'||kind==='month'||kind==='year'||kind==='trend'?g.slice().sort((a,b)=>String(a.key).localeCompare(String(b.key))):g;return {cols:['Agrupamento','Vendas','Pedidos distintos','Clientes distintos','Qtd. UN'],rows:sorted.map(x=>[names[x.key]||x.key,money(x.vlc),x.orders,x.clients,x.qty]),source:sorted}}

/* HAIALA v4.1: visualizacoes reais Q12; dados locais da extracao, sem atualizacao automatica. */
function isoWeekQ12(s){const d=new Date(s+'T12:00:00Z'); d.setUTCDate(d.getUTCDate()+4-(d.getUTCDay()||7)); const yr=d.getUTCFullYear(); const y0=new Date(Date.UTC(yr,0,1));return yr+'-S'+String(Math.ceil((((d-y0)/86400000)+1)/7)).padStart(2,'0')}
/* V4.7.5: contexto visual do recorte, sem mudar SQL ou formulas. */
function origemRecorte(){
 const periodo=state.period==='all'?'2026 - acumulado até a consulta':String(state.period).padStart(2,'0')+'/2026';
 const comItens=skuSelected()||typeSelected()||managerActive()||ufActive()||carteiraActive();
 const rep=state.rep!=='all';
 const cli=clientSelected();
 let fonte=DATA_ORIGIN==='ORACLE'?'Oracle - pedidos':'Snapshot Q12 - dados históricos';
 if(comItens)fonte=Q471_VALID?'Oracle - itens':'Indisponível - consulta de itens não validada';
 else if(cli)fonte=Q46_VALID?'Oracle - cliente do pedido':'Indisponível - consulta de clientes não validada';
 else if(rep)fonte=Q45_VALID?'Oracle - representante do pedido':'Indisponível - consulta de representantes não validada';
 const aplicados=['Período: '+periodo];
 if(managerActive()&&V477_REP_OK)aplicados.push('Gerência atual do representante: '+labelManager(state.manager));
 if(ufActive()&&V477_UF_OK)aplicados.push('UF do cadastro comercial do cliente: '+state.uf);
 if(carteiraActive()&&CARTEIRA478_VALID)aplicados.push('Responsável atual da carteira: '+carteiraName(state.carteira));
 if(rep && Q45_VALID)aplicados.push('Representante do pedido: '+repName(Number(state.rep)));
 if(cli && Q46_VALID)aplicados.push('Cliente do pedido: '+clientLabel());
 if(typeSelected() && Q471_VALID)aplicados.push('Tipologia: '+rotuloTipologia(state.type));
 if(skuSelected() && Q471_VALID)aplicados.push('SKU: '+rotuloSKU(state.sku));
 const naoAplicados=[];
 if(state.manager!=='all'&&!V477_REP_OK)naoAplicados.push('Gerência');
 if(state.uf!=='all'&&!V477_UF_OK)naoAplicados.push('UF');
 if(state.carteira!=='all'&&!CARTEIRA478_VALID)naoAplicados.push('Carteira atual');
 
 const classificacao=comItens?'Vendas dos itens selecionados; pedidos distintos por NUNOTA; '+(Q476_FISCAL_VALID?'ICMS/ST/IPI reais dos itens.':'ICMS/ST/IPI N/D - conciliação fiscal pendente.'):'Vendas dos pedidos (TOP 1000,1001,1005,1007,9000,9001; situação A/P/L); tributos separados.';
 return {fonte,periodo,aplicados,naoAplicados,classificacao,
  linha:'Fonte: '+fonte+' | Empresa 1 | '+aplicados.join(' | ')+'. '+classificacao+(naoAplicados.length?' Não aplicados ao Oracle: '+naoAplicados.join(', ')+'.':'')};
}
function atualizarContextoOrigem(){
 const box=document.getElementById('haialaOriginV43');if(!box)return;
 const c=origemRecorte();
 const geral=DATA_ORIGIN==='ORACLE'?'Oracle - consulta geral conciliada; '+Q43_PEDIDOS+' pedidos na base completa.':'Snapshot histórico (jan-out/2026); sem atualização automática.';
 box.textContent='ORIGEM DA BASE: '+geral+' | RECORTE EM TELA: '+c.linha+' Atualização da consulta ao abrir/recarregar. Acesso por perfil ainda não homologado.';
}

/* HAIALA v5.1.2 - KPI: pares distintos (NUNOTA, CODPROD) / pedidos distintos. 
   N/D sem conciliacao dimensional de Q471, inclusive snapshot.
   Um pedido com o mesmo CODPROD em duas sequencias conta apenas uma vez. */
function kpiSkuPedido512(pedidosEsperados){
 if(DATA_ORIGIN!=='ORACLE'||!Q471_VALID||state.profile!=='director')return null;
 if(!Number.isFinite(pedidosEsperados)||pedidosEsperados<0)return null;
 const itens=skuItemsFiltered();
 const pedidos=new Set(),pares=new Set();
 for(const r of itens){
  pedidos.add(String(r.id));
  pares.add(String(r.id)+'|'+String(r.sku));
 }
 // Nunca misturar um numerador de um recorte com outro denominador.
 if(pedidos.size!==pedidosEsperados)return null;
 return {pares:pares.size,pedidos:pedidos.size,media:pedidos.size?pares.size/pedidos.size:0};
}
function skuPedidoCard512(pedidos){
 const v=kpiSkuPedido512(pedidos);
 return ['Qte SKU / Pedido',v?v.media.toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2}):'N/D',v?'Pares pedido-SKU / pedidos':'Consulta de itens não conciliada'];
}
/* v5.3.3.9: preco medio comercial unitario (PC).
   Fonte: somente linhas em PC da Q533 conciliada com Q471.
   Prazo medio: N/D ate validar parcelas efetivas e ponderacao com Q534.
*/
function precoMedioAC(periodKey, granularity){
 if(DATA_ORIGIN!=='ORACLE'||!Q533_VALID||state.profile!=='director')return null;
 const selected=skuItemsFiltered();
 const ids=new Set(selected.map(r=>String(r.id)+'|'+String(r.sku)));
 const entries=Q533_ROWS.filter(r=>ids.has(String(r.id)+'|'+String(r.sku))&&
  (!periodKey || (granularity==='dia'?r.day:granularity==='semana'?isoWeekQ12(r.day):r.day.slice(0,7))===periodKey));
 if(!entries.length)return null;
 const targetRows=selected.filter(r=>!periodKey ||
  (granularity==='dia'?r.dia:granularity==='semana'?isoWeekQ12(r.dia):r.dia.slice(0,7))===periodKey);
 const realCents=Math.round(entries.reduce((a,r)=>a+r.sales,0)*100);
 const targetCents=Math.round(targetRows.reduce((a,r)=>a+r.sales,0)*100);
 if(entries.length!==targetRows.length||Math.abs(realCents-targetCents)>2)return null;
 const qty=entries.reduce((a,r)=>a+r.qty,0);
 const priceSales=entries.reduce((a,r)=>a+r.salesPC,0);
 return qty>0 && Number.isFinite(priceSales)?priceSales/qty:null;
}
/* Prazo ponderado preliminar: dias entre DTNEG e vencimentos, ponderados por VLRDESDOB.
   Não publicar se houver lacuna de pedidos no recorte. Filtros por SKU ou tipologia
   não possuem prazo próprio de parcela, portanto mostram N/D. */
const Q534P_ELEMENT=document.getElementById('haialaQ534PrazoResult');
const Q534P_OK=!!Q534P_ELEMENT && Q534P_ELEMENT.dataset.ok==='true';
const Q534P_ROWS=Q534P_ELEMENT?Array.from(Q534P_ELEMENT.querySelectorAll('.haiala-q534-prazo')).map(el=>({
 id:q43num(el.dataset.id),parcelas:q43num(el.dataset.parcelas),valor:q43num(el.dataset.valor),diasValor:q43num(el.dataset.diasvalor)
})):[];
const Q534P_MAP=new Map(Q534P_ROWS.map(r=>[r.id,r]));
const Q534P_VALID=Q534P_OK&&Q43_CONSISTENTE&&Q534P_ROWS.length===Q43_PEDIDOS&&Q534P_MAP.size===Q43_PEDIDOS&&
 Q534P_ROWS.every(r=>Number.isFinite(r.id)&&Number.isFinite(r.parcelas)&&r.parcelas>0&&Number.isFinite(r.valor)&&r.valor>0&&Number.isFinite(r.diasValor));
function prazoMedioAC(periodKey,granularity){
 if(DATA_ORIGIN!=='ORACLE'||!Q534P_VALID||!isRealPage()||state.profile!=='director'||skuSelected()||typeSelected())return 'N/D';
 const dates=skuItemsFiltered();
 const orders=new Map();
 for(const r of dates){
  const id=Number(r.id);
  if(!Number.isFinite(id)||id<=0)return 'N/D';
  const key=granularity==='dia'?r.dia:granularity==='semana'?isoWeekQ12(r.dia):r.dia.slice(0,7);
  if(!periodKey||periodKey===key)orders.set(id,true);
 }
 if(!orders.size)return 'N/D';
 let totalValor=0,totalDiasValor=0;
 for(const id of orders.keys()){
  const p=Q534P_MAP.get(id);
  if(!p||p.parcelas<=0||p.valor<=0)return 'N/D';
  totalValor+=p.valor;
  totalDiasValor+=p.diasValor;
 }
 if(!totalValor||!Number.isFinite(totalDiasValor))return 'N/D';
 return (totalDiasValor/totalValor).toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2})+' dias';
}
/* v5.3.3.14.6.4 - TOPs de devolucao aprovadas: 1200, 1201, 1209 e 9200.
   Data: DTNEG da devolucao; valor sem ST; sem abatimento nas Vendas homologadas. */
const Q535D_ELEMENT=document.getElementById('haialaQ535Returns');
const Q535D_LOADED=!!Q535D_ELEMENT&&Q535D_ELEMENT.dataset.ok==='true';
const Q535D_ROWS=Q535D_ELEMENT?[...Q535D_ELEMENT.querySelectorAll('.haiala-q535-return')].map(e=>({
 id:q43num(e.dataset.id),day:e.dataset.day,op:q43num(e.dataset.op),rep:q43num(e.dataset.rep),
 client:q43num(e.dataset.client),owner:q43num(e.dataset.owner),uf:String(e.dataset.uf||'(SEM UF)'),value:q43num(e.dataset.value)
})):[];
const Q535D_VALID=Q535D_LOADED&&Q535D_ROWS.length>0&&Q535D_ROWS.every(r=>Number.isFinite(r.id)&&r.id>0&&
 /^2026-\d{2}-\d{2}$/.test(r.day)&&[1200,1201,1209,9200].includes(r.op)&&
 [r.rep,r.client,r.owner,r.value].every(Number.isFinite));
function q535RefundsForAC(periodKey,granularity){
 if(DATA_ORIGIN!=='ORACLE'||!Q535D_VALID||!Q471_VALID||state.profile!=='director'||skuSelected()||typeSelected())return null;
 if(managerActive()&&!V477_REP_OK)return null;
 if(ufActive()&&!V477_UF_OK)return null;
 if(carteiraActive()&&!CAD479_VALID)return null;
 const matched=Q535D_ROWS.filter(r=>
  (state.period==='all'||Number(r.day.slice(5,7))===Number(state.period))&&
  (state.rep==='all'||String(r.rep)===String(state.rep))&&
  clientMatches(r.client)&&
  (!managerActive()||(V477_REP_MAP.get(String(r.rep))?.manager||'-1')===state.manager)&&
  (!ufActive()||r.uf===state.uf)&&
  (!carteiraActive()||String(r.owner)===String(state.carteira))&&
  (!periodKey||(granularity==='dia'?r.day:granularity==='semana'?isoWeekQ12(r.day):r.day.slice(0,7))===periodKey)
 );
 return matched.reduce((n,r)=>n+r.value,0);
}
function q535CustomersForAC(periodKey,granularity){
 if(DATA_ORIGIN!=='ORACLE'||!Q471_VALID||state.profile!=='director')return null;
 const orders=skuItemsFiltered().filter(r=>!periodKey||
  (granularity==='dia'?r.dia:granularity==='semana'?isoWeekQ12(r.dia):r.dia.slice(0,7))===periodKey);
 return new Set(orders.map(r=>String(r.client))).size;
}
/* HAIALA v5.1 - Acompanhamento sem indicadores sinteticos nas paginas consolidadas.
   A analise deriva exclusivamente das linhas diarias Q12 filtradas pela funcao realFiltered.
   Nao reaproveitar totais empresariais para dimensoes sem validacao. */
/* HAIALA v5.3.3.14.6.4 - Segunda linha do bloco 01 (somente Acompanhamento). Margem Oracle Q539-T.
   Total e Ativos: cadastro atual TGFPAR, ultimas compras historicas da empresa 1.
   C/ Vendas: CODPARC distintos dos itens de pedidos comerciais conciliados no periodo.
   ShowRoom: fonte de dados de implantacao NAO identificada. N/D ate validacao TI.
   Nunca interpretar ausencia de origem ShowRoom como zero. */
function renderAcClientShowroomV533144(){
 const host=byId('acClientSecondRow');
 if(!host)return;
 const ok=['AC-01','AC-02','AC-03'].includes(state.page);
 host.style.display=ok?'grid':'none';
 if(!ok){host.innerHTML='';return;}
 const clients=clientIds();
 const cadastral=CAD479_VALID&&DATA_ORIGIN==='ORACLE'&&state.profile==='director';
 // Exclusao exclusiva das contagens deste card; nenhuma outra metrica da pagina muda.
 // A origem Oracle CARD_CLIENTE_ELEGIVEL exclui base 4 e gerencia 4.
 // Uma selecao direta da gerencia 4 ou vendedor 4 nao deve contar clientes.
 const bloqueadoPorFiltro=String(state.manager)==='4'||String(state.rep)==='4'||String(state.carteira)==='4';
 const list=cadastral&&!bloqueadoPorFiltro?CAD479_ROWS.filter(c=>
  c.commercial&&c.cardEligible&&
  (state.carteira==='all'||c.owner===String(state.carteira))&&
  (state.uf==='all'||c.uf===state.uf)&&
  (state.manager==='all'||(V477_REP_MAP.get(c.owner)?.manager||'-1')===state.manager)&&
  (!clients.length||clients.includes(c.client))):[];
 const ativos=list.filter(c=>!c.never&&!c.inactive90);
 // Vendedor da venda 4 excluido apenas da contagem de clientes com vendas.
 // Cliente com outras vendas validas permanece contado nessas outras vendas.
 const podeVendas=cadastral&&Q471_VALID&&isRealPage()&&state.profile==='director';
 const vendidos=podeVendas?new Set(skuItemsFiltered().filter(r=>String(r.rep)!=='4').map(r=>String(r.client))):null;
 const comVendas=podeVendas?list.filter(c=>vendidos.has(c.client)).length:null;
 const comShowroom=cadastral?list.filter(c=>c.showroom).length:null;
 const comVendaShowroom=podeVendas?list.filter(c=>c.showroom&&vendidos.has(c.client)).length:null;
 const numberOrND=n=>n===null?'N/D':fmt(n);
 const metric=(name,value,help)=>'<div class="ac-client-metric"><span>'+esc(name)+'</span><strong>'+esc(value)+'</strong><small>'+esc(help)+'</small></div>';
 const combined='<section class="ac-client-card ac-client-card--combined" aria-label="Clientes e ShowRoom">'+
  '<h3>Clientes e ShowRoom</h3><div class="ac-client-metrics">'+
  metric('Total',cadastral?numberOrND(list.length):'N/D','Clientes cadastrados')+
  metric('Ativos (até 90 dias)',cadastral?numberOrND(ativos.length):'N/D','Última compra válida')+
  metric('Com vendas',numberOrND(comVendas),'No período selecionado')+
  metric('Com ShowRoom',numberOrND(comShowroom),'Status Showroom = Sim')+
  metric('Com venda ShowRoom',numberOrND(comVendaShowroom),'Com venda no período')+
  '</div><p class="ac-client-note">Clientes: excluídos código 4 na gerência, representante da base e representante da venda. ShowRoom: TGFPAR.AD_STATUSSHOWROOM = Sim (ou S); com venda respeita o recorte comercial.</p></section>';
 const mc=q539TCard();
 const freightRows=q539TFiltered();
 const freightValue=freightRows===null?'N/D':money(freightRows.reduce((v,i)=>v+i.frete,0));
 const freightCard='<section class="ac-client-card ac-client-card--freight" aria-label="Frete comercial projetado"><h3>Frete</h3><div class="ac-client-metrics">'+
  metric('Frete R$',freightValue,'Frete projetado dos pedidos: Q539-T / TGFEXC')+
  metric('Qte OCs','N/D','Origem de OC pendente de homologação')+
  '</div><p class="ac-client-note">Frete financeiro da MC Projetada. Qte OCs pendente de fonte homologada; não equivale à quantidade de pedidos.</p></section>';
 const margem='<section class="ac-client-card ac-client-card--margin" aria-label="Margem de contribuição"><h3>Margem de Contribuição por Grupo - Pedido</h3>'+q539V614Table()+'</section>';
 host.innerHTML=combined+freightCard+margem;
}
function renderAC51(){
 const isShort=state.page==='AC-01'||state.page==='AC-02';
 const isLong=state.page==='AC-03'||state.page==='AC-04'||state.page==='VD-03';
 const enabled=isShort||isLong;
 const acLayout=byId('primaryPanel') && byId('primaryPanel').parentElement;
 if(acLayout)acLayout.classList.toggle('ac-summary-compact',enabled && state.page!=='VD-03');
 const rules=byId('rulesPanel'), sec03=byId('cl01Sec03');
 if(!enabled){
  document.body.classList.remove('ac535-detail');
  if(rules)rules.style.display='';if(sec03)sec03.style.display='';
  const q12=byId('q12Real');if(q12)q12.style.display='';
  byId('cl01Sec01').querySelector('h2').textContent='01 - Visão executiva';
  byId('cl01Sec02').querySelector('h2').textContent='02 - Inteligência comercial';
  byId('cl01Sec04').querySelector('h2').textContent='04 - Análise detalhada';
  return;
 }
 if(rules)rules.style.display='none';
 if(sec03)sec03.style.display='none';
 const q12=byId('q12Real');if(q12)q12.style.display='none';
 const daily=realFiltered().filter(r=>state.period==='all'||Number(r[0].slice(5,7))===Number(state.period));
 const granularity=isShort?(state.page==='AC-01'?'dia':'semana'):'mes';
 const map=new Map();
 for(const r of daily){
   const key=granularity==='dia'?r[0]:granularity==='semana'?isoWeekQ12(r[0]):r[0].slice(0,7);
   if(!map.has(key))map.set(key,{key,orders:0,sales:0,st:0,icms:0,discount:0});
   const x=map.get(key);x.orders+=Number(r[2]||0);x.sales+=Number(r[3]||0);x.st+=Number(r[4]||0);x.icms+=Number(r[5]||0);x.discount+=Number(r[6]||0);
 }
 const arr=[...map.values()].sort((a,b)=>a.key.localeCompare(b.key));
 const all=arr.reduce((a,x)=>({orders:a.orders+x.orders,sales:a.sales+x.sales,st:a.st+x.st,icms:a.icms+x.icms,discount:a.discount+x.discount}),{orders:0,sales:0,st:0,icms:0,discount:0});
 // v5.3.3.6: tributo N/D quando a fonte fiscal do recorte nao estiver conciliada.
 // Zero monetario so pode ser exibido quando o Oracle confirma o valor.
 const fiscalACValid=(DATA_ORIGIN==='ORACLE') &&
  (fiscalFilterActive()?Q476_FISCAL_VALID:
   clientSelected()?Q46_VALID:
   state.rep!=='all'?Q45_VALID:Q43_CONSISTENTE);
 const showFiscalAC=value=>fiscalACValid&&Number.isFinite(value)?money(value):'N/D';
 const recent=arr[arr.length-1];
 const title=isShort?'Acompanhamento operacional':state.page==='AC-03'?'Acompanhamento mensal':'Acompanhamento anual';
 const suffix=granularity==='dia'?'dia':granularity==='semana'?'semana':'mês';
 byId('cl01Sec01').querySelector('h2').textContent='01 - '+title+' (Oracle)';
 byId('cl01Sec02').querySelector('h2').textContent='02 - Evolução por '+suffix+' (Oracle)';
 byId('cl01Sec04').querySelector('h2').textContent='03 - Histórico consolidado (Oracle)';
 const k=[
  ['Vendas no período',money(all.sales),'Sem ST'],
  ['Pedidos válidos',fmt(all.orders),'TOP 1000,1001,1005,1007,9000,9001 | A/P/L'],
  ['Ticket médio',all.orders?money(all.sales/all.orders):'N/D','Vendas / pedidos'],
  skuPedidoCard512(all.orders),
  ['Preço Médio',precoMedioAC(null,granularity)===null?'N/D':money(precoMedioAC(null,granularity)),'Vendas em PC / peças em PC'],
  ['Prazo Médio',prazoMedioAC(null,granularity),'Dias | ponderação financeira preliminar']
 ];
 byId('kpis').classList.remove('five-kpis','six-kpis','eight-kpis');byId('kpis').classList.add('six-ac-kpis');
 byId('kpis').innerHTML=k.map(([name,value,note])=>'<div class="kpi"><span>'+esc(name)+'</span><strong>'+esc(value)+'</strong><small>'+esc(note)+'</small></div>').join('');
 renderAcClientShowroomV533144();
 byId('kpiHint').textContent='Fonte: '+(DATA_ORIGIN==='ORACLE'?'Oracle':'Snapshot histórico sinalizado')+' | Empresa 1 | '+arr.length+' '+suffix+(arr.length===1?'':'s');
 const recentArr=arr.slice(-24);
 const max=Math.max(1,...recentArr.map(x=>x.sales));
 const bars=recentArr.map(x=>{const label=granularity==='dia'?x.key.slice(8,10)+'/'+x.key.slice(5,7):granularity==='semana'?x.key.slice(5):x.key.slice(5,7)+'/'+x.key.slice(2,4);return '<div class="barcol ac-bars-col" title="'+esc(x.key+' | '+money(x.sales))+'"><em>'+Math.round(x.sales/1000)+'k</em><div class="bar" style="height:'+Math.max(2,x.sales/max*165)+'px"></div><span title="'+esc(x.key)+'">'+esc(label)+'</span></div>';}).join('');
 byId('primaryPanel').innerHTML='<h3 class="paneltitle">Vendas por '+esc(suffix)+'</h3><div class="ac-bars-scroll"><div class="bars ac-bars" style="min-width:'+Math.max(620,recentArr.length*53)+'px">'+(bars||'<p class="empty">Sem dados na seleção.</p>')+'</div></div><p class="note">'+esc(origemRecorte().linha)+'</p>';
 const first=arr[0];
 const months=arr.length;
 const avg=months?all.sales/months:0;
 byId('secondaryPanel').innerHTML='<h3 class="paneltitle">Resumo do recorte selecionado</h3>'+
 '<div class="minirow"><span class="minilabel">Períodos com movimento</span><strong>'+fmt(months)+'</strong></div>'+
 '<div class="minirow"><span class="minilabel">Média de vendas por '+esc(suffix)+'</span><strong>'+money(avg)+'</strong></div>'+
 '<div class="minirow"><span class="minilabel">Primeiro período com movimento</span><strong>'+esc(first?first.key:'N/D')+'</strong></div>'+
 '<div class="minirow"><span class="minilabel">Último período com movimento</span><strong>'+esc(recent?recent.key:'N/D')+'</strong></div>'+
 '<div class="minirow"><span class="minilabel">ST no recorte</span><strong>'+showFiscalAC(all.st)+'</strong></div>'+
 (fiscalACValid?'':'<p class="note" role="status">ST e ICMS: N/D - consulta fiscal do recorte não conciliada.</p>')+
 '<p class="note">Média apenas entre períodos com movimento. Sem metas simuladas, projeções ou comparações homólogas nesta visão.</p>';
 // v5.3.1.0: Qte SKU/Pedido por periodo, mesma logica Q512 (pares distintos NUNOTA/CODPROD).
 // Uma linha so e publicada quando pedidos de itens e de vendas coincidem naquele periodo.
 const itemPeriod=new Map();
 if(DATA_ORIGIN==='ORACLE'&&Q471_VALID&&state.profile==='director'){
  for(const r of skuItemsFiltered()){
   const key=granularity==='dia'?r.dia:granularity==='semana'?isoWeekQ12(r.dia):r.dia.slice(0,7);
   let obj=itemPeriod.get(key);if(!obj){obj={orders:new Set(),pairs:new Set()};itemPeriod.set(key,obj);}
   obj.orders.add(String(r.id));obj.pairs.add(String(r.id)+'|'+String(r.sku));
  }
 }
 const skuAverage=(x)=>{
  const match=itemPeriod.get(x.key);
  if(DATA_ORIGIN!=='ORACLE'||!Q471_VALID||state.profile!=='director')return 'N/D';
  if(!match)return x.orders===0?'0,00':'N/D';
  if(match.orders.size!==x.orders)return 'N/D';
  return (x.orders?match.pairs.size/x.orders:0).toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2});
 };
 // MC % por período: denominador próprio da margem (receita elegível),
 // sem usar a receita integral do card Vendas e sem média de percentuais.
 const mcItems=q539TFiltered();
 const mcPeriod=new Map();
 let mcOverallRevenue=0,mcOverallMargin=0;
 if(mcItems!==null){
  for(const item of mcItems){
   const key=granularity==='dia'?item.dia:granularity==='semana'?isoWeekQ12(item.dia):item.dia.slice(0,7);
   if(!mcPeriod.has(key))mcPeriod.set(key,{receita:0,margem:0});
   const bucket=mcPeriod.get(key);
   bucket.receita+=item.receita;
   bucket.margem+=item.margem;
   mcOverallRevenue+=item.receita;
   mcOverallMargin+=item.margem;
  }
 }
 const freightPeriod=new Map();
 if(mcItems!==null)for(const item of mcItems){
  const key=granularity==='dia'?item.dia:granularity==='semana'?isoWeekQ12(item.dia):item.dia.slice(0,7);
  freightPeriod.set(key,(freightPeriod.get(key)||0)+item.frete);
 }
 const freightForPeriod=key=>mcItems===null?'N/D':money(freightPeriod.get(key)||0);
 const freightTotal=mcItems===null?'N/D':money(mcItems.reduce((v,i)=>v+i.frete,0));
 const mcPct=x=>x&&Number.isFinite(x.receita)&&Number.isFinite(x.margem)&&x.receita!==0?
  (100*x.margem/x.receita).toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2})+'%':'N/D';
 const mcPctForPeriod=key=>mcItems===null?'N/D':mcPct(mcPeriod.get(key));
 const mcPctTotal=mcItems===null?'N/D':mcPct({receita:mcOverallRevenue,margem:mcOverallMargin});
 // Ordem executiva: movimento, receita, rentabilidade, eficiência e tributos.
 const cols=['Período','Pedidos','Qte Clientes','Vendas','Devoluções R$','Frete R$','Ticket médio','MC %','Preço Médio','Qte SKU / Pedido','Prazo Médio','Descontos dos itens','ST','ICMS informativo'];
 const rows=arr.map(x=>{const dev=q535RefundsForAC(x.key,granularity),cli=q535CustomersForAC(x.key,granularity),preco=precoMedioAC(x.key,granularity);
  return [x.key,fmt(x.orders),cli===null?'N/D':fmt(cli),money(x.sales),dev===null?'N/D':money(dev),freightForPeriod(x.key),
   x.orders?money(x.sales/x.orders):'N/D',mcPctForPeriod(x.key),
   preco===null?'N/D':money(preco),skuAverage(x),prazoMedioAC(x.key,granularity),money(x.discount),showFiscalAC(x.st),showFiscalAC(x.icms)];
 });
 latestCols=cols;latestRows=rows;
 // Totalizadores por universo, não somar clientes distintos nem fazer média de percentuais.
 const totalDev=q535RefundsForAC(null,granularity);
 const totalClients=q535CustomersForAC(null,granularity);
 const totalPreco=precoMedioAC(null,granularity);
 const totalSku=skuPedidoCard512(all.orders)[1];
 const grandTotal=['TOTAL DO RECORTE',fmt(all.orders),totalClients===null?'N/D':fmt(totalClients),money(all.sales),
  totalDev===null?'N/D':money(totalDev),freightTotal,all.orders?money(all.sales/all.orders):'N/D',mcPctTotal,
  totalPreco===null?'N/D':money(totalPreco),totalSku,prazoMedioAC(null,granularity),money(all.discount),
  showFiscalAC(all.st),showFiscalAC(all.icms)];
 const table=byId('tablePanel');
 document.body.classList.add('ac535-detail');
 table.innerHTML='<table><thead><tr>'+cols.map(x=>'<th>'+(x==='Qte SKU / Pedido'?'Qte SKU /<span class="ac-header-break">Pedido</span>':esc(x))+'</th>').join('')+'</tr></thead><tbody>'+rows.map((r,i)=>'<tr data-ac51-row="'+i+'">'+r.map(v=>'<td>'+esc(v)+'</td>').join('')+'</tr>').join('')+'</tbody><tfoot><tr>'+grandTotal.map(v=>'<td>'+esc(v)+'</td>').join('')+'</tr></tfoot></table>';
 byId('tablePanel').querySelectorAll('[data-ac51-row]').forEach(tr=>tr.onclick=()=>detailPedidosAC(rows[Number(tr.getAttribute('data-ac51-row'))][0],granularity));
 byId('tableHelp').textContent=arr.length+' períodos na consulta | Linha TOTAL recalculada com denominadores corretos; MC % = margem / receita elegível por período, sem média simples; Qte Clientes = clientes distintos, não soma mensal. Frete R$ = soma do componente projetado Q539-T no mesmo recorte, nao frete realizado. Devoluções comerciais por DTNEG, TOP 1200/1201/1209/9200 (regra aprovada), situação A/P/L e versão TGFTOP conciliada. Valores de devoluções não deduzidos novamente de Vendas. | '+origemRecorte().linha;
 // Impedir exportacao em paginas de consolidacao ate homologar a autorizacao real.
 const exportButton=byId('exportBtn');if(exportButton){exportButton.disabled=true;exportButton.title='Exportação bloqueada até autorização real de usuário';}
}

/* v5.3.3.1 - Bloco 03: matriz unica Familia x Tipologia, quantidade + valor.
   Somente os filtros globais determinam o recorte; sem filtro interno.
   A conciliacao Q533/Q471 e obrigatoria para publicar dados. */
function q533Render(){
 const title=byId('q533FamilyTitle'),panel=byId('q533FamilyPanel');
 if(!title||!panel)return;
 const active=['AC-01','AC-02','AC-03'].includes(state.page);
 title.style.display=active?'':'none';panel.style.display=active?'':'none';
 if(!active)return;
 byId('cl01Sec04').querySelector('h2').textContent='04 - Análise detalhada';
 const status=byId('q533FamilyStatus');
 // O período exibido é exatamente a opção selecionada no filtro do cabeçalho.
 const periodSelect=byId('filters')?.querySelector('select[data-filter="Período"]');
 const periodLabel=periodSelect?.selectedOptions?.[0]?.textContent?.trim() ||
   (state.period==='all'?'2026 - acumulado até hoje':String(state.period).padStart(2,'0')+'/2026');
 status.textContent='Oracle | Família e tipologia'+
   (state.page==='AC-03'?' | Recorte: mês':'')+
   ' | Período: '+periodLabel;
 if(DATA_ORIGIN!=='ORACLE'||!Q533_VALID||state.profile!=='director'){
  panel.innerHTML='<div class="q533-alert"><strong>Dados indisponíveis para conciliação.</strong> A classificação Família x Tipologia não será apresentada enquanto Q533 e Q471 não coincidirem integralmente com os pedidos válidos.</div>'+haialaV615DiagnosticHTML();
  return;
 }
 // Os mesmos filtros do cabecalho aplicados aos outros indicadores Oracle.
 const selected=skuItemsFiltered();
 const keyset=new Set(selected.map(r=>String(r.id)+'|'+String(r.sku)));
 const filtered=Q533_ROWS.filter(r=>keyset.has(String(r.id)+'|'+String(r.sku)));
 const expectedSales=Math.round(selected.reduce((sum,r)=>sum+r.sales,0)*100);
 const actualSales=Math.round(filtered.reduce((sum,r)=>sum+r.sales,0)*100);
 if(filtered.length!==selected.length||Math.abs(actualSales-expectedSales)>2){
  panel.innerHTML='<div class="q533-alert">O recorte selecionado não conciliou entre itens comerciais e Família x Tipologia. Valores indisponíveis.</div>';return;
 }
 const families=['PRIMER','APD','ALUMINIO'];
 const empty=()=>({qty:0,val:0});
 const data=new Map();
 for(const r of filtered){
  const typ=r.type||'(SEM TIPOLOGIA)';
  if(!data.has(typ))data.set(typ,{PRIMER:empty(),APD:empty(),ALUMINIO:empty(),OUTRAS:empty()});
  const fam=families.includes(r.family)?r.family:'OUTRAS';
  const cell=data.get(typ)[fam];cell.qty+=r.qty;cell.val+=r.sales;
 }
 const fqty=n=>n.toLocaleString('pt-BR',{minimumFractionDigits:0,maximumFractionDigits:2});
 const fval=n=>money(n);
 const totalByFam={PRIMER:empty(),APD:empty(),ALUMINIO:empty(),OUTRAS:empty()};
 const rows=[...data.keys()].sort((a,b)=>a.localeCompare(b,'pt-BR'));
 let html='<div class="q533-scroll"><table class="q533-unified"><colgroup><col class="q533-typecol">'+Array(4).fill('<col class="q533-qtycol"><col class="q533-valuecol">').join('')+'</colgroup><thead>'+
  '<tr class="q533-tophead"><th rowspan="2" scope="col">Tipologia</th>'+
  '<th colspan="2" scope="colgroup">PRIMER</th><th colspan="2" scope="colgroup">APD</th>'+
  '<th colspan="2" scope="colgroup">ALUMÍNIO</th><th colspan="2" scope="colgroup">TOTAL</th></tr>'+
  '<tr class="q533-subhead">'+Array(4).fill('<th scope="col">QTE</th><th scope="col">VLR R$</th>').join('')+'</tr></thead><tbody>';
 for(const type of rows){
  const cells=data.get(type);let rowQty=0,rowVal=0;
  html+='<tr><td>'+esc(rotuloTipologia(type))+'</td>';
  for(const fam of families){
   const x=cells[fam];rowQty+=x.qty;rowVal+=x.val;
   totalByFam[fam].qty+=x.qty;totalByFam[fam].val+=x.val;
   html+='<td>'+fqty(x.qty)+'</td><td>'+fval(x.val)+'</td>';
  }
  const missing=cells.OUTRAS;
  totalByFam.OUTRAS.qty+=missing.qty;totalByFam.OUTRAS.val+=missing.val;
  rowQty+=missing.qty;rowVal+=missing.val;
  html+='<td class="q533-bold">'+fqty(rowQty)+'</td><td class="q533-bold">'+fval(rowVal)+'</td></tr>';
 }
 const allQty=Object.values(totalByFam).reduce((a,x)=>a+x.qty,0);
 const allVal=Object.values(totalByFam).reduce((a,x)=>a+x.val,0);
 html+='<tr class="q533-total"><td>TOTAL DO RECORTE</td>';
 for(const fam of families)html+='<td>'+fqty(totalByFam[fam].qty)+'</td><td>'+fval(totalByFam[fam].val)+'</td>';
 html+='<td>'+fqty(allQty)+'</td><td>'+fval(allVal)+'</td></tr></tbody></table></div>';
 const otherRows=filtered.filter(r=>!families.includes(r.family));
 const otherCount=otherRows.length;
 const otherQty=totalByFam.OUTRAS.qty,otherVal=totalByFam.OUTRAS.val;
 const otherUnits=filtered.reduce((a,r)=>a+r.other,0);
 const warning=otherCount?'<p class="q533-unclassified" role="alert"><strong>ATENÇÃO - OUTRAS / NÃO CLASSIFICADAS:</strong> '+otherCount+' pares pedido-SKU | '+fqty(otherQty)+' PC | '+fval(otherVal)+'. Esses itens estão incluídos nos totais, porém não nas três famílias exibidas.</p>':'';
 panel.innerHTML=html+warning+'<p class="q533-note">Fonte: TGFCAB + TGFITE + TGFPRO + TGFGRU | Empresa 1 | '+
   esc(state.period==='all'?'2026 acumulado até hoje':'Mês '+String(state.period).padStart(2,'0')+'/2026')+
   ' | Quantidade em PC: '+fqty(allQty)+' | Vendas conciliadas: '+fval(actualSales/100)+
   ' | Linhas em outras unidades: '+otherUnits+'. Mesmos filtros do cabeçalho. Quantidades não-PC não são somadas como peças; seus valores permanecem no financeiro.</p>';
}

/* HAIALA v5.2 - Vendas: separar analise por operacao da consulta agrupada.
   VD-01: base realFiltered() ja conciliada; nao replicar graficos temporais AC.
   VD-02: Q46 consulta AGRUPADA por dia/TOP/cliente/vendedor, sem NUNOTA.
   A exportacao continua bloqueada por permissoes. */
function renderVD52(){
 const isAnalysis=state.page==='VD-01';
 const isOrders=state.page==='VD-02';
 if(!isAnalysis&&!isOrders)return;
 const rules=byId('rulesPanel'),sec03=byId('cl01Sec03'),q12=byId('q12Real');
 if(rules)rules.style.display='none';
 if(sec03)sec03.style.display='none';
 if(q12)q12.style.display='none';
 const sec01=byId('cl01Sec01'),sec02=byId('cl01Sec02'),sec04=byId('cl01Sec04');
 const source=(DATA_ORIGIN==='ORACLE'&&Q43_CONSISTENTE&&(!isOrders||Q46_VALID));
 const itemDimension=(skuSelected()||typeSelected()||managerActive()||ufActive()||carteiraActive());
 const sourceRows=(isOrders&&!itemDimension&&Q46_VALID) ? Q46_ROWS.filter(r=>(state.rep==='all'||String(r[7])===String(state.rep))&&clientMatches(r[8])) : realFiltered();
 const filtered=sourceRows.filter(r=>state.period==='all'||Number(String(r[0]).slice(5,7))===Number(state.period));
 const totals=filtered.reduce((a,r)=>{a.orders+=Number(r[2]||0);a.sales+=Number(r[3]||0);a.st+=Number(r[4]||0);a.icms+=Number(r[5]||0);a.discount+=Number(r[6]||0);return a;},{orders:0,sales:0,st:0,icms:0,discount:0});
 const byTop=new Map();
 for(const r of filtered){const op=String(r[1]),x=byTop.get(op)||{op,orders:0,sales:0,st:0,icms:0,discount:0};x.orders+=Number(r[2]||0);x.sales+=Number(r[3]||0);x.st+=Number(r[4]||0);x.icms+=Number(r[5]||0);x.discount+=Number(r[6]||0);byTop.set(op,x);}
 const opRows=[...byTop.values()].sort((a,b)=>a.op.localeCompare(b.op));
 const cards=[['Vendas',money(totals.sales),'Sem ST'],['Pedidos válidos',fmt(totals.orders),'TOP 1000,1001,1005,1007,9000,9001 | A/P/L'],['Ticket médio',totals.orders?money(totals.sales/totals.orders):'N/D','Vendas / pedidos'],['ICMS informativo',money(totals.icms),'Sem nova dedução'],['ST',money(totals.st),'Separado das vendas'],skuPedidoCard512(totals.orders)];
 const setCards=(list)=>{byId('kpis').classList.remove('five-kpis');byId('kpis').classList.add('six-kpis');byId('kpis').innerHTML=list.map(([a,b,c])=>'<div class="kpi"><span>'+esc(a)+'</span><strong>'+esc(b)+'</strong><small>'+esc(c)+'</small></div>').join('');};
 const scope='Fonte: '+(source?'Oracle':'Indisponível')+' | Empresa 1 | '+(state.period==='all'?'2026 acumulado':'Mês '+String(state.period).padStart(2,'0')+'/2026');
 sec01.querySelector('h2').textContent='01 - Visão executiva de Vendas (Oracle)';
 sec02.querySelector('h2').textContent=isAnalysis?'02 - Composição por operação (Oracle)':'02 - Consulta agrupada (Oracle)';
 sec04.querySelector('h2').textContent=isAnalysis?'03 - Detalhamento comercial (Oracle)':'03 - Registros de vendas agrupados (Oracle)';
 byId('kpiHint').textContent=scope+' | '+fmt(totals.orders)+' pedidos';
 if(!source){
  setCards([['Dados de vendas','N/D','Consulta Oracle não conciliada']]);
  byId('primaryPanel').innerHTML='<p class="empty">Consulta Oracle indisponível. Não serão usados dados sintéticos neste recorte.</p>';
  byId('secondaryPanel').innerHTML='';byId('tablePanel').innerHTML='';byId('tableHelp').textContent='Sem valores validados';
  return;
 }
 setCards(cards);
 const topCols=['TOP','Pedidos','Vendas','Ticket médio','ICMS informativo','ST','Descontos'];
 const topTable='<table><thead><tr>'+topCols.map(x=>'<th>'+esc(x)+'</th>').join('')+'</tr></thead><tbody>'+opRows.map(x=>'<tr><td>'+esc(x.op)+'</td><td>'+fmt(x.orders)+'</td><td>'+money(x.sales)+'</td><td>'+(x.orders?money(x.sales/x.orders):'N/D')+'</td><td>'+money(x.icms)+'</td><td>'+money(x.st)+'</td><td>'+money(x.discount)+'</td></tr>').join('')+'</tbody></table>';
 if(isAnalysis){
  const max=Math.max(1,...opRows.map(x=>x.sales));
  byId('primaryPanel').innerHTML='<h3 class="paneltitle">Vendas por operação comercial</h3>'+opRows.map(x=>'<div class="minirow"><span class="minilabel">TOP '+esc(x.op)+'</span><div style="flex:1;max-width:70%;background:#e5eff5;border-radius:5px"><div style="height:14px;width:'+Math.max(1,100*x.sales/max)+'%;background:#367f9f;border-radius:5px"></div></div><strong>'+money(x.sales)+'</strong></div>').join('')+'<p class="note">Comparação por TOP. Evolução temporal consolidada pertence ao menu Acompanhamento.</p>';
  byId('secondaryPanel').innerHTML='<h3 class="paneltitle">Leitura comercial</h3><div class="minirow"><span class="minilabel">Pedidos</span><strong>'+fmt(totals.orders)+'</strong></div><div class="minirow"><span class="minilabel">Vendas sem ST</span><strong>'+money(totals.sales)+'</strong></div><div class="minirow"><span class="minilabel">Descontos dos itens</span><strong>'+money(totals.discount)+'</strong></div><div class="minirow"><span class="minilabel">ST informativa</span><strong>'+money(totals.st)+'</strong></div><p class="note">Vendas por operação, sem replicar as séries diária, semanal e anual de Acompanhamento.</p>';
  latestCols=topCols;latestRows=opRows.map(x=>[x.op,fmt(x.orders),money(x.sales),x.orders?money(x.sales/x.orders):'N/D',money(x.icms),money(x.st),money(x.discount)]);
  byId('tablePanel').innerHTML=topTable;
  byId('tableHelp').textContent='Operações comerciais válidas | '+scope+' | Exportação pendente de autorização';
 }else{
  // A consulta Q46 agrupa pedidos: NAO identifica cada NUNOTA. Recortes por item
  // podem usar Q471, mas a agregacao continua sendo por dia/cliente/TOP/vendedor.
  const byKey=new Map();
  for(const r of filtered){const key=[r[0],r[1],r[8]??'',r[7]??''].join('|');let x=byKey.get(key);if(!x){x={day:r[0],op:r[1],client:r[8],rep:r[7],orders:0,sales:0,st:0};byKey.set(key,x)}x.orders+=Number(r[2]||0);x.sales+=Number(r[3]||0);x.st+=Number(r[4]||0);}
  const grouped=[...byKey.values()].sort((a,b)=>b.day.localeCompare(a.day)||Number(a.client)-Number(b.client));
  byId('primaryPanel').innerHTML='<h3 class="paneltitle">Pedidos por TOP</h3>'+opRows.map(x=>'<div class="minirow"><span class="minilabel">TOP '+esc(x.op)+'</span><strong>'+fmt(x.orders)+' pedidos</strong></div>').join('')+'<p class="note">A contagem é real. A consulta Q46 não fornece NUNOTA individual.</p>';
  byId('secondaryPanel').innerHTML='<h3 class="paneltitle">Granularidade disponível</h3><p class="note">Registros agrupados por dia de negociação, cliente, representante da venda e TOP. Um registro pode representar vários pedidos. Para a listagem de NUNOTA será necessária uma consulta específica, ainda não integrada.</p>';
  const cols=['Data negociação','TOP','Cliente','Rep. venda','Pedidos','Vendas','ST'];
  latestCols=cols;latestRows=grouped.map(x=>[x.day,String(x.op),x.client!=null?rotuloCliente(x.client):'N/D',x.rep!=null?repName(x.rep):'N/D',fmt(x.orders),money(x.sales),money(x.st)]);
  byId('tablePanel').innerHTML='<table><thead><tr>'+cols.map(x=>'<th>'+(x==='Qte SKU / Pedido'?'Qte SKU /<span class="ac-header-break">Pedido</span>':esc(x))+'</th>').join('')+'</tr></thead><tbody>'+latestRows.slice(0,500).map(r=>'<tr>'+r.map(c=>'<td>'+esc(c)+'</td>').join('')+'</tr>').join('')+'</tbody></table>';
  byId('tableHelp').textContent=fmt(grouped.length)+' grupos reais, '+fmt(Math.min(grouped.length,500))+' exibidos | Q46/Q471 | Não é listagem de NUNOTA | Exportação indisponível';
 }
 const ex=byId('exportBtn');if(ex){ex.disabled=true;ex.title='Exportação bloqueada até autorização real de usuário';}
}

function renderQ12Primary(pg){
 const eligible=['AC-01','AC-02','AC-03','AC-04','VD-01','VD-03'].includes(state.page);
 if(!eligible)return;
 const set=realFiltered().filter(r=>state.period==='all'||Number(r[0].slice(5,7))===Number(state.period));
 const groupKey=r=>state.page==='AC-01'?r[0] :state.page==='AC-02'?isoWeekQ12(r[0]):r[0].slice(0,7);
 const data=new Map();
 for(const r of set){const k=groupKey(r);if(!data.has(k))data.set(k,{k,n:0,v:0,st:0,icms:0,desc:0});const x=data.get(k);x.n+=r[2];x.v+=r[3];x.st+=r[4];x.icms+=r[5];x.desc+=r[6]}
 const arr=[...data.values()].sort((a,b)=>a.k.localeCompare(b.k));
 for(const x of arr){x.skus=distinctSkusPeriod(x.k,r=>state.page==='AC-01'?r:state.page==='AC-02'?isoWeekQ12(r):r.slice(0,7));}

 const all={n:0,v:0,st:0,icms:0,desc:0};for(const x of arr)for(const k of Object.keys(all))all[k]+=x[k];
 const val=n=>money(Math.round(n*100)/100);
 const distinctSkuCount=Q471_VALID?new Set(skuItemsFiltered().map(r=>String(r.sku))).size:null;
 const k=[['Vendas (R$)',val(all.v),'VEN-03 | TOP 1000,1001,1005,1007,9000,9001'],['Pedidos',fmt(all.n),'VEN-04 | situação A/P/L'],['Ticket médio',all.n?val(all.v/all.n):'Indisponivel','VEN-05 | Vendas / pedidos'],['Substituição Tributária (ST)',(fiscalFilterActive()&&!Q476_FISCAL_VALID)?'N/D - não conciliado':val(all.st),'Tributario | fora das vendas'],['Qtd. SKUs',distinctSkuCount===null?'N/D':fmt(distinctSkuCount),'PRO | CODPROD distintos no recorte']];
 if(state.page==='AC-03')k.push(skuPedidoCard512(all.n));
 byId('kpis').classList.remove('five-kpis','six-kpis');byId('kpis').classList.add(state.page==='AC-03'?'six-kpis':'five-kpis');
 byId('kpis').innerHTML=k.map(([a,b,c])=>`<div class="kpi" style="cursor:default"><span>\${esc(a)}</span><strong>\${esc(b)}</strong><small>\${esc(c)}</small></div>`).join('');
 byId('kpiHint').textContent=`\${fmt(all.n)} pedidos - fonte \${DATA_ORIGIN}`;
 const mx=Math.max(1,...arr.map(x=>x.v));
 const bars=arr.slice(-31).map(x=>`<div class="barcol" title="\${esc(x.k)}: \${esc(val(x.v))}"><em>\${Math.round(x.v/1000)}k</em><div class="bar" style="height:\${Math.max(2,x.v/mx*165)}px"></div><span>\${esc(x.k.slice(5))}</span></div>`).join('');
 byId('primaryPanel').innerHTML=`<h3 class="paneltitle">Evolução de Vendas - \${state.page==='AC-01'?'diaria':state.page==='AC-02'?'semanal':'mensal'}</h3><div class="bars">\${bars||'<p class="empty">Sem dados na selecao.</p>'}</div><p class="note">\${esc(origemRecorte().linha)}</p>`;
 byId('secondaryPanel').innerHTML=`<h3 class="paneltitle">Composicao financeira - periodo</h3><div class="minirow"><span class="minilabel">Vendas</span><strong>\${val(all.v)}</strong></div><div class="minirow"><span class="minilabel">ST</span><strong>\${(fiscalFilterActive()&&!Q476_FISCAL_VALID)?'N/D':val(all.st)}</strong></div><div class="minirow"><span class="minilabel">ICMS (informativo)</span><strong>\${(fiscalFilterActive()&&!Q476_FISCAL_VALID)?'N/D':val(all.icms)}</strong></div><div class="minirow"><span class="minilabel">Descontos dos itens</span><strong>\${val(all.desc)}</strong></div><p class="note">ICMS nao e deduzido novamente do valor das vendas. ST tratada separadamente.</p>`;
 const cols=['Período','Pedidos','Vendas','Qtd. SKUs','ST','ICMS informativo','Descontos itens','Ticket médio'];
 const rows=arr.map(x=>[x.k,fmt(x.n),val(x.v),x.skus===null?'N/D':fmt(x.skus),(fiscalFilterActive()&&!Q476_FISCAL_VALID)?'N/D':val(x.st),(fiscalFilterActive()&&!Q476_FISCAL_VALID)?'N/D':val(x.icms),val(x.desc),x.n?val(x.v/x.n):'--']);
 latestCols=cols;latestRows=rows;
 byId('tablePanel').innerHTML=`<table><thead><tr>\${cols.map(c=>`<th>\${esc(c)}</th>`).join('')}</tr></thead><tbody>\${rows.map((r,i)=>`<tr data-row="\${i}">\${r.map(v=>`<td>\${esc(v)}</td>`).join('')}</tr>`).join('')}</tbody></table>`;
 byId('tablePanel').querySelectorAll('[data-row]').forEach(tr=>tr.onclick=()=>detail(rows[Number(tr.dataset.row)],cols));
 byId('tableHelp').textContent=`\${rows.length} períodos - \${origemRecorte().linha}`;
 const repApplied=state.rep!=='all' && Q45_VALID && state.profile==='director';
 const cliApplied=clientSelected() && Q46_VALID && state.profile==='director'; const otherFilters=(managerActive()&&!V477_REP_OK)||(ufActive()&&!V477_UF_OK)||(carteiraActive()&&!CARTEIRA478_VALID);
 const note=(otherFilters?'ATENÇÃO: dimensão indisponível; filtro bloqueado. ':'')+(carteiraActive()&&CARTEIRA478_VALID?'Responsável ATUAL '+carteiraName(state.carteira)+' aplicado ao cliente cadastrado; vendas continuam atribuídas ao vendedor original. ':'')+(repApplied?'Representante do pedido '+state.rep+' aplicado no Oracle. ':'')+(cliApplied?'Cliente do pedido '+clientLabel()+' aplicado no Oracle. ':'')+(typeSelected()?'Tipologia '+state.type+' aplicada aos itens (AD_TIPOLOGIA). ':'')+(skuSelected()?'SKU '+state.sku+' aplicado aos itens. ':'')+((skuSelected()||typeSelected())?'Vendas somente dos itens selecionados; pedidos distintos por NUNOTA; '+(Q476_FISCAL_VALID?'ICMS/ST/IPI dos itens conciliados. ':'ICMS/ST/IPI N/D - conciliação pendente. '):'')+'Período aplicado; demais filtros reais indisponíveis.';
 let msg=byId('q12FilterNotice');if(!msg){msg=document.createElement('div');msg.id='q12FilterNotice';msg.className='notice';byId('kpis').insertAdjacentElement('beforebegin',msg)}msg.textContent='DADOS COMERCIAIS - '+note+' '+origemRecorte().linha;
}


/* v5.3.3.14.6.4 - Exclusão mútua entre responsável da base (TGFPAR.CODVEND)
   e representante da venda (TGFCAB.CODVEND). Regra apenas de interface:
   nenhuma seleção dupla diferente de Todos é aceita. */
function haialaSyncRepLocks(){
 const root=byId('filters');if(!root)return;
 const base=root.querySelector('select[data-filter="Representante da Base"]');
 const venda=root.querySelector('select[data-filter="Representante da venda"]');
 if(!base||!venda)return;
 const baseSelected=state.carteira!=='all';
 const vendaSelected=state.rep!=='all';
 if(baseSelected){
   venda.disabled=true;
   venda.title='Para escolher Representante da venda, altere Representante da Base para Todas as carteiras.';
 }else if(vendaSelected){
   base.disabled=true;
   base.title='Para escolher Representante da Base, altere Representante da venda para Todos.';
 }else{
   // Não reabilitar controles bloqueados por falta de fonte ou por página não integrada.
   base.title='Selecione um representante da base ou mantenha Todos.';
   venda.title='Selecione um representante da venda ou mantenha Todos.';
 }
}

/* HAIALA v6.0.3 - bloco aditivo. Fonte: Q471, Q533, Q539-T, Q534 e TGFPAR/TGFVEN já presentes no JSP.
   Não cria consultas Oracle. Não altera o recorte nem as métricas dos blocos v5.
   Vendas pela autoria do pedido; carteira pelo responsável cadastral atual.
   Percentuais e médias são recomputados sobre seus denominadores, nunca somados. */
const V601_ACTIVE_NODE=document.getElementById('haialaV601RepAtivosMetadata');
const V601_ACTIVE_OK=!!V601_ACTIVE_NODE&&V601_ACTIVE_NODE.dataset.ok==='true';
const V601_ACTIVE_REPS=new Map();
if(V601_ACTIVE_OK){V601_ACTIVE_NODE.querySelectorAll('.haiala-v601-active-rep').forEach(el=>{
 const d=el.dataset;V601_ACTIVE_REPS.set(String(d.id),{
  name:String(d.name||''),manager:String(d.ger||'-1'),managerName:String(d.gerName||''),type:String(d.type||''),active:String(d.active||'')
 });
});}
// Bloco 02 somente: um gerente R/V tambem figura como representante da propria equipe.
// Usa o cadastro ja consultado, sem duplicar o CODVEND em dois grupos.
const V6_CODIGOS_GERENTES=new Set([...V601_ACTIVE_REPS.values()].map(m=>String(m.manager)).filter(id=>id!=='-1'));
function v6GerenciaRepresentante(rep,meta){
 const id=String(rep);
 return V6_CODIGOS_GERENTES.has(id)?id:String(meta.manager||'-1');
}
const V6_GERREP_COLS=['Representante','Vendas R$','Pedidos','Ticket médio','Qte SKU / Pedido','Preço médio','Prazo médio','Clientes total','Ativos 90 dias','Com vendas','Com Showroom','Venda Showroom','Frete R$','MC R$','MC %'];
function renderV6GerentesRepresentantes(){
 const host=document.getElementById('haialaV6GerRep');if(!host)return;
 const active=['AC-01','AC-02','AC-03'].includes(state.page);
 host.style.display=active?'block':'none';if(!active){host.innerHTML='';return;}
 const valid=DATA_ORIGIN==='ORACLE'&&Q471_VALID&&V477_REP_OK&&state.profile==='director';
 if(!valid){host.innerHTML='<h2>02 - Desempenho por Gerente e Representante</h2><p class="v6-warning">N/D: Q471 ou cadastro gerencial não conciliado. Nenhum valor sintético publicado.</p>';return;}
 const source=skuItemsFiltered(); // mesmo recorte de filtros Oracle do bloco 01
 const buckets=new Map();
 for(const item of source){
  const rep=String(item.rep);
  // Somente vendedores/representantes TIPVEND R/V: a lista vem do cadastro Oracle exclusivo do Bloco 02.
  if(!V601_ACTIVE_OK||!V601_ACTIVE_REPS.has(rep))continue;
  const meta=V601_ACTIVE_REPS.get(rep),ger=v6GerenciaRepresentante(rep,meta);
  let g=buckets.get(ger);if(!g){g=new Map();buckets.set(ger,g);}
  let rows=g.get(rep);if(!rows){rows=[];g.set(rep,rows);}rows.push(item);
 }
 // Sem venda também entra. A consulta de ativos é separada da V477 homologada.
 if(V601_ACTIVE_OK){for(const [rep,meta] of V601_ACTIVE_REPS){
   if(meta.active.toUpperCase()!=='S')continue; // Sem vendas: somente ativos, conforme regra homologada.
   const ger=v6GerenciaRepresentante(rep,meta);
   if(state.manager!=='all'&&String(state.manager)!==ger)continue;
   if(state.rep!=='all'&&String(state.rep)!==rep)continue;
   if(state.carteira!=='all'&&String(state.carteira)!==rep)continue;
   let g=buckets.get(ger);if(!g){g=new Map();buckets.set(ger,g);}
   if(!g.has(rep))g.set(rep,[]);
 }}
 // v6.0.9: preservar a carteira sem vendedor/representante em grupo próprio.
 // Não converte esta carteira em vendedor fictício nem a associa a uma gerência real.
 const semVendedor='__SEM_VENDEDOR__';
 if(CAD479_VALID && state.manager==='all' && state.rep==='all' && state.carteira==='all' &&
    CAD479_ROWS.some(c=>c.commercial&&c.cardEligible&&
      (c.owner==='-1'||c.owner==='0')&&
      (state.uf==='all'||c.uf===state.uf)&&clientMatches(c.client))){
   buckets.set(semVendedor,new Map([[semVendedor,[]]]));
 }
 const freight=q539TFiltered();
 const mcMap=freight===null?null:new Map(freight.map(r=>[String(r.id)+'|'+String(r.sku),r]));
 const portfolioOK=CAD479_VALID;
 const priceOK=Q533_VALID;
 const termOK=Q534P_VALID&&!skuSelected()&&!typeSelected();
 const metricsFor=(items,repsGroup,ger)=>{
  const orderIds=new Set(items.map(r=>r.id)),clientSold=new Set(items.filter(r=>String(r.rep)!=='4').map(r=>String(r.client)));
  const sales=items.reduce((t,r)=>t+r.sales,0),orderCount=orderIds.size;
  const validPairs=items.length>0&&items.every(r=>Number.isFinite(r.id)&&Number.isFinite(r.sales));
  const q533=priceOK?items.map(r=>Q533_ORDER_SKU.get(String(r.id)+'|'+String(r.sku))):null;
  const priceBase=q533&&q533.every(Boolean)&&q533.length===items.length;
  const qty=priceBase?q533.reduce((v,r)=>v+r.qty,0):0;
  const salesPC=priceBase?q533.reduce((v,r)=>v+r.salesPC,0):0;
  let days=0,parts=0,termsValid=termOK;
  if(termsValid){for(const id of orderIds){const r=Q534P_MAP.get(id);if(!r||!(r.valor>0)){termsValid=false;break;}days+=r.diasValor;parts+=r.valor;}}
  // Clientes e showroom: ownership atual; não duplicar clientes quando agrega gerente.
  const reps=new Set(repsGroup.map(String));
  const cards=portfolioOK?CAD479_ROWS.filter(c=>c.commercial&&c.cardEligible&&String(c.owner)!=='4'&&
    (reps.has(String(c.owner))||(ger==='__SEM_VENDEDOR__'&&(c.owner==='-1'||c.owner==='0')))&&
    (state.uf==='all'||c.uf===state.uf)&&clientMatches(c.client)&&
    (V477_REP_MAP.get(String(c.owner))?.manager||'-1')!=='4'):null;
  let mcs=null;
  if(mcMap){mcs=items.map(r=>mcMap.get(String(r.id)+'|'+String(r.sku)));if(mcs.some(x=>!x))mcs=null;}
  const mcSales=mcs?mcs.reduce((v,r)=>v+r.receita,0):0;
  const mcValue=mcs?mcs.reduce((v,r)=>v+r.margem,0):0;
  const sumFreight=mcs?mcs.reduce((v,r)=>v+r.frete,0):0;
  const cardSold=cards?cards.filter(c=>clientSold.has(c.client)).length:null;
  const show=cards?cards.filter(c=>c.showroom).length:null;
  const showSold=cards?cards.filter(c=>c.showroom&&clientSold.has(c.client)).length:null;
  const n=v=>v==null?'N/D':fmt(v);
  return [money(sales),n(orderCount),orderCount?money(sales/orderCount):'N/D',
   validPairs&&orderCount?(items.length/orderCount).toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2}):'N/D',
   priceBase&&qty>0?money(salesPC/qty):'N/D',termsValid&&parts>0?(days/parts).toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2})+' dias':'N/D',
   n(cards?.length),n(cards?.filter(c=>!c.never&&!c.inactive90).length),n(cardSold),n(show),n(showSold),
   mcs?money(sumFreight):'N/D',mcs?money(mcValue):'N/D',mcs&&mcSales>0?(100*mcValue/mcSales).toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2})+'%':'N/D'];
 };
 const v601RepName=id=>String(id)==='__SEM_VENDEDOR__'?'Sem vendedor/representante':
  V601_ACTIVE_REPS.has(String(id))?String(id)+' - '+V601_ACTIVE_REPS.get(String(id)).name:repName(Number(id));
 const v601GerName=id=>{
   if(String(id)==='__SEM_VENDEDOR__')return '0 - <SEM VENDEDOR>';
   const pair=[...V601_ACTIVE_REPS.values()].find(x=>x.manager===String(id));
   return pair?String(id)+' - '+pair.managerName:labelManager(id);
 };
 const head='<thead><tr>'+V6_GERREP_COLS.map((c,i)=>'<th'+(i===0?' scope="col"':'')+'>'+esc(i===0?'Gerente / Rep.':c)+'</th>').join('')+'</tr></thead>';
 const repSort=(a,b)=>a.localeCompare(b,'pt-BR',{numeric:true});
 const shortLabel=value=>{const arr=Array.from(String(value));return arr.length>20?arr.slice(0,17).join('')+'...':arr.join('');};
 const sections=[...buckets.keys()].sort((a,b)=>a==='__SEM_VENDEDOR__'?-1:b==='__SEM_VENDEDOR__'?1:a==='-1'?1:b==='-1'?-1:repSort(v601GerName(a),v601GerName(b)));
 let tableRows='';
 for(const ger of sections){
  const reps=buckets.get(ger),repIds=[...reps.keys()].sort((a,b)=>repSort(v601RepName(a),v601RepName(b)));
  const allItems=repIds.flatMap(r=>reps.get(r));
  const name=v601GerName(ger), metrics=metricsFor(allItems,repIds,ger);
  const gerKey=esc(String(ger));
  tableRows+='<tr class="v6-total" data-v6-manager="'+gerKey+'"><td><button type="button" class="v6-row-toggle" aria-expanded="false" title="'+esc(name)+' | '+fmt(repIds.length)+' representantes"><span class="v6-caret" aria-hidden="true"></span><span class="v6-row-name">'+esc(shortLabel(name))+'</span></button></td>'+metrics.map(v=>'<td>'+esc(v)+'</td>').join('')+'</tr>';
  for(const rep of repIds){
   const repNameFull=v601RepName(rep), idle=reps.get(rep).length===0;
   const own=String(rep)===String(ger);
   const etiquetaRep=rep==='__SEM_VENDEDOR__'
    ?'<span class="v6-rep-link" style="color:inherit;text-decoration:none;cursor:default" title="Clientes sem vendedor/representante cadastrado">'+esc(shortLabel(repNameFull))+'</span>'
    :'<button type="button" class="v6-rep-link'+(idle?' v6-rep-idle':'')+'" data-v6-order-rep="'+esc(String(rep))+'" title="'+esc(repNameFull)+(own?' (gerente: vendas próprias)':'')+(idle?' (sem vendas)':'')+'">'+esc(shortLabel(repNameFull))+'</button>';
   tableRows+='<tr data-v6-parent="'+gerKey+'" hidden><td title="'+esc(repNameFull)+(idle?' (sem vendas)':'')+'">'+etiquetaRep+'</td>'+metricsFor(reps.get(rep),[rep],ger).map(v=>'<td>'+esc(v)+'</td>').join('')+'</tr>';
  }
 }
 host.innerHTML='<h2>02 - Desempenho por Gerente e Representante</h2>'+
 '<p class="v6-subtitle">Fonte Oracle · Recorte e filtros atuais · Clique no gerente para expandir/recolher os representantes. Passe o mouse sobre os nomes abreviados.</p>'+
 (!V601_ACTIVE_OK?'<p class="v6-warning">Cadastro de tipos R/V indisponível. Não é possível publicar a visão gerencial sem validar o TIPVEND.</p>':'')+
 (!portfolioOK?'<p class="v6-warning">Cadastro de clientes não conciliado: indicadores cadastrais exibidos como N/D.</p>':'')+
 (!mcMap?'<p class="v6-warning">MC/frete indisponíveis no recorte: não substituídos por zero.</p>':'')+
 (tableRows?'<div class="v6-scroll"><table>'+head+'<tbody>'+tableRows+'</tbody></table></div>':'<p class="v6-warning">Não há representantes com vendas no recorte selecionado.</p>')+
 '<p class="v6-subtitle">Totais de gerência recalculados por pedidos e clientes distintos. Não somar percentuais ou médias.</p>';
 host.querySelectorAll('tr[data-v6-manager] .v6-row-toggle').forEach(button=>{
  button.addEventListener('click',()=>{
   const parent=button.closest('tr'), key=parent.dataset.v6Manager;
   const opening=button.getAttribute('aria-expanded')!=='true';
   button.setAttribute('aria-expanded',String(opening));
   host.querySelectorAll('tr[data-v6-parent]').forEach(row=>{
    if(row.dataset.v6Parent===key)row.hidden=!opening;
   });
  });
 });
 host.querySelectorAll('[data-v6-order-rep]').forEach(button=>{
  button.addEventListener('click',()=>detailPedidosAC(null,null,button.dataset.v6OrderRep));
 });
}

function draw(){if(state.rep!=='all'&&state.carteira!=='all')state.rep='all';if(state.page==='AC-04'||String(state.page).indexOf('VD-')===0)state.page='AC-03';atualizarCarteiraCompleta();update477Status();updateCarteiraNotice();atualizarContextoOrigem();byId('kpis').classList.remove('five-kpis','six-kpis');updateRepNotice();updateClientNotice();renderTaxComposition();const oldNote=byId('q12FilterNotice');if(oldNote)oldNote.remove();const pg=p();buildNav();byId('crumb').textContent=`\${pg.moduleName} / \${pg.id} - \${pg.codes}`;byId('pageTitle').textContent=pg.name;byId('pageDesc').textContent=pg.description;v5Presentation();byId('filters').innerHTML=options();let f=byId('filters').querySelectorAll('select');f.forEach(el=>{if(!isRealPage() && !(['CL-01','CL-02','CL-03','CL-04'].includes(state.page) && ['Gerência','Representante da venda','Representante da Base','UF','Cliente'].includes(el.dataset.filter)) && ['Gerência','Representante da venda','Representante da Base','UF','Tipologia','Cliente','SKU'].includes(el.dataset.filter))el.disabled=true;let key={'Período':'period','Perfil':'profile','Gerência':'manager','Representante da venda':'rep','Representante da Base':'carteira','UF':'uf','Tipologia':'type','Cliente':'focus','SKU':'sku'}[el.dataset.filter];el.value=state[key];if(el.value!==state[key]){state[key]='all';el.value='all'}el.onchange=()=>{if(key==='rep'&&el.value!=='all'&&state.carteira!=='all'){el.value='all';return;}if(key==='carteira'&&el.value!=='all'&&state.rep!=='all'){el.value='all';return;}state[key]=el.value;if(key==='profile'){state.rep='all';state.manager='all';state.focus='all';state.sku='all';state.type='all'}draw()}});haialaSyncRepLocks();initClientMulti();byId('scopeLabel').textContent='Empresa 1 | '+(DATA_ORIGIN==='ORACLE'?'Fonte: Oracle':'Fonte: snapshot')+' | '+(isRealPage()||['CL-01','CL-02','CL-03','CL-04'].includes(state.page)?'Dados comerciais':'Página em demonstração');const b=base();let g=groups(pg.kind,b.a);const k=kpisFor(pg.kind,b,g);byId('kpis').innerHTML=k.map(([name,value,code],i)=>`<div class="kpi" data-kpi="\${i}" role="button" tabindex="0"><span>\${esc(name)}</span><strong>\${esc(value)}</strong><small>\${esc(code)} - Ver composição </small></div>`).join('');byId('kpiHint').textContent=`\${b.orders} pedidos válidos na seleção`;byId('primaryPanel').innerHTML=pg.kind==='geo'||pg.kind==='map'||pg.kind==='region'||pg.kind==='expansion'?mapGraphic(g):plot(g);byId('secondaryPanel').innerHTML=rankings(g);if(pg.kind==='query'){byId('secondaryPanel').insertAdjacentHTML('afterbegin',`<div class="field"><label>Agrupar consulta</label><select id="queryGroup"><option value="rep">Representante</option><option value="client">Cliente</option><option value="sku">SKU</option><option value="uf">UF</option></select></div>`);byId('queryGroup').value=state.queryGroup||'rep';byId('queryGroup').onchange=e=>{state.queryGroup=e.target.value;draw()}};const t=tableFor(pg.kind,b,g);latestRows=t.rows;latestCols=t.cols;byId('tablePanel').innerHTML=`<table><thead><tr>\${t.cols.map(c=>`<th>\${esc(c)}</th>`).join('')}</tr></thead><tbody>\${t.rows.length?t.rows.map((r,i)=>`<tr data-row="\${i}">\${r.map(x=>`<td>\${esc(x)}</td>`).join('')}</tr>`).join(''):`<tr><td colspan="\${t.cols.length}" class="empty">Nenhum registro atende aos filtros.</td></tr>`}</tbody></table>`;byId('tablePanel').querySelectorAll('[data-row]').forEach(tr=>tr.onclick=()=>detail(t.rows[Number(tr.dataset.row)],t.cols));byId('tableHelp').textContent=`\${t.rows.length} linhas exibidas - Clique em uma linha para detalhar - Valores de demonstração, sem validação no ERP.`;byId('activeFilters').innerHTML=[['Período',state.period],['Representante da Base',state.carteira],['Cliente',state.focus],['SKU',state.sku],['Gerência',state.manager],['Representante da venda',state.rep],['UF',state.uf],['Tipologia',state.type]].filter(x=>x[1]!=='all').map(x=>`<span class="chip">\${esc(x[0])}: \${esc(x[1])}</span>`).join('')||'<span class="chip">Todos os filtros compatíveis</span>';document.querySelectorAll('[data-kpi]').forEach(el=>{el.onclick=()=>detail([k[+el.dataset.kpi][1]], [k[+el.dataset.kpi][0]]);el.onkeydown=e=>{if(e.key==='Enter')el.click()}});renderQ12();renderQ12Primary(pg);renderAC51();renderV6GerentesRepresentantes();renderCarteiraCompleta();byId('exportBtn').disabled=state.profile==='rep'||['AC-01','AC-02','AC-04','VD-01','VD-02','VD-03'].includes(state.page);byId('exportBtn').title=state.profile==='rep'?'Exportação indisponível no perfil demonstrativo de representante':''}
/* v5.3.3.14.6.10 - drill-down real de pedidos Q471, sem registros fictícios.
   Q471 é agregado NUNOTA/CODPROD: as linhas de item não são sequências fiscais originais. */
let detalheACPedidos=[];
let detalheACPaginacao=0;
let detalheACBusca='';
let detalheACAberto=null;
const DETALHE_AC_POR_PAGINA=25;
function detalheACPeriodo(dia,chave,gran){
 return gran==='dia'?dia===chave:gran==='semana'?isoWeekQ12(dia)===chave:dia.slice(0,7)===chave;
}
function v6RepPopupName(codvend){
 const cod=String(codvend), meta=V601_ACTIVE_REPS.get(cod);
 return cod+' - '+(meta?.name||repName(Number(cod)));
}
function detailPedidosAC(chave,gran,representante=null,topFiltro=null){
 if(!Q471_VALID||DATA_ORIGIN!=='ORACLE'||state.profile!=='director'){
  byId('modalHost').innerHTML='<div class="modalbg ac-order-modalbg" id="backdrop"><div class="modal" role="dialog" aria-modal="true"><div class="modalhead"><h2>Pedidos do período</h2><button class="btn" id="closeModal">Fechar</button></div><p class="note">Fonte Oracle de pedidos e itens não conciliada. Detalhamento indisponível.</p></div></div>';
  byId('closeModal').onclick=closeModal;byId('backdrop').onclick=e=>{if(e.target.id==='backdrop')closeModal()};return;
 }
 // Usar a mesma seleção dimensional da margem do Bloco 01 e Bloco 04.
 // Nunca consultar o mapa global sem validar os filtros/identidade da linha.
 // Detalhamento individual: a falha financeira de outro pedido não invalida
 // um pedido íntegro. O consolidado continua exigindo todas as linhas válidas.
 const margemPorPar=Q539T_MAP;
 const agrupados=new Map();
 const itensPeriodo=skuItemsFiltered();
 for(const r of itensPeriodo){
  if(gran&&!detalheACPeriodo(r.dia,chave,gran))continue;
  if(representante!==null&&String(r.rep)!==String(representante))continue;
  if(topFiltro!==null&&Number(r.op)!==Number(topFiltro))continue;
  let ped=agrupados.get(r.id);
  if(!ped){ped={id:r.id,dia:r.dia,cliente:r.client,rep:r.rep,top:r.op,vendas:0,descontos:0,icms:0,st:0,itens:[]};agrupados.set(r.id,ped);}
  ped.vendas+=r.sales;ped.descontos+=r.discount;ped.icms+=r.icms;ped.st+=r.st;
  const fam=Q533_VALID?Q533_ORDER_SKU.get(String(r.id)+'|'+String(r.sku)):null;
  const chavePar=String(r.id)+'|'+String(r.sku);
  const mc=margemPorPar?.get(chavePar)||null;
  // A ausência em Q539 é permitida somente para itens excluídos da margem.
  const excluidoMargem=false; // ausencia de margem sem conciliacao permanece N/D
  const mcConferido=!!mc && mc.id===r.id && mc.sku===r.sku && mc.dia===r.dia &&
   mc.client===r.client && mc.rep===r.rep && mc.op===r.op &&
   [mc.margem,mc.receita,mc.custo,mc.icms,mc.pis,mc.cofins,mc.comissao,mc.reflexo,mc.frete,mc.semCusto,mc.duplicados].every(Number.isFinite) &&
   Math.abs(mc.receita-r.sales)<0.03 && mc.semCusto===0 && mc.duplicados===0 &&
   Math.abs(mc.receita-mc.custo-mc.icms-mc.pis-mc.cofins-mc.comissao-mc.reflexo-mc.frete-mc.margem)<0.05 &&
   Q539T_MONTH_STATUS.get(r.dia.slice(5,7))===true;
  ped.itens.push({sku:r.sku,desc:rotuloSKU(r.sku),familia:fam?.family||'N/D',tipologia:r.typology,
   quantidade:fam?fam.qty:null,vendas:r.sales,descontos:r.discount,
   mc:mcConferido?mc.margem:null,receitaMc:mcConferido?mc.receita:null,memoria:mcConferido?mc:null,
   excluidoMargem:excluidoMargem && !mc,mcInvalido:!!mc && !mcConferido});
 }
 if(topFiltro!==null && Q6111_DOC_VALID){
  const docsSemItens=filtrarDocsTOP(topFiltro,1);
  for(const d of (docsSemItens||[])){
   if(!agrupados.has(d.id))agrupados.set(d.id,{id:d.id,dia:d.day,cliente:d.client,rep:d.rep,top:d.op,
    vendas:d.vlc,descontos:0,icms:0,st:d.st,itens:[],semItens:true});
  }
 }
 detalheACPedidos=[...agrupados.values()].sort((a,b)=>b.dia.localeCompare(a.dia)||b.id-a.id);
 for(const pedido of detalheACPedidos){
  pedido.buscaIndex=[pedido.id,pedido.cliente,rotuloClientePedido(pedido.cliente),repName(pedido.rep),prazoNegociacaoPedido(pedido.id),
    ...pedido.itens.flatMap(i=>[i.sku,i.desc])].join(' ').toLocaleLowerCase('pt-BR');
  const elegiveis=pedido.itens.filter(i=>i.mc!==null && i.receitaMc!==null);
  const temFalha=pedido.itens.some(i=>i.mcInvalido||(i.mc===null&&!i.excluidoMargem));
  const receita=elegiveis.reduce((a,i)=>a+i.receitaMc,0);
  const margem=elegiveis.reduce((a,i)=>a+i.mc,0);
  pedido.mcPercent=!temFalha && margemPorPedidoDisponivel(pedido,elegiveis)&&receita!==0?
   (100*margem/receita).toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2})+'%':'N/D';
  pedido.mcFalha=temFalha;
 }
 detalheACBusca='';detalheACPaginacao=0;detalheACAberto=null;
 const rotuloRecorte=topFiltro!==null?'TOP '+topFiltro:(representante===null?String(chave):'Representante '+v6RepPopupName(representante));
 const introRecorte=representante===null?'':' | Representante da venda: '+v6RepPopupName(representante);
 const numero=detalheACPedidos.length;
 const valor=detalheACPedidos.reduce((n,o)=>n+o.vendas,0);
 const clientes=new Set(detalheACPedidos.map(o=>o.cliente)).size;
 byId('modalHost').innerHTML='<div class="modalbg ac-order-modalbg" id="backdrop"><div class="modal ac-order-modal" role="dialog" aria-modal="true" aria-label="Pedidos do período">'+
  '<div class="modalhead"><h2>Pedidos - '+esc(rotuloRecorte)+'</h2><button class="btn" id="closeModal">Fechar ×</button></div>'+
  '<p class="ac-order-intro">Pedidos reais dos filtros selecionados | TOP 1000,1001,1005,1007,9000,9001 | situação A/P/L | empresa 1'+esc(introRecorte)+'. Clique em um pedido para consultar os produtos e o prazo de negociação.</p>'+
  '<div class="ac-order-summary"><div><span>Pedidos</span><strong>'+fmt(numero)+'</strong></div><div><span>Vendas sem ST</span><strong>'+esc(money(valor))+'</strong></div><div><span>Clientes distintos</span><strong>'+fmt(clientes)+'</strong></div><div><span>Itens pedido–SKU</span><strong>'+fmt(detalheACPedidos.reduce((n,o)=>n+o.itens.length,0))+'</strong></div></div>'+
  '<div class="ac-order-controls"><input id="acOrderSearch" type="search" placeholder="Pesquisar NUNOTA, cliente, SKU ou representante" aria-label="Pesquisar pedidos"><span id="acOrderFound" class="note"></span></div>'+
  '<div class="ac-order-list" id="acOrderList"></div><div class="ac-order-footer" id="acOrderFooter"></div></div></div>';
 byId('closeModal').onclick=closeModal;
 byId('backdrop').onclick=e=>{if(e.target.id==='backdrop')closeModal()};
 byId('acOrderSearch').oninput=e=>{detalheACBusca=e.target.value.toLocaleLowerCase('pt-BR').trim();detalheACPaginacao=0;detalheACAberto=null;renderDetalheACLista();};
 renderDetalheACLista();
}
/* v6.1.11 - clicar uma TOP abre Pedidos somente da TOP selecionada.
   Grupos informativos nunca usam dados ficticios, nem valores de Q43 comerciais. */
function filtrarDocsTOP(top,grupo){
 if(!Q6111_DOC_VALID||!Number.isInteger(top)||![1,3,4,5].includes(grupo))return null;
 if(skuSelected()||typeSelected())return null; // NUNOTA nao representa rateio por item
 if((managerActive()&&!V477_REP_OK)||(ufActive()&&!V477_UF_OK)||
   (carteiraActive()&&!CARTEIRA478_VALID))return null;
 if((state.rep!=='all'||clientSelected())&&(!isRealPage()||state.profile!=='director'))return null;
 return Q6111_DOC_ROWS.filter(d=>d.group===grupo&&d.op===top&&
  (state.period==='all'||Number(d.day.slice(5,7))===Number(state.period))&&
  (state.rep==='all'||d.rep===String(state.rep))&&clientMatches(d.client)&&
  (state.manager==='all'||String(V477_REP_MAP.get(d.rep)?.manager||'-1')===String(state.manager))&&
  (state.uf==='all'||String(V477_UF_MAP.get(d.client)||'(SEM UF)')===String(state.uf))&&
  (state.carteira==='all'||String(CARTEIRA478_MAP.get(d.client)||'-1')===String(state.carteira))
 ).sort((a,b)=>b.day.localeCompare(a.day)||b.id-a.id);
}
function abrirPedidosPorTOP(top,grupo){
 // Mantem detalhes de produtos e MC ja existentes somente para pedidos comerciais.
 if(grupo===1){detailPedidosAC(null,null,null,top);return;}
 const docs=filtrarDocsTOP(top,grupo);
 const host=byId('modalHost');
 if(docs===null){
  host.innerHTML='<div class="modalbg ac-order-modalbg" id="backdrop"><div class="modal" role="dialog" aria-modal="true"><div class="modalhead"><h2>Pedidos - TOP '+esc(top)+'</h2><button class="btn" id="closeModal">Fechar</button></div><p class="note">Consulta de documentos ou filtro não conciliado. Detalhamento indisponível; nenhum valor estimado foi publicado.</p></div></div>';
  byId('closeModal').onclick=closeModal;byId('backdrop').onclick=e=>{if(e.target.id==='backdrop')closeModal()};return;
 }
 const rotulos={3:'INVESTIMENTO',4:'PEQ DEFEITOS',5:'DEVOLUÇÃO'};
 const val=docs.reduce((a,d)=>a+d.vlc,0),st=docs.reduce((a,d)=>a+d.st,0);
 host.innerHTML='<div class="modalbg ac-order-modalbg" id="backdrop"><div class="modal ac-order-modal" role="dialog" aria-modal="true" aria-label="Pedidos por TOP">'+
  '<div class="modalhead"><h2>Pedidos - TOP '+esc(top)+'</h2><button class="btn" id="closeModal">Fechar ×</button></div>'+
  '<p class="ac-order-intro">'+esc(rotulos[grupo])+' | Somente informativo | Empresa 1 | Situação A/P/L. Documentos reais da TOP selecionada, sem efeito nos KPIs.</p>'+
  '<div class="ac-order-summary"><div><span>Documentos</span><strong>'+fmt(docs.length)+'</strong></div><div><span>Valor sem ST</span><strong>'+esc(money(val))+'</strong></div><div><span>ST</span><strong>'+esc(money(st))+'</strong></div><div><span>Total com ST</span><strong>'+esc(money(val+st))+'</strong></div></div>'+
  '<div class="ac-order-controls"><input id="acOrderSearch" type="search" placeholder="Pesquisar NUNOTA, cliente ou representante" aria-label="Pesquisar documentos"><span id="acOrderFound" class="note"></span></div>'+
  '<div class="ac-order-list" id="acOrderList"></div><div class="ac-order-footer" id="acOrderFooter"></div></div></div>';
 byId('closeModal').onclick=closeModal;byId('backdrop').onclick=e=>{if(e.target.id==='backdrop')closeModal()};
 let busca='',pagina=0;
 const render=()=>{
  const registros=busca?docs.filter(d=>[d.id,d.client,rotuloClientePedido(d.client),d.rep,repName(d.rep),d.status].join(' ').toLocaleLowerCase('pt-BR').includes(busca)):docs;
  const max=Math.max(0,Math.ceil(registros.length/25)-1);pagina=Math.min(pagina,max);
  const linhas=registros.slice(pagina*25,(pagina+1)*25).map(d=>
   '<tr><td>'+fmt(d.id)+'</td><td>'+esc(d.day.split('-').reverse().join('/'))+'</td><td>'+esc(rotuloClientePedido(d.client))+'</td><td>'+esc(repName(d.rep))+'</td><td>'+esc(d.status)+'</td><td class="ac-number">'+esc(money(d.vlc))+'</td><td class="ac-number">'+esc(money(d.st))+'</td><td class="ac-number">'+esc(money(d.vlc+d.st))+'</td></tr>').join('');
  byId('acOrderList').innerHTML='<table class="ac-order-table"><thead><tr><th>NUNOTA</th><th>Data</th><th>Cliente</th><th>Representante</th><th>Status</th><th>Valor sem ST</th><th>ST</th><th>Total com ST</th></tr></thead><tbody>'+(linhas||'<tr><td colspan="8" class="empty">Nenhum documento neste recorte.</td></tr>')+'</tbody></table>';
  byId('acOrderFound').textContent=fmt(registros.length)+' documentos encontrados';
  byId('acOrderFooter').innerHTML='<button id="acPrev" '+(!pagina?'disabled':'')+'>Anterior</button><span>Página '+(pagina+1)+' de '+(max+1)+'</span><button id="acNext" '+(pagina===max?'disabled':'')+'>Próxima</button>';
  byId('acPrev').onclick=()=>{pagina--;render()};byId('acNext').onclick=()=>{pagina++;render()};
 };
 byId('acOrderSearch').oninput=e=>{busca=e.target.value.toLocaleLowerCase('pt-BR').trim();pagina=0;render()};
 render();
}
function margemPorPedidoDisponivel(pedido,elegiveis){
 return elegiveis.length>0 && pedido.itens.every(i=>i.excluidoMargem ||
  (i.mc!==null && i.receitaMc!==null && Number.isFinite(i.mc) && Number.isFinite(i.receitaMc)));
}
function renderDetalheACLista(){
 const query=detalheACBusca;
 const registros=query?detalheACPedidos.filter(o=>o.buscaIndex.includes(query)):detalheACPedidos;
 const maxPage=Math.max(0,Math.ceil(registros.length/DETALHE_AC_POR_PAGINA)-1);
 detalheACPaginacao=Math.min(detalheACPaginacao,maxPage);
 const pagina=registros.slice(detalheACPaginacao*DETALHE_AC_POR_PAGINA,(detalheACPaginacao+1)*DETALHE_AC_POR_PAGINA);
 const linhas=pagina.map(o=>{
  const aberto=detalheACAberto===o.id;
  const temFalha=o.mcFalha;
  const mcPercent=o.mcPercent;
  const top='<tr><td><button type="button" class="ac-order-expand" data-open-order="'+o.id+'" aria-expanded="'+(aberto?'true':'false')+'" aria-label="'+(aberto?'Recolher':'Expandir')+' produtos do pedido '+o.id+'" title="'+(aberto?'Recolher detalhes do pedido':'Expandir detalhes do pedido')+'"><span class="ac-order-glyph" aria-hidden="true"></span></button></td><td>'+fmt(o.id)+'</td><td>'+esc(o.dia.split('-').reverse().join('/'))+'</td><td>'+esc(rotuloClientePedido(o.cliente))+'</td><td>'+esc(repName(o.rep))+'</td><td>'+fmt(o.top)+'</td><td class="ac-number">'+esc(money(o.vendas))+'</td><td class="ac-number">'+esc(mcPercent)+'</td><td class="ac-number">'+fmt(o.itens.length)+'</td><td class="ac-number"><button type="button" class="ac-mc-btn" data-mc-order="'+o.id+'" title="Abrir memória de cálculo e diagnóstico" aria-label="Memória de cálculo do pedido '+o.id+'"><span class="haiala-calculator-glyph" aria-hidden="true"></span></button></td></tr>';
  if(!aberto)return top;
  // v5.3.3.14.6.10: apenas apresentação; bruto = líquido + descontos já conciliados pela Q471.
  const linhasItens=o.itens.map(i=>{
   const bruto=Number.isFinite(i.vendas)&&Number.isFinite(i.descontos)?i.vendas+i.descontos:null;
   const percentual=bruto!==null&&bruto>0?(100*i.descontos/bruto):null;
   return '<tr><td>'+esc(i.desc)+'</td><td>'+esc(i.familia)+'</td><td>'+esc(i.tipologia)+'</td><td class="ac-number">'+(i.quantidade===null?'N/D':fmt(i.quantidade)+' PC')+'</td><td class="ac-number">'+(bruto===null?'N/D':esc(money(bruto)))+'</td><td class="ac-number">'+esc(money(i.descontos))+'</td><td class="ac-number">'+(percentual===null?'N/D':esc(percentual.toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2})+'%'))+'</td><td class="ac-number">'+esc(money(i.vendas))+'</td><td class="ac-number">'+(i.excluidoMargem?'Excluído':i.mc===null?'N/D':esc(money(i.mc)))+'</td></tr>';
  }).join('');
  const monthCheck=Q539T_MONTH_CHECKS.get(o.dia.slice(5,7));
  const note=temFalha?'Margem pendente: '+(monthCheck&&!monthCheck.ok?monthCheck.reason:'item sem margem conciliada')+'. N/D não representa zero.':
   o.itens.some(i=>i.excluidoMargem)?'O pedido contem itens sem correspondencia de margem. Conferir elegibilidade por TOP e grupo.':
   'Margem por NUNOTA + SKU, conciliada com a seleção e os cálculos do Bloco 01.';
  return top+'<tr class="ac-order-subrow"><td colspan="10"><div class="ac-order-subpanel"><div class="ac-order-subhead"><strong>Produtos do pedido '+fmt(o.id)+'</strong><span class="ac-order-prazo"><b>Prazo de negociação:</b> '+esc(prazoNegociacaoPedido(o.id))+'</span></div><div style="overflow-x:auto"><table><thead><tr><th>SKU / Descrição</th><th>Família</th><th>Tipologia</th><th>Qte PC</th><th>Valor bruto</th><th>Desconto R$</th><th>Desconto %</th><th>Venda líquida</th><th>Margem R$</th></tr></thead><tbody>'+linhasItens+'</tbody></table></div><p class="ac-order-margin-note">'+esc(note)+' Fonte: Oracle Q471, Q533 e Q539-T.</p></div></td></tr>';
 }).join('');
 byId('acOrderList').innerHTML='<table class="ac-order-table"><thead><tr><th>Detalhes</th><th>NUNOTA</th><th>Data</th><th>Cliente</th><th>Representante da venda</th><th>TOP</th><th>Vendas sem ST</th><th>MC %</th><th>SKUs</th><th>Memória</th></tr></thead><tbody>'+(linhas||'<tr><td colspan="10" class="empty">Nenhum pedido no recorte selecionado.</td></tr>')+'</tbody></table>';
 byId('acOrderFound').textContent=fmt(registros.length)+' pedidos encontrados';
 byId('acOrderFooter').innerHTML='<button type="button" id="acPrev" '+(detalheACPaginacao===0?'disabled':'')+'>Anterior</button><span>Página '+(detalheACPaginacao+1)+' de '+(maxPage+1)+'</span><button type="button" id="acNext" '+(detalheACPaginacao===maxPage?'disabled':'')+'>Próxima</button>';
 byId('acPrev').onclick=()=>{detalheACPaginacao--;detalheACAberto=null;renderDetalheACLista();};
 byId('acNext').onclick=()=>{detalheACPaginacao++;detalheACAberto=null;renderDetalheACLista();};
 byId('acOrderList').querySelectorAll('[data-open-order]').forEach(btn=>btn.onclick=()=>{const id=Number(btn.getAttribute('data-open-order'));detalheACAberto=detalheACAberto===id?null:id;renderDetalheACLista();});
 byId('acOrderList').querySelectorAll('[data-mc-order]').forEach(btn=>btn.onclick=()=>abrirMemoriaMC(Number(btn.dataset.mcOrder)));
}
/* v6.0.3: memória da MC usa exclusivamente os mesmos números da Q539-T. */
function abrirMemoriaMC(id,paginaSku=0){
 const ped=detalheACPedidos.find(p=>p.id===id);
 if(!ped)return;
 document.getElementById('haialaMcMemoryBackdrop')?.remove();
 const todosItens=ped.itens;
 const maxPaginas=Math.max(1,Math.ceil(todosItens.length/10));
 const pag=Math.max(0,Math.min(paginaSku,maxPaginas-1));
 const rows=todosItens.slice(pag*10,(pag+1)*10);
 const valido=todosItens.length>0&&todosItens.every(x=>x.memoria!==null);
  const rubricas=[['bruto','(+) Receita bruta'],['descontos','(-) Descontos comerciais'],['receita','(=) Receita comercial'],['custo','(-) Custo sem ICMS / substituto'],['icms','(-) ICMS projetado'],['pis','(-) PIS virtual (1,65%)'],['cofins','(-) COFINS virtual (7,60%)'],['comissao','(-) Comissão'],['reflexo','(-) Reflexo 1/12'],['frete','(-) Frete AD_VLRFRETE'],['margem','(=) MC Projetada R$']];
 const calc=(k)=>todosItens.reduce((s,i)=>s+(k==='bruto'?i.vendas+i.descontos:k==='descontos'?i.descontos:(i.memoria?.[k]||0)),0);
 const receita=calc('receita'), margem=calc('margem');
 const tabela=rubricas.map(([k,label])=>'<tr><td>'+esc(label)+'</td>'+rows.map(i=>'<td class="ac-number">'+(i.memoria?esc(money(k==='bruto'?i.vendas+i.descontos:k==='descontos'?i.descontos:i.memoria[k])):'N/D')+'</td>').join('')+'<td class="ac-number"><strong>'+(valido?esc(money(calc(k))):'N/D')+'</strong></td></tr>').join('');
 const cabeca=rows.map(i=>'<th>SKU '+esc(String(i.sku))+'</th>').join('');
 const custoRef=rows.map(i=>'<td class="ac-number">'+(i.memoria?.dataCusto?esc(i.memoria.dataCusto.split('-').reverse().join('/')):(i.memoria?.origemCusto==='04_VLRUNIT_CONTINGENCIA'?'N/A - VLRUNIT':'N/D'))+'</td>').join('');
 const rotulosCusto={'01_MES_ANTERIOR':'Mês - 1','02_HISTORICO_ANTERIOR':'Histórico','03_ATUAL_CONTINGENCIA':'Atual (cont.)','04_VLRUNIT_CONTINGENCIA':'VLRUNIT (cont.)','SEM_REFERENCIA':'Sem custo disponível'};
 const origemRef=rows.map(i=>'<td class="ac-number">'+(i.memoria?esc(rotulosCusto[i.memoria.origemCusto]||'Origem indisponível'):'N/D')+'</td>').join('');
 const qtdContingencia=todosItens.filter(i=>i.memoria&&['03_ATUAL_CONTINGENCIA','04_VLRUNIT_CONTINGENCIA'].includes(i.memoria.origemCusto)).length;
 const linhaPromo=rows.map(i=>'<td class="ac-number">'+(i.memoria?(i.memoria.itemPromocional?'Sim':'Não'):'N/D')+'</td>').join('');
 const promoTotal=todosItens.some(i=>i.memoria?.itemPromocional)?'Sim':'Não';
 const qtdRef=rows.map(i=>'<td class="ac-number">'+(i.memoria?esc(fmt(i.memoria.quantidade)):'N/D')+'</td>').join('');
 const cusUnit=rows.map(i=>'<td class="ac-number">'+(i.memoria&&i.memoria.quantidade>0?esc(money(i.memoria.custo/i.memoria.quantidade)):'N/D')+'</td>').join('');
 const aliqICMS=rows.map(i=>'<td class="ac-number">'+(i.memoria&&i.memoria.receita>0?esc((100*i.memoria.icms/i.memoria.receita).toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2})+'%'):'N/D')+'</td>').join('');
 const aliqCom=rows.map(i=>'<td class="ac-number">'+(i.memoria&&i.memoria.receita>0?esc((100*i.memoria.comissao/i.memoria.receita).toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2})+'%'):'N/D')+'</td>').join('');
 const taxa=valido&&receita!==0? (100*margem/receita).toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2})+'%':'N/D';
 const bg=document.createElement('div');bg.id='haialaMcMemoryBackdrop';bg.className='modalbg haiala-mc-memory-backdrop';
 bg.innerHTML='<div class="modal haiala-mc-memory-modal" role="dialog" aria-modal="true" aria-label="Memória de cálculo de margem"><div class="modalhead"><h2>Memória de cálculo - Pedido '+esc(String(ped.id))+'</h2><button class="btn" id="fecharMemoriaMC">Fechar ×</button></div>'+
 '<p class="note">MC Projetada | TOP '+esc(String(ped.top))+' | '+esc(ped.dia.split('-').reverse().join('/'))+' | Fonte: Q539-T / TGFCUS mensal / TGFEXC. Valores por SKU com precisão original da consulta.</p>'+
 (valido?'<div class="haiala-mc-indicator"><strong>'+esc(money(margem))+'</strong><span>'+esc(taxa)+'</span></div>':'<p class="ac-mc-warning">N/D - dados insuficientes ou não conciliados para este pedido. '+esc(rows.filter(x=>!x.memoria).map(x=>'SKU '+x.sku+': '+(Q539T_MAP.get(String(ped.id)+'|'+String(x.sku))?.semCusto>0?'sem CUSSEMICM válido':'margem sem conciliação Q471/Q539-T')).join('; '))+'. A memória não substitui valores ausentes por zero.</p>')+
 (rows.some(i=>i.memoria?.origemCusto==='04_VLRUNIT_CONTINGENCIA')?'<p class="ac-mc-warning">Atenção: VLRUNIT é preço unitário de venda utilizado como custo substituto por falta de CUSSEMICM. A MC é estimativa de contingência, não custo contábil.</p>':'')+
 (maxPaginas>1?'<div class="haiala-mc-pages"><span>SKUs '+(pag*10+1)+'–'+Math.min(todosItens.length,(pag+1)*10)+' de '+todosItens.length+' | Total do pedido completo</span><button type="button" class="btn" data-mc-page="'+(pag-1)+'" '+(pag===0?'disabled':'')+'>Anterior</button><button type="button" class="btn" data-mc-page="'+(pag+1)+'" '+(pag===maxPaginas-1?'disabled':'')+'>Próxima</button></div>':'')+
 '<div class="haiala-mc-scroll"><table class="ac-order-table"><thead><tr><th>Componente</th>'+cabeca+'<th class="ac-number">Total</th></tr></thead><tbody><tr><td>Item Promocional (NUPROMOCAO)</td>'+linhaPromo+'<td class="ac-number">'+promoTotal+'</td></tr><tr><td>Quantidade negociada</td>'+qtdRef+'<td class="ac-number">'+(valido?esc(fmt(calc('quantidade'))):'N/D')+'</td></tr><tr><td>Custo unitário aplicado</td>'+cusUnit+'<td>-</td></tr><tr><td>ICMS % sobre receita</td>'+aliqICMS+'<td>-</td></tr><tr><td>Comissão % efetiva</td>'+aliqCom+'<td>-</td></tr>'+tabela+'<tr><td>Origem do custo</td>'+origemRef+'<td>-</td></tr><tr><td>Data do custo TGFCUS</td>'+custoRef+'<td>-</td></tr></tbody></table></div>'+
 '<p class="note">Hierarquia do custo: 01 último CUSSEMICM do mês anterior; 02 último histórico anterior; 03 último CUSSEMICM disponível (contingência); 04 VLRUNIT do item no pedido (contingência). Contingência 03/04 não representa custo histórico e pode alterar a comparabilidade gerencial. Itens com contingência: '+qtdContingencia+'. PIS/COFINS são estimados e não representam tributos faturados. Os valores da memória são os mesmos empregados no indicador de MC.</p></div>';
 document.body.appendChild(bg);
 const memoryModal=bg.querySelector('.haiala-mc-memory-modal');
 memoryModal.dataset.skuCount=String(rows.length);
 memoryModal.classList.toggle('haiala-mc-many-skus', rows.length>8);
 memoryModal.style.width='min('+(380+rows.length*105)+'px, 98vw)';
 bg.querySelectorAll('[data-mc-page]').forEach(b=>b.onclick=()=>abrirMemoriaMC(id,Number(b.dataset.mcPage)));
 bg.querySelector('#fecharMemoriaMC').onclick=()=>bg.remove();
 bg.onclick=e=>{if(e.target===bg)bg.remove()};
 bg.querySelector('#fecharMemoriaMC').focus();
}
function detail(row,cols){byId('modalHost').innerHTML=`<div class="modalbg" id="backdrop"><div class="modal" role="dialog" aria-modal="true" aria-label="Detalhamento"><div class="modalhead"><h2>Detalhamento - \${esc(p().id)}</h2><button class="btn" id="closeModal">Fechar x</button></div><p class="note">Detalhe demonstrativo de registro selecionado. Não representa acesso autenticado ou pedido real.</p><div class="datagrid">\${row.map((v,i)=>`<div class="dataitem"><b>\${esc(cols[i]||'Valor')}</b>\${esc(v)}</div>`).join('')}</div></div></div>`;byId('closeModal').onclick=closeModal;byId('backdrop').onclick=e=>{if(e.target.id==='backdrop')closeModal()}}function closeModal(){byId('modalHost').innerHTML=''}
function closeNavGroups(ev){if(ev&&ev.target&&ev.target.closest&&ev.target.closest('.navgroup'))return;document.querySelectorAll('.navgroup').forEach(d=>d.removeAttribute('open'))}
function exportCSV(){if(state.profile==='rep')return;const records=[latestCols,...latestRows].map(r=>r.map(x=>'"'+String(x??'').replaceAll('"','""')+'"').join(';')).join('\r\n');let blob=new Blob(['\ufeff'+records],{type:'text/csv;charset=utf-8;'});let a=document.createElement('a');a.href=URL.createObjectURL(blob);a.download=`HAIALA_\${state.page}_DEMONSTRACAO.csv`;document.body.append(a);a.click();a.remove();setTimeout(()=>URL.revokeObjectURL(a.href),1000)}
function runTests(){let results=[];const assert=(n,c)=>results.push([n,!!c]);assert('26 páginas cadastradas',pageMap.length===26);assert('Seis módulos cadastrados',DB.modules.length===6);assert('IDs das páginas distintos',uniq(pageMap.map(p=>p.id))===26);assert('Pedido cancelado excluído',filtered().every(o=>o.status==='Válido'));assert('Vendas líquidas = bruto menos desconto',valid().every(o=>Math.abs(o.vlc-(o.gross-o.discount))<.011));assert('Todos os pedidos vinculados a clientes',DB.orders.every(o=>!!clients[o.client]));assert('Todos os pedidos vinculados a SKUs',DB.orders.every(o=>!!skus[o.sku]));assert('Todos os pedidos vinculados a representantes',DB.orders.every(o=>!!reps[o.rep]));assert('Vendas agrupadas concilia com total',Math.abs(sum(groups(p().kind,filtered()),x=>x.vlc)-base().v)<.01);let old=state.profile;state.profile='rep';assert('Representante restrito na amostra',filtered().every(o=>o.rep==='R01'));state.profile='manager';assert('Gerente restrito na amostra',filtered().every(o=>reps[o.rep].manager==='Norte'));state.profile=old;assert('Tabela selecionada tem mesma quantidade de colunas',latestRows.every(r=>r.length===latestCols.length));let passed=results.filter(x=>x[1]).length;byId('modalHost').innerHTML=`<div class="modalbg" id="backdrop"><div class="modal" role="dialog" aria-modal="true"><div class="modalhead"><h2>Autotestes do protótipo</h2><button class="btn" id="closeModal">Fechar x</button></div><h3>\${passed}/\${results.length} verificações passaram</h3><div class="audit">\${results.map(([n,ok])=>(ok?'OK ':'x ')+n).join('\n')}</div><p class="note">Testes de consistência do conjunto fictício e navegação. Não equivalem aos 235 testes comerciais especificados nem validam autenticação.</p></div></div>`;byId('closeModal').onclick=closeModal;byId('backdrop').onclick=e=>{if(e.target.id==='backdrop')closeModal()};draw()}

// HAIALA v3.0: supplementary rules simulator. No real ERP access or authentication.
const RULES_VERSION='v3.0';
const cents=x=>Math.round((Number(x)||0)*100);
const fromCents=x=>x/100;
const asISO=d=>d.toISOString().slice(0,10);
const commercial=date=>{let day=new Date(date+'T12:00:00Z').getUTCDay();return day>0&&day<6}; // DEMO only; no company holidays
const daysInMonth=(y,m)=>new Date(Date.UTC(y,m,0)).getUTCDate();
function commercialDates(y,m){let dates=[];for(let i=1;i<=daysInMonth(y,m);i++){let d=`\${y}-\${String(m).padStart(2,'0')}-\${String(i).padStart(2,'0')}`;if(commercial(d))dates.push(d)}return dates}
function allocateGoal(value,dates){if(!dates.length)return [];let total=cents(value),base=Math.floor(total/dates.length),extra=total-base*dates.length;return dates.map((date,i)=>({date,cents:base+(i<extra?1:0)}))}
function allocateDiscount(items,total){let gross=items.map(x=>Math.max(0,cents(x.gross))),sumGross=gross.reduce((a,b)=>a+b,0),totalC=cents(total);if(!sumGross)return null;let exact=gross.map(x=>x*totalC/sumGross),floors=exact.map(x=>Math.floor(x)),remaining=totalC-floors.reduce((a,b)=>a+b,0);let ranks=items.map((x,i)=>({i,remainder:exact[i]-floors[i],id:String(x.id)})).sort((a,b)=>b.remainder-a.remainder||a.id.localeCompare(b.id,'pt-BR',{numeric:true}));for(let i=0;i<remaining;i++)floors[ranks[i%ranks.length].i]++;return floors}
function abcClass(elements){let arr=elements.filter(x=>x.vlc>0).sort((a,b)=>b.vlc-a.vlc||String(a.key).localeCompare(String(b.key),'pt-BR',{numeric:true})),total=sum(arr,x=>x.vlc),running=0;return arr.map(x=>{running+=x.vlc;let share=running/total;return {...x,share,abc:share<=.8+1e-10?'A':share<=.95+1e-10?'B':'C'}})}
function commerciallyVisibleCustomers(){return DB.clients.filter(c=>state.uf==='all'||c.uf===state.uf).filter(c=>{if(state.profile==='manager')return reps[c.rep]?.manager==='Norte';if(state.profile==='rep')return c.rep==='R01';return true}).filter(c=>state.rep==='all'||c.rep===state.rep)}
const formatDate=d=>d.split('-').reverse().join('/');
function monthVLC(a,m){return sum(a.filter(o=>pnum(o.date)===m),o=>o.vlc)}
function computedRules(){let b=base(),a=b.a,pg=p(),clientsAllowed=commerciallyVisibleCustomers(),eligible=clientsAllowed.filter(c=>c.eligible),eligibleIDs=new Set(eligible.map(c=>c.id)),served=new Set(a.filter(o=>eligibleIDs.has(o.client)).map(o=>o.client)),m=state.period==='all'?10:Number(state.period),dates=commercialDates(2026,m),goal=DB.targets[m]||0,allocation=allocateGoal(goal,dates),spent=dates.filter(d=>d<='2026-10-30').length;let monthRows=a.filter(o=>pnum(o.date)===m),monthValue=sum(monthRows,o=>o.vlc),goalElapsed=fromCents(sum(allocation.filter(x=>x.date<='2026-10-30'),x=>x.cents));let projected=spent?monthValue/spent*dates.length:null;let g=groups(pg.kind,a);let typology=group(a,o=>skus[o.sku].type),abc=abcClass(typology);let totalPositive=sum(typology.filter(x=>x.vlc>0),x=>x.vlc),nonPositive=sum(typology.filter(x=>x.vlc<=0),x=>x.vlc);let uniqueCustomers=new Set(a.map(o=>o.client)),validOrders=uniq(a.map(o=>o.id));let past=DB.orders.some(o=>o.date<'2026-01-01');let lastMap=new Map();a.forEach(o=>{let old=lastMap.get(o.client)||'';if(o.date>old)lastMap.set(o.client,o.date)});let inactive=eligible.filter(c=>lastMap.has(c.id)&&((Date.parse('2026-10-30T00:00:00Z')-Date.parse(lastMap.get(c.id)+'T00:00:00Z'))/86400000)>=90).length;let territory=uniq(clientsAllowed.filter(c=>c.city).map(c=>c.uf+'|'+c.city));let servedCities=uniq(a.filter(o=>clients[o.client]?.city).map(o=>clients[o.client].uf+'|'+clients[o.client].city));
let cards=[['Vendas conciliadas',money(b.v),'Pedidos válidos, desconto já aplicado'],['Pedidos distintos',fmt(validOrders),'Não somar subtotais sobrepostos'],['Clientes elegíveis',fmt(eligible.length),'Carteira atual dentro do perfil'],['Cobertura elegível',eligible.length?pct(served.size*100/eligible.length):'Indisponível','Atendidos / elegíveis']];
let alerts=[],title='Controle financeiro e comercial';
if(pg.module==='AC'||['goals','repgoals'].includes(pg.kind)){
 title='Metas e calendário comercial - simulação';cards=[['Meta mensal de demonstração',money(goal),'Somente referência global, não homologada'],['Meta acumulada demonstrativa',money(goalElapsed),'Rateio em centavos, seg - sex'],['Projeção mensal',projected===null?'Indisponível':money(projected),'Vendas do mês / dias decorridos x dias do mês'],['Dias comerciais',`\${spent} / \${dates.length}`,'Sem cadastro de feriados']];alerts.push('Calendário apenas seg - sex: sem feriados reais. Metas por equipe/tipologia e conciliação de abrangências não estão disponíveis nesta amostra.');
 if(pg.kind==='year')alerts.push('DER-06 anual: indisponível - a amostra não possui os dois meses homólogos completos mínimos em anos anteriores.');}
if(pg.module==='CL'){title='Carteira atual, elegibilidade e recuperação';cards=[['Clientes da carteira',fmt(clientsAllowed.length),'Inclui não elegíveis e sem vendas'],['Elegíveis',fmt(eligible.length),'Sinalização sintética no cadastro'],['Atendidos no recorte',fmt(served.size),'Distintos no período'],['Sem compra >=90 dias',fmt(inactive),'Exemplo sobre as datas da amostra']];alerts.push('Grupo B e histórico de clientes não podem ser homologados com a amostra limitada de 2026.');}
if(pg.module==='PD'){title='Portfólio, mix e ABC';let soldSku=uniq(a.map(o=>o.sku));cards=[['SKUs cadastrados',fmt(DB.products.length),'Inclui SKUs sem venda e inativos'],['SKUs vendidos',fmt(soldSku),'Distintos no recorte'],['Cobertura do mix',pct(DB.products.length?soldSku/DB.products.length*100:0),'SKUs vendidos / total comercial'],['ABC positivos',fmt(abc.length),'Não positivos segregados']];}
if(pg.module==='RP'){title='Autoria de venda x carteira atual';cards=[['Vendas por representante do pedido',money(b.v),'Representante registrado no pedido'],['Pedidos distintos',fmt(b.orders),'Perspectiva vendas'],['Clientes da carteira',fmt(clientsAllowed.length),'Perspectiva carteira atual'],['Cobertura da carteira',eligible.length?pct(100*served.size/eligible.length):'Indisponível','Atendimento na amostra']];}
if(pg.module==='GM'){title='Cobertura geográfica cadastral';cards=[['Municípios cadastrados',fmt(territory),'Denominador: todos os clientes cadastrados visíveis'],['Municípios com vendas',fmt(servedCities),'UF e município em conjunto'],['Cobertura municipal',territory?pct(100*servedCities/territory):'Indisponível','Municípios com vendas / cadastrados'],['Vendas por território',money(b.v),'Endereço principal do cliente na amostra']];}
if(pg.kind==='intelligence')alerts.push('Funil completo desabilitado: oportunidades e propostas não existem na amostra. Disponível apenas análise de pedidos.');
if(!past&&['trend','year','productIntel','behavior'].includes(pg.kind))alerts.push('Comparativo homólogo e projeção sazonal indisponíveis: histórico de anos anteriores não fornecido.');
let abcRows=abc.slice(0,8).map(x=>`<tr><td>\${esc(x.key)}</td><td>\${money(x.vlc)}</td><td>\${pct(x.share*100)}</td><td><strong>\${x.abc}</strong></td></tr>`).join('');
let extra=pg.module==='PD'||pg.kind==='intelligence'?`<h4 class="rulesection">ABC por tipologia - valores positivos</h4><table class="rulestable"><thead><tr><th>Tipologia</th><th>Vendas</th><th>Acumulado</th><th>Classe</th></tr></thead><tbody>\${abcRows}</tbody></table><p class="rulefoot">Vendas com valor não positivo segregado: \${money(nonPositive)}. Positivos no ABC: \${money(totalPositive)}. Corte aplicado após inclusão do item.</p>`:'';
if(pg.module==='AC')extra+=`<p class="rulefoot">Distribuição exata da meta: \${allocation.length} datas comerciais - soma das parcelas \${money(fromCents(sum(allocation,x=>x.cents)))} - saldo não distribuído \${money(goal-fromCents(sum(allocation,x=>x.cents)))}.</p>`;
if(pg.kind==='query')extra+=`<p class="rulefoot">A consulta dinâmica preserva contagem distinta de pedidos; valores de tipologias são parcelas das vendas e não novos pedidos. Exportação continua simulação de interface.</p>`;
return `<h3 class="paneltitle">\${title}</h3><div class="rulesgrid">\${cards.map(([name,value,sub])=>`<div class="ruleitem"><span>\${esc(name)}</span><b>\${esc(value)}</b><span>\${esc(sub)}</span></div>`).join('')}</div>\${alerts.map(x=>`<div class="rulealert">\${esc(x)}</div>`).join('')}\${extra}<div class="rulealert ruleok">Regras calculadas com dados sintéticos. Cenários e autorizações reais exigem integração e homologação específicas.</div>`;
}

/* v4.8.0 - CL-01 Oracle only. No synthetic CL-01 metrics or charts.
   The customer's current portfolio and UF define the registered universe.
   Sales-representative-of-order affects service in period, not registered universe.
   The live backend is still read-only and does not authorize users. */
function cl01Context(){
 const clienteFiltro=clientIds();
 const registered=CAD479_ROWS.filter(c=>
   (state.carteira==='all'||c.owner===String(state.carteira))&&
   (state.uf==='all'||c.uf===state.uf)&&
   (state.manager==='all'||(V477_REP_MAP.get(c.owner)?.manager||'-1')===state.manager)&&
   (!clienteFiltro.length||clienteFiltro.includes(c.client)));
 const bought=new Set();
 if(Q46_VALID)Q46_ROWS.forEach(r=>{
   if(state.period!=='all' && Number(r[0].slice(5,7))!==Number(state.period))return;
   if(state.rep!=='all' && String(r[7])!==String(state.rep))return;
   bought.add(String(r[8]));
 });
 const eligible=registered.filter(c=>c.commercial&&c.active&&!c.blocked);
 const eligibleBought=eligible.filter(c=>bought.has(c.client));
 const allBought=registered.filter(c=>bought.has(c.client));
 const inactive=eligible.filter(c=>c.inactive90);
 const noHistory=eligible.filter(c=>c.never);
 const withoutPeriod=eligible.filter(c=>!bought.has(c.client));
 return {registered,eligible,eligibleBought,allBought,inactive,noHistory,withoutPeriod,bought,
   coverage:eligible.length?100*eligibleBought.length/eligible.length:null};
}
function cl01BarChart(items,title,empty){
 const max=Math.max(1,...items.map(x=>x.n));
 const content=items.length?items.map(x=>'<div class="minirow" style="gap:12px;align-items:center;margin:10px 0"><span class="minilabel" style="width:190px;flex-shrink:0">'+esc(x.name)+'</span><div style="background:#e9f0f5;border-radius:4px;flex:1;min-width:80px;height:13px;overflow:hidden"><div style="background:#397f9e;width:'+Math.max(0,100*x.n/max)+'%;height:100%"></div></div><strong style="min-width:48px;text-align:right">'+fmt(x.n)+'</strong></div>').join(''):'<p class="note">'+esc(empty)+'</p>';
 return '<h3 class="paneltitle">'+esc(title)+'</h3>'+content;
}
function renderCL01Real(){
 const active=state.page==='CL-01';
 const panel=document.getElementById('haialaCarteiraCompletaPanel');
 if(panel && active)panel.style.display='none';
 const heads=['cl01Sec01','cl01Sec02','cl01Sec03','cl01Sec04'];
 const defaultH=['01 - Visão executiva','02 - Inteligência comercial','03 - Regras e cenários funcionais','04 - Análise detalhada'];
 heads.forEach((id,i)=>{const el=document.getElementById(id);if(!el)return;const h=el.querySelector('h2');if(h)h.textContent=active?['01 - Indicadores da carteira (Oracle)','02 - Distribuição da carteira','03 - Cobertura e recuperação','04 - Clientes da carteira (Oracle)'][i]:defaultH[i];const note=el.querySelector('small');if(id==='cl01Sec03'&&note)note.textContent=active?'Fonte: Oracle - carteira comercial completa':'Calculados a partir da amostra sintética';});
 if(!active)return;
 const k=document.getElementById('kpis'),a=document.getElementById('primaryPanel'),b=document.getElementById('secondaryPanel'),rules=document.getElementById('rulesPanel'),table=document.getElementById('tablePanel');
 const help=document.getElementById('tableHelp'),hint=document.getElementById('kpiHint'),chips=document.getElementById('activeFilters');
 const exportBtn=document.getElementById('exportBtn'),testsBtn=document.getElementById('testBtn');
 exportBtn.disabled=true; exportBtn.title='Exportação real da carteira exige autorização e implementação específica';
 testsBtn.disabled=true; testsBtn.title='Autotestes sintéticos não homologam a carteira Oracle';
 if(!CAD479_VALID){
   k.innerHTML='<div class="notice" style="grid-column:1/-1">Consulta cadastral Oracle indisponível ou não conciliada. Sem indicadores demonstrativos nesta página.</div>';
   a.innerHTML='<h3 class="paneltitle">Oracle indisponível</h3>';b.innerHTML='<p class="note">Sem dados homologáveis</p>';
   rules.innerHTML='<div class="notice">Cobertura e recuperação indisponíveis até conciliação cadastral.</div>';
   table.innerHTML='<p class="note">Não há dados cadastrais confiáveis para exibir.</p>';
   if(help)help.textContent='Fonte: Oracle | situação: indisponível';if(hint)hint.textContent='';if(chips)chips.innerHTML='';return;
 }
 const x=cl01Context();
 const canSales=Q46_VALID;
 const pctText=x.coverage===null?'N/D':pct(x.coverage);
 const periodLabel=state.period==='all'?'2026 até a consulta':('2026-'+String(state.period).padStart(2,'0'));
 const keys=[
  ['Clientes cadastrados',fmt(x.registered.length),'TGFPAR | carteira atual'],
  ['Clientes elegíveis',fmt(x.eligible.length),'Critério comercial preliminar'],
  ['Clientes elegíveis com compras',canSales?fmt(x.eligibleBought.length):'N/D','Com pedido válido no período'],
  ['Cobertura elegível',canSales?pctText:'N/D','Clientes elegíveis com compras / elegíveis'],
  ['Inativos (90+ dias)',fmt(x.inactive.length),'Última compra válida histórica']
 ];
 k.classList.add('five-kpis');
 k.innerHTML=keys.map(row=>'<div class="kpi"><span>'+esc(row[0])+'</span><strong>'+esc(row[1])+'</strong><small>'+esc(row[2])+'</small></div>').join('');
 if(hint)hint.textContent='Fonte: Oracle | '+fmt(x.registered.length)+' clientes cadastrados na seleção';
 const byUf=new Map(),byOwner=new Map();
 x.registered.forEach(c=>{byUf.set(c.uf,(byUf.get(c.uf)||0)+1);byOwner.set(c.owner,(byOwner.get(c.owner)||0)+1)});
 const ufRows=[...byUf].map(([name,n])=>({name,n})).sort((p,q)=>q.n-p.n||p.name.localeCompare(q.name,'pt-BR'));
 const ownerRows=[...byOwner].map(([code,n])=>({name:carteiraName(code),n})).sort((p,q)=>q.n-p.n||p.name.localeCompare(q.name,'pt-BR'));
 a.innerHTML=cl01BarChart(ufRows,'Clientes cadastrados por UF','Nenhuma UF identificada')+'<p class="note">Base: todos os clientes cadastrados no recorte, inclusive sem compras.</p>';
 b.innerHTML=cl01BarChart(ownerRows.slice(0,12),'Clientes por responsável atual','Nenhuma carteira identificada')+'<p class="note">Responsável atual = TGFPAR.CODVEND; não confundir com autoria do pedido.</p>';
 const kpi=(name,value,desc)=>'<div class="ruleitem"><span>'+esc(name)+'</span><b>'+esc(value)+'</b><span>'+esc(desc)+'</span></div>';
 rules.innerHTML='<h3 class="paneltitle">Cobertura e oportunidades - Oracle</h3><div class="rulesgrid">'+
  kpi('Clientes elegíveis',fmt(x.eligible.length),'Denominador da cobertura')+
  kpi('Clientes elegíveis com compras',canSales?fmt(x.eligibleBought.length):'N/D','Clientes elegíveis com pedido no período')+
  kpi('Sem compras no período',canSales?fmt(x.withoutPeriod.length):'N/D','Elegíveis sem pedidos em '+periodLabel)+
  kpi('Cobertura comercial',canSales?pctText:'N/D','Atendidos elegíveis / elegíveis')+
  kpi('Inativos há 90+ dias',fmt(x.inactive.length),'Elegíveis com compra histórica antiga')+
  kpi('Sem histórico de compras',fmt(x.noHistory.length),'Elegíveis sem compra válida na empresa 1')+
  kpi('Não elegíveis',fmt(x.registered.length-x.eligible.length),'Cadastro ativo/bloqueio: critério provisório')+
  kpi('Clientes com compras no período',canSales?fmt(x.allBought.length):'N/D','Inclui clientes não elegíveis')+'</div>'+
  '<p class="note">Categorias não são necessariamente excludentes: um comprador de 2026 pode estar inativo há mais de 90 dias. Última compra: TOP 1000,1001,1005,1007,9000,9001, situação A/P/L, empresa 1. Histórico e elegibilidade sujeitos à homologação comercial.</p>'+
  (state.rep!=='all'?'<div class="rulealert">Representante da venda restringe compradores, não remove clientes da carteira cadastrada.</div>':'')+
  '<div class="rulealert ruleok">Fonte: TGFPAR, TGFCAB e cadastros geográficos Oracle. Nenhuma métrica sintética na CL-01. Permissões de usuário ainda não homologadas.</div>';
 const sorted=x.registered.slice().sort((u,v)=>u.client.localeCompare(v.client,'pt-BR',{numeric:true}));
 const cols=['Código','Cliente','UF','Responsável atual','Elegível','Com compras no período','Situação histórica','Última compra'];
 const rows=sorted.map(c=>{
  const el=c.commercial&&c.active&&!c.blocked;
  const status=c.never?'Sem histórico':c.inactive90?'Inativo (90+ dias)':'Compra recente';
  return [c.client,c.name,c.uf,carteiraName(c.owner),el?'Sim':'Não',canSales?(x.bought.has(c.client)?'Sim':'Não'):'N/D',status,c.last||'Nunca'];
 });
 latestCols=cols;latestRows=rows;
 table.innerHTML='<table><thead><tr>'+cols.map(col=>'<th>'+esc(col)+'</th>').join('')+'</tr></thead><tbody>'+rows.map((row,i)=>'<tr data-row="'+i+'">'+row.map(v=>'<td>'+esc(v)+'</td>').join('')+'</tr>').join('')+'</tbody></table>';
 table.querySelectorAll('[data-row]').forEach(tr=>tr.onclick=()=>detail(rows[Number(tr.dataset.row)],cols));
 help.textContent=fmt(rows.length)+' clientes reais exibidos | Empresa 1 | '+periodLabel+' | Sem limitação de 150 linhas | Exportação indisponível até controle de acesso.';
 chips.innerHTML='<span class="chip">Fonte: Oracle</span>'+(state.carteira!=='all'?'<span class="chip">Carteira atual: '+esc(carteiraName(state.carteira))+'</span>':'')+(state.uf!=='all'?'<span class="chip">UF: '+esc(state.uf)+'</span>':'')+(state.manager!=='all'?'<span class="chip">Gerência: '+esc(labelManager(state.manager))+'</span>':'');
}


/* HAIALA v4.8.2 - Cliente, Comportamento e Recuperação usando dados Oracle existentes.
   Q46 está agregado por dia/cliente/representante/TOP: permite total de pedidos e
   dias com compras, mas não intervalo entre pedidos individuais no mesmo dia.
   Q471 é detalhado por item e NUNOTA. Não duplica contagem de pedidos. */

/* v4.8.3: quantidades comerciais de itens por mes, tipologia e unidade. */
const Q483_EL=document.getElementById('haialaQ483Result');
const Q483_OK=!!Q483_EL && Q483_EL.dataset.testOk==='true';
const Q483_ROWS=Q483_EL?Array.from(Q483_EL.querySelectorAll('.haiala-q483-row')).map(el=>({
 month:String(el.dataset.mes||''),client:String(el.dataset.client||''),rep:String(el.dataset.rep||''),
 typology:String(el.dataset.tipologia||'(SEM TIPOLOGIA)'),unit:String(el.dataset.unidade||'(SEM UNIDADE)'),
 qty:q43num(el.dataset.quantidade),value:q43num(el.dataset.valor),orders:q43num(el.dataset.pedidos)
})):[];
const Q483_VALID=Q483_OK && Q483_ROWS.every(r=>/^2026-\d{2}$/.test(r.month)&&
 Number.isFinite(r.qty)&&Number.isFinite(r.value)&&Number.isFinite(r.orders)&&r.client.length>0&&r.typology.length>0&&r.unit.length>0);
function v483MonthlyTypology(cards){
 const ids=new Set(cards.map(c=>String(c.client)));
 const rows=Q483_ROWS.filter(r=>ids.has(r.client)&&(state.rep==='all'||r.rep===String(state.rep))&&
    (state.period==='all'||Number(r.month.slice(5))===Number(state.period)));
 const months=state.period==='all'?Array.from({length:12},(_,i)=>'2026-'+String(i+1).padStart(2,'0')):
  ['2026-'+String(state.period).padStart(2,'0')];
 const totals=new Map(),cells=new Map();
 for(const r of rows){
  const key=JSON.stringify([r.typology,r.unit]);
  const total=totals.get(key)||{qty:0,value:0,type:r.typology,unit:r.unit};
  total.qty+=r.qty;total.value+=r.value;totals.set(key,total);
  const mkey=JSON.stringify([key,r.month]);
  const cell=cells.get(mkey)||{qty:0,value:0};cell.qty+=r.qty;cell.value+=r.value;cells.set(mkey,cell);
 }
 const keys=[...totals.keys()].sort((a,b)=>totals.get(b).value-totals.get(a).value||
   rotuloTipologia(totals.get(a).type).localeCompare(rotuloTipologia(totals.get(b).type),'pt-BR'));
 const number=v=>Number(v).toLocaleString('pt-BR',{maximumFractionDigits:3});
 const price=v=>money(v);
 const cols=['Tipologia / Unidade',...months.flatMap(m=>[m.slice(5)+' Qtd',m.slice(5)+' R$']),'Total Qtd','Total R$'];
 const data=keys.map(key=>{
  const v=totals.get(key);
  return [rotuloTipologia(v.type)+' ('+v.unit+')',...months.flatMap(m=>{
    const cell=cells.get(JSON.stringify([key,m]))||{qty:0,value:0};return [number(cell.qty),price(cell.value)];
  }),number(v.qty),price(v.value)];
 });
 // Totais monetários podem ser somados; quantidades entre unidades distintas não.
 const monthValue=months.map(m=>rows.filter(r=>r.month===m).reduce((t,r)=>t+r.value,0));
 const totalValue=monthValue.reduce((a,b)=>a+b,0);
 data.push(['TOTAL R$ (todas as tipologias)',...months.flatMap((m,i)=>['-',price(monthValue[i])]),'-',price(totalValue)]);
 return {cols,data,rows,keys,months,totalValue};
}
function cl02BehaviorHTML(orders,selectedClient,periodLabel){
 const months=Array.from({length:12},(_,i)=>'2026-'+String(i+1).padStart(2,'0'));
 const monthly=new Map(months.map(m=>[m,{value:0,orders:0,days:new Set()}]));
 const byDay=new Map();
 for(const r of orders){
  const date=String(r[0]),month=date.slice(0,7),v=monthly.get(month);
  if(!v)continue;
  v.value+=Number(r[3])||0;v.orders+=Number(r[2])||0;v.days.add(date);
  const day=byDay.get(date)||{value:0,orders:0};day.value+=Number(r[3])||0;day.orders+=Number(r[2])||0;byDay.set(date,day);
 }
 const valid=months.filter(m=>monthly.get(m).orders>0);
 const total=months.reduce((n,m)=>n+monthly.get(m).value,0);
 const peak=valid.length?valid.reduce((p,m)=>monthly.get(m).value>monthly.get(p).value?m:p):null;
 const last=[...byDay.keys()].sort().pop()||null;
 const max=Math.max(0,...months.map(m=>monthly.get(m).value));
 const activeMonths=state.period==='all'?months:months.filter(m=>Number(m.slice(5))===Number(state.period));
 const nBought=activeMonths.filter(m=>monthly.get(m).orders>0).length;
 const moneyTiny=v=>Number(v).toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2});
 const title='<h3 class="paneltitle">04 - Comportamento de compra (Oracle)</h3>'+
  '<p class="note">Cliente '+esc(selectedClient)+' | Empresa 1 | '+esc(periodLabel)+' | Data de negociação (DTNEG) | Vendas dos pedidos válidos, sem ST.</p>';
 const cards='<div class="cl02-behavior-cards">'+[
  ['Meses com compras',String(nBought)],['Meses sem compras',String(activeMonths.length-nBought)],
  ['Última compra no período',last?last.split('-').reverse().join('/'):'Sem compra'],
  ['Maior mês de compras',peak?peak.slice(5)+'/'+peak.slice(0,4):'Sem compra'],
  ['Média por mês com compras',valid.length?money(total/valid.length):money(0)],
  ['Pedidos no período',String(activeMonths.reduce((sum,m)=>sum+monthly.get(m).orders,0))]
 ].map(([label,v])=>'<div class="cl02-behavior-kpi"><span>'+esc(label)+'</span><strong>'+esc(v)+'</strong></div>').join('')+'</div>';
 const timeline='<h4>Meses com compras e valor mensal</h4><div class="cl02-month-track">'+months.map(m=>{
  const x=monthly.get(m),on=x.orders>0,active=activeMonths.includes(m);
  return '<div class="cl02-month-cell '+(on?'has-purchase':'')+(active?'':' outside-period')+'"><span>'+esc(m.slice(5))+'</span><strong>'+esc('R$ '+moneyTiny(x.value))+'</strong><small>'+x.orders+' pedido(s)</small></div>';
 }).join('')+'</div>';
 const chart='<h4>Vendas mensais (R$)</h4><div class="cl02-month-bars">'+months.map(m=>{
  const x=monthly.get(m);const w=max>0?Math.max(0,100*x.value/max):0;
  return '<div class="cl02-month-bar"><span>'+esc(m.slice(5))+'</span><div class="cl02-track"><div style="width:'+w.toFixed(2)+'%"></div></div><strong>R$ '+esc(moneyTiny(x.value))+'</strong></div>';
 }).join('')+'</div>';
 const dates='<details class="cl02-dates"><summary>Ver datas com compras (dias de negociação)</summary><table><thead><tr><th>Data</th><th>Pedidos</th><th>Vendas</th></tr></thead><tbody>'+
  ([...byDay].sort((a,b)=>a[0].localeCompare(b[0])).map(([d,x])=>'<tr><td>'+esc(d.split('-').reverse().join('/'))+'</td><td>'+x.orders+'</td><td>'+esc(money(x.value))+'</td></tr>').join('')||'<tr><td colspan="3">Nenhuma compra no recorte</td></tr>')+'</tbody></table></details>';
 return title+cards+timeline+chart+dates+'<p class="note">Meses sem compras = zero. Valores mensais calculados pelo cabeçalho de pedidos (TGFCAB), não somados novamente por item.</p>';
}

function customerPageV482(){return ['CL-02','CL-03','CL-04'].includes(state.page)}
function customerScopeV482(){
 const clientFilter=clientIds();
 return CAD479_ROWS.filter(c=>
  (state.carteira==='all'||c.owner===String(state.carteira)) &&
  (state.uf==='all'||c.uf===state.uf) &&
  (state.manager==='all'||(V477_REP_MAP.get(c.owner)?.manager||'-1')===state.manager) &&
  (!clientFilter.length||clientFilter.includes(c.client)));
}
function customerOrdersV482(codes){
 const ids=new Set(codes.map(x=>x.client));
 if(!Q46_VALID)return [];
 return Q46_ROWS.filter(r=>ids.has(String(r[8]))&&
  (state.period==='all'||Number(r[0].slice(5,7))===Number(state.period)) &&
  (state.rep==='all'||String(r[7])===String(state.rep)));
}
function customerItemsV482(codes){
 if(!Q471_VALID)return [];
 const ids=new Set(codes.map(x=>x.client));
 return Q471_ROWS.filter(r=>ids.has(String(r.client))&&
  (state.period==='all'||Number(r.dia.slice(5,7))===Number(state.period))&&
  (state.rep==='all'||String(r.rep)===String(state.rep)));
}
function customerCardV482(label,value,description){
 return '<div class="kpi"><span>'+esc(label)+'</span><strong>'+esc(value)+'</strong><small>'+esc(description)+'</small></div>';
}
function customerV482Table(columns,rows){
 latestCols=columns;latestRows=rows;
 const host=byId('tablePanel');
 host.innerHTML='<table><thead><tr>'+columns.map(c=>'<th>'+esc(c)+'</th>').join('')+'</tr></thead><tbody>'+
 (rows.length?rows.map((r,i)=>'<tr data-row="'+i+'">'+r.map(v=>'<td>'+esc(v)+'</td>').join('')+'</tr>').join(''):'<tr><td colspan="'+columns.length+'">Nenhum cliente no recorte.</td></tr>')+
 '</tbody></table>';
 host.querySelectorAll('tr[data-row]').forEach(tr=>tr.onclick=()=>detail(rows[Number(tr.dataset.row)],columns));
}
function renderCustomersV482(){
 if(!customerPageV482())return;
 byId('cl01DetailContainer').classList.remove('cl02-wide-table');
 const k=byId('kpis'),a=byId('primaryPanel'),b=byId('secondaryPanel'),rules=byId('rulesPanel'),help=byId('tableHelp'),hint=byId('kpiHint'),chips=byId('activeFilters');
 // The generic panel is not a substitute for the new real sections.
 const oldBlock=byId('haialaCarteiraCompletaPanel');if(oldBlock)oldBlock.style.display='none';
 byId('exportBtn').disabled=true;byId('testBtn').disabled=true;
 byId('exportBtn').title='Exportação desativada até implementar autorização real';
 const sections=['cl01Sec01','cl01Sec02','cl01Sec03','cl01Sec04'];
 const names=state.page==='CL-03'?['01 - Frequência de compras (Oracle)','02 - Recorrência e evolução mensal (Oracle)','03 - Interpretação da frequência e inatividade (Oracle)','04 - Clientes e frequência (Oracle)']:['01 - Indicadores de clientes (Oracle)','02 - Histórico e distribuição (Oracle)','03 - Comportamento e recuperação (Oracle)','04 - Clientes e compras (Oracle)'];
 sections.forEach((id,i)=>{const el=byId(id);if(!el)return;const h=el.querySelector('h2');if(h)h.textContent=state.page==='CL-02'&&i===3?'03 - Quantidade e valor por tipologia e mês (Oracle)':names[i];const sm=el.querySelector('small');if(sm)sm.textContent='Fonte: Oracle | Empresa 1 | 2026';});
 if(!CAD479_VALID||!Q46_VALID){
  k.innerHTML='<div class="notice" style="grid-column:1/-1">Dados cadastrais ou pedidos Oracle não conciliados. Não serão mostrados indicadores demonstrativos.</div>';
  a.innerHTML='<p class="note">Dados Oracle indisponíveis.</p>';b.innerHTML='';rules.innerHTML='';customerV482Table(['Situação'],[]);return;
 }
 const cards=customerScopeV482(),eligible=cards.filter(c=>c.commercial&&c.active&&!c.blocked);
 const orders=customerOrdersV482(cards),items=customerItemsV482(cards);
 const aggregated=new Map(),clientById=new Map(cards.map(c=>[c.client,c]));
 for(const r of orders){
  const id=String(r[8]),v=aggregated.get(id)||{orders:0,sales:0,days:new Set(),lastInPeriod:''};
  v.orders+=r[2];v.sales+=r[3];v.days.add(r[0]);if(r[0]>v.lastInPeriod)v.lastInPeriod=r[0];aggregated.set(id,v);
 }
 const eligibleWith=eligible.filter(c=>aggregated.has(c.client));
 const without=eligible.filter(c=>!aggregated.has(c.client));
 const inactive=eligible.filter(c=>c.inactive90),never=eligible.filter(c=>c.never);
 const numOrders=orders.reduce((t,r)=>t+r[2],0),sales=orders.reduce((t,r)=>t+r[3],0);
 const selected=clientIds().length===1;
 const periodLabel=state.period==='all'?'2026 acumulado até a consulta':String(state.period).padStart(2,'0')+'/2026';
 const monthLabel=periodLabel;
 const info=(!Q471_VALID?'Detalhamento de produtos indisponível: consulta de itens não conciliada. ':'')+
  (state.rep!=='all'?'O representante da venda filtra compras, não retira clientes da carteira cadastrada. ':'')+
  (state.type!=='all'||state.sku!=='all'?'Tipologia e SKU não estão aplicados a estas análises cadastrais. ':'')+
  'Elegibilidade atual preliminar: CLIENTE=S, ATIVO=S, BLOQUEAR diferente de S. Última compra e inatividade calculadas no histórico até a data da execução; compras do período são 2026 filtrado.';
 const rowsVendas=[...aggregated].sort((x,y)=>y[1].sales-x[1].sales).slice(0,12).map(([id,v])=>({name:id+' - '+(clientById.get(id)?.name||''),n:v.sales}));
 if(state.page==='CL-02'){
   const sec03=byId('cl01Sec03');if(sec03)sec03.style.display='none';
   if(rules){rules.innerHTML='';rules.style.display='none';}
   const c=selected?cards[0]:null;
   if(!c){
    k.innerHTML=customerCardV482('Clientes no recorte',fmt(cards.length),'Selecione um cliente para abrir a ficha 360º')+
      customerCardV482('Clientes com compras no período',fmt(aggregated.size),'Distintos por CODPARC')+
      customerCardV482('Pedidos',fmt(numOrders),'Documentos comerciais')+
      customerCardV482('Vendas',money(sales),'Sem ST');
    a.innerHTML=cl01BarChart(rowsVendas.map(x=>({...x,n:Math.round(x.n)})),'Principais clientes por Vendas','Sem clientes com compras');
    b.innerHTML='<h3 class="paneltitle">Ficha 360º</h3><p class="note">Selecione um cliente no filtro Cliente para ver cadastro, compras, frequência observada por dia e mix de produtos.</p>';
    rules.innerHTML='<h3 class="paneltitle">Regras e fonte</h3><p class="note">'+esc(info)+'</p>';
    customerV482Table(['Código','Cliente','Responsável atual','UF','Elegível','Compras no período'],cards.map(c=>[c.client,c.name,carteiraName(c.owner),c.uf,c.commercial&&c.active&&!c.blocked?'Sim':'Não',aggregated.has(c.client)?'Sim':'Não']));
   }else{
    const v=aggregated.get(c.client)||{orders:0,sales:0,days:new Set(),lastInPeriod:''};
    const list=items.filter(x=>String(x.client)===c.client),skuMap=new Map();
    for(const x of list){const a=skuMap.get(x.sku)||{sales:0,orders:new Set(),discount:0};a.sales+=x.sales;a.discount+=x.discount;a.orders.add(x.id);skuMap.set(x.sku,a)}
    k.innerHTML=customerCardV482('Vendas',money(v.sales),'Compras do cliente no período')+
      customerCardV482('Pedidos',fmt(v.orders),'Pedidos comerciais')+
      customerCardV482('Dias com compras',fmt(v.days.size),'Datas distintas, não pedidos')+
      customerCardV482('SKUs distintos',Q471_VALID?fmt(skuMap.size):'N/D','Itens diferentes');
    a.innerHTML='<h3 class="paneltitle">Cadastro e responsável atual</h3><p><strong>'+esc(c.client+' - '+c.name)+'</strong></p><p class="note">Responsável: '+esc(carteiraName(c.owner))+' | UF: '+esc(c.uf)+' | Elegível: '+(c.commercial&&c.active&&!c.blocked?'Sim':'Não')+'</p><p class="note">Última compra histórica: '+esc(c.last||'Sem histórico')+'</p>';
    const months=new Map();for(const r of orders){let month=r[0].slice(0,7),o=months.get(month)||{sales:0,orders:0};o.sales+=r[3];o.orders+=r[2];months.set(month,o)}
    b.innerHTML=cl01BarChart([...months].map(([name,x])=>({name,n:Math.round(x.sales)})),'Vendas por mês','Sem compras no período');
    // CL-02: sem bloco de comportamento; a analise de frequencia fica na CL-03.
    const tm=v483MonthlyTypology(cards);
    if(Q483_VALID){
      customerV482Table(tm.cols,tm.data);
      byId('cl01DetailContainer').classList.add('cl02-wide-table');
      const totalRow=byId('tablePanel')?.querySelector('tbody tr:last-child');
      if(totalRow){totalRow.style.fontWeight='700';totalRow.style.background='#edf3f8';totalRow.style.borderTop='2px solid #b9cad9';}
      const foot=byId('tableHelp');if(foot)foot.textContent='Quantidade (TGFITE.QTDNEG) e valor comercial dos itens (VLRTOT - VLRDESC - VLRDESCRAT), por tipologia e mês. Total por tipologia. Quantidades de unidades comerciais diferentes não são somadas. Período: '+periodLabel+'. Empresa 1.';
    }else{
      latestCols=['Situação'];latestRows=[];
      byId('tablePanel').innerHTML='<div class="notice">Consulta Q483 de quantidades indisponivel ou com erro. Nao foi utilizada estimativa a partir das vendas.</div>';
    }
    b.innerHTML+='<p class="note">Produtos distintos: '+fmt(skuMap.size)+'. A tabela mensal de quantidades esta no bloco 03. Unidades comerciais diferentes nao sao somadas entre si.</p>';
   }
 }else if(state.page==='CL-03'){
   const sec03=byId('cl01Sec03');if(sec03)sec03.style.display='';
   if(rules)rules.style.display='';
   // Frequência operacional: cada registro Q46 contém contagem de pedidos válidos.
   // Somente clientes elegíveis entram nos denominadores da carteira.
   const elegIds=new Set(eligible.map(c=>c.client));
   const elegOrders=orders.filter(r=>elegIds.has(String(r[8])));
   const once=eligibleWith.filter(c=>aggregated.get(c.client).orders===1);
   const repeated=eligibleWith.filter(c=>aggregated.get(c.client).orders>=2);
   const repeatRate=eligibleWith.length?100*repeated.length/eligibleWith.length:null;
   const elegNumOrders=elegOrders.reduce((t,r)=>t+r[2],0);
   const elegSales=elegOrders.reduce((t,r)=>t+r[3],0);
   const avgOrders=eligibleWith.length?elegNumOrders/eligibleWith.length:0;
   const monthly=new Map();
   for(const r of elegOrders){
      const m=r[0].slice(0,7);
      const x=monthly.get(m)||{orders:0,sales:0,clients:new Set()};
      x.orders+=r[2];x.sales+=r[3];x.clients.add(String(r[8]));monthly.set(m,x);
   }
   const freq=[{name:'Sem compras no período',n:without.length},{name:'1 pedido',n:once.length},{name:'2 a 3 pedidos',n:0},{name:'4 a 6 pedidos',n:0},{name:'7 ou mais pedidos',n:0}];
   for(const c of repeated){const n=aggregated.get(c.client).orders;freq[n<=3?2:n<=6?3:4].n++}
   const numbers=eligibleWith.map(c=>aggregated.get(c.client).orders).sort((a,b)=>a-b);
   const med= numbers.length?(numbers.length%2?numbers[(numbers.length-1)/2]:(numbers[numbers.length/2-1]+numbers[numbers.length/2])/2):0;
   k.innerHTML=customerCardV482('Clientes cadastrados no recorte',fmt(cards.length),'Cadastro comercial e histórico')+
      customerCardV482('Clientes elegíveis',fmt(eligible.length),'Base da análise comercial')+
      customerCardV482('Clientes elegíveis com compras',fmt(eligibleWith.length),'Clientes distintos no período')+
      customerCardV482('Clientes com recompra (2+ pedidos)',fmt(repeated.length),'2 ou mais pedidos válidos')+
      customerCardV482('Taxa de recompra',repeatRate===null?'N/D':pct(repeatRate),'Recompraram / elegíveis com compras')+
      customerCardV482('Inativos há 90+ dias',fmt(inactive.length),'Elegíveis com última compra antiga');
   a.innerHTML=cl01BarChart(freq,'Frequência de pedidos por cliente elegível','Sem clientes no recorte')+
      '<p class="note">Faixas mutuamente exclusivas: os clientes elegíveis são contados uma vez. O número de pedidos considera TOP 1000,1001,1005,1007,9000,9001, situação A/P/L, empresa 1.</p>';
   const sortedMonthly=[...monthly].sort((x,y)=>x[0].localeCompare(y[0]));
   b.innerHTML=cl01BarChart(sortedMonthly.map(([name,v])=>({name,n:v.clients.size})),'Clientes elegíveis com compras por mês','Sem movimentação')+
      '<div class="cl03-month-table"><table><thead><tr><th>Mês</th><th>Clientes com compras</th><th>Pedidos</th><th>Vendas</th><th>Pedidos por cliente</th></tr></thead><tbody>'+
      (sortedMonthly.map(([month,v])=>'<tr><td>'+esc(month)+'</td><td>'+fmt(v.clients.size)+'</td><td>'+fmt(v.orders)+'</td><td>'+money(v.sales)+'</td><td>'+(v.clients.size?(v.orders/v.clients.size).toFixed(2).replace('.',','):'0')+'</td></tr>').join('')||'<tr><td colspan="5">Nenhum pedido válido no período</td></tr>')+
      '</tbody></table></div><p class="note">Um mesmo cliente pode ser contado em meses diferentes. Não somar clientes mensais para calcular clientes distintos no período.</p>';
   rules.innerHTML='<h3 class="paneltitle">Interpretação da frequência e inatividade</h3><div class="rulesgrid">'+
      '<div class="ruleitem">Sem compras no período<br><strong>'+fmt(without.length)+'</strong></div>'+
      '<div class="ruleitem">Compra única (1 pedido)<br><strong>'+fmt(once.length)+'</strong></div>'+
      '<div class="ruleitem">Recompra (2+ pedidos)<br><strong>'+fmt(repeated.length)+'</strong></div>'+
      '<div class="ruleitem">Inativos há 90+ dias<br><strong>'+fmt(inactive.length)+'</strong></div></div>'+
      '<p class="note">Recompra = 2 ou mais pedidos válidos no período; não significa necessariamente compras em dias distintos. Inatividade = última compra histórica há 90 dias ou mais. Os grupos podem se sobrepor.</p>'+
      '<p class="note">Pedidos dos clientes elegíveis: <strong>'+fmt(elegNumOrders)+'</strong> | Vendas dos clientes elegíveis: <strong>'+money(elegSales)+'</strong> | Média de pedidos por cliente com compras: '+avgOrders.toFixed(2).replace('.',',')+' | Mediana: '+String(med).replace('.',',')+'</p>'+
      '<p class="note">'+esc(info)+'</p>';
   const details=cards.map(c=>{
      const v=aggregated.get(c.client);const eligibleFlag=c.commercial&&c.active&&!c.blocked;
      return [c.client,c.name,carteiraName(c.owner),eligibleFlag?'Sim':'Não',v?fmt(v.orders):'0',v?fmt(v.days.size):'0',v?money(v.sales):money(0),v?(v.orders>=2?'Recompra':'Compra única'):'Sem compras',c.last||'Sem histórico'];
   });
   details.sort((x,y)=>Number(y[4].replace(/\./g,''))-Number(x[4].replace(/\./g,''))||x[0].localeCompare(y[0],'pt-BR',{numeric:true}));
   customerV482Table(['Código','Cliente','Responsável atual','Elegível','Pedidos','Dias com compras','Vendas','Frequência','Última compra histórica'],details);
   if(help)help.textContent=fmt(details.length)+' clientes na carteira | Oracle Q46 e TGFPAR | Exportação bloqueada';
 }else{
   const sec03=byId('cl01Sec03');if(sec03)sec03.style.display='';
   if(rules)rules.style.display='';
   k.innerHTML=customerCardV482('Clientes elegíveis',fmt(eligible.length),'Universo da cobertura')+
    customerCardV482('Elegíveis sem compras no período',fmt(without.length),'Oportunidade de contato')+
    customerCardV482('Elegíveis inativos 90+ dias',fmt(inactive.length),'Última compra histórica')+
    customerCardV482('Elegíveis sem histórico',fmt(never.length),'Nunca compraram no histórico consultado')+
    customerCardV482('Cobertura comercial',eligible.length?pct(100*eligibleWith.length/eligible.length):'N/D','Elegíveis com compras / elegíveis');
   const statuses=[{name:'Elegíveis com compras no período',n:eligibleWith.length},{name:'Elegíveis sem compras no período',n:without.length},{name:'Inativos 90+ dias',n:inactive.length},{name:'Sem histórico',n:never.length}];
   a.innerHTML=cl01BarChart(statuses,'Oportunidades de recuperação','Sem registros');
   const uf=new Map();for(const c of without)uf.set(c.uf,(uf.get(c.uf)||0)+1);
   b.innerHTML=cl01BarChart([...uf].map(([name,n])=>({name,n})).sort((a,b)=>b.n-a.n),'Elegíveis sem compras por UF','Sem clientes nesse grupo');
   rules.innerHTML='<h3 class="paneltitle">Critérios de recuperação</h3><p class="note">Os grupos se sobrepõem: um cliente pode estar há 90 dias sem comprar e ainda ter comprado no início do ano. Sem histórico é subconjunto de sem compras no período. Nenhuma receita potencial é inferida.</p><p class="note">'+esc(info)+'</p>';
   const opportunities=eligible.filter(c=>!aggregated.has(c.client)||c.inactive90).sort((a,b)=>Number(!aggregated.has(b.client))-Number(!aggregated.has(a.client)) || a.client.localeCompare(b.client,'pt-BR',{numeric:true}));
   customerV482Table(['Código','Cliente','Responsável atual','UF','Compras no período','Inativo 90+ dias','Sem histórico','Última compra'],opportunities.map(c=>[c.client,c.name,carteiraName(c.owner),c.uf,aggregated.has(c.client)?'Sim':'Não',c.inactive90?'Sim':'Não',c.never?'Sim':'Não',c.last||'Nunca']));
 }
 const behaviorHostId='haialaCl02Behavior';
 let behaviorNode=byId(behaviorHostId);
 if(state.page==='CL-02'&&selected&&cards.length===1){
  if(!behaviorNode){behaviorNode=document.createElement('section');behaviorNode.id=behaviorHostId;behaviorNode.className='box cl02-behavior';byId('cl01DetailContainer').insertAdjacentElement('afterend',behaviorNode);}
  behaviorNode.innerHTML=cl02BehaviorHTML(orders,cards[0].client,periodLabel);
 }else if(behaviorNode){behaviorNode.remove();}
 if(hint)hint.textContent='Fonte: Oracle | '+fmt(cards.length)+' clientes cadastrados no recorte';
 if(help)help.textContent=state.page==='CL-02'&&selected ? (Q483_VALID ? '2026 | Quantidades e valores por tipologia e mês | Fonte: Oracle, TGFITE | Exportação bloqueada' : 'Consulta Oracle de quantidades pendente | Exportação bloqueada') : fmt(latestRows.length)+' registros exibidos | '+monthLabel+' | Empresa 1 | Exportação bloqueada: autorização pendente';
 if(chips)chips.innerHTML='<span class="chip">Fonte: Oracle</span>'+(state.carteira!=='all'?'<span class="chip">Carteira atual: '+esc(carteiraName(state.carteira))+'</span>':'')+(state.uf!=='all'?'<span class="chip">UF: '+esc(state.uf)+'</span>':'')+(selected?'<span class="chip">Cliente: '+esc(clientLabel())+'</span>':'');
}

const originalDrawV2=draw;
draw=function(){originalDrawV2();updateSkuNotice();let holder=byId('rulesPanel');if(holder && state.page!=='CL-01')holder.innerHTML=computedRules();let hint=byId('tableHelp');/* v5.3.3.9: rodape legado V3 removido; mensagens de origem existentes preservadas. */renderCL01Real();renderCustomersV482();};

/* CL-03: ferramentas de consulta, origem compacta e contexto financeiro correto. */
const cl03Ui={q:'',sort:'Pedidos',desc:true};
function cl03Number(v){var n=String(v||'').replace(/[^0-9,.-]/g,'');return Number(n.replace(/\./g,'').replace(',','.'))||0;}
function cl03EnhanceTable(){
 const panel=byId('tablePanel'),root=byId('cl01DetailContainer');if(!panel||!root)return;
 let tools=byId('cl03Tools');if(!tools){tools=document.createElement('div');tools.id='cl03Tools';tools.innerHTML='<input id="cl03QuickSearch" type="search" placeholder="Buscar código ou nome de cliente" aria-label="Buscar código ou nome de cliente"><small id="cl03QuickCount"></small>';panel.parentNode.insertBefore(tools,panel);}
 const input=byId('cl03QuickSearch');input.value=cl03Ui.q;
 const cols=latestCols.slice(),source=latestRows.map(row=>row.slice());
 const idx={Pedidos:cols.indexOf('Pedidos'),Vendas:cols.indexOf('Vendas'),'Última compra histórica':cols.indexOf('Última compra histórica')};
 const paint=function(){
   const q=cl03Ui.q.toLocaleLowerCase('pt-BR').trim();
   let rows=source.filter(r=>!q||String(r[0]).toLocaleLowerCase('pt-BR').includes(q)||String(r[1]).toLocaleLowerCase('pt-BR').includes(q));
   const col=idx[cl03Ui.sort];
   if(col>=0){rows.sort(function(a,b){let d;if(cl03Ui.sort==='Última compra histórica'){d=String(a[col]||'').localeCompare(String(b[col]||''));}else{d=cl03Number(a[col])-cl03Number(b[col]);}return (cl03Ui.desc?-d:d)||String(a[1]).localeCompare(String(b[1]),'pt-BR');});}
   panel.innerHTML='<table><thead><tr>'+cols.map(function(c){let sort=Object.prototype.hasOwnProperty.call(idx,c);return '<th '+(sort?'class="cl03-sort" data-sort="'+esc(c)+'" data-dir="'+(cl03Ui.sort===c?(cl03Ui.desc?'desc':'asc'):'')+'" aria-sort="'+(cl03Ui.sort===c?(cl03Ui.desc?'descending':'ascending'):'none')+'" title="Clique para ordenar por '+esc(c)+'"':'')+'>'+esc(c)+'</th>';}).join('')+'</tr></thead><tbody>'+(rows.length?rows.map(function(r){return '<tr>'+r.map(function(v){return '<td>'+esc(v)+'</td>';}).join('')+'</tr>';}).join(''):'<tr><td colspan="'+cols.length+'">Nenhum cliente localizado.</td></tr>')+'</tbody></table>';
   panel.querySelectorAll('th[data-sort]').forEach(function(h){h.onclick=function(){const col=h.getAttribute('data-sort');if(cl03Ui.sort===col)cl03Ui.desc=!cl03Ui.desc;else{cl03Ui.sort=col;cl03Ui.desc=true;}paint();};});
   byId('cl03QuickCount').textContent=rows.length+' de '+source.length+' clientes exibidos';
 };
 input.oninput=function(){cl03Ui.q=input.value;paint();};paint();
}
function cl03MonthlyLayout(){
 const section=byId('cl01Sec02');const analytics=section&&section.nextElementSibling;
 if(!analytics)return;
 let full=byId('cl03MonthlyFull');
 if(!full){full=document.createElement('section');full.id='cl03MonthlyFull';full.className='box';analytics.parentNode.insertBefore(full,analytics.nextSibling);}
 const current=byId('secondaryPanel');const monthly=current&&current.querySelector('.cl03-month-table');
 if(monthly){
   full.innerHTML='<h3 class="paneltitle">Evolução mensal - clientes, pedidos e vendas</h3>';
   full.appendChild(monthly);
   const notes=current.querySelectorAll('p.note');
   if(notes.length)full.appendChild(notes[notes.length-1]);
 }
 full.style.display='';
}
function cl03CompactStatus(){
 const main=document.querySelector('main.main');if(!main)return;
 let bar=byId('cl03OracleStatus');
 if(!bar){bar=document.createElement('div');bar.id='cl03OracleStatus';bar.setAttribute('role','status');const tax=byId('taxReferencePanel');if(tax)tax.parentNode.insertBefore(bar,tax);}
 const diagnostic=document.querySelector('#cl03OriginsContent > section.haiala-diagnostics')||document.querySelector('main > section.haiala-diagnostics');
 const fullText=diagnostic?diagnostic.textContent||'':'';
 const failed=/ORACLE:\s*ERRO/i.test(fullText);
 bar.classList.toggle('cl03-error',failed);
 const source=byId('haialaCarteiraCompletaNotice');
 const sourceOk=source&&!/erro|indispon[ií]vel/i.test(source.textContent||'');
 bar.textContent=(failed?'Oracle: falha na consulta geral. Verifique os detalhes técnicos.':'Oracle: consulta geral executada.')+' Carteira '+(state.carteira==='all'?'todas':String(state.carteira))+' | Empresa 1 | '+(state.period==='all'?'2026 - acumulado':String(state.period).padStart(2,'0')+'/2026')+'.'+(sourceOk?' Cadastro comercial disponível.':' Consulte os detalhes para status cadastral.');
}
function cl03Layout(){
 const active=state.page==='CL-03';document.body.classList.toggle('cl03-layout',active);
 const tax=byId('taxReferencePanel');if(!active){const monthly=byId('cl03MonthlyFull');if(monthly){monthly.style.display='none';monthly.innerHTML='';}const status=byId('cl03OracleStatus');if(status)status.style.display='none';const d=byId('cl03Origins');if(d){const home=byId('cl01Sec01');const diag=byId('cl03OriginsContent');if(home&&diag){Array.from(diag.children).forEach(function(el){if(el.tagName==='SECTION'&&el.classList.contains('haiala-diagnostics')){const tax=byId('taxReferencePanel');if(tax)tax.parentNode.insertBefore(el,tax);}else home.parentNode.insertBefore(el,home);});}d.style.display='none';}const t=byId('cl03Tools');if(t)t.style.display='none';return;}
 if(tax){tax.open=false;
   // Não mostrar uma composição geral como se tivesse o filtro da carteira.
   const scope=byId('taxScope'),source=byId('taxSourcePill'),content=byId('taxContent');
   if(state.carteira!=='all'){
     if(scope)scope.textContent='Carteira atual: '+carteiraName(state.carteira)+' | Empresa 1 | '+(state.period==='all'?'2026 - acumulado até hoje':String(state.period).padStart(2,'0')+'/2026');
     if(source)source.textContent='RECORTE FINANCEIRO NÃO INTEGRADO';
     if(content)content.innerHTML='<p class="tax-notice"><strong>Composição financeira por carteira indisponível nesta página.</strong> Os totais gerais da empresa não representam a carteira selecionada. Consulte os valores dos clientes elegíveis no bloco 03 ou use uma página financeira com filtro Oracle conciliado.</p>';
   }
 }
 let diag=byId('cl03Origins');if(!diag){diag=document.createElement('details');diag.id='cl03Origins';diag.innerHTML='<summary>Origem dos dados e regras da consulta</summary><div id="cl03OriginsContent"></div>';const first=byId('haialaOriginV43');if(first&&first.parentNode)first.parentNode.insertBefore(diag,first);}
 diag.style.display='';diag.open=false;
 const content=byId('cl03OriginsContent');
 const diagnostic=document.querySelector('main > section.haiala-diagnostics');if(diagnostic&&diagnostic.parentNode!==content)content.insertBefore(diagnostic,content.firstChild);
 ['haialaOriginV43','haialaQ43Notice','haialaRepNotice','haialaClientNotice','haialaCarteiraCompletaNotice','haialaCarteiraNotice','haialaV477Notice','haialaSkuNotice'].forEach(function(id){const el=byId(id);if(el&&el.parentNode!==content)content.appendChild(el);});
 // Além dos IDs previstos, reunir mensagens técnicas diretamente antes da seção principal.
 const main=byId('cl01Sec01');if(main){let el=diag.nextElementSibling;while(el&&el!==main){const next=el.nextElementSibling;if(el.classList&&el.classList.contains('haiala-diagnostics'))content.appendChild(el);el=next;}}
 cl03MonthlyLayout();cl03CompactStatus();cl03EnhanceTable();
 const t=byId('cl03Tools');if(t)t.style.display='';
}
const cl03PreviousDraw=draw;
draw=function(){cl03PreviousDraw();cl03Layout();};
function runTestsV3(){const results=[],add=(name,condition)=>results.push({name,ok:!!condition});
 add('6 módulos',DB.modules.length===6);add('26 páginas',pageMap.length===26);add('IDs exclusivos',uniq(pageMap.map(x=>x.id))===26);add('365/366 dias do ano corretamente interpretados',daysInMonth(2024,2)===29&&daysInMonth(2026,2)===28);
 add('Pedidos cancelados excluídos',valid().every(o=>o.status==='Válido'));add('Vendas: bruto menos descontos conciliado',valid().every(o=>Math.abs(o.vlc-o.gross+o.discount)<.011));add('Relacionamento de clientes íntegro',DB.orders.every(o=>!!clients[o.client]));add('Relacionamento de SKU íntegro',DB.orders.every(o=>!!skus[o.sku]));add('Relacionamento de representantes íntegro',DB.orders.every(o=>!!reps[o.rep]));
 add('Vendas agrupadas concilia',Math.abs(sum(groups(p().kind,filtered()),x=>x.vlc)-base().v)<.01);
 let old=state.profile;state.profile='rep';add('Restrição simulada representante',filtered().every(o=>o.rep==='R01'));state.profile='manager';add('Restrição simulada gerente',filtered().every(o=>reps[o.rep].manager==='Norte'));state.profile=old;
 add('Tabela com colunas consistentes',latestRows.every(r=>r.length===latestCols.length));let dates=commercialDates(2026,10),dist=allocateGoal(12345.67,dates);add('Rateio diário soma centavos',sum(dist,x=>x.cents)===cents(12345.67));add('Rateio diário cronológico',dist.every((x,i)=>i===0||dist[i-1].cents>=x.cents));add('Rateio desconto concilia',sum(allocateDiscount([{id:'A',gross:10},{id:'B',gross:20},{id:'C',gross:30}],2.01),x=>x)===201);add('Empate ABC determinístico',abcClass([{key:'B',vlc:10},{key:'A',vlc:10}])[0].key==='A');add('ABC exclui valores não positivos',abcClass([{key:'A',vlc:-1},{key:'B',vlc:0},{key:'C',vlc:1}]).length===1);add('Portfólio preserva SKUs sem venda',DB.products.length>=uniq(valid().map(o=>o.sku)));add('Histórico sazonal insuficiente sinalizado',!DB.orders.some(o=>o.date<'2026-01-01'));
let good=results.filter(x=>x.ok).length;byId('modalHost').innerHTML=`<div class="modalbg" id="backdrop"><div class="modal" role="dialog" aria-modal="true"><div class="modalhead"><h2>Autotestes HAIALA v3.0</h2><button class="btn" id="closeModal">Fechar x</button></div><h3>\${good}/\${results.length} verificações passaram</h3><div class="audit">\${results.map(x=>(x.ok?'OK ':'x ')+esc(x.name)).join('\n')}</div><p class="note">Testes automatizados da amostra sintética. Não são os 235 testes funcionais de homologação, nem validam acesso real, metas Sankhya, feriados, datas históricas ou integrações.</p></div></div>`;byId('closeModal').onclick=closeModal;byId('backdrop').onclick=e=>{if(e.target.id==='backdrop')closeModal()};}
byId('testBtn').onclick=runTestsV3;

byId('exportBtn').onclick=exportCSV;byId('testBtn').onclick=runTestsV3;document.addEventListener('click',e=>closeNavGroups(e));document.addEventListener('keydown',e=>{if(e.key==='Escape'){closeModal();closeNavGroups();}});/* HAIALA v4.8.7 - CL04 priorizacao sem duplicidade; Oracle CAD479 e Q46 */
const cl04State={search:'',category:'all',sort:'priority'};
function cl04Refresh(){
 const active=state.page==='CL-04';document.body.classList.toggle('cl04-real',active);
 let filters=byId('cl04Filters');if(!active){if(filters)filters.remove();return;}
 ['01 - Indicadores de oportunidades (Oracle)','02 - Distribuicao e prioridades (Oracle)','03 - Criterios de recuperacao (Oracle)','04 - Lista de oportunidades (Oracle)'].forEach((name,i)=>{const e=byId(['cl01Sec01','cl01Sec02','cl01Sec03','cl01Sec04'][i]);if(e&&e.querySelector('h2'))e.querySelector('h2').textContent=name;});
 if(!CAD479_VALID||!Q46_VALID)return;
 const cards=customerScopeV482().filter(c=>c.commercial&&c.active&&!c.blocked);
 const orders=customerOrdersV482(cards),byClient=new Map();
 for(const r of orders){const id=String(r[8]),old=byClient.get(id)||{orders:0,sales:0};old.orders+=Number(r[2])||0;old.sales+=Number(r[3])||0;byClient.set(id,old);}
 const all=cards.map(c=>{let cat=null;if(c.never)cat='never';else if(!byClient.has(c.client))cat='without';else if(c.inactive90)cat='inactive';return {c,cat,data:byClient.get(c.client)};});
 const opp=all.filter(x=>x.cat),total=opp.length;
 const cnt=cat=>opp.filter(x=>x.cat===cat).length;
 const countNever=cnt('never'),countWithout=cnt('without'),countInactive=cnt('inactive');
 const rawWithout=cards.filter(c=>!byClient.has(c.client)).length,rawInactive=cards.filter(c=>c.inactive90).length;
 const categories={never:'Sem historico',without:'Sem compras no periodo (com historico)',inactive:'Inativo 90+ com compra no periodo'};
 const period=state.period==='all'?'2026 acumulado':String(state.period).padStart(2,'0')+'/2026';
 const scope='Empresa 1 | '+period+' | '+(state.carteira==='all'?'Todas as carteiras':'Carteira '+carteiraName(state.carteira));
 byId('kpis').innerHTML=customerCardV482('Clientes elegiveis',fmt(cards.length),'Cadastro Oracle')+
  customerCardV482('Oportunidades unicas',fmt(total),'Sem duplicar clientes')+
  customerCardV482('Sem historico',fmt(countNever),'Prioridade 1')+
  customerCardV482('Sem compras no periodo, com historico',fmt(countWithout),'Prioridade 2')+
  customerCardV482('Inativos 90+ com compras no periodo',fmt(countInactive),'Prioridade 3')+
  customerCardV482('Com compras e ativos na frequencia',fmt(all.filter(x=>!x.cat).length),'Fora da lista de recuperacao');
 byId('primaryPanel').innerHTML=cl01BarChart([{name:'Sem historico',n:countNever},{name:'Sem compras, com historico',n:countWithout},{name:'Inativos 90+ com compras',n:countInactive}], 'Prioridades exclusivas','Sem oportunidades');
 const uf=new Map();for(const x of opp)uf.set(x.c.uf,(uf.get(x.c.uf)||0)+1);
 byId('secondaryPanel').innerHTML=cl01BarChart([...uf].map(([name,n])=>({name,n})).sort((a,b)=>b.n-a.n),'Oportunidades por UF','Sem oportunidades');
 byId('rulesPanel').innerHTML='<h3 class="paneltitle">Critérios de classificação - sem duplicidade</h3>'+
 '<div class="cl04-criteria">'+
 '<div class="cl04-criterion"><strong>Prioridade 1 - Sem histórico</strong><p>Cliente elegível sem pedido comercial válido identificado no histórico da empresa 1.</p></div>'+
 '<div class="cl04-criterion"><strong>Prioridade 2 - Sem compras no período</strong><p>Cliente elegível com compras históricas, porém sem pedidos válidos no período selecionado.</p></div>'+
 '<div class="cl04-criterion"><strong>Prioridade 3 - Inativo com compras</strong><p>Cliente elegível que comprou no período, mas cuja última compra histórica ocorreu há 90 dias ou mais.</p></div></div>'+
 '<p class="note">Cada cliente recebe apenas uma prioridade. Indicadores brutos de clientes sem compras e inativos podem se sobrepor; não devem ser somados. Não há estimativa de receita potencial.</p>'+
 '<p class="note">'+esc(scope)+' | Elegibilidade preliminar: CLIENTE=S, ATIVO=S, BLOQUEAR diferente de S. Acesso por usuário não homologado.</p>';
 const table=byId('tablePanel');filters=byId('cl04Filters');
 if(!filters){filters=document.createElement('div');filters.id='cl04Filters';table.parentNode.insertBefore(filters,table);}
 filters.innerHTML='<input id="cl04Search" type="search" placeholder="Pesquisar cliente, codigo, responsavel ou UF" aria-label="Pesquisar oportunidades">'+
 '<select id="cl04Category"><option value="all">Todas as prioridades</option><option value="never">Sem historico</option><option value="without">Sem compras no periodo</option><option value="inactive">Inativo 90+ com compras</option></select>'+
 '<select id="cl04Sort"><option value="priority">Prioridade</option><option value="name">Nome</option><option value="sales">Vendas no periodo</option><option value="last">Ultima compra</option></select><small id="cl04Count"></small>';
 const input=byId('cl04Search'),category=byId('cl04Category'),sort=byId('cl04Sort');input.value=cl04State.search;category.value=cl04State.category;sort.value=cl04State.sort;
 const cols=['Prioridade','Codigo','Cliente','Responsavel atual','UF','Pedidos no periodo','Vendas no periodo','Ultima compra historica'];
 function paint(){
  const q=cl04State.search.trim().toLocaleLowerCase('pt-BR');let list=opp.filter(x=>(cl04State.category==='all'||cl04State.category===x.cat)&&(!q||[x.c.client,x.c.name,x.c.uf,carteiraName(x.c.owner)].some(v=>String(v).toLocaleLowerCase('pt-BR').includes(q))));
  const pr={never:1,without:2,inactive:3};
  list.sort((a,b)=>cl04State.sort==='sales'?(b.data?.sales||0)-(a.data?.sales||0):cl04State.sort==='name'?a.c.name.localeCompare(b.c.name,'pt-BR'):cl04State.sort==='last'?String(a.c.last||'').localeCompare(String(b.c.last||'')):(pr[a.cat]-pr[b.cat]||a.c.name.localeCompare(b.c.name,'pt-BR')));
  latestCols=cols;latestRows=list.map(x=>[categories[x.cat],x.c.client,x.c.name,carteiraName(x.c.owner),x.c.uf,String(x.data?.orders||0),money(x.data?.sales||0),x.c.last||'Sem historico']);
  table.innerHTML='<table><thead><tr>'+cols.map(c=>'<th>'+esc(c)+'</th>').join('')+'</tr></thead><tbody>'+(latestRows.length?latestRows.map((r,i)=>'<tr data-row="'+i+'">'+r.map((v,j)=>'<td>'+(j===0?'<strong class="cl04-tag">'+esc(v)+'</strong>':esc(v))+'</td>').join('')+'</tr>').join(''):'<tr><td colspan="8">Nenhum registro no filtro.</td></tr>')+'</tbody></table>';
  table.querySelectorAll('tr[data-row]').forEach(tr=>tr.onclick=()=>detail(latestRows[Number(tr.dataset.row)],cols));
  byId('cl04Count').textContent=list.length+' de '+opp.length+' oportunidades unicas | Exportacao indisponivel';
  byId('tableHelp').textContent=scope+' | Oracle TGFPAR e TGFCAB | Sem duplicidade | Exportacao bloqueada ate autorizacao real';
 }
 input.oninput=()=>{cl04State.search=input.value;paint();};category.onchange=()=>{cl04State.category=category.value;paint();};sort.onchange=()=>{cl04State.sort=sort.value;paint();};paint();
 byId('kpiHint').textContent=fmt(total)+' oportunidades unicas | '+scope;
}
/* CL-04 - apresentação compacta, sem alterar os dados do Oracle. */
function cl04Polish(){
 const active=state.page==='CL-04';
 const tax=byId('taxReferencePanel');
 const origin=byId('cl04Origins');
 const status=byId('cl04OracleStatus');
 if(!active){
  if(status)status.style.display='none';
  if(origin){
   const content=byId('cl04OriginsContent');const first=byId('cl01Sec01');
   if(content&&first){Array.from(content.children).forEach(function(el){
    if(el.tagName==='SECTION'&&el.classList.contains('haiala-diagnostics')){
     const t=byId('taxReferencePanel');if(t)t.parentNode.insertBefore(el,t);
    }else first.parentNode.insertBefore(el,first);
   });}
   origin.style.display='none';
  }
  return;
 }
 if(tax){
  tax.open=false;
  const scope=byId('taxScope'),pill=byId('taxSourcePill'),body=byId('taxContent');
  const period=state.period==='all'?'2026 acumulado até hoje':String(state.period).padStart(2,'0')+'/2026';
  if(scope)scope.textContent='Carteira atual: '+(state.carteira==='all'?'Todas':carteiraName(state.carteira))+' | Empresa 1 | '+period;
  if(pill)pill.textContent='RECORTE FINANCEIRO NÃO INTEGRADO';
  if(body)body.innerHTML='<p class="tax-notice"><strong>Composição financeira indisponível na CL-04.</strong> Os totais gerais da empresa não devem ser interpretados como valores da carteira selecionada. Consulte os pedidos e vendas no bloco de oportunidades; análises financeiras exigem recorte Oracle conciliado.</p>';
 }
 let details=byId('cl04Origins');
 if(!details){
  details=document.createElement('details');details.id='cl04Origins';
  details.innerHTML='<summary>Origem dos dados e regras da consulta</summary><div id="cl04OriginsContent"></div>';
  const first=byId('haialaOriginV43')||byId('cl01Sec01');
  if(first)first.parentNode.insertBefore(details,first);
 }
 details.style.display='';details.open=false;
 const content=byId('cl04OriginsContent');
 const diagnostic=document.querySelector('main.main>section.haiala-diagnostics');
 if(diagnostic&&diagnostic.parentNode!==content)content.insertBefore(diagnostic,content.firstChild);
 ['haialaOriginV43','haialaQ43Notice','haialaRepNotice','haialaClientNotice','haialaCarteiraCompletaNotice','haialaCarteiraNotice','haialaV477Notice','haialaSkuNotice'].forEach(function(id){
  const el=byId(id);if(el&&el.parentNode!==content)content.appendChild(el);
 });
 const first=byId('cl01Sec01');
 if(first){let el=details.nextElementSibling;while(el&&el!==first){const next=el.nextElementSibling;if(el.classList&&el.classList.contains('haiala-diagnostics'))content.appendChild(el);el=next;}}
 let bar=byId('cl04OracleStatus');if(!bar){bar=document.createElement('div');bar.id='cl04OracleStatus';bar.setAttribute('role','status');if(tax)tax.parentNode.insertBefore(bar,tax);}
 bar.style.display='';
 const diagText=(content.querySelector('section.haiala-diagnostics')||content).textContent||'';
 const error=/ORACLE:\s*ERRO/i.test(diagText);
 bar.classList.toggle('cl04-fail',error);
 bar.textContent=(error?'Oracle: falha na consulta geral; confira o diagnóstico.':'Oracle: consulta geral executada.')+' | Empresa 1 | '+(state.carteira==='all'?'Todas as carteiras':'Carteira '+carteiraName(state.carteira))+' | '+(state.period==='all'?'2026 acumulado até hoje':String(state.period).padStart(2,'0')+'/2026')+' | Elegibilidade preliminar';
}
const cl04BaseDraw=draw;
draw=function(){cl04BaseDraw();cl04Refresh();cl04Polish();};

draw();
/* HAIALA v5.1.1 - avisos de excecao globais, sem conteudo tecnico normal. */
function v511UpdateException(){
 const target=document.getElementById('v511Exception');
 if(!target)return;
 const parts=[];
 if(typeof DATA_ORIGIN!=='undefined' && DATA_ORIGIN!=='ORACLE')parts.push('Snapshot histórico em uso: dados podem estar desatualizados.');
 if(typeof state!=='undefined' && typeof isRealPage==='function' && !isRealPage() && !['CL-01','CL-02','CL-03','CL-04'].includes(state.page))parts.push('Página demonstrativa: indicadores ainda não integrados ao Oracle.');
 if(['CL-01','CL-02','CL-03','CL-04'].includes(state.page) && typeof CAD479_VALID!=='undefined' && !CAD479_VALID)parts.push('Consulta de carteira indisponível: indicadores cadastrais não conciliados.');
 if(typeof state!=='undefined' && state.page==='CL-02' && typeof Q46_VALID!=='undefined' && !Q46_VALID)parts.push('Consulta financeira por cliente indisponível.');
 target.textContent=parts.join(' ');
 target.dataset.visible=parts.length?'true':'false';
}
(function(){
 const previousDraw=draw;
 draw=function(){previousDraw.apply(this,arguments);v511UpdateException();};
 v511UpdateException();
})();
/* Renderizar matrizes APOS os demais controladores de cada pagina. */
(function(){const original=draw;draw=function(){original.apply(this,arguments);q533Render();};q533Render();})();

/* v6.0.3: numeração visual apenas na página AC. Preserva identificadores e consultas. */
function v601NumberSections(){
 if(!['AC-01','AC-02','AC-03'].includes(state.page))return;
 const sec02=document.querySelector('#cl01Sec02 h2');
 const family=document.querySelector('#q533FamilyTitle h2');
 const sec04=document.querySelector('#cl01Sec04 h2');
 if(sec02)sec02.textContent=sec02.textContent.replace(/^02\s*-/, '03 -');
 if(family)family.textContent=family.textContent.replace(/^03\s*-/, '04 -');
 if(sec04)sec04.textContent='05 - Análise detalhada';
}
(function(){const oldDraw=draw;draw=function(){oldDraw.apply(this,arguments);v601NumberSections();};v601NumberSections();})();

/* v6.0.9 - CL-01 Carteira em primeiro lugar, usando os blocos existentes. */
(function(){
  const title=document.getElementById('cl01Sec03');
  const content=document.getElementById('rulesPanel');
  if(!title||!content)return;
  const titleMarker=document.createComment('v609-posicao-original-cobertura-titulo');
  const contentMarker=document.createComment('v609-posicao-original-cobertura-conteudo');
  title.parentNode.insertBefore(titleMarker,title);
  content.parentNode.insertBefore(contentMarker,content);
  function apply(){
    const active=state.page==='CL-01';
    document.body.classList.toggle('haiala-v609-carteira',active);
    if(active){
      const afterFilters=document.querySelector('main.main .top');
      if(afterFilters && afterFilters.parentNode){
        afterFilters.parentNode.insertBefore(title,afterFilters.nextSibling);
        title.parentNode.insertBefore(content,title.nextSibling);
      }
      const h=title.querySelector('h2');if(h)h.textContent='03 - Cobertura e recuperação';
    }else{
      if(titleMarker.parentNode)titleMarker.parentNode.insertBefore(title,titleMarker.nextSibling);
      if(contentMarker.parentNode)contentMarker.parentNode.insertBefore(content,contentMarker.nextSibling);
    }
  }
  const prev=draw;
  draw=function(){prev.apply(this,arguments);apply();};
  apply();
})();

/* v31: métrica de carga do documento, sem requisições adicionais nem gravação. */
(function(){
  var meter=document.getElementById('haialaLoadMeter');
  if(!meter || !window.performance)return;
  var fmt=function(ms){return (ms/1000).toFixed(2).replace('.',',')+' s';};
  var initMs=performance.now();
  function update(){
    var nav=performance.getEntriesByType && performance.getEntriesByType('navigation')[0];
    var total=performance.now();
    var server=nav && nav.responseStart>0 ? nav.responseStart : null;
    var transfer=nav && nav.responseEnd>=nav.responseStart ? nav.responseEnd-nav.responseStart : null;
    meter.textContent='Carga: '+fmt(total);
    meter.title='Carga inicial: '+fmt(total)+' (início da navegação até load).'+
      (server!==null?' Espera até primeiro byte (rede + Oracle/JSP): '+fmt(server)+'.':'')+
      (transfer!==null?' Transferência HTML: '+fmt(transfer)+'.':'')+
      ' Inicialização e renderização da interface até o fim do script: '+fmt(initMs)+
      '. Os tempos dependem da rede, cache e ambiente Sankhya.';
    meter.dataset.loadMs=String(Math.round(total));
    if(server!==null)meter.dataset.ttfbMs=String(Math.round(server));
    if(transfer!==null)meter.dataset.transferMs=String(Math.round(transfer));
    meter.dataset.initMs=String(Math.round(initMs));
  }
  if(document.readyState==='complete')update();
  else window.addEventListener('load',update,{once:true});
})();
</script></body></html>