<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>

<c:choose>
<c:when test="${param.action == 'execSql'}">
  <% response.setContentType("application/json;charset=UTF-8"); %>
  <c:catch var="errSql">
    <snk:query var="resQuery">
      ${param.sql}
    </snk:query>
  </c:catch>
  <c:choose>
    <c:when test="${not empty errSql}">
      {"status": "error", "message": "<c:out value="${errSql.message}"/>"}
    </c:when>
    <c:otherwise>
      <%
        try {
          javax.servlet.jsp.jstl.sql.Result res = (javax.servlet.jsp.jstl.sql.Result) pageContext.getAttribute("resQuery");
          if (res == null) {
            out.print("{\"status\":\"ok\",\"rows\":[]}");
          } else {
            StringBuilder sb = new StringBuilder();
            sb.append("{\"status\":\"ok\",\"columns\":[");
            String[] cols = res.getColumnNames();
            for (int i = 0; i < cols.length; i++) {
              if (i > 0) sb.append(",");
              sb.append("\"").append(cols[i]).append("\"");
            }
            sb.append("],\"rows\":[");
            Object[][] rows = res.getRowsByIndex();
            for (int i = 0; i < rows.length; i++) {
              if (i > 0) sb.append(",");
              sb.append("[");
              for (int j = 0; j < rows[i].length; j++) {
                if (j > 0) sb.append(",");
                Object val = rows[i][j];
                if (val == null) {
                  sb.append("null");
                } else if (val instanceof Number || val instanceof Boolean) {
                  sb.append(val);
                } else {
                  String s = val.toString()
                    .replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\n", "\\n")
                    .replace("\r", "\\r");
                  sb.append("\"").append(s).append("\"");
                }
              }
              sb.append("]");
            }
            sb.append("]}");
            out.print(sb.toString());
          }
        } catch (Exception e) {
          out.print("{\"status\":\"error\",\"message\":\"" + e.toString().replace("\"", "\\\"") + "\"}");
        }
      %>
    </c:otherwise>
  </c:choose>
</c:when>
<c:when test="${param.action == 'getSeqapa'}">
  <% response.setContentType("application/json"); %>
  <snk:query var="seqQuery">
    SELECT MAX(SEQAPA) AS SEQAPA FROM TPRAPA WHERE NUAPO = ${param.nuapo} AND CODPRODPA = ${param.codprod}
  </snk:query>
  {"seqapa": "${seqQuery.rows[0].SEQAPA}"}
</c:when>
<c:otherwise>

<c:catch var="errMtp">
    <snk:query var="mtpQuery">
      SELECT CODMTP, DESCRICAO FROM TPRMTP WHERE ATIVO = 'S' ORDER BY DESCRICAO
    </snk:query>
</c:catch>

<c:if test="${not empty param.nroOp}">
  <c:catch var="errOp">
    <snk:query var="opQuery">
      SELECT 
        IPA.CODPRODPA, 
        PRO.DESCRPROD, 
        PRC.IDIPROC, 
        PRC.DHINST, 
        IPA.NROLOTE, 
        IPA.QTDPRODUZIR,
        ATV.IDIATV,
        ATV.IDEFX,
        (CASE 
          WHEN ATV.DHACEITE IS NOT NULL AND (
            SELECT COUNT(1) 
            FROM TPREIATV 
            WHERE IDIATV = ATV.IDIATV 
              AND TIPO IN ('P', 'T', 'S') 
              AND DHFINAL IS NULL
          ) > 0 THEN 'P'
          WHEN ATV.CODEXEC IS NULL AND ATV.DHACEITE IS NULL THEN 'G'
          WHEN ATV.CODEXEC IS NOT NULL AND ATV.DHACEITE IS NOT NULL AND ATV.DHINICIO IS NULL THEN 'A'
          WHEN ATV.DHINICIO IS NOT NULL AND ATV.DHFINAL IS NULL THEN 'I'
          WHEN ATV.DHFINAL IS NOT NULL THEN 'F'
          ELSE NULL 
        END) AS SITUACAO_CALCULADA
      FROM TPRIPROC PRC
      LEFT JOIN TPRIPA IPA ON PRC.IDIPROC = IPA.IDIPROC
      LEFT JOIN TGFPRO PRO ON IPA.CODPRODPA = PRO.CODPROD
      LEFT JOIN TPRIATV ATV ON ATV.IDIPROC = PRC.IDIPROC
      WHERE PRC.IDIPROC = ${param.nroOp}
    </snk:query>
  </c:catch>
</c:if>

<c:if test="${not empty opQuery.rows and not empty opQuery.rows[0].IDIATV}">
  <c:catch var="errApo">
    <snk:query var="apoQuery">
      SELECT 
        APO.NUAPO,
        APA.QTDAPONTADA,
        APO.AD_QTDPESSOAS AS QTDPESSOAS,
        APO.AD_DHINICIO AS DHINC,
        APO.AD_DHFINAL AS DHFIN,
        APO.AD_TURNO AS NOMETURNO,
        APF.NUNOTA,
        APO.SITUACAO
      FROM TPRAPO APO
      LEFT JOIN TPRAPA APA ON APO.NUAPO = APA.NUAPO
      LEFT JOIN TPRAPF APF ON APO.NUAPO = APF.NUAPO
      WHERE APO.IDIATV = ${opQuery.rows[0].IDIATV}
      ORDER BY APO.AD_DHINICIO DESC
    </snk:query>
  </c:catch>
</c:if>

<c:if test="${not empty param.nroOp}">
  <c:catch var="errCnc">
    <snk:query var="cncQuery">
      SELECT 
        C.SEQ,
        C.IDIPROC,
        C.DTINICIO,
        C.DTFINAL,
        C.QTDPESSOAS,
        C.CODMTP,
        M.DESCRICAO AS MOTIVO_DESC
      FROM AD_CNC C
      LEFT JOIN TPRMTP M ON C.CODMTP = M.CODMTP
      WHERE C.IDIPROC = ${param.nroOp}
      ORDER BY C.SEQ DESC
    </snk:query>
  </c:catch>

  <c:catch var="errQuali">
    <snk:query var="qualiQuery">
      SELECT 
        Q.SEQUENCIAL,
        Q.IDIPROC,
        Q.ANOMALIA,
        Q.QTDAMOSTRA,
        Q.QTDREPROVADA,
        Q.QTDRETIDA,
        Q.QTDNOTIFICADA,
        Q.SETOR_DEF
      FROM AD_QUALIHAIALA Q
      WHERE Q.IDIPROC = ${param.nroOp}
      ORDER BY Q.SEQUENCIAL DESC
    </snk:query>
  </c:catch>
</c:if>

<c:catch var="errSetor">
  <snk:query var="setorMaintQuery">
    SELECT CODSETOR, SETDESCRICAO FROM AD_MSETOR ORDER BY SETDESCRICAO
  </snk:query>
</c:catch>

<c:catch var="errItens">
  <snk:query var="itensMaintQuery">
    SELECT CODITEM, CODMAQ, DESCMAQUINA, CODSETOR FROM AD_MITENS WHERE STATUS != 4 ORDER BY DESCMAQUINA
  </snk:query>
</c:catch>

<c:catch var="errTecnicos">
  <snk:query var="tecMaintQuery">
    SELECT CODTEC, TEC_NOME FROM AD_MCADTECNICO WHERE ATIVO = 'S' ORDER BY TEC_NOME
  </snk:query>
</c:catch>

<script>

    function applyDateTimeMask(el) {
        let v = el.value.replace(/\D/g, "");
        if (v.length > 12) v = v.substring(0, 12);
        
        let out = "";
        if (v.length > 0) out += v.substring(0, 2);
        if (v.length > 2) out += "/" + v.substring(2, 4);
        if (v.length > 4) out += "/" + v.substring(4, 8);
        if (v.length > 8) out += " " + v.substring(8, 10);
        if (v.length > 10) out += ":" + v.substring(10, 12);
        
        el.value = out;
    }

  // ==========================================
  // INJEÇÃO DIRETA DO BANCO (SERVER-SIDE)
  // ==========================================
  window.DB_SERIES = [];
</script>

<c:if test="${not empty opQuery.rows}">
  <c:set var="myIdiproc" value="${opQuery.rows[0].IDIPROC}" />
  <c:set var="myCodprod" value="${opQuery.rows[0].CODPRODPA}" />
</c:if>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>Apontamento Mobile - Sankhya</title>
  <snk:load />
  
  <style>
    /* ==========================================================================
       DESIGN SYSTEM & VARIABLES
       ========================================================================== */
    :root {
      --slate-50: #f8fafc;
      --slate-100: #f1f5f9;
      --slate-200: #e2e8f0;
      --slate-300: #cbd5e1;
      --slate-400: #94a3b8;
      --slate-500: #64748b;
      --slate-600: #475569;
      --slate-700: #334155;
      --slate-800: #1e293b;
      --slate-900: #0f172a;
      
      --sky-500: #0ea5e9;
      --sky-600: #0284c7;
      --sky-700: #0369a1;
      
      --emerald-500: #10b981;
      --emerald-600: #059669;
      --emerald-700: #047857;
      
      --amber-400: #fbbf24;
      --amber-500: #f59e0b;
      --amber-600: #d97706;
      
      --orange-500: #f97316;
      --orange-600: #ea580c;
      --orange-700: #c2410c;
      
      --rose-400: #fb7185;
      --rose-500: #f43f5e;
      --rose-800: #9f1239;
      --rose-950: #4c0519;
      
      --indigo-900: #312e81;
      
      --purple-400: #c084fc;
      --purple-500: #a855f7;
      --purple-600: #9333ea;
      --purple-700: #7e22ce;
      
      --glass-bg: rgba(30, 41, 59, 0.7);
      --glass-border: rgba(255, 255, 255, 0.1);
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      -webkit-tap-highlight-color: transparent;
    }

    body {
      background-color: var(--slate-900);
      color: white;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
      height: 100vh;
      width: 100vw;
      overflow: hidden; /* Mobile app feel */
    }

    /* ==========================================================================
       UTILITIES & ANIMATIONS
       ========================================================================== */
    .hidden { display: none !important; }
    
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }
    
    @keyframes slideIn {
      from { transform: translateX(100%); opacity: 0; }
      to { transform: translateX(0); opacity: 1; }
    }
    
    @keyframes pulse-dot {
      0%, 100% { opacity: 1; transform: scale(1); }
      50% { opacity: 0.5; transform: scale(0.8); }
    }

    .animate-fade-in {
      animation: fadeIn 0.4s ease-out forwards;
    }

    /* ==========================================================================
       LOADER OVERLAY
       ========================================================================== */
    #loader-overlay {
      position: fixed;
      top: 0; left: 0; width: 100%; height: 100%;
      background: rgba(15, 23, 42, 0.7);
      backdrop-filter: blur(4px);
      z-index: 99999;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      gap: 16px;
    }
    
    .spinner {
      width: 40px;
      height: 40px;
      border: 4px solid rgba(255, 255, 255, 0.1);
      border-left-color: var(--sky-500);
      border-radius: 50%;
      animation: spin 1s linear infinite;
    }
    
    @keyframes spin {
      to { transform: rotate(360deg); }
    }
    
    .loader-text {
      color: white;
      font-weight: 600;
      font-size: 14px;
      letter-spacing: 0.5px;
    }

    /* ==========================================================================
       APP WRAPPER (Mobile Frame)
       ========================================================================== */
    #app-container {
      display: flex;
      flex-direction: column;
      height: 100%;
      width: 100%;
      max-width: 480px; /* Limit width on desktop to look like mobile */
      margin: 0 auto;
      background: var(--slate-900);
      position: relative;
    }

    /* ==========================================================================
       HEADER (Navbar)
       ========================================================================== */
    .app-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 16px 20px;
      background: var(--glass-bg);
      backdrop-filter: blur(12px);
      border-bottom: 1px solid var(--glass-border);
      position: sticky;
      top: 0;
      z-index: 10;
    }

    .app-header-title {
      font-size: 16px;
      font-weight: 600;
      color: var(--slate-50);
      letter-spacing: 0.5px;
    }

    .btn-back {
      background: none;
      border: none;
      color: var(--slate-400);
      font-size: 14px;
      display: flex;
      align-items: center;
      gap: 6px;
      cursor: pointer;
      padding: 8px 12px 8px 0;
      transition: color 0.2s;
    }

    .btn-back:hover, .btn-back:active {
      color: white;
    }

    .profile-avatar {
      width: 32px;
      height: 32px;
      border-radius: 50%;
      background: linear-gradient(135deg, var(--sky-500), var(--indigo-900));
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: bold;
      font-size: 12px;
      color: white;
      border: 2px solid var(--slate-700);
    }

    /* ==========================================================================
       SCREENS
       ========================================================================== */
    .screen {
      flex: 1;
      overflow-y: auto;
      padding: 24px;
      padding-bottom: 40px;
    }

    /* Launcher Menu */
    .client-logo-card {
      background: white;
      border-radius: 20px;
      padding: 20px;
      display: flex;
      flex-direction: column;
      align-items: center;
      box-shadow: 0 4px 20px rgba(0,0,0,0.1);
      margin-bottom: 32px;
    }

    .logo-graphics {
      display: flex;
      align-items: center;
      margin-bottom: 16px;
    }

    .brand-name {
      display: flex;
      flex-direction: column;
      color: var(--indigo-900);
    }
    
    .brand-name-title {
      font-size: 28px;
      font-weight: 900;
      line-height: 1;
    }
    
    .brand-name-subtitle {
      font-size: 8px;
      letter-spacing: 0.2em;
      color: var(--slate-500);
      font-weight: bold;
      margin-top: 4px;
    }

    .logo-separator {
      height: 32px;
      width: 1px;
      background: var(--slate-300);
      margin: 0 16px;
    }

    .anos-emblem {
      display: flex;
      align-items: center;
      position: relative;
    }
    
    .anos-number {
      font-size: 32px;
      font-weight: 900;
      color: var(--indigo-900);
      line-height: 1;
    }

    .bottom-bar-label {
      width: 100%;
      background: var(--slate-50);
      border: 1px solid var(--slate-200);
      border-radius: 12px;
      padding: 8px;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
    }

    .pulse-indicator {
      width: 8px;
      height: 8px;
      background: var(--emerald-500);
      border-radius: 50%;
      animation: pulse-dot 1.5s infinite;
    }

    .label-text {
      font-size: 11px;
      font-weight: 700;
      color: var(--slate-700);
      text-transform: uppercase;
      letter-spacing: 0.05em;
    }

    /* Menu Buttons */
    .menu-buttons {
      display: flex;
      flex-direction: column;
      gap: 20px;
    }

    .launcher-btn {
      width: 100%;
      padding: 16px 20px;
      border-radius: 16px;
      border: none;
      display: flex;
      align-items: center;
      justify-content: space-between;
      cursor: pointer;
      transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
      position: relative;
      overflow: hidden;
    }

    .launcher-btn:active {
      transform: translateY(4px);
      box-shadow: none !important;
    }

    .launcher-btn-content {
      display: flex;
      align-items: center;
      gap: 12px;
      font-size: 14px;
      font-weight: 700;
      color: white;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .launcher-btn-badge {
      font-size: 10px;
      font-family: monospace;
      font-weight: 700;
      padding: 4px 8px;
      border-radius: 100px;
      color: white;
    }

    /* specific buttons */
    .btn-production {
      background: var(--sky-600);
      border: 1px solid var(--sky-700);
      box-shadow: 0 4px 0 0 var(--sky-700);
    }
    .btn-production .launcher-btn-badge { background: var(--sky-700); }
    .btn-production:hover { background: var(--sky-500); }

    .btn-quality {
      background: var(--emerald-600);
      border: 1px solid var(--emerald-700);
      box-shadow: 0 4px 0 0 var(--emerald-700);
    }
    .btn-quality .launcher-btn-badge { background: var(--emerald-700); }
    .btn-quality:hover { background: var(--emerald-500); }

    .btn-maintenance {
      background: var(--purple-500);
      border: 1px solid var(--purple-600);
      box-shadow: 0 4px 0 0 var(--purple-600);
    }
    .btn-maintenance .launcher-btn-badge { background: var(--purple-600); }
    .btn-maintenance:hover { background: var(--purple-400); }
    .btn-labels {
      background: var(--orange-600);
      border: 1px solid var(--orange-700);
      box-shadow: 0 4px 0 0 var(--orange-700);
    }
    .btn-labels .launcher-btn-badge { background: var(--orange-700); }
    .btn-labels:hover { background: var(--orange-500); }

    .btn-disabled {
      background: var(--slate-700);
      border: 1px solid var(--slate-800);
      box-shadow: 0 4px 0 0 var(--slate-800);
      cursor: not-allowed;
      opacity: 0.6;
    }
    .btn-disabled .launcher-btn-badge { background: var(--slate-600); }
    .btn-disabled:active {
      transform: none !important;
      box-shadow: 0 4px 0 0 var(--slate-800) !important;
    }

    /* ==========================================================================
       PRODUCTION MODULE LIGHT THEME (From Image)
       ========================================================================== */
    .prod-container { background: var(--slate-50); border-radius: 12px; overflow: hidden; padding-bottom: 24px; }
    .prod-card { background: white; border: 1px solid var(--slate-200); border-radius: 12px; padding: 16px; margin: 16px 16px 0 16px; box-shadow: 0 2px 4px rgba(0,0,0,0.02); }
    
    .prod-op-row { display: flex; align-items: center; gap: 12px; }
    .prod-op-input-wrapper { flex: 1; display: flex; align-items: center; background: var(--slate-50); border: 1px solid var(--slate-300); border-radius: 6px; padding: 0 12px; }
    .prod-op-label { font-size: 13px; font-weight: 800; color: var(--slate-500); white-space: nowrap; margin-right: 12px; }
    .prod-op-input { border: none; background: transparent; padding: 12px 0; width: 100%; font-size: 16px; font-weight: 800; color: var(--slate-800); outline: none; }
    .prod-btn-blue { background: #1d4ed8; color: white; border: none; border-radius: 6px; padding: 10px 16px; font-weight: 700; font-size: 14px; cursor: pointer; }
    
    .prod-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 16px 12px; margin-bottom: 8px;}
    .prod-grid-item { display: flex; flex-direction: column; gap: 4px; }
    .prod-grid-item.full { grid-column: 1 / -1; }
    .prod-lbl { font-size: 11px; font-weight: 800; color: var(--slate-400); text-transform: uppercase; }
    .prod-val { font-size: 13px; font-weight: 800; color: var(--slate-800); }
    
    .prod-actions-bar { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 10px; margin: 16px; }
    .prod-btn-outline { background: white; border: 1px solid var(--slate-300); border-radius: 8px; padding: 8px 6px; display: flex; align-items: center; justify-content: center; gap: 6px; font-size: 13px; font-weight: 700; color: var(--slate-700); cursor: pointer; box-shadow: 0 1px 2px rgba(0,0,0,0.02); }
    .prod-btn-outline svg { width: 16px; height: 16px; flex-shrink: 0; }
    
    .prod-sec-header { display: flex; align-items: flex-end; justify-content: space-between; border-bottom: 2px solid var(--emerald-600); padding-bottom: 6px; margin-bottom: 16px; }
    .prod-sec-title { font-size: 14px; font-weight: 800; color: var(--slate-800); text-transform: uppercase; }
    .prod-badge { background: #dcfce7; color: #166534; font-size: 11px; font-weight: 800; padding: 4px 8px; border-radius: 4px; border: 1px solid #bbf7d0;}
    
    .prod-sub-actions { display: flex; justify-content: flex-end; gap: 8px; margin-bottom: 16px; }
    .prod-btn-gray { background: var(--slate-50); border: 1px solid var(--slate-300); color: var(--slate-700); padding: 8px 14px; border-radius: 6px; font-size: 13px; font-weight: 700; display: flex; align-items: center; gap: 6px;}
    .prod-btn-green { background: var(--emerald-600); border: none; color: white; padding: 8px 14px; border-radius: 6px; font-size: 13px; font-weight: 700; display: flex; align-items: center; gap: 6px;}
    
    .prod-form { background: var(--slate-50); border-radius: 8px; padding: 12px; margin-bottom: 16px; display: flex; flex-direction: column; gap: 12px; }
    .prod-form-grid { display: grid; grid-template-columns: minmax(0, 1fr) minmax(0, 1fr); gap: 12px; }
    .prod-form-item { display: flex; flex-direction: column; gap: 6px; }
    .prod-form-lbl { font-size: 12px; font-weight: 800; color: var(--slate-500); }
    .prod-form-input { border: 1px solid var(--slate-300); border-radius: 6px; padding: 8px 10px; font-size: 14px; font-weight: 600; color: var(--slate-800); width: 100%; min-width: 0; outline: none; background: white; }
    
    .prod-list { display: flex; flex-direction: column; gap: 8px; }
    .prod-item { background: white; border: 1px solid var(--slate-200); border-radius: 8px; padding: 12px; display: flex; justify-content: space-between; align-items: center; }
    .prod-item-info { font-size: 12px; color: var(--slate-500); display: flex; flex-direction: column; gap: 4px; }
    .prod-item-val { font-size: 13px; font-weight: 800; color: var(--slate-800); }
    .prod-item-tag { background: var(--slate-200); padding: 2px 6px; border-radius: 4px; font-size: 10px; font-weight: 700; color: var(--slate-600); margin-left: 4px;}
    .prod-btn-print { color: #0284c7; background: #e0f2fe; border: none; padding: 8px; border-radius: 6px; display: flex; align-items: center; justify-content: center; cursor: pointer; }
    .prod-btn-del { color: #ef4444; background: #fee2e2; border: none; padding: 8px; border-radius: 6px; display: flex; align-items: center; justify-content: center; cursor: pointer; }

    /* Icons (Inline SVG replacement for lucide) */
    .icon {
      width: 22px;
      height: 22px;
      stroke: currentColor;
      stroke-width: 2;
      stroke-linecap: round;
      stroke-linejoin: round;
      fill: none;
    }

    /* ==========================================================================
       TOAST NOTIFICATIONS
       ========================================================================== */
    #toast-container {
      position: fixed;
      top: 16px;
      right: 16px;
      left: 16px;
      z-index: 99999;
      display: flex;
      flex-direction: column;
      gap: 8px;
      pointer-events: none;
      align-items: center;
    }

    .toast {
      pointer-events: auto;
      padding: 12px 16px;
      border-radius: 12px;
      font-size: 13px;
      font-weight: 600;
      display: flex;
      align-items: flex-start;
      gap: 12px;
      max-width: 400px;
      width: 100%;
      box-shadow: 0 10px 25px rgba(0,0,0,0.2);
      animation: slideIn 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    }

    .toast.success { background: rgba(2, 44, 34, 0.95); color: #a7f3d0; border: 1px solid #065f46; }
    .toast.error { background: rgba(76, 5, 25, 0.95); color: #fecdd3; border: 1px solid #9f1239; }
    .toast.info { background: rgba(15, 23, 42, 0.95); color: #bae6fd; border: 1px solid #334155; }
    
    /* ==========================================================================
       MAINTENANCE MODULE (LIGHT THEME)
       ========================================================================== */
    .maint-container {
      background: white;
      border-radius: 12px;
      padding: 16px;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
      margin-bottom: 24px;
      color: var(--slate-800);
    }
    .btn-maint-large {
      width: 100%;
      padding: 16px;
      border-radius: 16px;
      border: none;
      font-weight: 800;
      font-size: 16px;
      color: white;
      margin-bottom: 16px;
      cursor: pointer;
      text-align: center;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }
    .btn-maint-open { background: #059669; }
    .btn-maint-close { background: #f97316; }
    
    .maint-form-group { margin-bottom: 12px; }
    .maint-label {
      display: block;
      font-size: 13px;
      font-weight: 700;
      color: var(--slate-600);
      margin-bottom: 4px;
    }
    .maint-input-row { display: flex; gap: 8px; }
    .maint-input {
      flex: 1;
      width: 100%;
      padding: 10px;
      border: 1px solid var(--slate-300);
      border-radius: 6px;
      font-size: 14px;
      color: var(--slate-800);
      background: #fff;
      outline: none;
    }
    .maint-input:focus { border-color: #059669; }
    .maint-input[readonly] { background: #f1f5f9; color: var(--slate-600); }
    .maint-btn-search {
      padding: 0 14px;
      background: #f1f5f9;
      border: 1px solid var(--slate-300);
      border-radius: 6px;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      color: var(--slate-600);
    }
    .maint-checkbox-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 8px;
      background: #f8fafc;
      padding: 12px;
      border-radius: 8px;
      border: 1px solid var(--slate-200);
      margin-bottom: 12px;
    }
    .maint-checkbox-item {
      display: flex;
      align-items: center;
      justify-content: space-between;
      font-size: 13px;
      font-weight: 500;
      color: var(--slate-700);
    }
    .maint-checkbox-item input {
      width: 18px;
      height: 18px;
      accent-color: #059669;
    }
    .maint-btn-red {
      background: #ef4444;
      color: white;
      padding: 6px 12px;
      border: none;
      font-weight: bold;
      text-align: center;
      border-radius: 6px;
      font-size: 11px;
      cursor: pointer;
    }
    .maint-table {
      width: 100%;
      border-collapse: collapse;
      font-size: 10px;
      margin-bottom: 16px;
    }
    .maint-table th, .maint-table td {
      border: 1px solid #cbd5e1;
      padding: 6px 4px;
      text-align: left;
    }
    .maint-table th { background: #f8fafc; font-weight: 700; color: var(--slate-600); text-transform: uppercase; }
    .maint-action-row { display: flex; gap: 8px; margin-top: 16px; }
    .maint-btn-save {
      flex: 2;
      background: #059669;
      color: white;
      padding: 14px;
      border: none;
      border-radius: 8px;
      font-weight: bold;
      font-size: 15px;
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 6px;
    }
    .maint-btn-save.orange { background: #f97316; }
    .maint-btn-discard {
      flex: 1;
      background: #f8fafc;
      color: var(--slate-700);
      border: 1px solid var(--slate-300);
      padding: 14px;
      border-radius: 8px;
      font-weight: bold;
      font-size: 15px;
    }
    /* ==========================================================================
       MODULE TEMPLATE (Placeholder UI for Submodules)
       ========================================================================== */
    .module-card {
      background: var(--slate-800);
      border: 1px solid var(--slate-700);
      border-radius: 16px;
      padding: 20px;
      margin-bottom: 16px;
    }
    
    .module-title {
      font-size: 18px;
      font-weight: 700;
      margin-bottom: 16px;
      color: white;
    }
    
    .form-group {
      margin-bottom: 16px;
    }
    
    .form-label {
      display: block;
      font-size: 12px;
      color: var(--slate-400);
      margin-bottom: 8px;
      font-weight: 600;
    }
    
    .form-input {
      width: 100%;
      background: var(--slate-900);
      border: 1px solid var(--slate-700);
      color: white;
      padding: 12px 16px;
      border-radius: 12px;
      font-size: 14px;
      outline: none;
      transition: border-color 0.2s;
    }
    
    .form-input:focus {
      border-color: var(--sky-500);
    }
    
    .btn-submit {
      width: 100%;
      padding: 14px;
      border-radius: 12px;
      border: none;
      background: var(--emerald-600);
      color: white;
      font-weight: 700;
      font-size: 14px;
      margin-top: 8px;
      cursor: pointer;
    }
  </style>
</head>
<body>

  <!-- Toast Container -->
  <div id="toast-container"></div>

  <!-- Global Loader -->
  <div id="loader-overlay" class="hidden">
    <div class="spinner"></div>
    <div class="loader-text" id="loader-text">Processando...</div>
  </div>

  <div id="app-container">
    
    <!-- HEADER -->
    <header class="app-header">
      <div style="display:flex; align-items:center;">
        <button id="btn-back" class="btn-back hidden" onclick="navigate('MENU')">
          <svg class="icon" viewBox="0 0 24 24"><path d="m15 18-6-6 6-6"/></svg>
          <span>Voltar</span>
        </button>
        <div id="header-title" class="app-header-title">Menu Principal</div>
      </div>
      <div class="profile-avatar">CA</div>
    </header>

    <!-- MAIN CONTENT -->
    <main class="screen" id="main-screen">
      
      <!-- SCREEN: MENU (Launcher) -->
      <div id="screen-MENU" class="animate-fade-in">
        
        <!-- Logo Card -->
        <div class="client-logo-card">
          <div class="logo-graphics">
            <img src="data:image/webp;base64,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" style="max-height: 120px; width: 100%; object-fit: contain;" />
          </div>
          
          <div class="bottom-bar-label">
            <div class="pulse-indicator"></div>
            <span class="label-text">Coletor de Produção</span>
          </div>
        </div>

        <!-- Launcher Buttons -->
        <div class="menu-buttons">
          
          <button class="launcher-btn btn-production" onclick="navigate('PRODUCTION')">
            <div class="launcher-btn-content">
              <svg class="icon" viewBox="0 0 24 24"><path d="M9 5H7a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-2"/><rect width="8" height="4" x="8" y="3" rx="1" ry="1"/><path d="M9 14h6"/><path d="M9 10h6"/></svg>
              <span>Apontamento de Produção</span>
            </div>
            <span class="launcher-btn-badge">POS</span>
          </button>

          <button class="launcher-btn btn-quality" onclick="navigate('QUALITY')">
            <div class="launcher-btn-content">
              <svg class="icon" viewBox="0 0 24 24"><polyline points="9 11 12 14 22 4"/><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"/></svg>
              <span>Qualidade e NCs</span>
            </div>
            <span class="launcher-btn-badge">QA</span>
          </button>

          <button class="launcher-btn btn-maintenance" onclick="navigate('MAINTENANCE')">
            <div class="launcher-btn-content">
              <svg class="icon" viewBox="0 0 24 24"><path d="M8.5 14.5A2.5 2.5 0 0 0 11 12c0-1.38-.5-2-1-3-1.072-2.143-.224-4.054 2-6 .5 2.5 2 4.9 4 6.5 2 1.6 3 3.5 3 5.5a7 7 0 1 1-14 0c0-1.153.433-2.294 1-3a2.5 2.5 0 0 0 2.5 2.5z"/></svg>
              <span>Manutenção Industrial</span>
            </div>
            <span class="launcher-btn-badge">OS</span>
          </button>


        </div>
      </div>

      <!-- SCREEN: PRODUCTION (LIGHT THEME MATCHING IMAGE) -->
      <div id="screen-PRODUCTION" class="hidden animate-fade-in" style="margin: -24px; padding-bottom: 24px;">
        <div class="prod-container">
          
          <!-- EXIBIÇÃO DE ERRO DE SQL SE HOUVER -->
          <c:if test="${not empty errMtp}">
            <div style="background: #fee2e2; color: #9f1239; padding: 12px; margin: 16px; border-radius: 8px; font-size: 12px; border: 1px solid #fecdd3;">
              <b>ERRO SQL (Motivos Parada):</b> ${errMtp.message}
            </div>
          </c:if>
          <c:if test="${not empty errOp}">
            <div style="background: #fee2e2; color: #9f1239; padding: 12px; margin: 16px; border-radius: 8px; font-size: 12px; border: 1px solid #fecdd3;">
              <b>ERRO SQL (OP):</b> ${errOp.message}
            </div>
          </c:if>
          <c:if test="${not empty errApo}">
            <div style="background: #fee2e2; color: #9f1239; padding: 12px; margin: 16px; border-radius: 8px; font-size: 12px; border: 1px solid #fecdd3;">
              <b>ERRO SQL (Apontamentos):</b> ${errApo.message}
            </div>
          </c:if>

          <!-- Leitura da OP -->
          <div class="prod-card" style="margin-top: 24px;">
            <div class="prod-op-row">
              <div class="prod-op-input-wrapper">
                <span class="prod-op-label">NRO. OP:</span>
                <input type="number" id="input-nro-op" class="prod-op-input" placeholder="Ex: 4339" value="${param.nroOp}" autofocus onkeypress="if(event.key === 'Enter') lerOP()">
              </div>
              <button class="prod-btn-blue" onclick="lerOP()">Ler</button>
            </div>
          </div>

          <!-- Info OP -->
          <div class="prod-card">
            <div class="prod-grid">
              <c:choose>
                <c:when test="${not empty opQuery.rows}">
                  <c:set var="op" value="${opQuery.rows[0]}" />
                  <input type="hidden" id="val-ideatv" value="${op.IDIATV}">
          <input type="hidden" id="val-idefx" value="${op.IDEFX}">
          <input type="hidden" id="val-idiproc" value="${op.IDIPROC}">
                </c:when>
                <c:otherwise>
                  <c:set var="op" value="${null}" />
                </c:otherwise>
              </c:choose>

              <div class="prod-grid-item">
                <span class="prod-lbl">CÓD. PRODUTO</span>
                <span class="prod-val" id="val-codprod"><c:out value="${op.CODPRODPA}" default="-" /></span>
              </div>
              <div class="prod-grid-item">
                <span class="prod-lbl">NRO. OP: *</span>
                <span class="prod-val" id="val-nroop"><c:out value="${op.IDIPROC}" default="-" /></span>
              </div>

              <div class="prod-grid-item full">
                <span class="prod-lbl">PRODUTO</span>
                <span class="prod-val" id="val-produto" style="line-height: 1.3;"><c:out value="${op.DESCRPROD}" default="-" /></span>
              </div>

              <div class="prod-grid-item">
                <span class="prod-lbl">DH. OP</span>
                <span class="prod-val" id="val-dhop">
                  <c:choose>
                    <c:when test="${not empty op.DHINST}">
                      <c:set var="dh" value="${op.DHINST}" />
                      <c:out value="${fn:substring(dh, 8, 10)}/${fn:substring(dh, 5, 7)}/${fn:substring(dh, 0, 4)} ${fn:substring(dh, 11, 16)}" />
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                  </c:choose>
                </span>
              </div>
              <div class="prod-grid-item">
                <span class="prod-lbl">NRO. LOTE</span>
                <span class="prod-val" id="val-nrolote"><c:out value="${op.NROLOTE}" default="-" /></span>
              </div>

              <div class="prod-grid-item">
                <span class="prod-lbl">QTD.</span>
                <span class="prod-val" id="val-qtd">
                  <c:choose>
                    <c:when test="${not empty op.QTDPRODUZIR}"><c:out value="${op.QTDPRODUZIR}"/> PC</c:when>
                    <c:otherwise>-</c:otherwise>
                  </c:choose>
                </span>
              </div>

              <div class="prod-grid-item">
                <span class="prod-lbl">STATUS</span>
                <span class="prod-val">
                  <c:choose>
                    <c:when test="${op.SITUACAO_CALCULADA == 'P'}"><span class="prod-badge" style="background:#fef08a; color:#854d0e; border-color:#fde047;">Paralisada</span></c:when>
                    <c:when test="${op.SITUACAO_CALCULADA == 'G'}"><span class="prod-badge" style="background:#e2e8f0; color:#475569; border-color:#cbd5e1;">Aguardando</span></c:when>
                    <c:when test="${op.SITUACAO_CALCULADA == 'A'}"><span class="prod-badge" style="background:#bfdbfe; color:#1e40af; border-color:#93c5fd;">Aceita</span></c:when>
                    <c:when test="${op.SITUACAO_CALCULADA == 'I'}"><span class="prod-badge" style="background:#bbf7d0; color:#166534; border-color:#86efac;">Em Andamento</span></c:when>
                    <c:when test="${op.SITUACAO_CALCULADA == 'F'}"><span class="prod-badge" style="background:#d9f99d; color:#3f6212; border-color:#bef264;">Finalizada</span></c:when>
                    <c:otherwise><span class="prod-badge" style="background:#e2e8f0; color:#475569; border-color:#cbd5e1;">Desconhecido</span></c:otherwise>
                  </c:choose>
                </span>
              </div>
            </div>
          </div>

          <!-- MODAL DE PARADA -->
    <div id="modal-parada" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(15, 23, 42, 0.6); z-index:9999; justify-content:center; align-items:center; backdrop-filter: blur(2px);">
      <div style="background:white; padding:24px; border-radius:12px; width:90%; max-width:400px; box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);">
        <h3 style="margin-top:0; color:#0f172a; font-size:18px; font-weight:600; margin-bottom: 16px;">Parada da Atividade</h3>
        
        <div class="prod-form-item">
          <span class="prod-form-lbl">Motivo Parada: *</span>
          <select id="input-parada-motivo" class="prod-form-input" style="appearance: auto;">
            <option value="">Selecione o motivo...</option>
            <c:if test="${empty errMtp}">
              <c:forEach items="${mtpQuery.rows}" var="mtp">
                <option value="${mtp.CODMTP}"><c:out value="${mtp.CODMTP} - ${mtp.DESCRICAO}"/></option>
              </c:forEach>
            </c:if>
          </select>
        </div>
        
        <div class="prod-form-item">
          <span class="prod-form-lbl">Observação:</span>
          <textarea id="input-parada-obs" class="prod-form-input" rows="3" placeholder="Detalhes da parada..."></textarea>
        </div>
        
        <div style="display:flex; justify-content:flex-end; gap:12px; margin-top:24px;">
          <button class="prod-btn-outline" style="padding: 10px 16px; border: none; color: #64748b;" onclick="document.getElementById('modal-parada').style.display='none'">Cancelar</button>
          <button class="prod-btn-green" style="padding: 10px 16px;" onclick="confirmarParada()">Confirmar Parada</button>
        </div>
      </div>
    </div>

    <!-- MODAL DE SÉRIES -->
    <div id="modal-series" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(15, 23, 42, 0.6); z-index:9999; justify-content:center; align-items:center; backdrop-filter: blur(2px);">
      <div style="background:white; padding:24px; border-radius:12px; width:90%; max-width:400px; max-height:80vh; display:flex; flex-direction:column; box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);">
        <h3 style="margin-top:0; color:#0f172a; font-size:18px; font-weight:600; margin-bottom: 8px;">Liberar Séries do Apontamento</h3>
        <p style="color:#64748b; font-size:14px; margin-top:0; margin-bottom:16px;">Selecione as séries geradas para confirmar a injeção no estoque.</p>
        
        <div style="flex:1; overflow-y:auto; border: 1px solid #e2e8f0; border-radius: 8px; padding: 8px;" id="lista-series-container">
            <!-- Lista de series injetada via JS -->
            <div style="text-align:center; padding:20px; color:#94a3b8; font-size:14px;">Buscando séries...</div>
        </div>
        
        <div style="display:flex; justify-content:space-between; align-items:center; margin-top: 16px;">
            <label style="font-size: 14px; color: #475569; font-weight: 600; cursor: pointer; display: flex; align-items: center; gap: 8px;">
                <input type="checkbox" id="checkbox-marcar-todas" style="width: 18px; height: 18px; accent-color: var(--emerald-500); cursor: pointer;" onchange="toggleMarcarTodasSeries(this)">
                Marcar todas
            </label>
            <span style="font-size: 14px; color: #475569; font-weight: 600;">Séries: <span id="contador-series-selecionadas">0</span> / <span id="contador-series-total">0</span></span>
        </div>

        <div style="display:flex; justify-content:flex-end; gap:12px; margin-top:16px;">
          <button class="prod-btn-outline" style="padding: 10px 16px; border: none; color: #64748b;" onclick="document.getElementById('modal-series').style.display='none'">Cancelar</button>
          <button class="prod-btn-green" style="padding: 10px 16px;" onclick="enviarConfirmacaoSeries()">Confirmar Séries</button>
        </div>
        <input type="hidden" id="modal-series-nuapo" value="" />
        <input type="hidden" id="modal-series-ideatv" value="" />
      </div>
    </div>

    <!-- Ações principais -->
          <div class="prod-actions-bar">
            <c:choose>
              <c:when test="${op.SITUACAO_CALCULADA == 'P'}">
                <button class="prod-btn-outline" onclick="alterarStatus('I')">
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polygon points="5 3 19 12 5 21 5 3"/></svg>
                  Continuar
                </button>
              </c:when>
              <c:otherwise>
                <button class="prod-btn-outline" onclick="alterarStatus('I')">
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polygon points="5 3 19 12 5 21 5 3"/></svg>
                  Iniciar
                </button>
              </c:otherwise>
            </c:choose>
            
            <button class="prod-btn-outline" onclick="document.getElementById('modal-parada').style.display='flex'">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="6" y="4" width="4" height="16"/><rect x="14" y="4" width="4" height="16"/></svg>
              Parar
            </button>
            <button class="prod-btn-outline" onclick="alterarStatus('C')">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
              Finalizar
            </button>
          </div>

          <!-- Apontamentos -->
          <div class="prod-card">
            
            <div class="prod-sec-header" style="margin-top: 16px;">
              <span class="prod-sec-title">APONTAMENTOS</span>
            </div>

            <!-- Formulário -->
            <div class="prod-form">
              <div class="prod-form-grid">
                <div class="prod-form-item">
                  <span class="prod-form-lbl">Qtd. apontada</span>
                  <input type="number" id="input-apo-qtd" class="prod-form-input" placeholder="0">
                </div>
                <div class="prod-form-item">
                  <span class="prod-form-lbl">Qtd. Pessoas: *</span>
                  <input type="number" id="input-apo-pessoas" class="prod-form-input" placeholder="0">
                </div>
                <div class="prod-form-item">
                  <span class="prod-form-lbl">Dh. Inicio [P]: *</span>
                  <input type="tel" placeholder="DD/MM/AAAA HH:MM" oninput="applyDateTimeMask(this)" maxlength="16" id="input-apo-inicio" class="prod-form-input">
                </div>
                <div class="prod-form-item">
                  <span class="prod-form-lbl">Dh. Final [P]: *</span>
                  <input type="tel" placeholder="DD/MM/AAAA HH:MM" oninput="applyDateTimeMask(this)" maxlength="16" id="input-apo-fim" class="prod-form-input">
                </div>
              </div>
              <div class="prod-form-item">
                <span class="prod-form-lbl">Turno: *</span>
                <select id="input-apo-turno" class="prod-form-input" style="appearance: auto;">
                  <option value="1">Turno 1</option>
                  <option value="2">Turno 2</option>
                  <option value="3">Turno 3</option>
                </select>
              </div>
              
              <button class="prod-btn-green" onclick="salvarApontamento()" style="width: 100%; justify-content: center; padding: 12px; margin-top: 4px; font-size: 14px;">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
                Gravar Apontamento
              </button>
            </div>

            <!-- Lista Salva -->
            <div class="prod-list">
              <c:choose>
                <c:when test="${not empty apoQuery.rows}">
                  <c:forEach items="${apoQuery.rows}" var="apo">
                    <div class="prod-item">
                      <div class="prod-item-info">
                        <div>
                          <span class="prod-item-val">Qtd: <c:out value="${apo.QTDAPONTADA}"/> PC</span>
                          <c:if test="${not empty apo.NOMETURNO}">
                            <span class="prod-item-tag"><c:out value="${apo.NOMETURNO}"/></span>
                          </c:if>
                          <span style="margin-left:4px;">(<c:out value="${apo.QTDPESSOAS}"/> Pessoas)</span>
                        </div>
                        <div style="margin-top: 4px;">
                          <c:set var="dhinc" value="${apo.DHINC}" />
                          <c:set var="dhfin" value="${apo.DHFIN}" />
                          <c:out value="${fn:substring(dhinc, 8, 10)}/${fn:substring(dhinc, 5, 7)}/${fn:substring(dhinc, 0, 4)} ${fn:substring(dhinc, 11, 16)}"/> - <c:out value="${fn:substring(dhfin, 8, 10)}/${fn:substring(dhfin, 5, 7)}/${fn:substring(dhfin, 0, 4)} ${fn:substring(dhfin, 11, 16)}"/>
                        </div>
                      </div>
                      <div style="display: flex; gap: 8px;">
                        <c:if test="${apo.SITUACAO == 'P'}">
                          <button class="prod-btn-print" style="color: #0d9488; background-color: #f0fdfa;" onclick="confirmarApontamentoCard('${apo.NUAPO}')" title="Confirmar Apontamento">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"></polyline></svg>
                          </button>
                        </c:if>
                        <button class="prod-btn-print" onclick="imprimirEtiqueta('${apo.NUAPO}', '${apo.NUNOTA}')" title="Imprimir Etiqueta">
                          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="6 9 6 2 18 2 18 9"></polyline><path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"></path><rect x="6" y="14" width="12" height="8"></rect></svg>
                        </button>
                        <button class="prod-btn-del" onclick="excluirApontamento('${apo.NUAPO}')" title="Excluir">
                          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/><line x1="10" y1="11" x2="10" y2="17"/><line x1="14" y1="11" x2="14" y2="17"/></svg>
                        </button>
                      </div>
                    </div>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <div style="text-align: center; color: var(--slate-400); font-size: 13px; padding: 16px;">
                    Nenhum apontamento registrado.
                  </div>
                </c:otherwise>
              </c:choose>
            </div>

          </div>

        </div>
      </div>

      <!-- SCREEN: QUALITY -->
      <div id="screen-QUALITY" class="hidden animate-fade-in" style="margin: -24px; padding-bottom: 24px;">
        <div class="prod-container">
          <!-- EXIBIÇÃO DE ERRO DE SQL SE HOUVER -->
          <c:if test="${not empty errCnc}">
            <div style="background: #fee2e2; color: #9f1239; padding: 12px; margin: 16px; border-radius: 8px; font-size: 12px; border: 1px solid #fecdd3;">
              <b>ERRO SQL (AD_CNC):</b> ${errCnc.message}
            </div>
          </c:if>
          <c:if test="${not empty errQuali}">
            <div style="background: #fee2e2; color: #9f1239; padding: 12px; margin: 16px; border-radius: 8px; font-size: 12px; border: 1px solid #fecdd3;">
              <b>ERRO SQL (AD_QUALIHAIALA):</b> ${errQuali.message}
            </div>
          </c:if>

          <!-- Leitura da OP -->
          <div class="prod-card" style="margin-top: 24px;">
            <div class="prod-op-row">
              <div class="prod-op-input-wrapper">
                <span class="prod-op-label">NRO. OP:</span>
                <input type="number" id="input-nro-op-quali" class="prod-op-input" placeholder="Ex: 4339" value="${param.nroOp}" onkeypress="if(event.key === 'Enter') lerOPQuali()">
              </div>
              <button class="prod-btn-blue" onclick="lerOPQuali()">Ler</button>
            </div>
          </div>

          <!-- Info OP -->
          <div class="prod-card">
            <div class="prod-grid">
              <div class="prod-grid-item">
                <span class="prod-lbl">CÓD. PRODUTO</span>
                <span class="prod-val"><c:out value="${op.CODPRODPA}" default="-" /></span>
              </div>
              <div class="prod-grid-item">
                <span class="prod-lbl">NRO. OP: *</span>
                <span class="prod-val"><c:out value="${op.IDIPROC}" default="-" /></span>
              </div>
              <div class="prod-grid-item full">
                <span class="prod-lbl">PRODUTO</span>
                <span class="prod-val" style="line-height: 1.3;"><c:out value="${op.DESCRPROD}" default="-" /></span>
              </div>
              <div class="prod-grid-item">
                <span class="prod-lbl">DH. OP</span>
                <span class="prod-val">
                  <c:choose>
                    <c:when test="${not empty op.DHINST}">
                      <c:set var="dh" value="${op.DHINST}" />
                      <c:out value="${fn:substring(dh, 8, 10)}/${fn:substring(dh, 5, 7)}/${fn:substring(dh, 0, 4)} ${fn:substring(dh, 11, 16)}" />
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                  </c:choose>
                </span>
              </div>
              <div class="prod-grid-item">
                <span class="prod-lbl">NRO. LOTE</span>
                <span class="prod-val"><c:out value="${op.NROLOTE}" default="-" /></span>
              </div>
              <div class="prod-grid-item">
                <span class="prod-lbl">QTD.</span>
                <span class="prod-val">
                  <c:choose>
                    <c:when test="${not empty op.QTDPRODUZIR}"><c:out value="${op.QTDPRODUZIR}"/> PC</c:when>
                    <c:otherwise>-</c:otherwise>
                  </c:choose>
                </span>
              </div>
            </div>
          </div>

          <!-- Formulário CNC -->
          <div class="prod-card">
            <div class="prod-sec-header" style="margin-top: 8px;">
              <span class="prod-sec-title">CAUSAS DE NÃO CONFORMIDADES</span>
            </div>
            <div class="prod-form">
              <div class="prod-form-grid">
                <div class="prod-form-item">
                  <span class="prod-form-lbl">Data/Hora Início: *</span>
                  <input type="tel" placeholder="DD/MM/AAAA HH:MM" oninput="applyDateTimeMask(this)" maxlength="16" id="cnc-dtinicio" class="prod-form-input">
                </div>
                <div class="prod-form-item">
                  <span class="prod-form-lbl">Data/Hora Final: *</span>
                  <input type="tel" placeholder="DD/MM/AAAA HH:MM" oninput="applyDateTimeMask(this)" maxlength="16" id="cnc-dtfinal" class="prod-form-input">
                </div>
                <div class="prod-form-item">
                  <span class="prod-form-lbl">Qtd Pessoas: *</span>
                  <input type="number" id="cnc-qtdpessoas" class="prod-form-input" placeholder="0">
                </div>
                <div class="prod-form-item">
                  <span class="prod-form-lbl">Código: *</span>
                  <select id="cnc-codmtp" class="prod-form-input" style="appearance: auto;">
                    <option value="">Selecione...</option>
                    <c:forEach items="${mtpQuery.rows}" var="mtp">
                      <option value="${mtp.CODMTP}"><c:out value="${mtp.CODMTP} - ${mtp.DESCRICAO}"/></option>
                    </c:forEach>
                  </select>
                </div>
              </div>
              <button class="prod-btn-green" onclick="salvarCNC()" style="width: 100%; justify-content: center; padding: 12px; margin-top: 8px; background: var(--rose-500);">
                Gravar Causa NC
              </button>
            </div>
          </div>

          <!-- LISTA DE CNC -->
          <c:if test="${not empty cncQuery.rows}">
            <div class="prod-card" style="margin-top: 8px; padding-top: 8px; padding-bottom: 8px;">
              <span class="prod-sec-title" style="font-size:12px; color:var(--slate-500);">REGISTROS DE CAUSAS (CNC)</span>
              <div class="prod-list" style="margin-top: 8px;">
                <c:forEach items="${cncQuery.rows}" var="cnc">
                  <div class="prod-item">
                    <div class="prod-item-info">
                      <span class="prod-item-val" style="color:var(--rose-500);"><c:out value="${cnc.CODMTP} - ${cnc.MOTIVO_DESC}"/></span>
                      <span>
                        <c:choose>
                          <c:when test="${not empty cnc.DTINICIO}">
                            <c:set var="dhinc" value="${cnc.DTINICIO}" />
                            <c:out value="${fn:substring(dhinc, 8, 10)}/${fn:substring(dhinc, 5, 7)}/${fn:substring(dhinc, 0, 4)} ${fn:substring(dhinc, 11, 16)}"/>
                          </c:when>
                          <c:otherwise>-</c:otherwise>
                        </c:choose>
                         até 
                        <c:choose>
                          <c:when test="${not empty cnc.DTFINAL}">
                            <c:set var="dhfin" value="${cnc.DTFINAL}" />
                            <c:out value="${fn:substring(dhfin, 8, 10)}/${fn:substring(dhfin, 5, 7)}/${fn:substring(dhfin, 0, 4)} ${fn:substring(dhfin, 11, 16)}"/>
                          </c:when>
                          <c:otherwise>-</c:otherwise>
                        </c:choose>
                      </span>
                      <span><c:out value="${cnc.QTDPESSOAS}"/> Pessoa(s)</span>
                    </div>
                    <button class="prod-btn-del" onclick="excluirCNC('${cnc.SEQ}')" title="Excluir">
                      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/><line x1="10" y1="11" x2="10" y2="17"/><line x1="14" y1="11" x2="14" y2="17"/></svg>
                    </button>
                  </div>
                </c:forEach>
              </div>
            </div>
          </c:if>

          <!-- Formulário INFORMAÇÕES DA QUALIDADE -->
          <div class="prod-card">
            <div class="prod-sec-header" style="margin-top: 8px;">
              <span class="prod-sec-title">INFORMAÇÕES DA QUALIDADE HAIALA</span>
            </div>
            <div class="prod-form">
              <div class="prod-form-grid" style="grid-template-columns: 1fr;">
                <div class="prod-form-item">
                  <span class="prod-form-lbl">Cod Anomalia:</span>
                  <select id="quali-anomalia" class="prod-form-input" style="appearance: auto;">
                    <option value="" selected>Selecione...</option>
                    <option value="10">10 Medida(s)</option>
                    <option value="11">11 Avarias</option>
                    <option value="12">12 Pintura/Acabamento</option>
                    <option value="13">13 Alinhamento</option>
                    <option value="14">14 Solda MIG</option>
                    <option value="15">15 Solda Ponto</option>
                    <option value="16">16 Vedação</option>
                    <option value="17">17 Regulagem/Funcionamento</option>
                  </select>
                </div>
                <div class="prod-form-item">
                  <span class="prod-form-lbl">Origem Defeito:</span>
                  <select id="quali-setor" class="prod-form-input" style="appearance: auto;">
                    <option value="" selected>Selecione...</option>
                    <option value="0">SEM SETOR</option>
                    <option value="1">C.D.A.</option>
                    <option value="2">CORTE</option>
                    <option value="3">CORTE SLLITER</option>
                    <option value="4">DOBRA</option>
                    <option value="5">DOBRA PALHETA</option>
                    <option value="6">MONTAGEM 01</option>
                    <option value="7">MONTAGEM 02</option>
                    <option value="8">MONTAGEM 03</option>
                    <option value="9">MONTAGEM 04</option>
                    <option value="10">MONTAGEM 05</option>
                    <option value="23">MONTAGEM 06</option>
                    <option value="11">MONTAGEM 07 (GRADE)</option>
                    <option value="12">MONTAGEM 08 AÇO PINTADO</option>
                    <option value="13">MONTAGEM 09 ALUMINIO</option>
                    <option value="14">MONTAGEM DE SHOW-ROOM</option>
                    <option value="15">PALHETADEIRA</option>
                    <option value="16">PINTURA CINZA</option>
                    <option value="17">PINTURA ELETROSTÁTICA</option>
                    <option value="18">PINTURA SHOW-ROOM</option>
                    <option value="19">USINAGEM</option>
                    <option value="20">VIDROS</option>
                    <option value="21">MONTAGEM 10 ALUMINIO PINTADO</option>
                    <option value="22">PREPARAÇÃO</option>
                    <option value="25">EXPEDIÇÃO</option>
                    <option value="24">DEVOLUÇÃO</option>
                  </select>
                </div>
              </div>
              <div class="prod-form-grid" style="grid-template-columns: 1fr 1fr; margin-top:12px;">
                <div class="prod-form-item">
                  <span class="prod-form-lbl" style="color:var(--slate-400);">AMOSTRA</span>
                  <input type="number" id="quali-amostra" class="prod-form-input" placeholder="0">
                </div>
                <div class="prod-form-item">
                  <span class="prod-form-lbl" style="color:var(--rose-500);">REPROVADA</span>
                  <input type="number" id="quali-reprovada" class="prod-form-input" placeholder="0">
                </div>
                <div class="prod-form-item">
                  <span class="prod-form-lbl" style="color:var(--amber-500);">RETIDA</span>
                  <input type="number" id="quali-retida" class="prod-form-input" placeholder="0">
                </div>
                <div class="prod-form-item">
                  <span class="prod-form-lbl" style="color:var(--sky-600);">NOTIFICADA</span>
                  <input type="number" id="quali-notificada" class="prod-form-input" placeholder="0">
                </div>
              </div>
              <button class="prod-btn-green" onclick="salvarQuali()" style="width: 100%; justify-content: center; padding: 12px; margin-top: 16px;">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
                Gravar Nota Qualidade
              </button>
            </div>
          </div>

          <!-- LISTA DE QUALIDADE -->
          <c:if test="${not empty qualiQuery.rows}">
            <div class="prod-card" style="margin-top: 8px; padding-top: 8px; padding-bottom: 8px;">
              <span class="prod-sec-title" style="font-size:12px; color:var(--slate-500);">REGISTROS DE QUALIDADE HAIALA</span>
              <div class="prod-list" style="margin-top: 8px;">
                <c:forEach items="${qualiQuery.rows}" var="quali">
                  <div class="prod-item" style="flex-direction:column; align-items:stretch; gap:8px;">
                    <div style="display:flex; justify-content:space-between; align-items:flex-start;">
                      <div class="prod-item-info">
                        <span class="prod-item-val" style="color:var(--indigo-900);">Anomalia Cód: <c:out value="${quali.ANOMALIA}"/></span>
                        <span>Origem (Setor): <c:out value="${quali.SETOR_DEF}"/></span>
                      </div>
                      <button class="prod-btn-del" onclick="excluirQuali('${quali.SEQUENCIAL}')" title="Excluir" style="padding:4px;">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/><line x1="10" y1="11" x2="10" y2="17"/><line x1="14" y1="11" x2="14" y2="17"/></svg>
                      </button>
                    </div>
                    <div style="display:flex; justify-content:space-between; border-top:1px solid var(--slate-200); padding-top:8px; font-size:11px; font-weight:700;">
                      <div style="text-align:center;"><div style="color:var(--slate-400);">AMOSTRA</div><div style="font-size:14px; color:var(--slate-800);"><c:out value="${quali.QTDAMOSTRA}"/></div></div>
                      <div style="text-align:center;"><div style="color:var(--rose-500);">REPR</div><div style="font-size:14px; color:var(--rose-500);"><c:out value="${quali.QTDREPROVADA}"/></div></div>
                      <div style="text-align:center;"><div style="color:var(--amber-500);">RET</div><div style="font-size:14px; color:var(--amber-500);"><c:out value="${quali.QTDRETIDA}"/></div></div>
                      <div style="text-align:center;"><div style="color:var(--sky-600);">NOTIF</div><div style="font-size:14px; color:var(--sky-600);"><c:out value="${quali.QTDNOTIFICADA}"/></div></div>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </div>
          </c:if>

        </div>
      </div>

      <!-- SCREEN: MAINTENANCE -->
      <div id="screen-MAINTENANCE" class="hidden animate-fade-in" style="margin: -24px; padding-bottom: 24px; background: white; min-height: 100vh;">
        
        <!-- Maint Menu -->
        <div id="maint-menu" style="padding: 24px;">
          <div style="height: 60px;"></div>
          <button class="btn-maint-large btn-maint-open" onclick="maintNavigate('ABERTURA')">ABERTURA DE OS</button>
          <button class="btn-maint-large btn-maint-close" onclick="maintNavigate('FECHAMENTO')">FECHAMENTO DE OS</button>
        </div>

        <!-- Maint Abertura -->
        <div id="maint-abertura" class="hidden" style="padding: 16px;">
          <div style="text-align:center; margin-bottom: 16px;">
            <button class="btn-maint-large btn-maint-open" style="border-radius:24px; width:auto; padding:8px 24px; font-size:14px; box-shadow:none; cursor:default;">ABERTURA DE OS</button>
          </div>
          
          <!-- Removed Leitura da OS for Abertura -->
          
          <div class="maint-form-group">
            <label class="maint-label">Item / Máquina: *</label>
            <select id="maint-coditem" class="maint-input" style="appearance: auto;" onchange="updateMaintItemSector()">
              <option value="">Selecione a Máquina...</option>
              <c:if test="${not empty itensMaintQuery.rows}">
                <c:forEach items="${itensMaintQuery.rows}" var="item">
                  <option value="${item.CODITEM}" data-setor="${item.CODSETOR}">
                    <c:out value="${item.CODMAQ} - ${item.DESCMAQUINA}"/>
                  </option>
                </c:forEach>
              </c:if>
            </select>
          </div>

          <div class="maint-form-group">
            <label class="maint-label">Setor: *</label>
            <select id="maint-codsetor" class="maint-input" style="appearance: auto;">
              <option value="">Selecione o Setor...</option>
              <c:if test="${not empty setorMaintQuery.rows}">
                <c:forEach items="${setorMaintQuery.rows}" var="setor">
                  <option value="${setor.CODSETOR}">
                    <c:out value="${setor.CODSETOR} - ${setor.SETDESCRICAO}"/>
                  </option>
                </c:forEach>
              </c:if>
            </select>
          </div>

          <div class="maint-form-group">
            <label class="maint-label">Nome do Solicitante:</label>
            <input type="text" id="maint-solicitante" class="maint-input" placeholder="Ex: João da Silva">
          </div>

          <div class="maint-form-group">
            <label class="maint-label">Status Produção: *</label>
            <select id="maint-statusprod" class="maint-input" style="appearance: auto;" onchange="toggleMaintStatusOutros()">
              <option value="0">Em Funcionamento</option>
              <option value="1">Parada</option>
              <option value="2">Com Deficiência</option>
              <option value="3" selected>Outros</option>
            </select>
          </div>

          <div class="maint-form-group" id="maint-statusoutros-div">
            <label class="maint-label">Outras - Descrever situação:</label>
            <input type="text" id="maint-statusoutros" class="maint-input">
          </div>

          <div class="maint-form-group">
            <label class="maint-label">Descrição da Anormalidade:</label>
            <textarea id="maint-anormalidade" class="maint-input" rows="4" placeholder="Descreva o problema..."></textarea>
          </div>
          
          <hr style="border:none; border-top:1px solid #cbd5e1; margin:24px 0;">
          <h4 style="margin:0 0 16px 0; color:#334155;">Tipo de Manutenção</h4>

          <div class="maint-form-group">
            <label class="maint-label">Tipo de Manutenção: *</label>
            <select id="maint-tpmanutencao" class="maint-input" style="appearance: auto;">
              <option value="1">Corretiva</option>
              <option value="2">Preventiva</option>
              <option value="3">Programada</option>
              <option value="4" selected>Melhorias</option>
            </select>
          </div>

          <label class="maint-label">Categoria:</label>
          <div class="maint-checkbox-grid">
            <div class="maint-checkbox-item"><span>Elétrica</span><input type="checkbox" id="maint-cat-eletrica"></div>
            <div class="maint-checkbox-item"><span>Hidráulica</span><input type="checkbox" id="maint-cat-hidraulica"></div>
            <div class="maint-checkbox-item"><span>Pneumática</span><input type="checkbox" id="maint-cat-pneumatica"></div>
            <div class="maint-checkbox-item"><span>Mecânica</span><input type="checkbox" id="maint-cat-mecanica"></div>
            <div class="maint-checkbox-item"><span>Ferramental</span><input type="checkbox" id="maint-cat-ferramental"></div>
            <div class="maint-checkbox-item"><span>Serralheria</span><input type="checkbox" id="maint-cat-serralheria"></div>
            <div class="maint-checkbox-item"><span>Predial</span><input type="checkbox" id="maint-cat-predial"></div>
            <div class="maint-checkbox-item"><span>Outros</span><input type="checkbox" id="maint-cat-outros" onchange="toggleMaintCatOutros()"></div>
          </div>
          
          <div class="maint-form-group hidden" id="maint-cat-outros-div">
            <label class="maint-label">Outros - Descrever situação:</label>
            <input type="text" id="maint-detaoutros" class="maint-input">
          </div>

          <div class="maint-action-row">
            <button class="maint-btn-save" onclick="salvarAberturaOS()"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"></polyline></svg> Salvar OS</button>
            <button class="maint-btn-discard" onclick="maintNavigate('MENU')">Descartar</button>
          </div>
        </div>

        <!-- Maint Fechamento -->
        <div id="maint-fechamento" class="hidden" style="padding: 16px;">
          <div style="text-align:center; margin-bottom: 16px;">
            <button class="btn-maint-large btn-maint-close" style="border-radius:24px; width:auto; padding:8px 24px; font-size:14px; box-shadow:none; cursor:default;">FECHAMENTO DE OS</button>
          </div>

          <!-- Leitura da OS -->
          <div class="prod-card" style="margin-bottom: 24px; padding:12px; border: 1px solid #cbd5e1;">
            <div class="prod-op-row">
              <div class="prod-op-input-wrapper">
                <span class="prod-op-label">NRO. OS:</span>
                <input type="number" id="maint-fech-osnum" class="prod-op-input" placeholder="Ex: 3049" onkeypress="if(event.key === 'Enter') buscarOSFechamento()">
              </div>
              <button class="prod-btn-blue" onclick="buscarOSFechamento()">Ler</button>
            </div>
          </div>

          <!-- DETALHES DA OS (Somente Leitura) -->
          <div id="maint-fech-details" class="hidden">
            <div style="font-size:12px; color:#64748b; margin-bottom:12px;">Detalhes: <strong id="maint-fech-det-maquina"></strong> (<span id="maint-fech-det-setor"></span>)</div>
            
            <div class="maint-form-group">
              <label class="maint-label">Técnico/Responsável: *</label>
              <select id="maint-fech-tecnico" class="maint-input" style="appearance: auto;">
                <option value="">Selecione...</option>
                <c:if test="${not empty tecMaintQuery.rows}">
                  <c:forEach items="${tecMaintQuery.rows}" var="tec">
                    <option value="${tec.CODTEC}">
                      <c:out value="${tec.CODTEC} - ${tec.TEC_NOME}"/>
                    </option>
                  </c:forEach>
                </c:if>
              </select>
            </div>

            <div class="maint-input-row" style="margin-bottom:12px;">
              <div style="flex:1">
                <label class="maint-label">Tipo de Manutenção:</label>
                <select id="maint-fech-tpmanutencao" class="maint-input" style="appearance: auto;">
                  <option value="1">Corretiva</option>
                  <option value="2">Preventiva</option>
                  <option value="3">Programada</option>
                  <option value="4">Melhorias</option>
                </select>
              </div>
              <div style="flex:1">
                <label class="maint-label">Status OS: *</label>
                <select id="maint-fech-statusos" class="maint-input" style="appearance: auto; font-weight:bold; color:var(--slate-800);">
                  <option value="0">Aguardando Atend.</option>
                  <option value="1">Em Atendimento</option>
                  <option value="2">Finalizado</option>
                  <option value="3">Finalizado C/Pend.</option>
                </select>
              </div>
            </div>

            <div class="maint-form-group">
              <label class="maint-label">Motivo da Manutenção:</label>
              <textarea id="maint-fech-motivo" class="maint-input" rows="2"></textarea>
            </div>
            
            <div class="maint-form-group">
              <label class="maint-label">Causa da Manutenção:</label>
              <textarea id="maint-fech-causa" class="maint-input" rows="2"></textarea>
            </div>

            <hr style="border:none; border-top:1px solid #cbd5e1; margin:24px 0;">
            <h4 style="margin:0 0 16px 0; color:#334155;">Manutenção Horas Serviços</h4>

            <!-- LANÇAMENTO DE HORAS -->
            <div style="background:#f1f5f9; padding:12px; border-radius:8px; border:1px dashed #cbd5e1; margin-bottom:16px;">
              <div class="maint-input-row" style="margin-bottom:8px;">
                <div style="flex:1">
                  <label class="maint-label">Hora Inicial:</label>
                  <input type="tel" placeholder="DD/MM/AAAA HH:MM" oninput="applyDateTimeMask(this)" maxlength="16" id="maint-fech-hrinicial" class="maint-input" style="padding:6px;">
                </div>
                <div style="flex:1">
                  <label class="maint-label">Hora Final:</label>
                  <input type="tel" placeholder="DD/MM/AAAA HH:MM" oninput="applyDateTimeMask(this)" maxlength="16" id="maint-fech-hrfinal" class="maint-input" style="padding:6px;">
                </div>
              </div>
              <button class="maint-btn-red" style="width:100%; justify-content:center; padding:10px; background:#0ea5e9; border:none;" onclick="adicionarHorasOS()"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg> Registrar Horas</button>
            </div>

            <!-- LISTA DE HORAS (CARDS) -->
            <div id="maint-fech-horas-list" style="display:flex; flex-direction:column; gap:8px; margin-bottom:16px;">
              <!-- Cards dinamicos aqui -->
            </div>

            <div style="margin-top: 24px;">
              <button class="maint-btn-save orange" style="width:100%; justify-content:center;" onclick="salvarFechamentoOS()"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"></polyline></svg> SALVAR FECHAMENTO / EDIÇÃO</button>
            </div>
          </div>
          
          <div style="text-align:center; margin-top:24px;">
             <a href="javascript:void(0)" onclick="maintNavigate('MENU')" style="color:var(--slate-500); font-weight:bold; text-decoration:none; display:inline-block; padding:12px 24px; border:1px solid #cbd5e1; border-radius:8px;">&larr; Voltar Menu</a>
          </div>
        </div>
      </div>

    </main>
  </div>

  <!-- Custom Modal Confirm -->
  <div id="custom-confirm-modal" style="display:none; align-items:center; justify-content:center; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(15,23,42,0.6); z-index:9999;">
    <div style="background:#fff; border-radius:16px; width:90%; max-width:320px; padding:24px; box-shadow:0 10px 25px rgba(0,0,0,0.2); text-align:center;">
      <div style="font-size:18px; font-weight:700; color:#1e293b; margin-bottom:12px;">Confirmação</div>
      <div id="custom-confirm-msg" style="font-size:14px; color:#475569; margin-bottom:24px; line-height: 1.5;">Deseja realmente continuar?</div>
      <div style="display:flex; gap:12px; justify-content:center;">
        <button onclick="closeCustomConfirm()" style="flex:1; padding:12px; border-radius:8px; border:1px solid #cbd5e1; background:#f8fafc; color:#475569; font-weight:600; cursor:pointer;">Cancelar</button>
        <button id="custom-confirm-btn" style="flex:1; padding:12px; border-radius:8px; border:none; background:#0d9488; color:#fff; font-weight:600; cursor:pointer;">Confirmar</button>
      </div>
    </div>
  </div>

  <!-- Javascript Logic -->
  <script>
    // GLOBAL ERROR HANDLER FOR MOBILE DEBUGGING
    window.onerror = function(msg, url, line, col, error) {
       alert("JS Error na linha " + line + ": " + msg);
       return false;
    };
    window.addEventListener('unhandledrejection', function(event) {
       alert("Async Error: " + (event.reason ? event.reason.message : event.reason));
    });

    // State
    const state = {
      activeModule: 'MENU'
    };

    let currentConfirmCallback = null;

    function showCustomConfirm(message, callback) {
      document.getElementById('custom-confirm-msg').innerText = message;
      currentConfirmCallback = callback;
      document.getElementById('custom-confirm-modal').style.display = 'flex';
    }

    function closeCustomConfirm() {
      document.getElementById('custom-confirm-modal').style.display = 'none';
      currentConfirmCallback = null;
    }

    document.getElementById('custom-confirm-btn').addEventListener('click', function() {
      if (currentConfirmCallback) {
        currentConfirmCallback();
      }
      closeCustomConfirm();
    });

    // Screens Map
    const screens = ['MENU', 'PRODUCTION', 'QUALITY', 'MAINTENANCE'];
    const titles = {
      'MENU': 'Menu Principal',
      'PRODUCTION': 'Apontamento Produção',
      'QUALITY': 'Qualidade / NC',
      'MAINTENANCE': 'Apontamento Manutenção'
    };

    function maintNavigate(subScreen) {
      document.getElementById('maint-menu').classList.add('hidden');
      document.getElementById('maint-abertura').classList.add('hidden');
      document.getElementById('maint-fechamento').classList.add('hidden');

      if (subScreen === 'MENU') {
        document.getElementById('maint-menu').classList.remove('hidden');
      } else if (subScreen === 'ABERTURA') {
        document.getElementById('maint-abertura').classList.remove('hidden');
      } else if (subScreen === 'FECHAMENTO') {
        document.getElementById('maint-fechamento').classList.remove('hidden');
      }
    }

    // Função robusta para chamar API sem recursos muito novos de JS (como ?.)
    async function callSankhyaApi(modulo, serviceName, requestBody, maxRetries = 3) {
      if (maxRetries <= 0) {
        throw new Error("Falha ao confirmar evento do Sankhya. Exigido: " + JSON.stringify(requestBody.clientEventList));
      }

      let url = modulo + '/service.sbr?serviceName=' + serviceName + '&outputType=json';
      
      // Compartilhamento de sessão para chamadas cross-module (ex: /mgeprod a partir de /mge)
      const sessionMatch = document.cookie.match(/JSESSIONID=([^;]+)/);
      if (sessionMatch) {
         const sessionId = sessionMatch[1].split('.')[0]; // remove sufixos como .master
         url += '&mgeSession=' + sessionId;
      }
      
      const response = await fetch(url, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Accept': 'application/json'
        },
        credentials: 'same-origin',
        body: JSON.stringify({
          serviceName: serviceName,
          requestBody: requestBody
        })
      });
      
      if (!response.ok) {
        throw new Error('Erro HTTP na comunicação: ' + response.status);
      }
      
      const data = await response.json();
      
      // AUTO-CONFIRMAÇÃO DE EVENTOS DE CLIENTE (STATUS 4)
      if (data.status == '4' && data.clientEvents) {
        if (!requestBody.clientEventList) {
          requestBody.clientEventList = { clientEvent: [] };
        }
        if (!Array.isArray(requestBody.clientEventList.clientEvent)) {
           if (requestBody.clientEventList.clientEvent) {
               requestBody.clientEventList.clientEvent = [requestBody.clientEventList.clientEvent];
           } else {
               requestBody.clientEventList.clientEvent = [];
           }
        }
        
        for (let i = 0; i < data.clientEvents.length; i++) {
           let ev = data.clientEvents[i];
           
           // INTERCEPTAÇÃO: Se for a liberação de série, interrompe a recursão e avisa o chamador!
           if (ev.id === 'br.com.sankhya.mgeProd.apontamento.liberaNroSerie') {
               throw new Error("LIBERA_SERIE_REQUIRED");
           }
           
           let confirmValue = "true";
           if (ev.id === "br.com.sankhya.mgeProd.apontamento.ultimo" || ev.id === "br.com.sankhya.mgeprod.confirma.ultimo.apontamento.mp.fixo") {
               confirmValue = "false";
           }
           
           let confirmedEvent = {
               $: ev.id,
               _clientConfirm: confirmValue
           };
           
           // O Sankhya espera que os parâmetros do evento venham no mesmo nível do nó XML (achatamendo JSON)
           if (ev.params) {
               for (let key in ev.params) {
                   confirmedEvent[key] = ev.params[key];
               }
           }
           
           requestBody.clientEventList.clientEvent.push(confirmedEvent);
        }
        
        return await callSankhyaApi(modulo, serviceName, requestBody, maxRetries - 1);
      }

      if (data.status != '1') {
        let msg = data.statusMessage;
        
        if (data.tsError && data.tsError.statusMessage) {
          msg = data.tsError.statusMessage;
        }
        
        if (!msg) {
          msg = "ERRO: " + JSON.stringify(data).substring(0, 300); // Mostra o raw json
        }
        throw new Error(msg);
      }
      
      return data;
    }

    async function alterarStatus(novoStatus) {
      const ideatv = document.getElementById('val-ideatv');
      const idefx = document.getElementById('val-idefx');
      const idiproc = document.getElementById('val-idiproc');
      
      if (!ideatv || !ideatv.value) {
        showToast('ERRO: Nenhuma atividade (IDIATV) associada.', 'error');
        return;
      }
      
      let serviceName = '';
      if (novoStatus === 'I') serviceName = 'OperacaoProducaoSP.iniciarInstanciaAtividades';
      if (novoStatus === 'C') serviceName = 'OperacaoProducaoSP.finalizarInstanciaAtividades'; 
      if (novoStatus === 'F') serviceName = 'OperacaoProducaoSP.finalizarInstanciaAtividades';
      
      try {
        await callSankhyaApi('/mgeprod', serviceName, {
          instancias: {
            confirmarApontamentosDivergentes: true,
            ignoraValidacaoFormulario: true,
            instancia: [
              { 
                IDIATV: { $: parseInt(ideatv.value) },
                IDEFX: { $: parseInt(idefx.value) },
                IDIPROC: { $: parseInt(idiproc.value) }
              }
            ]
          }
        });
        showToast('Status alterado com sucesso!', 'success');
        setTimeout(() => window.location.reload(), 1500);
      } catch (error) {
        showToast("Erro ao alterar status: " + error.message, 'error');
      }
    }

    async function fetchSeriesForNuapo() {
      try {
        const idiprocElement = document.getElementById('val-idiproc');
        if (!idiprocElement || !idiprocElement.value) return [];
        const idiprocVal = parseInt(idiprocElement.value);
        
        const codprodElement = document.getElementById('val-codprod');
        let codprodVal = codprodElement ? parseInt(codprodElement.innerText.trim()) : 0;
        if (isNaN(codprodVal)) codprodVal = 0;

        // Trazendo TODAS as colunas via API
        const sqlSeries = "SELECT * FROM TPRSERPA WHERE IDIPROC = " + idiprocVal + " AND CODPRODPA = " + codprodVal + " AND PERDA = 'N' AND LIBERADO = 'N'";
        
        const data = await callSankhyaApi('/mge', 'DbExplorerSP.executeQuery', { sql: sqlSeries, query: sqlSeries });
        let series = [];
        
        if (data && data.responseBody && data.responseBody.rows && data.responseBody.fieldsMetadata) {
            // O Sankhya pode retornar { field: [...] } dependendo do parser XML-JSON
            let meta = data.responseBody.fieldsMetadata;
            if (meta.field) {
                meta = meta.field;
            }
            if (!Array.isArray(meta)) {
                meta = [meta];
            }
            
            // O Sankhya pode retornar { row: [...] } dependendo do parser XML-JSON
            let rows = data.responseBody.rows;
            if (rows.row) {
                rows = rows.row;
            }
            if (!Array.isArray(rows)) {
                rows = [rows];
            }
            
            for (let i = 0; i < rows.length; i++) {
                let rowArray = rows[i];
                let obj = {};
                let serieStr = "SEM SÉRIE DEFINIDA";
                
                // Mapeia dinamicamente usando os nomes das colunas retornados pelo banco!
                for (let c = 0; c < meta.length; c++) {
                    let colName = meta[c].name;
                    let cellVal = null;
                    
                    // Suporte a diferentes formatos de array/objeto no rowArray
                    if (Array.isArray(rowArray)) {
                        cellVal = rowArray[c];
                    } else if (typeof rowArray === 'object') {
                        cellVal = rowArray[colName] !== undefined ? rowArray[colName] : rowArray["c" + c];
                    }
                    
                    if (cellVal && typeof cellVal === 'object' && cellVal.$ !== undefined) cellVal = cellVal.$;
                    if (cellVal === null || cellVal === undefined) cellVal = "";
                    
                    obj[colName] = cellVal.toString().trim();
                    
                    if (colName.toUpperCase() === 'SERIEPA') {
                        serieStr = obj[colName];
                    }
                }
                
                obj["SERIEPA"] = serieStr;
                series.push(obj);
            }
        }
        
        if (series.length > 0) {
            showToast("Encontradas " + series.length + " séries prontas!", "success");
        } else {
            showToast("Nenhuma série pendente encontrada no banco.", "warning");
        }
        
        return series;
      } catch (e) {
        showToast("Erro séries: " + e.message, "error");
        return [];
      }
    }

    async function confirmarParada() {
      const ideatv = document.getElementById('val-ideatv');
      const idefx = document.getElementById('val-idefx');
      const idiproc = document.getElementById('val-idiproc');
      
      if (!ideatv || !ideatv.value) {
        showToast('ERRO: Nenhuma atividade associada.', 'error');
        return;
      }

      const motivo = document.getElementById('input-parada-motivo').value;
      const obs = document.getElementById('input-parada-obs').value;

      if (!motivo) {
        showToast('Por favor, informe o Motivo de Parada!', 'error');
        return;
      }
      
      try {
        await callSankhyaApi('/mgeprod', 'OperacaoProducaoSP.pararInstanciaAtividades', {
          instancias: {
            tipoParada: "P",
            instancia: [
              { 
                 IDIATV: { $: parseInt(ideatv.value) },
                 CODMTP: { $: parseInt(motivo) },
                 OBSERVACAO: { $: obs }
              }
            ]
          }
        });
        showToast('Atividade paralisada com sucesso!', 'success');
        setTimeout(() => window.location.reload(), 1500);
      } catch (error) {
        showToast("Erro ao registrar parada: " + error.message, 'error');
      }
    }

    async function salvarApontamento() {
      const ideatv = document.getElementById('val-ideatv');
      if (!ideatv || !ideatv.value) {
        showToast('ERRO: Nenhuma atividade associada.', 'error');
        return;
      }
      
      function formatDateTimeForSankhya(val) {
        if (!val) return "";
        if (val.length === 16 && val.indexOf('/') !== -1) {
            return val + ':00';
        }
        if (val.indexOf('T') !== -1) {
            const parts = val.split('T');
            if (parts.length !== 2) return val;
            const d = parts[0].split('-');
            return d[2] + '/' + d[1] + '/' + d[0] + ' ' + parts[1] + ':00';
        }
        return val;
      }

      const qtd = document.getElementById('input-apo-qtd').value;
      const pessoas = document.getElementById('input-apo-pessoas').value;
      const inicioRaw = document.getElementById('input-apo-inicio').value;
      const fimRaw = document.getElementById('input-apo-fim').value;
      const turno = document.getElementById('input-apo-turno').value;
      
      if (!inicioRaw || !fimRaw) {
        showToast('As datas de Início e Fim são obrigatórias.', 'error');
        return;
      }
      
      const dhInicio = formatDateTimeForSankhya(inicioRaw);
      const dhFim = formatDateTimeForSankhya(fimRaw);
      const entidadeApontamento = 'CabecalhoApontamento';
      
      const codprodElement = document.getElementById('val-codprod');
      let codprod = codprodElement ? parseInt(codprodElement.innerText.trim()) : 0;
      if (isNaN(codprod)) codprod = 0;
      
      try {
        const criarParams = { IDIATV: parseInt(ideatv.value) };
        if (codprod > 0) {
            criarParams.CODPRODPA = codprod;
        }
        if (qtd > 0) {
            criarParams.QTDAPONTADA = parseFloat(qtd);
        }

        const respCriar = await callSankhyaApi('/mgeprod', 'OperacaoProducaoSP.criarApontamento', {
          params: criarParams
        });
        
        let nuapo = null;
        if (respCriar && respCriar.responseBody && respCriar.responseBody.apontamento) {
          const apo = respCriar.responseBody.apontamento;
          nuapo = Array.isArray(apo) ? apo[0].NUAPO : apo.NUAPO;
        }
        
        let isNovoCabecalho = false;
        if (!nuapo) {
            isNovoCabecalho = true;
            nuapo = ""; 
        }

        // PASSO 2: Puxa as séries que a Fase 1 acabou de gerar na TPRSERPA (Simula a abertura do Popup na tela)
        let seriePAObj = await fetchSeriesForNuapo();

        // PASSO 2: Atualizar ou INSERIR o CABEÇALHO do apontamento
        try {
          let pkCabecalho = isNovoCabecalho ? {} : { NUAPO: nuapo.toString() };
          let fieldsCab = isNovoCabecalho ? 
            ["IDIATV", "AD_QTDPESSOAS", "AD_DHINICIO", "AD_DHFINAL", "AD_TURNO"] : 
            ["NUAPO", "IDIATV", "AD_QTDPESSOAS", "AD_DHINICIO", "AD_DHFINAL", "AD_TURNO"];
            
          let valuesCab = isNovoCabecalho ? {
            "0": ideatv.value.toString(),
            "1": (pessoas || 0).toString(),
            "2": dhInicio,
            "3": dhFim,
            "4": (turno || "1").toString()
          } : {
            "0": nuapo.toString(),
            "1": ideatv.value.toString(),
            "2": (pessoas || 0).toString(),
            "3": dhInicio,
            "4": dhFim,
            "5": (turno || "1").toString()
          };

          const respCab = await callSankhyaApi('/mge', 'DatasetSP.save', {
            dataSetID: "01J",
            entityName: "CabecalhoApontamento",
            standAlone: false,
            parentEntityName: "InstanciaAtividade",
            fields: fieldsCab,
            records: [
              {
                pk: pkCabecalho,
                foreignKey: { IDIATV: ideatv.value.toString() },
                values: valuesCab
              }
            ]
          });
          
          if (isNovoCabecalho) {
              if (respCab && respCab.responseBody && respCab.responseBody.entities && respCab.responseBody.entities.entity) {
                  const ent = Array.isArray(respCab.responseBody.entities.entity) ? respCab.responseBody.entities.entity[0] : respCab.responseBody.entities.entity;
                  if (ent.NUAPO) {
                      nuapo = ent.NUAPO.$ !== undefined ? ent.NUAPO.$ : ent.NUAPO;
                  }
              }
              if (!nuapo || nuapo === "") {
                  throw new Error("Falha ao gerar o NUAPO. O Sankhya não devolveu o número após a inserção do cabeçalho.");
              }
          }

        } catch (errCab) {
          throw new Error("Erro no Cabeçalho (Datas/Pessoas/Turno): " + errCab.message);
        }

        // PASSO 3: Buscar o SEQAPA caso o ERP já tenha criado a linha do Produto
        let seqapa = null;
        try {
          // Bypassing API metadata issues - query JSP server directly!
          const fetchUrl = window.location.href + '&action=getSeqapa&nuapo=' + parseInt(nuapo) + '&codprod=' + parseInt(codprod || 0);
          const resp = await fetch(fetchUrl);
          const text = await resp.text();
          try {
             const json = JSON.parse(text);
             if (json.seqapa && json.seqapa !== 'null' && json.seqapa.trim() !== '') {
                 seqapa = parseInt(json.seqapa);
             }
          } catch(e) {
             console.error("Erro no parse JSON do getSeqapa:", text);
          }
        } catch (e) {
          console.error("Erro ao carregar SEQAPA via JSP:", e);
        }

        // PASSO 4: Atualizar ou Inserir a Quantidade no ApontamentoPA
        try {
          const paFields = ["NUAPO", "CODPRODPA", "QTDAPONTADA"];
          const paValues = {
            "0": nuapo.toString(),
            "1": (codprod || 0).toString(),
            "2": (qtd || 0).toString()
          };
          
          let pkPA = undefined;
          if (seqapa) {
            paFields.push("SEQAPA");
            paValues["3"] = seqapa.toString();
            pkPA = { NUAPO: nuapo.toString(), SEQAPA: seqapa.toString() };
          }

          await callSankhyaApi('/mge', 'DatasetSP.save', {
            dataSetID: "DS_PA_01",
            entityName: "ApontamentoPA",
            standAlone: false,
            parentEntityName: "CabecalhoApontamento",
            fields: paFields,
            records: [
              {
                pk: pkPA,
                foreignKey: { NUAPO: nuapo.toString() },
                values: paValues
              }
            ]
          });
        } catch (errPA) {
          throw new Error("Erro na Qtd (ApontamentoPA): " + errPA.message);
        }

        showToast('Apontamento ' + nuapo + ' gravado com sucesso!', 'success');
        setTimeout(() => window.location.reload(), 1500);
      } catch (error) {
        showToast("Erro ao salvar: " + error.message, 'error');
      }
    }

    function confirmarApontamentoCard(nuapoStr) {
      showCustomConfirm("Deseja confirmar este apontamento?", async function() {
        const ideatv = document.getElementById('val-ideatv');
        
        if (!ideatv || !ideatv.value || isNaN(parseInt(ideatv.value))) {
            showToast("ERRO interno: Atividade (IDIATV) não encontrada na tela.", "error");
            return;
        }

        try {
          showLoader("Iniciando Confirmação...");
          
          const paramsStep1 = {
              NUAPO: parseInt(nuapoStr),
              IDIATV: parseInt(ideatv.value),
              ACEITARQTDMAIOR: false,
              ULTIMOAPONTAMENTO: false,
              RESPOSTA_ULTIMO_APONTAMENTO: "false",
              notaProducao: "S",
              ALLMP: {}
          };
          
            const baseEventsStep1 = [
              { $: "br.com.sankhya.mgeprod.apontamentos.divergentes" },
              { $: "br.com.sankhya.mgeProd.wc.indisponivel" },
              { $: "br.com.sankhya.mgeprod.redimensionar.op.pa.perda" },
              { $: "br.com.sankhya.mgeprod.redimensionar.op.pa.avisos" },
              { $: "br.com.sankhya.mgeprod.trocaturno.avisos" },
              { $: "br.com.sankhya.mgeProd.apontamento.ultimo" },
              { $: "br.com.sankhya.mgeProd.apontamento.liberaNroSerie" }
            ];
            
            const answeredEventsStep1 = baseEventsStep1.map(e => {
                if (e.$ === "br.com.sankhya.mgeProd.apontamento.liberaNroSerie") return { $: e.$ };
                if (e.$ === "br.com.sankhya.mgeProd.apontamento.ultimo") return { $: e.$, _clientConfirm: "false" };
                return { $: e.$, _clientConfirm: "true" };
            });

            try {
              // Faz a chamada. Removemos o _clientConfirm da liberaNroSerie para que o callSankhyaApi estoure o erro!
              await callSankhyaApi('/mgeprod', 'OperacaoProducaoSP.confirmarApontamento', {
                params: paramsStep1,
                clientEventList: {
                  clientEvent: baseEventsStep1.concat(answeredEventsStep1)
                }
              }, 1);
              
              // Se passar direto sem pedir série, sucesso.
              finalizarConfirmacaoComSucesso();
              
          } catch(err) {
              if (err.message === "LIBERA_SERIE_REQUIRED" || err.message.indexOf("br.com.sankhya.mgeProd.apontamento.liberaNroSerie") !== -1) {
                  hideLoader();
                  document.getElementById('modal-series-nuapo').value = nuapoStr;
                  document.getElementById('modal-series-ideatv').value = ideatv.value;
                  abrirModalSeries(nuapoStr);
                  return; // Interrompe o fluxo aqui! O usuário continuará pelo modal.
              } else {
                  throw err; // Outro erro, repassa pra fora
              }
          }

        } catch (error) {
          hideLoader();
          showToast("Erro ao confirmar: " + error.message, 'error');
          console.error(error);
        }
      });
    }

    async function abrirModalSeries(nuapo) {
        document.getElementById('modal-series').style.display = 'flex';
        const container = document.getElementById('lista-series-container');
        container.innerHTML = '<div style="text-align:center; padding:20px; color:#94a3b8; font-size:14px;">Buscando séries no Sankhya...</div>';
        
        let series = await fetchSeriesForNuapo();
        window.seriesPendentes = series; // Salva no escopo global para o botão confirmar pegar
        
        if (!series || series.length === 0) {
            container.innerHTML = '<div style="text-align:center; padding:20px; color:#ef4444; font-size:14px;">Nenhuma série encontrada.</div>';
            document.getElementById('contador-series-selecionadas').innerText = "0";
            document.getElementById('contador-series-total').innerText = "0";
            return;
        }
        
        document.getElementById('contador-series-selecionadas').innerText = "0";
        document.getElementById('contador-series-total').innerText = series.length;
        document.getElementById('checkbox-marcar-todas').checked = false;
        
        let html = '';
        for (let i = 0; i < series.length; i++) {
            let s = series[i];
            
            let serieLabel = s.SERIEPA && s.SERIEPA.trim() !== "" ? s.SERIEPA : "VALOR VAZIO NO BANCO";
            let checkboxVal = s.SERIEPA || '';
            
            html += "<div class='prod-card' style='margin-bottom: 12px; border: 1px solid #e2e8f0; border-radius: 8px; overflow: hidden; box-shadow: 0 1px 3px rgba(0,0,0,0.05);'>" +
                        "<div style='display:flex; align-items:center; padding: 12px; background: #f8fafc;'>" +
                            "<input type='checkbox' class='serie-checkbox' data-seriepa='" + checkboxVal + "' data-realserie='" + checkboxVal + "' style='width:22px; height:22px; margin-right:12px; accent-color:var(--emerald-500); cursor:pointer; flex-shrink:0;' onchange='atualizarContadorSeries()'>" +
                            "<div style='font-weight: 700; color:var(--slate-800); font-size: 14px; flex:1;'>" +
                                "Série: <span style='color:#2563eb;'>" + serieLabel + "</span>" +
                            "</div>" +
                        "</div>" +
                    "</div>";
        }
        container.innerHTML = html;
    }
    
    function atualizarContadorSeries() {
        const checkboxes = document.querySelectorAll('.serie-checkbox:checked');
        const allCheckboxes = document.querySelectorAll('.serie-checkbox');
        document.getElementById('contador-series-selecionadas').innerText = checkboxes.length;
        
        const checkboxMarcarTodas = document.getElementById('checkbox-marcar-todas');
        if (checkboxMarcarTodas) {
            checkboxMarcarTodas.checked = (checkboxes.length === allCheckboxes.length && allCheckboxes.length > 0);
        }
    }

    function toggleMarcarTodasSeries(checkboxObj) {
        const checkboxes = document.querySelectorAll('.serie-checkbox');
        checkboxes.forEach(cb => cb.checked = checkboxObj.checked);
        atualizarContadorSeries();
    }

    async function enviarConfirmacaoSeries() {
        const checkboxes = document.querySelectorAll('.serie-checkbox:checked');
        if (checkboxes.length === 0) {
            showToast("Selecione pelo menos uma série para confirmar.", "warning");
            return;
        }

        let seriePAObj = [];
        checkboxes.forEach(cb => {
            seriePAObj.push({ SERIEPA: cb.getAttribute('data-realserie') });
        });
        
        const nuapoStr = document.getElementById('modal-series-nuapo').value;
        
        showLoader("Verificando banco de dados...");
        
        let dbNuapo = null;
        let dbIdiatv = null;
        let dbQtdApontada = 0;
        
        try {
            // Busca o NUAPO, IDIATV e QTDAPONTADA reais direto no banco de dados via API nativa (join com TPRAPA para pegar a Qtd)
            const sqlVerifica = "SELECT A.NUAPO, A.IDIATV, PA.QTDAPONTADA FROM TPRAPO A INNER JOIN TPRAPA PA ON A.NUAPO = PA.NUAPO WHERE A.NUAPO = " + parseInt(nuapoStr);
            const dataVerifica = await callSankhyaApi('/mge', 'DbExplorerSP.executeQuery', { sql: sqlVerifica });
            
            if (dataVerifica && dataVerifica.responseBody && dataVerifica.responseBody.rows && dataVerifica.responseBody.rows.length > 0) {
                dbNuapo = dataVerifica.responseBody.rows[0][0];
                dbIdiatv = dataVerifica.responseBody.rows[0][1];
                dbQtdApontada = parseFloat(dataVerifica.responseBody.rows[0][2] || '0');
            } else {
                hideLoader();
                showToast("Erro crítico: Apontamento não encontrado no banco de dados!", "error");
                return;
            }
            
            if (checkboxes.length !== dbQtdApontada) {
                hideLoader();
                showToast("Aviso: Qtd. de séries selecionadas diferente com a qtd. apontada.", "warning");
                return;
            }
            
            document.getElementById('modal-series').style.display = 'none';
            document.getElementById('loader-text').innerText = "Confirmando Séries Selecionadas...";
            
            // Params construídos 100% com dados retirados do banco
            const paramsStep2 = {
                NUAPO: parseInt(dbNuapo),
                IDIATV: parseInt(dbIdiatv),
                ACEITARQTDMAIOR: false,
                ULTIMOAPONTAMENTO: false,
                RESPOSTA_ULTIMO_APONTAMENTO: "false",
                RESPOSTA_SERIE_LIBERADO: true,
                RESPOSTA_SERIE_LIBERADO_MP: false,
                RESPOSTA_SERIE_LIBERADO_PERDA: false,
                RESPOSTA_ULTIMO_APONTAMENTO: "false",
                SERIES: {
                    SERIESPA: { seriePA: seriePAObj },
                    SERIESMP: { serieMP: [] }
                }
            };

            // O nativo envia a lista de eventos duas vezes: a primeira declarando o listener, a segunda enviando a resposta!
            const eventBase = [
              { $: "br.com.sankhya.mgeprod.apontamentos.divergentes" },
              { $: "br.com.sankhya.mgeProd.wc.indisponivel" },
              { $: "br.com.sankhya.mgeprod.redimensionar.op.pa.perda" },
              { $: "br.com.sankhya.mgeprod.redimensionar.op.pa.avisos" },
              { $: "br.com.sankhya.mgeprod.trocaturno.avisos" },
              { $: "br.com.sankhya.mgeprod.finalizar.liberacao.desvio.pa" },
              { $: "br.com.sankhya.actionbutton.clientconfirm" },
              { $: "br.com.sankhya.mgeProd.apontamento.ultimo" },
              { $: "br.com.sankhya.mgeprod.operacaoproducao.mpalt.proporcao.apontamento.invalida" },
              { $: "br.com.sankhya.mgeProd.apontamento.liberaNroSerie" },
              { $: "br.com.sankhya.prod.remove.apontamento.pesagemvolume" },
              { $: "br.com.sankhya.mgeprod.confirma.ultimo.apontamento.mp.fixo" },
              { $: "br.com.sankhya.apontamentomp.naoreproporcionalizado" }
            ];
            
            const answeredEvents = eventBase.map(e => {
                if (e.$ === "br.com.sankhya.mgeProd.apontamento.liberaNroSerie") return { $: e.$ };
                if (e.$ === "br.com.sankhya.mgeProd.apontamento.ultimo" || e.$ === "br.com.sankhya.mgeprod.confirma.ultimo.apontamento.mp.fixo") {
                    return { $: e.$, _clientConfirm: "false" };
                }
                return { $: e.$, _clientConfirm: "true" };
            });
            
            const finalEventList = eventBase.concat(answeredEvents);

            await callSankhyaApi('/mgeprod', 'OperacaoProducaoSP.confirmarApontamento', {
              params: paramsStep2,
              clientEventList: {
                clientEvent: finalEventList
              }
            });
            
            finalizarConfirmacaoComSucesso();
        } catch(e) {
            hideLoader();
            showToast("Erro ao processar as séries: " + e.message, "error");
        }
    }
    
    async function finalizarConfirmacaoComSucesso() {
        // Tenta garantir o AD_QTDIMPETQ atualizando a tabela após a confirmação nativa
        try {
            if (window.seriesPendentes && window.seriesPendentes.length > 0) {
                let seriesValues = window.seriesPendentes.map(s => "'" + s.SERIEPA + "'").join(",");
                const sqlUpdate = "UPDATE TGFSER SET AD_QTDIMPETQ = 1 WHERE SERIE IN (" + seriesValues + ")";
                await callSankhyaApi('/mge', 'DbExplorerSP.executeQuery', { sql: sqlUpdate, query: sqlUpdate });
            }
        } catch(eUpd) {
            console.warn("Silencioso: falha ao rodar update customizado", eUpd);
        }

        hideLoader();
        showToast('Apontamento confirmado com SÉRIES!', 'success');
        setTimeout(() => window.location.reload(), 1500);
    }
    
    async function imprimirEtiqueta(nuapo, nunota) {
        try {
          if (!nunota || nunota.trim() === '') {
            showToast("Apontamento sem Nota: Confirme o apontamento primeiro para gerar a NUNOTA.", "warning");
            return;
          }

          // TRUQUE PARA MOBILE: Os celulares bloqueiam window.open se a chamada acontecer 
          // DEPOIS de um "await" (pois eles perdem o contexto do clique do usuário).
          // A solução é abrir a aba EM BRANCO agora mesmo, antes de ir no servidor, e depois atualizar ela.
          let newTab = null;
          try {
             newTab = window.open('', '_blank');
          } catch(e) {}

          showToast("Gerando etiqueta...", "info");

          const rawIdiproc = document.getElementById('val-idiproc').value;
          const cleanNunota = parseInt(String(nunota).replace(/\./g, '')).toString();
          const cleanIdiproc = parseInt(String(rawIdiproc).replace(/\./g, '')).toString();

          const requestBody = {
            relatorio: {
              nuRfe: 189,
              parametros: {
                parametro: [
                  {
                    classe: "java.lang.String",
                    descricao: "Nr. Único Apontamento Produção",
                    nome: "P_NUNOTAPROD",
                    pesquisa: "false",
                    requerido: "false",
                    valor: cleanNunota
                  },
                  {
                    classe: "java.math.BigDecimal",
                    descricao: "Nro OP",
                    nome: "P_IDIPROC",
                    pesquisa: "false",
                    requerido: "false",
                    valor: cleanIdiproc
                  }
                ]
              }
            }
          };

          const resp = await callSankhyaApi('/mge', 'VisualizadorRelatorios.visualizarRelatorio', requestBody);
          
          if (resp && resp.responseBody && resp.responseBody.chave) {
            let chaveStr = typeof resp.responseBody.chave === 'object' ? resp.responseBody.chave.valor : resp.responseBody.chave;
            
            if (!chaveStr) {
               showToast("A chave gerada pelo servidor é inválida.", "error");
               return;
            }

            // ATENÇÃO: Se quisermos baixar na mesma tela (sem openLevel), 
            // PRECISAREMOS saber o nome da "URL misteriosa" do F12.
            // Para efeitos de teste, deixei "visualizadorRelatorio.mge" no código, 
            // mas você pode alterar para o que achar no F12!
            
            // URL Exata descoberta no F12 da tela nativa!
            const finalUrl = '/mge/visualizadorArquivos.mge?chaveArquivo=' + chaveStr;
            
            if (newTab) {
                newTab.location.href = finalUrl;
            } else {
                // Se até a aba em branco foi bloqueada pelo celular, redirecionamos a própria página
                window.location.href = finalUrl;
            }

          } else {
            if (newTab) newTab.close();
            showToast("Falha: Chave de download não retornada pelo servidor.", "warning");
          }
        } catch (e) {
          console.error("Erro ao imprimir etiqueta:", e);
          showToast("Erro ao imprimir: " + e.message, "error");
        }
      }

    function excluirApontamento(nuapo) {
      showCustomConfirm('Deseja realmente excluir este apontamento?', async function() {
        try {
          await callSankhyaApi('/mge', 'CRUDServiceProvider.removeRecord', {
            entityName: 'ApontamentoProducao',
            keys: {
              NUAPO: nuapo
            }
          });
          showToast('Apontamento excluído com sucesso!', 'success');
          setTimeout(() => window.location.reload(), 1500);
        } catch (error) {
          showToast('Erro ao excluir: ' + error.message, 'error');
          console.error(error);
        }
      });
    }

    // ==========================================
    // INITIALIZATION
    // ==========================================

    function updateMaintItemSector() {
      const itemSelect = document.getElementById('maint-coditem');
      if (itemSelect.selectedIndex > 0) {
        const setorId = itemSelect.options[itemSelect.selectedIndex].getAttribute('data-setor');
        if (setorId) {
          document.getElementById('maint-codsetor').value = setorId;
        }
      }
    }

    function toggleMaintStatusOutros() {
      const statusSelect = document.getElementById('maint-statusprod');
      const divOutros = document.getElementById('maint-statusoutros-div');
      if (statusSelect.value === "3") {
        divOutros.classList.remove('hidden');
      } else {
        divOutros.classList.add('hidden');
      }
    }

    function toggleMaintCatOutros() {
      const cbOutros = document.getElementById('maint-cat-outros');
      const divOutros = document.getElementById('maint-cat-outros-div');
      if (cbOutros.checked) {
        divOutros.classList.remove('hidden');
      } else {
        divOutros.classList.add('hidden');
      }
    }

    async function salvarAberturaOS() {
      const coditem = document.getElementById('maint-coditem').value;
      const codsetor = document.getElementById('maint-codsetor').value;
      const solicitante = document.getElementById('maint-solicitante').value;
      const statusprod = document.getElementById('maint-statusprod').value;
      const statusoutros = document.getElementById('maint-statusoutros').value;
      const anormalidade = document.getElementById('maint-anormalidade').value;
      const tpmanutencao = document.getElementById('maint-tpmanutencao').value;
      
      const isEletrica = document.getElementById('maint-cat-eletrica').checked ? "S" : "N";
      const isHidraulica = document.getElementById('maint-cat-hidraulica').checked ? "S" : "N";
      const isPneumatica = document.getElementById('maint-cat-pneumatica').checked ? "S" : "N";
      const isMecanica = document.getElementById('maint-cat-mecanica').checked ? "S" : "N";
      const isFerramental = document.getElementById('maint-cat-ferramental').checked ? "S" : "N";
      const isSerralheria = document.getElementById('maint-cat-serralheria').checked ? "S" : "N";
      const isPredial = document.getElementById('maint-cat-predial').checked ? "S" : "N";
      const isOutros = document.getElementById('maint-cat-outros').checked ? "S" : "N";
      const detaoutros = document.getElementById('maint-detaoutros').value;

      if (!coditem || !codsetor) {
        showToast("Selecione o Item e o Setor.", "warning");
        return;
      }

      if (statusprod === '3' && !statusoutros) {
        showToast("Descreva o status da produção.", "warning");
        return;
      }

      if (isOutros === 'S' && !detaoutros) {
        showToast("Descreva a outra categoria.", "warning");
        return;
      }

      try {
        showLoader("Abrindo OS...");
        const body = {
          rootEntity: "AD_MCABOS",
          includePresentationFields: "N",
          dataRow: {
            localFields: {
              CODITEM: { $: parseInt(coditem) },
              CODSETOR: { $: parseInt(codsetor) },
              SOLICITANTE: { $: solicitante },
              STATUSPRODCAO: { $: statusprod },
              STATUSOUTROS: { $: statusoutros },
              ANORMALIDADE: { $: anormalidade },
              TPMANUTENCAO: { $: tpmanutencao },
              ELETRICA: { $: isEletrica },
              HIDRAULICA: { $: isHidraulica },
              PNEUMATICA: { $: isPneumatica },
              MECANICA: { $: isMecanica },
              FERRAMENTAL: { $: isFerramental },
              SERRALHERIA: { $: isSerralheria },
              PREDIAL: { $: isPredial },
              OUTROS: { $: isOutros },
              DETAOUTROS: { $: detaoutros },
              STATUSORDEMSERVICO: { $: "0" } // Aguardando Atendimento
            }
          },
          entity: {
            fieldset: {
              list: "CODITEM,CODSETOR,SOLICITANTE,STATUSPRODCAO,STATUSOUTROS,ANORMALIDADE,TPMANUTENCAO,ELETRICA,HIDRAULICA,PNEUMATICA,MECANICA,FERRAMENTAL,SERRALHERIA,PREDIAL,OUTROS,DETAOUTROS,STATUSORDEMSERVICO"
            }
          }
        };

        const response = await callSankhyaApi('/mge', 'CRUDServiceProvider.saveRecord', { dataSet: body });

        hideLoader();
        if (response && response.responseBody && response.responseBody.entities && response.responseBody.entities.entity) {
           const ent = Array.isArray(response.responseBody.entities.entity) ? response.responseBody.entities.entity[0] : response.responseBody.entities.entity;
           const osNum = ent.OSNUM ? (ent.OSNUM.$ !== undefined ? ent.OSNUM.$ : ent.OSNUM) : "Desconhecido";
           showToast('OS ' + osNum + ' aberta com sucesso!', 'success');
           
           // Limpa formulário
           document.getElementById('maint-coditem').value = '';
           document.getElementById('maint-codsetor').value = '';
           document.getElementById('maint-solicitante').value = '';
           document.getElementById('maint-statusprod').value = '3';
           document.getElementById('maint-statusoutros').value = '';
           document.getElementById('maint-anormalidade').value = '';
           toggleMaintStatusOutros();
           
           setTimeout(() => maintNavigate('MENU'), 1500);
        } else {
           showToast('OS aberta com sucesso!', 'success');
           setTimeout(() => maintNavigate('MENU'), 1500);
        }
      } catch (error) {
        hideLoader();
        showToast("Erro ao abrir OS: " + error.message, 'error');
      }
    }

    async function buscarOSFechamento() {
      const osnum = document.getElementById('maint-fech-osnum').value;
      if (!osnum) { showToast("Digite o número da OS.", "error"); return; }
      
      try {
        showLoader("Buscando OS...");
        const sqlOS = "SELECT OS.OSNUM, (SELECT m.descmaquina FROM ad_mitens m WHERE m.coditem = OS.coditem) AS DESCITEM, (SELECT upper(s.setdescricao) FROM ad_msetor s WHERE s.codsetor = OS.codsetor) AS SETORDESCRICAO, OS.CODTEC, OS.TPMANUTENCAO, OS.STATUSORDEMSERVICO, OS.MOTIVOMANUTECAO, OS.CAUSAMANUTENCAO FROM AD_MCABOS OS WHERE OS.OSNUM = " + parseInt(osnum);

        const response = await callSankhyaApi('/mge', 'DbExplorerSP.executeQuery', { sql: sqlOS, query: sqlOS });
        hideLoader();

        if (response && response.responseBody && response.responseBody.rows && response.responseBody.rows.length > 0) {
           const row = response.responseBody.rows[0];
           
           document.getElementById('maint-fech-det-maquina').innerText = row[1] || '-'; // DESCITEM
           document.getElementById('maint-fech-det-setor').innerText = row[2] || '-'; // SETORDESCRICAO
           
           document.getElementById('maint-fech-tecnico').value = row[3] || ''; // CODTEC
           document.getElementById('maint-fech-tpmanutencao').value = row[4] || '4'; // TPMANUTENCAO
           document.getElementById('maint-fech-statusos').value = row[5] || '0'; // STATUSORDEMSERVICO
           document.getElementById('maint-fech-motivo').value = row[6] || ''; // MOTIVOMANUTECAO
           document.getElementById('maint-fech-causa').value = row[7] || ''; // CAUSAMANUTENCAO

           document.getElementById('maint-fech-details').classList.remove('hidden');
           
           recarregarHorasOS(osnum);
        } else {
           showToast("OS não encontrada.", "warning");
           document.getElementById('maint-fech-details').classList.add('hidden');
        }
      } catch (e) {
        hideLoader();
        showToast("Erro ao buscar OS: " + e.message, "error");
      }
    }

    async function recarregarHorasOS(osnum) {
      try {
        const sqlHoras = "SELECT h.OSNUM, h.HR_INICIAL, h.HR_FINAL, h.CODTEC, t.TEC_NOME FROM AD_MHORASSERV h LEFT JOIN AD_MCADTECNICO t ON h.CODTEC = t.CODTEC WHERE h.OSNUM = " + parseInt(osnum);

        const response = await callSankhyaApi('/mge', 'DbExplorerSP.executeQuery', { sql: sqlHoras, query: sqlHoras });
        
        const list = document.getElementById('maint-fech-horas-list');
        list.innerHTML = '';
        
        if (response && response.responseBody && response.responseBody.rows && response.responseBody.rows.length > 0) {
           response.responseBody.rows.forEach(row => {
             const dtIniStr = row[1] || '';
             const dtFimStr = row[2] || '';
             const tecName = row[4] || row[3] || 'Não informado'; // TEC_NOME or CODTEC
             
             const formatDisplayDate = (dStr) => {
                 if (!dStr) return '';
                 if (typeof dStr === 'number') {
                     const d = new Date(dStr);
                     return d.toLocaleDateString('pt-BR') + ' ' + d.toLocaleTimeString('pt-BR').substring(0,5);
                 }
                 let str = String(dStr).trim();
                 
                 // Formato "22062026 09:46:00"
                 if (str.length >= 8 && !str.includes('/') && !str.includes('-')) {
                     const dd = str.substring(0,2);
                     const mm = str.substring(2,4);
                     const yyyy = str.substring(4,8);
                     let time = '';
                     if (str.length > 8) {
                         const timePart = str.substring(8).trim();
                         time = ' ' + timePart.substring(0, 5);
                     }
                     return dd + '/' + mm + '/' + yyyy + time;
                 }
                 // Formato "22/06/2026 09:46:00"
                 if (str.includes('/')) {
                     const parts = str.split(' ');
                     if (parts.length >= 2) return parts[0] + ' ' + parts[1].substring(0, 5);
                     return str.substring(0, 16);
                 }
                 // Formato ISO "2026-06-22T09:46"
                 if (str.includes('T')) {
                     return str.substring(0, 16).split('T').reverse().join(' ').replace(/-/g, '/').replace(/(\d{4})\/(\d{2})\/(\d{2})/, '$3/$2/$1');
                 }
                 return str.substring(0, 16);
             };
             
             let fIni = formatDisplayDate(dtIniStr); 
             let fFim = formatDisplayDate(dtFimStr);

             const card = document.createElement('div');
             card.style.cssText = "background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 8px; padding: 12px; display: flex; flex-direction: column; gap: 4px; box-shadow: 0 1px 2px rgba(0,0,0,0.05);";
             
             card.innerHTML = 
                '<div style="display:flex; justify-content:space-between; align-items:center;">' +
                    '<div style="font-size:13px; font-weight:700; color:var(--slate-800);"><span style="color:var(--emerald-600);">Início:</span> ' + fIni + '</div>' +
                    '<div style="font-size:13px; font-weight:700; color:var(--slate-800);"><span style="color:var(--rose-500);">Fim:</span> ' + fFim + '</div>' +
                '</div>' +
                '<div style="margin-top:6px; font-size:12px; font-weight:600; color:var(--slate-500); border-top:1px solid #e2e8f0; padding-top:6px;">' +
                    'Técnico: <span style="color:var(--slate-800);">' + tecName + '</span>' +
                '</div>';
             list.appendChild(card);
           });
        } else {
           list.innerHTML = '<div style="text-align:center; padding:12px; color:#94a3b8; font-size:13px; font-weight:600; background:#f8fafc; border-radius:8px; border:1px dashed #cbd5e1;">Nenhuma hora lançada.</div>';
        }
      } catch (e) {
        showToast("Erro ao carregar horas.", "error");
        console.error("Erro ao carregar horas: ", e);
      }
    }

    async function adicionarHorasOS() {
      const osnum = document.getElementById('maint-fech-osnum').value;
      const hrInicial = document.getElementById('maint-fech-hrinicial').value;
      const hrFinal = document.getElementById('maint-fech-hrfinal').value;
      const codtec = document.getElementById('maint-fech-tecnico').value; 

      if (!osnum) { showToast("OS não carregada", "error"); return; }
      if (!hrInicial || !hrFinal) { showToast("Preencha a data/hora inicial e final", "error"); return; }
      if (!codtec) { showToast("Selecione o técnico responsável na OS", "error"); return; }
      
      function fmtData(val) {
          if (!val) return "";
          if (val.length === 16 && val.indexOf('/') !== -1) {
              return val + ':00';
          }
          const d = new Date(val);
          if (isNaN(d.getTime())) return val;
          const dia = String(d.getDate()).padStart(2, '0');
          const mes = String(d.getMonth()+1).padStart(2, '0');
          const ano = d.getFullYear();
          const hr = String(d.getHours()).padStart(2, '0');
          const mn = String(d.getMinutes()).padStart(2, '0');
          return dia + "/" + mes + "/" + ano + " " + hr + ":" + mn + ":00";
      }

      try {
        showLoader("Registrando horas...");
        await callSankhyaApi('/mge', 'DatasetSP.save', {
          dataSetID: "DS_MHORASSERV",
          entityName: "AD_MHORASSERV",
          standAlone: false,
          parentEntityName: "AD_MCABOS",
          fields: [ "OSNUM", "HR_INICIAL", "HR_FINAL", "CODTEC" ],
          records: [{
             pk: { OSNUM: osnum.toString() },
             foreignKey: { OSNUM: osnum.toString() },
             values: {
                "0": osnum.toString(),
                "1": fmtData(hrInicial),
                "2": fmtData(hrFinal),
                "3": codtec.toString()
             }
          }]
        });

        hideLoader();
        showToast("Horas registradas!", "success");
        document.getElementById('maint-fech-hrinicial').value = '';
        document.getElementById('maint-fech-hrfinal').value = '';
        recarregarHorasOS(osnum);
      } catch (error) {
        hideLoader();
        showToast("Erro ao lançar hora: " + error.message, "error");
      }
    }

    async function salvarFechamentoOS() {
      const osnum = document.getElementById('maint-fech-osnum').value;
      const tecnico = document.getElementById('maint-fech-tecnico').value;
      const tpmanutencao = document.getElementById('maint-fech-tpmanutencao').value;
      const statusos = document.getElementById('maint-fech-statusos').value;
      const motivo = document.getElementById('maint-fech-motivo').value;
      const causa = document.getElementById('maint-fech-causa').value;

      if (!osnum) { showToast("OS não carregada", "error"); return; }
      if (!tecnico) { showToast("Selecione um técnico para fechar/editar", "error"); return; }
      
      try {
        showLoader("Fechando/Salvando OS...");
        const body = {
          rootEntity: "AD_MCABOS",
          includePresentationFields: "N",
          dataRow: {
            key: {
              OSNUM: { $: parseInt(osnum) }
            },
            localFields: {
              CODTEC: { $: parseInt(tecnico) },
              TPMANUTENCAO: { $: tpmanutencao },
              STATUSORDEMSERVICO: { $: statusos },
              MOTIVOMANUTECAO: { $: motivo },
              CAUSAMANUTENCAO: { $: causa }
            }
          },
          entity: {
            fieldset: {
              list: "CODTEC,TPMANUTENCAO,STATUSORDEMSERVICO,MOTIVOMANUTECAO,CAUSAMANUTENCAO"
            }
          }
        };

        const response = await callSankhyaApi('/mge', 'CRUDServiceProvider.saveRecord', { dataSet: body });
        
        hideLoader();
        
        // Verifica se houve erro de permissão ou similar dentro do payload de sucesso
        if (response && response.status === '0') {
            showToast("Erro do Sankhya: " + (response.statusMessage || "Falha ao salvar."), "error");
            return;
        }

        showToast("OS atualizada com sucesso!", "success");
        setTimeout(() => maintNavigate('MENU'), 1500);
      } catch (error) {
        hideLoader();
        showToast("Erro ao fechar OS: " + error.message, "error");
      }
    }

    // Search OP and Reload Page
    function lerOP() {
      const input = document.getElementById('input-nro-op');
      const nroOp = input.value.trim();
      
      if (!nroOp) {
        showToast('Informe o Nro. da OP.', 'error');
        return;
      }
      
      let currentUrl = window.location.href.split('#')[0];
      // remove old params if they exist to avoid duplicate injection
      currentUrl = currentUrl.replace(/&nroOp=\d+/g, '').replace(/&tela=\w+/g, '').replace(/&subtela=\w+/g, '');
      currentUrl = currentUrl.replace(/\?nroOp=\d+&/g, '?').replace(/\?tela=\w+&/g, '?').replace(/\?subtela=\w+&/g, '?');
      
      const separator = currentUrl.includes('?') ? '&' : '?';
      window.location.href = currentUrl + separator + 'nroOp=' + nroOp + '&tela=PRODUCTION';
    }

    // Navigation function
    function navigate(moduleName) {
      // Hide all screens
      screens.forEach(s => {
        const el = document.getElementById('screen-' + s);
        if (el) el.classList.add('hidden');
      });

      // Show target screen
      const target = document.getElementById('screen-' + moduleName);
      if (target) {
        target.classList.remove('hidden');
      }

      // Update state
      state.activeModule = moduleName;

      // Update Header
      const headerTitle = document.getElementById('header-title');
      if (headerTitle) headerTitle.innerText = titles[moduleName];

      const btnBack = document.getElementById('btn-back');
      if (moduleName === 'MENU') {
        btnBack.classList.add('hidden');
      } else {
        btnBack.classList.remove('hidden');
      }

      // Auto-focus NRO OP on PRODUCTION
      if (moduleName === 'PRODUCTION') {
        setTimeout(() => {
          const opInput = document.getElementById('input-nro-op');
          if (opInput) opInput.focus();
        }, 50);
      }
    }

    // Gerenciamento de Loader
    function showLoader(msg) {
      if (!msg) msg = "Processando...";
      const textEl = document.getElementById('loader-text');
      const overlay = document.getElementById('loader-overlay');
      if (textEl) textEl.innerText = msg;
      if (overlay) overlay.classList.remove('hidden');
    }

    function hideLoader() {
      const overlay = document.getElementById('loader-overlay');
      if (overlay) overlay.classList.add('hidden');
    }

    // Toast Notification System
    function showToast(message, type = 'info') {
      const container = document.getElementById('toast-container');
      if (!container) return;
      
      const toast = document.createElement('div');
      toast.className = 'toast ' + type;
      
      let iconSvg = '';
      if (type === 'success') {
        iconSvg = '<svg class="icon" style="color:#34d399; flex-shrink:0" viewBox="0 0 24 24" width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>';
      } else if (type === 'error') {
        iconSvg = '<svg class="icon" style="color:#fb7185; flex-shrink:0" viewBox="0 0 24 24" width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3Z"/><path d="M12 9v4"/><path d="M12 17h.01"/></svg>';
      } else {
        iconSvg = '<svg class="icon" style="color:#60a5fa; flex-shrink:0" viewBox="0 0 24 24" width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="16" x2="12" y2="12"/><line x1="12" y1="8" x2="12.01" y2="8"/></svg>';
      }
      
      toast.innerHTML = iconSvg + '<span style="flex:1">' + message + '</span>';
      container.appendChild(toast);
      
      setTimeout(() => {
        toast.style.animation = 'slideIn 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275) reverse forwards';
        setTimeout(() => {
          if (container.contains(toast)) container.removeChild(toast);
        }, 300);
      }, 4000);
    }
    <c:if test="${not empty param.tela}">
      navigate('<c:out value="${param.tela}"/>');
      <c:if test="${not empty param.subtela}">
        maintNavigate('<c:out value="${param.subtela}"/>');
      </c:if>
    </c:if>
    <c:if test="${not empty param.nroOp and empty opQuery.rows}">
      setTimeout(() => { showToast('OP não encontrada no Sankhya.', 'error'); }, 400);
    </c:if>
    <c:if test="${not empty param.nroOp and not empty opQuery.rows}">
      setTimeout(() => { showToast('OP carregada com sucesso!', 'success'); }, 400);
    </c:if>

    // Módulo Qualidade
    function lerOPQuali() {
      const op = document.getElementById('input-nro-op-quali').value;
      if (!op) {
        showToast("Digite o Nro da OP!", "warning");
        return;
      }
      
      let currentUrl = window.location.href.split('#')[0];
      currentUrl = currentUrl.replace(/&nroOp=\d+/g, '').replace(/&tela=\w+/g, '');
      currentUrl = currentUrl.replace(/\?nroOp=\d+&/g, '?').replace(/\?tela=\w+&/g, '?');
      
      const separator = currentUrl.includes('?') ? '&' : '?';
      window.location.href = currentUrl + separator + 'nroOp=' + op + '&tela=QUALITY';
    }

    async function salvarCNC() {
      const idiproc = document.getElementById('val-idiproc') ? document.getElementById('val-idiproc').value : null;
      if (!idiproc) {
        showToast("OP não carregada. Leia a OP primeiro.", "error");
        return;
      }

      function formatDateTimeForSankhya(val) {
        if (!val) return "";
        if (val.length === 16 && val.indexOf('/') !== -1) {
            return val + ':00';
        }
        if (val.indexOf('T') !== -1) {
            const parts = val.split('T');
            if (parts.length !== 2) return val;
            const d = parts[0].split('-');
            return d[2] + '/' + d[1] + '/' + d[0] + ' ' + parts[1] + ':00';
        }
        return val;
      }

      const inicioRaw = document.getElementById('cnc-dtinicio').value;
      const fimRaw = document.getElementById('cnc-dtfinal').value;
      const qtdpessoas = document.getElementById('cnc-qtdpessoas').value;
      const codmtp = document.getElementById('cnc-codmtp').value;

      if (!inicioRaw || !fimRaw || !qtdpessoas || !codmtp) {
        showToast("Preencha todos os campos da Causa NC.", "warning");
        return;
      }

      try {
        const body = {
          rootEntity: "AD_CNC",
          includePresentationFields: "N",
          dataRow: {
            localFields: {
              IDIPROC: { $: parseInt(idiproc) },
              DTINICIO: { $: formatDateTimeForSankhya(inicioRaw) },
              DTFINAL: { $: formatDateTimeForSankhya(fimRaw) },
              QTDPESSOAS: { $: parseFloat(qtdpessoas) },
              CODMTP: { $: parseInt(codmtp) }
            }
          },
          entity: {
            fieldset: {
              list: "IDIPROC,DTINICIO,DTFINAL,QTDPESSOAS,CODMTP"
            }
          }
        };

        await callSankhyaApi('/mge', 'CRUDServiceProvider.saveRecord', { dataSet: body });
        showToast("Causa NC gravada com sucesso!", "success");
        setTimeout(() => window.location.reload(), 1500);
      } catch (error) {
        showToast("Erro ao gravar CNC: " + error.message, "error");
      }
    }

    function excluirCNC(seq) {
      showCustomConfirm("Deseja realmente excluir este registro de Causa NC?", async function() {
        const idiproc = document.getElementById('val-idiproc').value;
        try {
          await callSankhyaApi('/mge', 'CRUDServiceProvider.removeRecord', {
            entityName: "AD_CNC",
            primaryKey: {
              IDIPROC: { $: parseInt(idiproc) },
              SEQ: { $: parseInt(seq) }
            }
          });
          showToast("Registro excluído!", "success");
          setTimeout(() => window.location.reload(), 1500);
        } catch (error) {
          showToast("Erro ao excluir: " + error.message, "error");
        }
      });
    }

    async function salvarQuali() {
      const idiproc = document.getElementById('val-idiproc') ? document.getElementById('val-idiproc').value : null;
      if (!idiproc) {
        showToast("OP não carregada. Leia a OP primeiro.", "error");
        return;
      }

      const anomalia = document.getElementById('quali-anomalia').value;
      const setor = document.getElementById('quali-setor').value;
      const amostra = document.getElementById('quali-amostra').value;
      const reprovada = document.getElementById('quali-reprovada').value;
      const retida = document.getElementById('quali-retida').value;
      const notificada = document.getElementById('quali-notificada').value;

      try {
        const body = {
          rootEntity: "AD_QUALIHAIALA",
          includePresentationFields: "N",
          dataRow: {
            localFields: {
              IDIPROC: { $: parseInt(idiproc) },
              QTDAMOSTRA: { $: parseFloat(amostra || "0") },
              QTDREPROVADA: { $: parseFloat(reprovada || "0") },
              QTDRETIDA: { $: parseFloat(retida || "0") },
              QTDNOTIFICADA: { $: parseFloat(notificada || "0") }
            }
          },
          entity: {
            fieldset: {
              list: "IDIPROC,ANOMALIA,SETOR_DEF,QTDAMOSTRA,QTDREPROVADA,QTDRETIDA,QTDNOTIFICADA"
            }
          }
        };

        if (anomalia) body.dataRow.localFields.ANOMALIA = { $: parseInt(anomalia) };
        if (setor) body.dataRow.localFields.SETOR_DEF = { $: parseInt(setor) };

        showLoader("Gravando Qualidade...");

        await callSankhyaApi('/mge', 'CRUDServiceProvider.saveRecord', { dataSet: body });
        hideLoader();
        showToast("Informações de Qualidade gravadas!", "success");
        setTimeout(() => window.location.reload(), 1500);
      } catch (error) {
        hideLoader();
        showToast("Erro ao gravar Qualidade: " + error.message, "error");
      }
    }

    function excluirQuali(seq) {
      showCustomConfirm("Deseja realmente excluir este registro de Qualidade?", async function() {
        const idiproc = document.getElementById('val-idiproc').value;
        try {
          await callSankhyaApi('/mge', 'CRUDServiceProvider.removeRecord', {
            entityName: "AD_QUALIHAIALA",
            primaryKey: {
              IDIPROC: { $: parseInt(idiproc) },
              SEQUENCIAL: { $: parseInt(seq) }
            }
          });
          showToast("Registro excluído!", "success");
          setTimeout(() => window.location.reload(), 1500);
        } catch (error) {
          showToast("Erro ao excluir: " + error.message, "error");
        }
      });
    }

  </script>
  </body>
</html>
</c:otherwise>
</c:choose>
