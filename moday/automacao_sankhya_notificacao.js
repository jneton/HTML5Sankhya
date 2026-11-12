/**
 * EVENTO PROGRAMADO NO DICIONÁRIO DE DADOS DO SANKHYA
 * Tabela: AD_TAREFAS
 * Momento: Após Inserir (AfterInsert) e Após Atualizar (AfterUpdate)
 * Objetivo: Enviar Aviso no Sistema (TSIAVI) ao responsável quando a tarefa for atribuída ou mudar de status.
 */

function afterInsert(ctx) {
    var registro = ctx.getLinhas()[0];
    var codUsuResp = registro.getCampo("CODUSU_RESP");
    var titulo = registro.getCampo("TITULO");
    var codTarefa = registro.getCampo("CODTAREFA");

    if (codUsuResp != null && codUsuResp > 0) {
        enviarAvisoSankhya(
            codUsuResp,
            "Nova Tarefa Atribuída (#" + codTarefa + ")",
            "Você foi definido como responsável pela tarefa: " + titulo
        );
    }
}

function afterUpdate(ctx) {
    var registro = ctx.getLinhas()[0];
    var codUsuResp = registro.getCampo("CODUSU_RESP");
    var titulo = registro.getCampo("TITULO");
    var codTarefa = registro.getCampo("CODTAREFA");
    var statusNovo = registro.getCampo("STATUS");
    var statusAntigo = registro.getCampoOriginal("STATUS");
    var respAntigo = registro.getCampoOriginal("CODUSU_RESP");

    // 1. Notifica se o responsável foi alterado
    if (codUsuResp != null && codUsuResp != respAntigo) {
        enviarAvisoSankhya(
            codUsuResp,
            "Tarefa Transferida para Você (#" + codTarefa + ")",
            "A tarefa '" + titulo + "' foi atribuída a você."
        );
    }

    // 2. Notifica se o status mudou (ex: Travado ou Feito)
    if (codUsuResp != null && statusNovo != statusAntigo) {
        enviarAvisoSankhya(
            codUsuResp,
            "Status Atualizado (#" + codTarefa + ")",
            "A tarefa '" + titulo + "' mudou de status para: " + statusNovo
        );
    }
}

function enviarAvisoSankhya(codUsuDestino, titulo, descricao) {
    var dwf = ctx.getEntityFacade();
    var avisoVO = dwf.getDefaultValueObjectInstance("AvisoSistema");
    
    avisoVO.setProperty("CODUSU", new java.math.BigDecimal(codUsuDestino));
    avisoVO.setProperty("TITULO", titulo);
    avisoVO.setProperty("DESCRICAO", descricao);
    avisoVO.setProperty("IMPORTANCIA", new java.math.BigDecimal(1)); // 1 = Normal, 2 = Alta
    avisoVO.setProperty("IDENTIFICADOR", "PERSONALIZADO");
    avisoVO.setProperty("TIPO", "P");
    avisoVO.setProperty("DHCRIACAO", new java.sql.Timestamp(java.lang.System.currentTimeMillis()));

    dwf.createEntity("AvisoSistema", avisoVO);
}
