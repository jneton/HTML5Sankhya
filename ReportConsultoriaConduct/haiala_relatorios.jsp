<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,java.sql.*,java.math.BigDecimal,java.time.LocalDate,java.time.YearMonth,java.time.ZoneId,br.com.sankhya.modelcore.util.EntityFacadeFactory,br.com.sankhya.jape.dao.JdbcWrapper,br.com.sankhya.jape.sql.NativeSql,br.com.sankhya.jape.EntityFacade" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<%!
private String jsonEsc(String s) { if(s==null)return ""; StringBuilder b=new StringBuilder(); for(int i=0;i<s.length();i++){char c=s.charAt(i);switch(c){case '\"':b.append("\\\"");break;case '\\':b.append("\\\\");break;case '\n':b.append("\\n");break;case '\r':b.append("\\r");break;case '\t':b.append("\\t");break;default:if(c<32)b.append(' ');else b.append(c);}}return b.toString().replace("<","\\u003c").replace("&","\\u0026"); }
private String num(BigDecimal n){return n==null?"null":n.stripTrailingZeros().toPlainString();}
%>
<%
// SQLs originais fornecidas pelo analista; execução somente SELECT. Um relatório e um mês por requisição.
LocalDate hoje=LocalDate.now(ZoneId.of("America/Sao_Paulo"));
int ano=hoje.getYear(), mes=hoje.getMonthValue();
String tela="estoque"; String erro=""; String payload="[]";
try { if(request.getParameter("ano")!=null) ano=Integer.parseInt(request.getParameter("ano")); if(request.getParameter("mes")!=null) mes=Integer.parseInt(request.getParameter("mes")); if(ano<1900||ano>2100||mes<1||mes>12)throw new IllegalArgumentException("Ano ou mês inválido"); } catch(Exception e){erro="Período inválido: "+e.getMessage(); ano=hoje.getYear(); mes=hoje.getMonthValue();}
if("producao".equals(request.getParameter("rel")))tela="producao";
String dtmes=String.format(java.util.Locale.ROOT,"01/%02d/%04d",mes,ano);
JdbcWrapper jdbc=null;ResultSet rs=null;
try {
EntityFacade facade=EntityFacadeFactory.getDWFFacade(); jdbc=facade.getJdbcWrapper(); jdbc.openSession();
String consulta;
if("estoque".equals(tela)){
consulta=
    "SELECT B.*, G1.DESCRGRUPOPROD AS GRUPO_FILHO, G2.DESCRGRUPOPROD AS GRUPO_PAI, G3.DESCRGRUPOPROD AS GRUPO_AVO, G4.DESCRGRUPOPROD AS GRUPO_RAIZ FROM (\n" +
    "WITH\n" +
    "parametros AS\n" +
    " (SELECT to_date(:dtmes, 'DD/MM/YYYY') AS data_referencia,\n" +
    "         trunc(SYSDATE) AS data_atual,\n" +
    "         1 AS codemp\n" +
    "    FROM dual),\n" +
    "periodo AS\n" +
    " (SELECT last_day(add_months(data_referencia, -1)) + 1 AS data_inicio,\n" +
    "         last_day(data_referencia) AS data_fim,\n" +
    "         codemp,\n" +
    "         data_atual\n" +
    "    FROM parametros),\n" +
    "calendario AS\n" +
    " (SELECT periodo.data_inicio + LEVEL - 1 AS dia\n" +
    "    FROM periodo\n" +
    "  CONNECT BY LEVEL <= periodo.data_fim - periodo.data_inicio + 1),\n" +
    "produtos AS\n" +
    " (SELECT pro.codgrupoprod,\n" +
    "         gru.descrgrupoprod,\n" +
    "         pro.codprod,\n" +
    "         pro.descrprod || pro.compldesc AS descproduto\n" +
    "    FROM tgfpro pro\n" +
    "   INNER JOIN tgfgru gru\n" +
    "      ON gru.codgrupoprod = pro.codgrupoprod\n" +
    "   WHERE substr(pro.codgrupoprod, 1, 1) = '6'),\n" +
    "estoque_atual AS\n" +
    " (SELECT est.codprod,\n" +
    "         SUM(est.estoque) AS quantidade_atual\n" +
    "    FROM tgfest est\n" +
    "   INNER JOIN produtos pro\n" +
    "      ON pro.codprod = est.codprod\n" +
    "   CROSS JOIN periodo per\n" +
    "   WHERE est.codemp = per.codemp\n" +
    "   GROUP BY est.codprod),\n" +
    "produto_dia AS\n" +
    " (SELECT pro.codgrupoprod,\n" +
    "         pro.descrgrupoprod,\n" +
    "         pro.codprod,\n" +
    "         pro.descproduto,\n" +
    "         cal.dia\n" +
    "    FROM produtos pro\n" +
    "   CROSS JOIN calendario cal),\n" +
    "movimentacoes_posteriores AS\n" +
    " (SELECT pd.codprod,\n" +
    "         pd.dia,\n" +
    "         SUM(ese.qtdneg * ese.atualestoque) AS quantidade_movimentada\n" +
    "    FROM produto_dia pd\n" +
    "   CROSS JOIN periodo per\n" +
    "    LEFT JOIN tgfese ese\n" +
    "      ON ese.codemp = per.codemp\n" +
    "     AND ese.codprod = pd.codprod\n" +
    "     AND ese.dtreferencia > pd.dia\n" +
    "   GROUP BY pd.codprod,\n" +
    "            pd.dia),\n" +
    "estoque_diario AS\n" +
    " (SELECT pd.codgrupoprod,\n" +
    "         pd.descrgrupoprod,\n" +
    "         pd.codprod,\n" +
    "         pd.descproduto,\n" +
    "         pd.dia,\n" +
    "         CASE\n" +
    "            WHEN pd.dia > per.data_atual THEN\n" +
    "             NULL\n" +
    "            WHEN pd.dia < per.data_atual THEN\n" +
    "             nvl(ea.quantidade_atual, 0) - nvl(mp.quantidade_movimentada, 0)\n" +
    "            ELSE\n" +
    "             nvl(ea.quantidade_atual, 0)\n" +
    "         END AS estoque\n" +
    "    FROM produto_dia pd\n" +
    "   CROSS JOIN periodo per\n" +
    "    LEFT JOIN estoque_atual ea\n" +
    "      ON ea.codprod = pd.codprod\n" +
    "    LEFT JOIN movimentacoes_posteriores mp\n" +
    "      ON mp.codprod = pd.codprod\n" +
    "     AND mp.dia = pd.dia)\n" +
    "SELECT codgrupoprod,\n" +
    "       descrgrupoprod,\n" +
    "       codprod,\n" +
    "       descproduto,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 1 THEN\n" +
    "               estoque\n" +
    "           END) AS d01,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 2 THEN\n" +
    "               estoque\n" +
    "           END) AS d02,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 3 THEN\n" +
    "               estoque\n" +
    "           END) AS d03,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 4 THEN\n" +
    "               estoque\n" +
    "           END) AS d04,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 5 THEN\n" +
    "               estoque\n" +
    "           END) AS d05,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 6 THEN\n" +
    "               estoque\n" +
    "           END) AS d06,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 7 THEN\n" +
    "               estoque\n" +
    "           END) AS d07,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 8 THEN\n" +
    "               estoque\n" +
    "           END) AS d08,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 9 THEN\n" +
    "               estoque\n" +
    "           END) AS d09,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 10 THEN\n" +
    "               estoque\n" +
    "           END) AS d10,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 11 THEN\n" +
    "               estoque\n" +
    "           END) AS d11,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 12 THEN\n" +
    "               estoque\n" +
    "           END) AS d12,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 13 THEN\n" +
    "               estoque\n" +
    "           END) AS d13,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 14 THEN\n" +
    "               estoque\n" +
    "           END) AS d14,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 15 THEN\n" +
    "               estoque\n" +
    "           END) AS d15,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 16 THEN\n" +
    "               estoque\n" +
    "           END) AS d16,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 17 THEN\n" +
    "               estoque\n" +
    "           END) AS d17,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 18 THEN\n" +
    "               estoque\n" +
    "           END) AS d18,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 19 THEN\n" +
    "               estoque\n" +
    "           END) AS d19,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 20 THEN\n" +
    "               estoque\n" +
    "           END) AS d20,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 21 THEN\n" +
    "               estoque\n" +
    "           END) AS d21,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 22 THEN\n" +
    "               estoque\n" +
    "           END) AS d22,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 23 THEN\n" +
    "               estoque\n" +
    "           END) AS d23,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 24 THEN\n" +
    "               estoque\n" +
    "           END) AS d24,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 25 THEN\n" +
    "               estoque\n" +
    "           END) AS d25,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 26 THEN\n" +
    "               estoque\n" +
    "           END) AS d26,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 27 THEN\n" +
    "               estoque\n" +
    "           END) AS d27,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 28 THEN\n" +
    "               estoque\n" +
    "           END) AS d28,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 29 THEN\n" +
    "               estoque\n" +
    "           END) AS d29,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 30 THEN\n" +
    "               estoque\n" +
    "           END) AS d30,\n" +
    "       MAX(CASE\n" +
    "              WHEN extract(DAY FROM dia) = 31 THEN\n" +
    "               estoque\n" +
    "           END) AS d31\n" +
    "  FROM estoque_diario\n" +
    " GROUP BY codgrupoprod,\n" +
    "          descrgrupoprod,\n" +
    "          codprod,\n" +
    "          descproduto\n" +
    ") B LEFT JOIN TGFGRU G1 ON G1.CODGRUPOPROD=B.CODGRUPOPROD LEFT JOIN TGFGRU G2 ON G2.CODGRUPOPROD=G1.CODGRUPAI LEFT JOIN TGFGRU G3 ON G3.CODGRUPOPROD=G2.CODGRUPAI LEFT JOIN TGFGRU G4 ON G4.CODGRUPOPROD=G3.CODGRUPAI ORDER BY B.CODGRUPOPROD,B.CODPROD\n";
}else{
consulta=
    "SELECT B.*, G1.DESCRGRUPOPROD AS GRUPO_FILHO, G2.DESCRGRUPOPROD AS GRUPO_PAI, G3.DESCRGRUPOPROD AS GRUPO_AVO, G4.DESCRGRUPOPROD AS GRUPO_RAIZ FROM (\n" +
    "WITH\n" +
    "parametros AS\n" +
    " (SELECT trunc(to_date(:dtmes, 'DD/MM/YYYY'), 'MM') AS dt_inicio,\n" +
    "         add_months(trunc(to_date(:dtmes, 'DD/MM/YYYY'), 'MM'), 1) AS dt_fim,\n" +
    "         8 AS setor,\n" +
    "         trunc(SYSDATE) AS dt_atual\n" +
    "    FROM dual),\n" +
    "dados_producao AS\n" +
    " (SELECT trunc(apo.dhapo) AS dia,\n" +
    "         pro.codprod,\n" +
    "         pro.descrprod || pro.compldesc AS descproduto,\n" +
    "         SUM(apf.qtd) AS qtd\n" +
    "    FROM tpriproc ord\n" +
    "   INNER JOIN tpriatv atv\n" +
    "      ON atv.idiproc = ord.idiproc\n" +
    "   INNER JOIN tpripa ipa\n" +
    "      ON ipa.idiproc = atv.idiproc\n" +
    "   INNER JOIN tprapo apo\n" +
    "      ON apo.idiatv = atv.idiatv\n" +
    "   INNER JOIN tprapf apf\n" +
    "      ON apf.nuapo = apo.nuapo\n" +
    "   INNER JOIN tgfpro pro\n" +
    "      ON pro.codprod = ipa.codprodpa\n" +
    "   CROSS JOIN parametros p\n" +
    "   WHERE apo.dhapo >= p.dt_inicio\n" +
    "     AND apo.dhapo < p.dt_fim\n" +
    "     AND apo.dhapo < p.dt_atual + 1\n" +
    "     AND pro.ad_set_producao = p.setor\n" +
    "   GROUP BY trunc(apo.dhapo),\n" +
    "            pro.codprod,\n" +
    "            pro.descrprod || pro.compldesc),\n" +
    "matriz_producao AS\n" +
    " (SELECT dp.codprod,\n" +
    "         dp.descproduto,\n" +
    "         /* Dia 01 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 1 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_01,\n" +
    "         /* Dia 02 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 2 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_02,\n" +
    "         /* Dia 03 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 3 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_03,\n" +
    "         /* Dia 04 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 4 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_04,\n" +
    "         /* Dia 05 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 5 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_05,\n" +
    "         /* Dia 06 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 6 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_06,\n" +
    "         /* Dia 07 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 7 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_07,\n" +
    "         /* Dia 08 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 8 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_08,\n" +
    "         /* Dia 09 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 9 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_09,\n" +
    "         /* Dia 10 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 10 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_10,\n" +
    "         /* Dia 11 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 11 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_11,\n" +
    "         /* Dia 12 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 12 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_12,\n" +
    "         /* Dia 13 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 13 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_13,\n" +
    "         /* Dia 14 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 14 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_14,\n" +
    "         /* Dia 15 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 15 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_15,\n" +
    "         /* Dia 16 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 16 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_16,\n" +
    "         /* Dia 17 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 17 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_17,\n" +
    "         /* Dia 18 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 18 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_18,\n" +
    "         /* Dia 19 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 19 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_19,\n" +
    "         /* Dia 20 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 20 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_20,\n" +
    "         /* Dia 21 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 21 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_21,\n" +
    "         /* Dia 22 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 22 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_22,\n" +
    "         /* Dia 23 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 23 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_23,\n" +
    "         /* Dia 24 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 24 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_24,\n" +
    "         /* Dia 25 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 25 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_25,\n" +
    "         /* Dia 26 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 26 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_26,\n" +
    "         /* Dia 27 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 27 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_27,\n" +
    "         /* Dia 28 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 28 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_28,\n" +
    "         /* Dia 29 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 29 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_29,\n" +
    "         /* Dia 30 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 30 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_30,\n" +
    "         /* Dia 31 */\n" +
    "         SUM(CASE\n" +
    "                WHEN extract(DAY FROM dp.dia) = 31 THEN\n" +
    "                 dp.qtd\n" +
    "                ELSE\n" +
    "                 0\n" +
    "             END) AS dia_31,\n" +
    "         /* Total produzido no periodo */\n" +
    "         SUM(dp.qtd) AS total_mes\n" +
    "    FROM dados_producao dp\n" +
    "   GROUP BY dp.codprod,\n" +
    "            dp.descproduto)\n" +
    "SELECT mp.codprod,\n" +
    "       mp.descproduto,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 0 <= p.dt_atual THEN\n" +
    "           mp.dia_01\n" +
    "       END AS dia_01,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 1 <= p.dt_atual THEN\n" +
    "           mp.dia_02\n" +
    "       END AS dia_02,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 2 <= p.dt_atual THEN\n" +
    "           mp.dia_03\n" +
    "       END AS dia_03,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 3 <= p.dt_atual THEN\n" +
    "           mp.dia_04\n" +
    "       END AS dia_04,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 4 <= p.dt_atual THEN\n" +
    "           mp.dia_05\n" +
    "       END AS dia_05,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 5 <= p.dt_atual THEN\n" +
    "           mp.dia_06\n" +
    "       END AS dia_06,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 6 <= p.dt_atual THEN\n" +
    "           mp.dia_07\n" +
    "       END AS dia_07,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 7 <= p.dt_atual THEN\n" +
    "           mp.dia_08\n" +
    "       END AS dia_08,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 8 <= p.dt_atual THEN\n" +
    "           mp.dia_09\n" +
    "       END AS dia_09,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 9 <= p.dt_atual THEN\n" +
    "           mp.dia_10\n" +
    "       END AS dia_10,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 10 <= p.dt_atual THEN\n" +
    "           mp.dia_11\n" +
    "       END AS dia_11,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 11 <= p.dt_atual THEN\n" +
    "           mp.dia_12\n" +
    "       END AS dia_12,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 12 <= p.dt_atual THEN\n" +
    "           mp.dia_13\n" +
    "       END AS dia_13,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 13 <= p.dt_atual THEN\n" +
    "           mp.dia_14\n" +
    "       END AS dia_14,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 14 <= p.dt_atual THEN\n" +
    "           mp.dia_15\n" +
    "       END AS dia_15,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 15 <= p.dt_atual THEN\n" +
    "           mp.dia_16\n" +
    "       END AS dia_16,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 16 <= p.dt_atual THEN\n" +
    "           mp.dia_17\n" +
    "       END AS dia_17,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 17 <= p.dt_atual THEN\n" +
    "           mp.dia_18\n" +
    "       END AS dia_18,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 18 <= p.dt_atual THEN\n" +
    "           mp.dia_19\n" +
    "       END AS dia_19,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 19 <= p.dt_atual THEN\n" +
    "           mp.dia_20\n" +
    "       END AS dia_20,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 20 <= p.dt_atual THEN\n" +
    "           mp.dia_21\n" +
    "       END AS dia_21,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 21 <= p.dt_atual THEN\n" +
    "           mp.dia_22\n" +
    "       END AS dia_22,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 22 <= p.dt_atual THEN\n" +
    "           mp.dia_23\n" +
    "       END AS dia_23,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 23 <= p.dt_atual THEN\n" +
    "           mp.dia_24\n" +
    "       END AS dia_24,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 24 <= p.dt_atual THEN\n" +
    "           mp.dia_25\n" +
    "       END AS dia_25,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 25 <= p.dt_atual THEN\n" +
    "           mp.dia_26\n" +
    "       END AS dia_26,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 26 <= p.dt_atual THEN\n" +
    "           mp.dia_27\n" +
    "       END AS dia_27,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 27 <= p.dt_atual THEN\n" +
    "           mp.dia_28\n" +
    "       END AS dia_28,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 28 <= p.dt_atual THEN\n" +
    "           mp.dia_29\n" +
    "       END AS dia_29,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 29 <= p.dt_atual THEN\n" +
    "           mp.dia_30\n" +
    "       END AS dia_30,\n" +
    "       CASE\n" +
    "          WHEN p.dt_inicio + 30 <= p.dt_atual THEN\n" +
    "           mp.dia_31\n" +
    "       END AS dia_31,\n" +
    "       mp.total_mes\n" +
    "  FROM matriz_producao mp\n" +
    " CROSS JOIN parametros p\n" +
    ") B LEFT JOIN TGFPRO PR ON PR.CODPROD=B.CODPROD LEFT JOIN TGFGRU G1 ON G1.CODGRUPOPROD=PR.CODGRUPOPROD LEFT JOIN TGFGRU G2 ON G2.CODGRUPOPROD=G1.CODGRUPAI LEFT JOIN TGFGRU G3 ON G3.CODGRUPOPROD=G2.CODGRUPAI LEFT JOIN TGFGRU G4 ON G4.CODGRUPOPROD=G3.CODGRUPAI ORDER BY B.CODPROD\n";
}
NativeSql q=new NativeSql(jdbc);q.appendSql(consulta);
q.setNamedParameter("dtmes",dtmes);
if("producao".equals(tela))q.setNamedParameter("xsetor",new BigDecimal("8"));
rs=q.executeQuery();
StringBuilder b=new StringBuilder("["); boolean first=true;
while(rs.next()){
 if(!first)b.append(',');first=false;
 b.append("{\"codigo\":\"").append(jsonEsc(rs.getString("CODPROD"))).append("\",\"descricao\":\"").append(jsonEsc(rs.getString("DESCPRODUTO")))
 .append("\",\"grupoFilho\":\"").append(jsonEsc(rs.getString("GRUPO_FILHO")))
 .append("\",\"grupoPai\":\"").append(jsonEsc(rs.getString("GRUPO_PAI")))
 .append("\",\"grupoAvo\":\"").append(jsonEsc(rs.getString("GRUPO_AVO")))
 .append("\",\"grupoRaiz\":\"").append(jsonEsc(rs.getString("GRUPO_RAIZ"))).append("\",\"valores\":{");
 for(int d=1;d<=YearMonth.of(ano,mes).lengthOfMonth();d++){
  if(d>1)b.append(','); String col=("estoque".equals(tela)?"D":"DIA_")+String.format(java.util.Locale.ROOT,"%02d",d);
  b.append('\"').append(d).append("\":").append(num(rs.getBigDecimal(col)));
 }
 b.append("},\"totalMes\":");
 if("producao".equals(tela))b.append(num(rs.getBigDecimal("TOTAL_MES")));else b.append("null");
 b.append('}');
}
b.append(']');payload=b.toString();
} catch(Exception e) { erro=e.getClass().getSimpleName()+": "+String.valueOf(e.getMessage());application.log("HAIALA v2.2 - "+tela+" "+dtmes,e); }
finally{try{if(rs!=null)rs.close();}catch(Exception ignored){}try{if(jdbc!=null)jdbc.closeSession();}catch(Exception ignored){}}
%>
<!doctype html><html lang="pt-BR"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Haiala | Relatórios Industriais</title><style>
:root{--navy:#173044;--green:#159464;--bg:#f4f7f8;--line:#dee7e9;--text:#213547;--muted:#697a88;--white:#fff}*{box-sizing:border-box}body{margin:0;background:var(--bg);font:14px system-ui,-apple-system,Segoe UI,Arial,sans-serif;color:var(--text)}header{background:var(--navy);color:white;padding:19px 26px;display:flex;justify-content:space-between;align-items:center;gap:20px}h1{font-size:20px;margin:0;font-weight:650}header small{display:block;color:#d5e2e6;margin-top:3px}main{max-width:1500px;padding:24px;margin:auto}.tabs{display:flex;gap:8px;margin-bottom:18px;flex-wrap:wrap}.tab{border:1px solid var(--line);background:white;border-radius:9px;padding:13px 17px;cursor:pointer;color:#486070;font-weight:700}.tab.active{color:var(--green);border-color:var(--green);box-shadow:inset 0 -3px var(--green)}.panel{background:white;border:1px solid var(--line);border-radius:12px;box-shadow:0 2px 7px #102b3910;padding:20px;margin-bottom:18px}.filters{display:flex;gap:13px;flex-wrap:wrap;align-items:end}label{display:block;font-size:12px;color:var(--muted);font-weight:650;margin-bottom:5px}select,input{padding:10px 11px;border:1px solid #ccd8dc;border-radius:7px;background:white;color:var(--text);font:inherit;min-width:120px}input[type=search]{min-width:260px}button{font:inherit;cursor:pointer;border:1px solid #c9d9d7;border-radius:7px;background:white;padding:10px 14px;font-weight:600;color:#245047}button.primary{background:var(--green);border-color:var(--green);color:white}button:hover{filter:brightness(.97)}.title-row{display:flex;justify-content:space-between;gap:12px;align-items:center;flex-wrap:wrap}.title-row h2{margin:0;font-size:19px}.muted{color:var(--muted);font-size:13px}.pill{font-size:12px;border-radius:999px;background:#fff7e4;border:1px solid #f3d18e;color:#86600a;padding:6px 10px}.pill.connected{background:#e9f8f0;border-color:#a7dac2;color:#116c48}.toolbar{display:flex;justify-content:space-between;gap:10px;flex-wrap:wrap;margin:16px 0 13px}.toolbar>div{display:flex;gap:8px;flex-wrap:wrap}.tablewrap{overflow:auto;max-height:68vh;border:1px solid var(--line);border-radius:8px}table{border-collapse:separate;border-spacing:0;width:100%;font-size:13px}th,td{padding:11px 12px;border-bottom:1px solid #e8eeef;white-space:nowrap}th{background:#edf4f5;position:sticky;top:0;z-index:2;text-align:left;color:#334d5f}td.number,th.number{text-align:right;font-variant-numeric:tabular-nums}tr:hover td{background:#f6faf9}th:first-child,td:first-child{position:sticky;left:0;z-index:1;background:white}th:first-child{z-index:3;background:#edf4f5}th:nth-child(2),td:nth-child(2){min-width:360px}tfoot td{background:#e7f4ed!important;font-weight:700;position:sticky;bottom:0}td.zero{color:#a3abb1}.current-stock{background:#e8f6ee!important;color:#116845;font-weight:700}th.number,td.number{min-width:70px;padding-left:8px;padding-right:8px}th:nth-child(2),td:nth-child(2){min-width:300px;max-width:390px;overflow:hidden;text-overflow:ellipsis}.notice{padding:14px;border-radius:8px;background:#f4f8fb;color:#4b6070;border:1px solid #d7e5eb;line-height:1.55}.metrics{display:flex;gap:16px;margin:14px 0;flex-wrap:wrap}.metric{background:#f7faf9;padding:10px 15px;border-radius:8px;border:1px solid var(--line)}.metric strong{font-size:20px;display:block}.version{font-size:11px;font-weight:700;background:#28576c;border:1px solid #537f8b;border-radius:5px;padding:3px 7px;vertical-align:middle;margin-left:7px}.hidden{display:none!important}#file{display:none}footer{color:#74848c;font-size:12px;margin-top:14px}@media(max-width:700px){header{padding:17px}main{padding:12px}.panel{padding:14px}h1{font-size:17px}th:nth-child(2),td:nth-child(2){min-width:250px}}

/* v2.1: densidade de informação / espaço vertical otimizado */
header{padding:10px 17px}h1{font-size:17px}main{max-width:none;padding:12px 16px}
.tabs{margin-bottom:9px}.tab{padding:8px 12px;border-radius:6px}
.panel{padding:12px 14px;margin-bottom:10px;border-radius:9px}
.filters{gap:8px}label{font-size:11px;margin-bottom:3px}select,input{padding:7px 9px;font-size:12px;min-width:100px}
input[type=search]{min-width:210px}button{padding:7px 11px;font-size:12px}
.title-row h2{font-size:16px}.muted{font-size:11px}.metrics{margin:8px 0;gap:8px}
.metric{padding:6px 11px;min-width:130px}.metric strong{font-size:16px}.toolbar{margin:8px 0}
.tablewrap{max-height:calc(100vh - 310px);min-height:280px}table{font-size:11px}
th,td{padding:6px 8px;line-height:1.3}th.number,td.number{min-width:48px;padding:6px}
th:nth-child(2),td:nth-child(2){min-width:245px;max-width:300px}
.group-col{max-width:190px;min-width:125px;overflow:hidden;text-overflow:ellipsis}
.notice{padding:8px 12px;font-size:11px}footer{margin-top:7px;font-size:11px}
@media(max-width:700px){main{padding:8px}.panel{padding:9px}.tablewrap{max-height:65vh}}
</style><snk:load/></head><body>
<header><div><h1>HAIALA · Relatórios Industriais <span class="version">v2.2</span></h1><small>PCP / Produção · Sankhya Oracle</small></div><span>Histórico diário</span></header><main>
<div class="tabs"><button class="tab" id="tab-estoque" onclick="navigate('estoque')">01 · Estoque de Perfis</button><button class="tab" id="tab-producao" onclick="navigate('producao')">02 · Produção Montagem 03</button></div>
<section class="panel"><div class="filters"><div><label for="year">Ano</label><input id="year" type="number" min="1900" max="2100" step="1" style="width:110px;min-width:100px"></div><div><label for="month">Mês</label><select id="month"></select></div><div><label for="search">Pesquisar código ou descrição</label><input id="search" type="search" placeholder="Digite código, descrição ou grupo"></div><button class="primary" onclick="navigate()">Atualizar relatório</button><button onclick="exportCsv()">Exportar CSV</button></div></section>
<section class="panel"><div class="title-row"><div><h2 id="report-title"></h2><div class="muted" id="report-subtitle"></div></div><span class="pill" id="status"></span></div>
<div class="metrics"><div class="metric"><label>Produtos encontrados</label><strong id="count">—</strong></div><div class="metric"><label id="total-title">Total do período</label><strong id="total">—</strong></div><div class="metric"><label>Período</label><strong id="period">—</strong></div></div>
<div class="toolbar"><div class="muted" id="source"></div><div><button onclick="scrollDates(-1)">← Datas anteriores</button><button onclick="scrollDates(1)">Datas seguintes →</button></div></div>
<div class="tablewrap" id="tablewrap"><table id="report"></table></div><footer id="footnote"></footer></section><div class="notice" id="notice"></div>
<section id="diagnostic" class="panel hidden"><div class="title-row"><strong>Diagnóstico SQL · v2.2</strong><button onclick="copyDiagnostic()">Copiar diagnóstico</button></div><pre id="diagnostic-text" style="white-space:pre-wrap;overflow-wrap:anywhere"></pre></section></main>
<script>
window.HAIALA_BOOT={rel:"<%= tela %>",ano:<%= ano %>,mes:<%= mes %>,hoje:"<%= hoje.toString() %>",rows:<%= payload %>,erro:"<%= jsonEsc(erro) %>"};
</script>
<script>
const B=window.HAIALA_BOOT,MONTHS=['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'];
const el=id=>document.getElementById(id),fmt=n=>new Intl.NumberFormat('pt-BR',{maximumFractionDigits:3}).format(n),esc=s=>String(s??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const days=Array.from({length:new Date(B.ano,B.mes,0).getDate()},(_,i)=>i+1);
let visible=[];
function navigate(report){const a=Number(el('year').value),m=Number(el('month').value);if(!Number.isInteger(a)||a<1900||a>2100||!Number.isInteger(m)||m<1||m>12){alert('Informe um ano entre 1900 e 2100 e um mês válido.');return;}
 const url=new URL(window.location.href);url.searchParams.set('rel',report||B.rel);url.searchParams.set('ano',String(a));url.searchParams.set('mes',String(m));window.location.assign(url.toString());}
(function init(){el('year').value=B.ano;el('month').innerHTML=MONTHS.map((s,i)=>`<option value="${i+1}">${s}</option>`).join('');el('month').value=B.mes;el('year').addEventListener('change',()=>navigate());el('month').addEventListener('change',()=>navigate());el('search').addEventListener('input',render);el('tab-'+B.rel).classList.add('active');el('report-title').textContent=B.rel==='estoque'?'Relatório 01 — Estoque diário de perfis':'Relatório 02 — Produção diária Montagem 03';el('report-subtitle').textContent=B.rel==='estoque'?'Grupo 06.00.000.00 · Empresa 1 · histórico reconstruído':'Setor de Produção 8 · SQL do analista de TI';el('total-title').textContent=B.rel==='estoque'?'Saldo no último dia disponível':'Produção total no mês';el('period').textContent=MONTHS[B.mes-1]+'/'+B.ano;
if(B.erro){el('diagnostic').classList.remove('hidden');el('diagnostic-text').textContent='Versão: v2.2\nRelatório: '+B.rel+'\nCompetência: '+B.mes+'/'+B.ano+'\nErro Oracle/JSP: '+B.erro;}render();})();
function render(){const search=el('search').value.trim().toLocaleLowerCase('pt-BR');visible=B.rows.filter(r=>[r.codigo,r.descricao,r.grupoFilho,r.grupoPai,r.grupoAvo,r.grupoRaiz].some(s=>String(s||'').toLocaleLowerCase('pt-BR').includes(search)));
const maxDate=B.hoje, key=d=>`${B.ano}-${String(B.mes).padStart(2,'0')}-${String(d).padStart(2,'0')}`;
const totalFor=d=>visible.reduce((s,r)=>s+(Number(r.valores?.[d])||0),0);
const lastDay=days.filter(d=>key(d)<=maxDate).pop();
const total=B.rel==='estoque'?(lastDay?totalFor(lastDay):null):visible.reduce((s,r)=>s+(Number(r.totalMes)||0),0);
el('count').textContent=fmt(visible.length);el('total').textContent=total==null?'—':fmt(total);el('status').textContent=B.erro?'Erro SQL — ver diagnóstico':visible.length?'Dados do Sankhya':'Sem registros';el('status').classList.toggle('connected',!B.erro&&visible.length>0);
let h='<thead><tr><th>COD</th><th>DESCRIÇÃO</th>'+days.map(d=>`<th class="number">${String(d).padStart(2,'0')}/${String(B.mes).padStart(2,'0')}</th>`).join('')+'<th class="group-col">GRUPO FILHO</th><th class="group-col">GRUPO PAI</th><th class="group-col">GRUPO AVÔ</th><th class="group-col">GRUPO RAIZ</th></tr></thead><tbody>';
for(const r of visible){h+=`<tr><td>${esc(r.codigo)}</td><td title="${esc(r.descricao)}">${esc(r.descricao)}</td>`+days.map(d=>{const v=r.valores?.[d];return `<td class="number ${v==null?'zero':''}">${v==null?'—':fmt(Number(v))}</td>`}).join('')+[r.grupoFilho,r.grupoPai,r.grupoAvo,r.grupoRaiz].map(g=>`<td class="group-col" title="${esc(g||'')}">${esc(g||'—')}</td>`).join('')+'</tr>';}
if(!visible.length)h+=`<tr><td colspan="${days.length+6}" style="padding:24px;text-align:center">${B.erro?'Consulta não executada — consulte diagnóstico':'Sem registros para o período selecionado'}</td></tr>`;
h+='</tbody>';
if(visible.length){h+='<tfoot><tr><td colspan="2">TOTAL</td>'+days.map(d=>`<td class="number">${visible.some(r=>r.valores?.[d]!=null)?fmt(totalFor(d)):'—'}</td>`).join('')+'<td colspan="4"></td></tr></tfoot>';}
el('report').innerHTML=h;
el('source').textContent=`${fmt(visible.length)} SKU(s) · ${days.length} dias · consulta da competência ${String(B.mes).padStart(2,'0')}/${B.ano}`;
el('footnote').textContent=B.rel==='estoque'?'Fonte: SQL do analista (TGFEST + TGFESE). Saldo histórico reconstruído, sujeito à conciliação com o estoque oficial.':'Fonte: SQL do analista (TPRAPF.QTD, TPRAPO.DHAPO). XSETOR=8 (Montagem 03).';
el('notice').textContent=B.rel==='estoque'?'Saldo histórico estimado pela reversão das movimentações posteriores, conforme SQL do analista. Datas futuras não são exibidas. Verificar conciliação antes do uso gerencial.':'Produção por data efetiva de apontamento, conforme SQL do analista. Dias sem produção apontada são exibidos como zero; dias futuros ficam sem valor.';
}
function scrollDates(dir){el('tablewrap').scrollBy({left:dir*520,behavior:'smooth'});}
function copyDiagnostic(){const v=el('diagnostic-text').textContent;if(navigator.clipboard?.writeText)navigator.clipboard.writeText(v);else prompt('Copie:',v);}
function exportCsv(){const cols=['COD','DESCRIÇÃO',...days.map(d=>String(d).padStart(2,'0')+'/'+String(B.mes).padStart(2,'0')),'GRUPO FILHO','GRUPO PAI','GRUPO AVÔ','GRUPO RAIZ'];let values=[cols,...visible.map(r=>[r.codigo,r.descricao,...days.map(d=>r.valores?.[d]??''),r.grupoFilho||'',r.grupoPai||'',r.grupoAvo||'',r.grupoRaiz||''])];const csv='\ufeff'+values.map(row=>row.map(v=>'"'+String(v).replace(/"/g,'""')+'"').join(';')).join('\r\n');const a=document.createElement('a');const obj=URL.createObjectURL(new Blob([csv],{type:'text/csv;charset=utf-8'}));a.href=obj;a.download=`HAIALA_${B.rel}_v2_2_${B.ano}_${String(B.mes).padStart(2,'0')}.csv`;a.click();setTimeout(()=>URL.revokeObjectURL(obj),500);}
</script></body></html>