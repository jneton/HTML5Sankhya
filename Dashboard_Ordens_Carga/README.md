# Dashboard de Acompanhamento de Ordens de Carga — Sankhya / Oracle 19c

## Estrutura
- `dashboard.xml`: gadget e parâmetros nativos P_OC e SIT.
- `dashboard.jsp`: componente HTML5, execução da query e renderização.
- `css/dashboard.css`: estilos responsivos isolados.
- `js/dashboard.js`: KPIs, gráficos, pesquisa e exportação CSV.
- `sql/query_ordens_carga_otimizada.sql`: SQL Oracle 19c independente para revisão/teste.

## Parâmetros
- `P_OC`: multisseleção de ordens de carga ativas, obtidas de TGFORD.
- `SIT`: multisseleção `N = Aberto` e `S = Concluída`.

## Instalação
1. Faça backup do gadget/componente atual.
2. Publique os arquivos JSP, CSS e JS no diretório de componentes HTML5 correspondente ao gadget.
3. Importe/adapte `dashboard.xml` no construtor de dashboards do Sankhya, preservando o ID do componente se houver dependências.
4. Confirme que o caminho `${BASE_FOLDER}` resolve para a pasta do componente.
5. Teste inicialmente em homologação com uma única ordem e uma situação; depois teste multisseleção.
6. Compare totais com a consulta original antes de liberar em produção.

## Alterações SQL relevantes
- Pedidos com observação consolidados por produto, evitando junção incompleta por produto/ordem e fan-out no resumo final.
- `LISTAGG ... ON OVERFLOW TRUNCATE` substitui o pivot textual limitado a 20 pedidos.
- `NULLIF(ite.qtdneg, 0)` protege o cálculo unitário contra divisão por zero.
- Simplificação do predicado de produto SA.
- Aplicação de SIT aos CTEs de pedidos com observação para manter coerência com os filtros selecionados.

## Limitações e validações pendentes
- A estrutura original das colunas de ordens de carga permanece fixa em 30 posições (01 a 30). Seleções com mais de 30 ordens precisam ser bloqueadas no prompt ou tratadas em uma versão de layout dinâmico; não se deve presumir que a 31ª ordem será exibida.
- A query depende dos campos customizados `TGFORD.AD_FORMCONC`, `TGFPRO.AD_COD_PROD_SA`, `TGFPRO.AD_SET_PRODUCAO`, `TGFITE.AD_VLRUNITFRETE` e `TGFITE.AD_VLRLIQ`.
- O componente foi montado a partir do modelo de referência recebido. A compilação JSP e o comportamento de parâmetros devem ser homologados na versão exata do Sankhya do cliente.
- Índices não foram criados: recomendações precisam do plano real (`DBMS_XPLAN.DISPLAY_CURSOR`) e seletividade do ambiente.
- A soma de volume considera os campos `MT3_01` a `MT3_30` retornados pela query.
- O KPI de falta conta produtos cujo saldo projetado (`estoque - pendente`) é negativo.

## Índices para avaliar (não criar sem validar)
- `TGFCAB(ORDEMCARGA, TIPMOV, PENDENTE, NUNOTA)`
- `TGFITE(NUNOTA, PENDENTE, CODPROD)`
- `TGFFEST(CODPROD, CODPARC, CODLOCAL)`
- `TGFORD(ORDEMCARGA, SITUACAO)`

Validar índices existentes, estatísticas e plano antes de qualquer DDL.
