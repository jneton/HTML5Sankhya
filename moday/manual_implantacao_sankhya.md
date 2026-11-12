# Manual de Implantação — Sistema Estilo Monday no Sankhya

Este pacote contém todos os arquivos necessários para implantar o módulo de gestão de tarefas estilo **monday.com** dentro do ERP Sankhya.

## Arquivos Inclusos
1. `index.html`: Interface completa em HTML5/CSS/JS com integração nativa via **SankhyaJX** (Visão Tabela, Quadro Kanban, Gaveta de Edição, Subtarefas e Comentários).
2. `automacao_sankhya_notificacao.js`: Código JavaScript para **Evento Programado** no Dicionário de Dados do Sankhya (dispara notificações na `TSIAVI` ao atribuir tarefas ou alterar status).
3. `dados_iniciais_exemplo.sql`: Script SQL para popular um Workspace, Quadro, Grupos e Tarefas iniciais de teste.

## Passo a Passo de Implantação

### Passo 1: Criar as Tabelas no Construtor de Telas
Crie as tabelas `AD_WORKSPACES`, `AD_QUADROS`, `AD_GRUPOS`, `AD_TAREFAS`, `AD_SUBTAREFAS`, `AD_COMENTARIOS` e `AD_TAREFA_TAGS` conforme a documentação do DER e configure a **Numeração Automática** para todas as chaves primárias.

### Passo 2: Popular Dados Iniciais
Execute o script `dados_iniciais_exemplo.sql` no banco de dados (via Construtor de Consultas ou cliente SQL) para criar o primeiro quadro de exemplo. *(Nota: se utilizar SQL Server, substitua `SYSDATE` por `GETDATE()`).*

### Passo 3: Importar o Componente HTML5 no Construtor de BI
1. Compacte o arquivo `index.html` sozinho dentro de um arquivo `.zip` (ex: `monday_sankhya.zip`).
2. No Sankhya, abra o **Construtor de BI** (ou *Dashboards*).
3. Crie um novo Dashboard, adicione um componente **HTML5** e faça o upload do `.zip`.
4. Publique o dashboard no menu desejado.

### Passo 4: Ativar Notificações Automáticas (Opcional)
1. Acesse **Dicionário de Dados** > localize a tabela `AD_TAREFAS`.
2. Vá até a aba **Eventos Programados** (ou *Ações*).
3. Crie um evento do tipo **JavaScript** e cole o conteúdo de `automacao_sankhya_notificacao.js`.
