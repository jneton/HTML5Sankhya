# Dashboard de Ordens de Carga — Sankhya HTML5 / Oracle 19c

## Estrutura
- `model_XML_Oracle.xml`: gadget com os prompts e os níveis de navegação.
- `model_Ordens_Carga.jsp`: resumo por produto/estoque.
- `model_Itens_Produto.jsp`: pedidos/itens do produto selecionado.
- `model_Pedidos.jsp`: pedidos pendentes por nota.
- `model_Itens_Pedido.jsp`: itens da nota selecionada.
- `sql/`: cópias independentes das quatro consultas para validação no Oracle.
- `css/dashboardCSS.css`: estilos compartilhados.

## Filtros
- `P_OC`: multisseleção de OCs ativas, conforme SQL fornecido.
- `SIT`: multisseleção N = Aberta e S = Concluída.

## Navegação
1. A tabela principal consolida por produto as OCs selecionadas.
2. O botão **Detalhes** do produto atualiza a tabela de pedidos/itens daquele produto.
3. A tabela de pedidos permite abrir o nível com os itens da nota selecionada.

## Compatibilidade dos parâmetros Sankhya
- Corrigida a sintaxe dos filtros multisseleção para `IN (:P_OC)` e `IN (:SIT)`, conforme o padrão do XML de referência enviado.

## Ajustes técnicos aplicados à consulta principal
- Removida a chamada `OPTION_LABEL`, porque o teste anterior no ambiente do usuário retornou o mesmo erro. O campo `SET_SA` passa a exibir o valor bruto de `TGFPRO.AD_SET_PRODUCAO`, sem descrição de domínio.
- Corrigido o relacionamento das observações: quantidade e texto agora são agregados por produto antes do JOIN, evitando multiplicação das linhas do resumo causada pelo agrupamento por OC.
- Protegida a divisão por zero com `NULLIF(ite.qtdneg, 0)`.
- Simplificada a validação de `codpro_sa` para `IS NOT NULL`.

## Pontos que exigem validação no ambiente
- O pivot original continua limitado a 30 OCs (`OCA_01` ... `OCA_30`). O resumo por produto e as tabelas de detalhe continuam considerando todas as OCs selecionadas, mas a apresentação das colunas individuais por OC fica limitada às 30 primeiras.
- As consultas de detalhe usam o relacionamento padrão `TGFPAR -> TSICID -> TSIUFS`. Confirme os nomes das colunas de UF/cidade no dicionário da sua base se houver customização.
- A grade JSP principal apresenta os indicadores consolidados e observações; as 30 posições do PIVOT permanecem disponíveis na consulta SQL, mas não foram transformadas em 120 colunas HTML para evitar uma grade excessivamente larga.
- A estrutura segue o padrão do modelo HTML5 enviado (`<snk:load/>`, `<snk:query>`, `refreshDetails()` e `openLevel()`). A instalação e execução ainda precisam ser homologadas no Sankhya, pois não há conexão com sua instância para executar as consultas.

## Instalação
1. Faça backup do gadget atual.
2. Copie os JSPs e a pasta `css` para o diretório de componentes HTML5 utilizado pelo gadget, mantendo a estrutura relativa.
3. Importe/registre `model_XML_Oracle.xml` como modelo do gadget.
4. Teste primeiro os prompts; depois a consulta principal; por fim, os dois níveis de detalhe.
5. Se o ambiente exigir nomes de entryPoint ou diretórios específicos, ajuste-os no XML antes da publicação.


## Correção adicional da versão v3
- O componente `model_Itens_Produto.jsp` é carregado no primeiro nível, antes de o usuário clicar em um produto.
- Como `A_CODPROD` só é preenchido pela ação `refreshDetails`, a consulta agora usa `ite.codprod = NVL(:A_CODPROD, -1)`.
- Enquanto nenhum produto estiver selecionado, a consulta não retorna linhas; depois do clique em **Detalhes**, usa o código informado.
- Esta alteração corrige o uso do argumento ainda não selecionado. Ela não comprova, por si só, que a consulta principal esteja livre de outros erros Oracle; a validação final depende da execução no ambiente Sankhya.
