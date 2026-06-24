<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>

<c:choose>
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
            <!-- Wavy flag placeholder -->
            <svg style="width: 48px; height: 32px; margin-right: 6px;" viewBox="0 0 100 60" fill="currentColor">
              <path d="M5 20 Q 15 12, 25 22 T 45 18 L 45 45 Q 35 39, 25 49 T 5 43 Z" color="#059669" />
              <path d="M14 31 L 25 21 L 36 31 L 25 41 Z" color="#facc15" />
              <circle cx="25" cy="31" r="7.5" color="#312e81" />
            </svg>
            
            <div class="brand-name">
              <span class="brand-name-title">Haiala</span>
              <span class="brand-name-subtitle">PORTAS E JANELAS</span>
            </div>
            
            <div class="logo-separator"></div>
            
            <div class="anos-emblem">
              <span class="anos-number">45</span>
              <div style="position:absolute; bottom:-4px; right:-8px; background:#059669; color:white; font-size:7px; font-weight:bold; border-radius:50%; width:20px; height:20px; display:flex; align-items:center; justify-content:center; border:1px solid #facc15;">anos</div>
            </div>
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
                  <input type="datetime-local" id="input-apo-inicio" class="prod-form-input">
                </div>
                <div class="prod-form-item">
                  <span class="prod-form-lbl">Dh. Final [P]: *</span>
                  <input type="datetime-local" id="input-apo-fim" class="prod-form-input">
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
                  <input type="datetime-local" id="cnc-dtinicio" class="prod-form-input">
                </div>
                <div class="prod-form-item">
                  <span class="prod-form-lbl">Data/Hora Final: *</span>
                  <input type="datetime-local" id="cnc-dtfinal" class="prod-form-input">
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
                  <span class="prod-form-lbl">Cod Anomalia: *</span>
                  <select id="quali-anomalia" class="prod-form-input" style="appearance: auto;">
                    <option value="">Selecione...</option>
                    <option value="10">10 Medida(s)</option>
                    <option value="11">11 Avarias</option>
                    <option value="12">12 Pintura/Acabamento</option>
                    <option value="13">13 Alinhamento</option>
                    <option value="14">14 Solda MIG</option>
                    <option value="15">15 Solda Ponto</option>
                    <option value="16">16 Vedação</option>
                    <option value="17" selected>17 Regulagem/Funcionamento</option>
                  </select>
                </div>
                <div class="prod-form-item">
                  <span class="prod-form-lbl">Origem Defeito: *</span>
                  <select id="quali-setor" class="prod-form-input" style="appearance: auto;">
                    <option value="">Selecione...</option>
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
                    <option value="24" selected>DEVOLUÇÃO</option>
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
                  <input type="datetime-local" id="maint-fech-hrinicial" class="maint-input" style="padding:6px;">
                </div>
                <div style="flex:1">
                  <label class="maint-label">Hora Final:</label>
                  <input type="datetime-local" id="maint-fech-hrfinal" class="maint-input" style="padding:6px;">
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
           let confirmedEvent = {
               $: ev.id,
               _clientConfirm: "true"
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

    async function fetchSeriesForNuapo(nuapo) {
      try {
        let url = '/mgeprod/service.sbr?serviceName=DatasetSP.loadRecords&outputType=json';
        const sessionMatch = document.cookie.match(/JSESSIONID=([^;]+)/);
        if (sessionMatch) url += '&mgeSession=' + sessionMatch[1].split('.')[0];

        const req = {
          dataSetID: "DS_SERIES_AUTO",
          entityName: "SerieProdutoAcabado",
          fields: ["NROSERIE"],
          criteria: { expression: "NUAPO = " + nuapo }
        };
        const response = await fetch(url, {
            method: 'POST',
            body: JSON.stringify({serviceName: 'DatasetSP.loadRecords', requestBody: req}),
            headers: {'Content-Type': 'application/json;charset=UTF-8', 'Accept': 'application/json'}
        });
        const data = await response.json();
        let series = [];
        if (data.responseBody && data.responseBody.entities && data.responseBody.entities.entity) {
            let list = Array.isArray(data.responseBody.entities.entity) ? data.responseBody.entities.entity : [data.responseBody.entities.entity];
            for (let i = 0; i < list.length; i++) {
                if (list[i].f0 && list[i].f0.$) {
                    series.push({ SERIEPA: list[i].f0.$ });
                }
            }
        }
        return series;
      } catch (e) {
        console.error("Erro ao buscar series:", e);
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
      
      function formatDateTimeForSankhya(datetimeLocalVal) {
        if (!datetimeLocalVal) return "";
        const parts = datetimeLocalVal.split('T');
        if (parts.length !== 2) return datetimeLocalVal;
        const d = parts[0].split('-');
        return d[2] + '/' + d[1] + '/' + d[0] + ' ' + parts[1] + ':00';
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

        // PASSO 2: Atualizar ou INSERIR o CABEÇALHO do apontamento
        try {
          let pkCabecalho = isNovoCabecalho ? {} : { NUAPO: nuapo.toString() };
          
          const respCab = await callSankhyaApi('/mge', 'DatasetSP.save', {
            dataSetID: "01J",
            entityName: "CabecalhoApontamento",
            standAlone: false,
            parentEntityName: "InstanciaAtividade",
            fields: ["NUAPO", "IDIATV", "AD_QTDPESSOAS", "AD_DHINICIO", "AD_DHFINAL", "AD_TURNO"],
            records: [
              {
                pk: pkCabecalho,
                foreignKey: { IDIATV: ideatv.value.toString() },
                values: {
                  "0": nuapo.toString(),
                  "1": ideatv.value.toString(),
                  "2": (pessoas || 0).toString(),
                  "3": dhInicio,
                  "4": dhFim,
                  "5": (turno || "1").toString()
                }
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
          showLoader("Gerando Número de Série...");
          
          // Busca as séries dinamicamente caso o produto controle número de série
          let seriePAObj = await fetchSeriesForNuapo(nuapoStr);

          showLoader("Finalizando o Apontamento...");

          await callSankhyaApi('/mgeprod', 'OperacaoProducaoSP.confirmarApontamento', {
            params: {
              NUAPO: parseInt(nuapoStr),
              IDIATV: parseInt(ideatv.value),
              ACEITARQTDMAIOR: false,
              ULTIMOAPONTAMENTO: false,
              RESPOSTA_SERIE_LIBERADO: true,
              RESPOSTA_SERIE_LIBERADO_MP: false,
              RESPOSTA_SERIE_LIBERADO_PERDA: false,
              notaProducao: "S",
              ALLMP: {},
              SERIES: {
                  SERIESPA: { seriePA: seriePAObj },
                  SERIESMP: { serieMP: [] }
              }
            },
            clientEventList: {
              clientEvent: [
                { $: "br.com.sankhya.mgeprod.apontamentos.divergentes", _clientConfirm: "true" },
                { $: "br.com.sankhya.mgeProd.wc.indisponivel", _clientConfirm: "true" },
                { $: "br.com.sankhya.mgeprod.redimensionar.op.pa.perda", _clientConfirm: "true" },
                { $: "br.com.sankhya.mgeprod.redimensionar.op.pa.avisos", _clientConfirm: "true" },
                { $: "br.com.sankhya.mgeprod.trocaturno.avisos", _clientConfirm: "true" },
                { $: "br.com.sankhya.mgeprod.finalizar.liberacao.desvio.pa", _clientConfirm: "true" },
                { $: "br.com.sankhya.actionbutton.clientconfirm", _clientConfirm: "true" },
                { $: "br.com.sankhya.mgeProd.apontamento.ultimo", _clientConfirm: "true" },
                { $: "br.com.sankhya.mgeprod.operacaoproducao.mpalt.proporcao.apontamento.invalida", _clientConfirm: "true" },
                { $: "br.com.sankhya.mgeProd.apontamento.liberaNroSerie", _clientConfirm: "true" },
                { $: "br.com.sankhya.prod.remove.apontamento.pesagemvolume", _clientConfirm: "true" },
                { $: "br.com.sankhya.mgeprod.confirma.ultimo.apontamento.mp.fixo", _clientConfirm: "true" },
                { $: "br.com.sankhya.apontamentomp.naoreproporcionalizado", _clientConfirm: "true" }
              ]
            }
          });
          hideLoader();
          showToast('Apontamento confirmado!', 'success');
          setTimeout(() => window.location.reload(), 1500);
        } catch (error) {
          hideLoader();
          showToast("Erro ao confirmar: " + error.message, 'error');
          console.error(error);
        }
      });
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
    // MAINTENANCE (OS) LOGIC
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
      
      function fmtData(isoStr) {
          if (!isoStr) return "";
          const d = new Date(isoStr);
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

      function formatDateTimeForSankhya(datetimeLocalVal) {
        if (!datetimeLocalVal) return "";
        const parts = datetimeLocalVal.split('T');
        if (parts.length !== 2) return datetimeLocalVal;
        const d = parts[0].split('-');
        return d[2] + '/' + d[1] + '/' + d[0] + ' ' + parts[1] + ':00';
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

      if (!anomalia || !setor) {
        showToast("Anomalia e Origem são obrigatórios.", "warning");
        return;
      }

      try {
        const body = {
          rootEntity: "AD_QUALIHAIALA",
          includePresentationFields: "N",
          dataRow: {
            localFields: {
              IDIPROC: { $: parseInt(idiproc) },
              ANOMALIA: { $: parseInt(anomalia) },
              SETOR_DEF: { $: parseInt(setor) },
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

        await callSankhyaApi('/mge', 'CRUDServiceProvider.saveRecord', { dataSet: body });
        showToast("Informações de Qualidade gravadas!", "success");
        setTimeout(() => window.location.reload(), 1500);
      } catch (error) {
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
