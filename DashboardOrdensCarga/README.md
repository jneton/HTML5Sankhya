# Dashboard Gerencial de Ordens de Carga — Sankhya / Oracle 19c

## Conteúdo
- `JSP_MODELO.jsp`: componente HTML5/JSP substituto do exemplo de parceiros.
- `css/mainCSS.css`: layout responsivo corporativo.
- `sql/ordens_carga.sql`: consulta de referência Oracle 19c em formato longo (produto x OC).

## Parâmetros esperados no Construtor de Componentes HTML5
1. `P_OC`: MultiList:Text com as ordens de carga; obrigatório.
2. `SIT`: MultiList:Text com os valores de `TG Ford.AD_FORMCONC`; obrigatório.

A query utiliza os mesmos tokens `:P_OC` e `:SIT` do SQL recebido. No JSP, os parâmetros são passados a `executeQuery` como tipos `IN`.

## Importante: adaptação do SQL no JSP
O SQL está embutido na variável `SQL` para permitir que o componente funcione como artefato único. A cópia em `sql/ordens_carga.sql` é a versão de referência para manutenção.

## Estratégia sem limite de 30 ordens
A consulta retorna uma linha por produto e ordem de carga. A interface agrupa as ordens recebidas dinamicamente, sem PIVOT de 30 posições. O CSV também exporta o conjunto filtrado na tela.

## Validações obrigatórias antes de produção
- Confirmar que `P_OC` e `SIT` são parâmetros MultiList:Text e que o valor chega como lista compatível com `executeQuery`.
- Confirmar a semântica da regra de estoque: disponível soma locais diferentes de 2030000 para `CODPARC=0`; estoque SA usa local 2010000.
- Confirmar a regra de associação do produto SA e a exceção do grupo 301 com a área de negócio. A expressão original não deixa totalmente clara a semântica de `CODPRO_PINT`.
- Validar a lista de observações: a nova versão conta notas distintas por OC/produto e lista os números de nota.
- Testar com OCs com muitos itens e mais de 30 ordens.
- Comparar totais com o relatório anterior para um conjunto controlado de ordens.
- Executar `DBMS_XPLAN.DISPLAY_CURSOR(..., 'ALLSTATS LAST +PREDICATE +ALIAS')` para validar o plano real.

## Segurança e desempenho
- Valores vindos do banco são inseridos como texto escapado; não se usa `innerHTML` com dados brutos em células.
- Pesquisa no cliente, sem nova ida ao banco.
- Não foram adicionadas bibliotecas externas.
- Não criar índices sem verificar índices existentes, seletividade e plano de execução.
- A função `executeQuery` e a tag `<snk:load/>` são recursos nativos demonstrados no modelo original.

## Limitações conhecidas desta entrega
- Não foi possível executar a SQL contra o banco Sankhya/Oracle do cliente.
- A interface dinâmica não gera colunas físicas para cada OC: usa linhas produto x OC e um gráfico/agrupamento por ordem, evitando a limitação estrutural de 30 colunas.
- Para volumes excepcionalmente grandes, recomenda-se paginação server-side ou filtro adicional de produto/grupo, pois `executeQuery` retorna o resultado integral.
