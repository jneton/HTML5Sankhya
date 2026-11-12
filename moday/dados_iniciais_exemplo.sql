-- SCRIPT DE CARGA INICIAL PARA TESTE DO SISTEMA ESTILO MONDAY NO SANKHYA
-- Execute no Construtor de Consultas / SQL após criar as tabelas no Construtor de Telas.

-- 1. Criar Workspace Inicial
INSERT INTO AD_WORKSPACES (CODWORKSPACE, NOME, DESCRICAO, COR, ATIVO)
VALUES (1, 'Operações & TI', 'Área de trabalho principal da equipe', '#0073EA', 'S');

-- 2. Criar Quadro Inicial (Ajuste CODUSU_DONO para um usuário válido da TSIUSU, ex: 0 ou 1)
INSERT INTO AD_QUADROS (CODQUADRO, CODWORKSPACE, NOME, DESCRICAO, CODUSU_DONO, VISIBILIDADE, DHCRIACAO)
VALUES (1, 1, 'Implantação & Melhorias ERP', 'Controle de demandas e sprints', 0, 'P', SYSDATE);

-- 3. Criar Grupos dentro do Quadro
INSERT INTO AD_GRUPOS (CODGRUPO, CODQUADRO, NOME, COR, ORDEM)
VALUES (1, 1, 'Sprint Atual', '#579BFC', 1);

INSERT INTO AD_GRUPOS (CODGRUPO, CODQUADRO, NOME, COR, ORDEM)
VALUES (2, 1, 'Backlog / Próximos Passos', '#A25DDC', 2);

-- 4. Criar Tarefas de Exemplo
INSERT INTO AD_TAREFAS (CODTAREFA, CODGRUPO, TITULO, DESCRICAO, CODUSU_RESP, STATUS, PRIORIDADE, DTINICIO, DTENTREGA, PROGRESSO, ORDEM)
VALUES (1, 1, 'Modelar tabelas AD_ no Construtor de Telas', 'Criar workspaces, quadros, grupos e tarefas', 0, 'FEITO', 'ALTA', SYSDATE - 2, SYSDATE, 100, 1);

INSERT INTO AD_TAREFAS (CODTAREFA, CODGRUPO, TITULO, DESCRICAO, CODUSU_RESP, STATUS, PRIORIDADE, DTINICIO, DTENTREGA, PROGRESSO, ORDEM)
VALUES (2, 1, 'Importar Componente HTML5 no Construtor de BI', 'Subir o arquivo index.html compactado em ZIP', 0, 'ANDAMENTO', 'CRITICA', SYSDATE, SYSDATE + 3, 50, 2);

INSERT INTO AD_TAREFAS (CODTAREFA, CODGRUPO, TITULO, DESCRICAO, CODUSU_RESP, STATUS, PRIORIDADE, DTINICIO, DTENTREGA, PROGRESSO, ORDEM)
VALUES (3, 2, 'Configurar Eventos Programados de Notificação', 'Ativar script JS na tabela AD_TAREFAS', 0, 'PENDENTE', 'MEDIA', SYSDATE + 4, SYSDATE + 7, 0, 1);

COMMIT;
