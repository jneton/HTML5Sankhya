(function () {
  "use strict";

  const table = document.getElementById("dataTable");
  if (!table) return;

  const body = table.tBodies[0];
  const rows = Array.from(body ? body.rows : []);
  const cell = (row, name) => {
    const el = row.querySelector('[data-col="' + name + '"]');
    return el ? el.textContent.trim() : "";
  };

  // Converte números retornados pelo Oracle/JSP em formatos pt-BR ou en-US.
  function numberValue(value) {
    if (!value) return 0;
    let s = String(value).replace(/\s/g, "").replace(/[R$]/g, "");
    if (s.includes(",") && s.includes(".")) {
      s = s.lastIndexOf(",") > s.lastIndexOf(".")
        ? s.replace(/\./g, "").replace(",", ".")
        : s.replace(/,/g, "");
    } else if (s.includes(",")) {
      s = s.replace(",", ".");
    }
    const n = Number(s);
    return Number.isFinite(n) ? n : 0;
  }

  const sum = (name) => rows.reduce((total, row) => total + numberValue(cell(row, name)), 0);
  const money = new Intl.NumberFormat("pt-BR", { style: "currency", currency: "BRL" });
  const decimal = new Intl.NumberFormat("pt-BR", { maximumFractionDigits: 3 });

  document.getElementById("kpiProdutos").textContent = decimal.format(rows.length);
  document.getElementById("kpiPendente").textContent = decimal.format(sum("pendente"));
  document.getElementById("kpiValor").textContent = money.format(sum("vlttot"));
  document.getElementById("kpiFrete").textContent = money.format(sum("frete"));

  let totalVolume = 0;
  rows.forEach((row) => {
    for (let i = 1; i <= 30; i++) {
      totalVolume += numberValue(cell(row, "mt3_" + String(i).padStart(2, "0")));
    }
    const farol = cell(row, "farol").toUpperCase();
    const farolCell = row.querySelector('[data-col="farol"]');
    if (farolCell) {
      farolCell.classList.add(farol === "RED" ? "farol-red" : farol === "YELLOW" ? "farol-yellow" : "farol-blue");
    }
  });
  document.getElementById("kpiVolume").textContent = decimal.format(totalVolume) + " m³";
  document.getElementById("kpiFalta").textContent = decimal.format(
    rows.filter((row) => numberValue(cell(row, "difneg")) < 0).length
  );

  function renderBars(containerId, items) {
    const container = document.getElementById(containerId);
    if (!container) return;
    container.replaceChildren();
    const positive = items.filter((item) => item.value > 0);
    if (!positive.length) {
      const empty = document.createElement("div");
      empty.className = "chart-empty";
      empty.textContent = "Sem dados para os filtros selecionados.";
      container.appendChild(empty);
      return;
    }
    const max = Math.max.apply(null, positive.map((item) => item.value));
    positive.forEach((item) => {
      const row = document.createElement("div");
      row.className = "bar-row";
      const label = document.createElement("span");
      label.className = "bar-label";
      label.textContent = item.label;
      label.title = item.label;
      const track = document.createElement("div");
      track.className = "bar-track";
      const fill = document.createElement("div");
      fill.className = "bar-fill";
      fill.style.width = Math.max(2, (item.value / max) * 100) + "%";
      track.appendChild(fill);
      const value = document.createElement("strong");
      value.className = "bar-value";
      value.textContent = decimal.format(item.value);
      row.append(label, track, value);
      container.appendChild(row);
    });
  }

  const byOrder = [];
  for (let i = 1; i <= 30; i++) {
    const suffix = String(i).padStart(2, "0");
    const orderNumber = rows.map((row) => cell(row, "oca_" + suffix)).find(Boolean);
    const quantity = sum("qtd_" + suffix);
    if (orderNumber && quantity > 0) byOrder.push({ label: "OC " + orderNumber, value: quantity });
  }
  renderBars("chartOrdens", byOrder);

  const topProducts = rows.map((row) => ({
    label: cell(row, "codprod") + " - " + cell(row, "descrprod"),
    value: numberValue(cell(row, "pendente"))
  })).sort((a, b) => b.value - a.value).slice(0, 10);
  renderBars("chartProdutos", topProducts);

  const search = document.getElementById("searchInput");
  const count = document.getElementById("resultCount");
  function filterRows() {
    const term = (search.value || "").toLocaleLowerCase("pt-BR");
    let visible = 0;
    rows.forEach((row) => {
      const match = !term || row.textContent.toLocaleLowerCase("pt-BR").includes(term);
      row.hidden = !match;
      if (match) visible++;
    });
    count.textContent = visible + " de " + rows.length + " registros";
  }
  search.addEventListener("input", filterRows);
  count.textContent = rows.length + " registros";

  document.getElementById("exportCsv").addEventListener("click", function () {
    const headers = Array.from(table.tHead.rows[0].cells).map((th) => th.textContent.trim());
    const visibleRows = rows.filter((row) => !row.hidden);
    const lines = [headers].concat(visibleRows.map((row) =>
      Array.from(row.cells).map((td) => td.textContent.trim())
    ));
    const csv = "\uFEFF" + lines.map((line) =>
      line.map((value) => '"' + String(value).replace(/"/g, '""') + '"').join(";")
    ).join("\r\n");
    const blob = new Blob([csv], { type: "text/csv;charset=utf-8;" });
    const url = URL.createObjectURL(blob);
    const link = document.createElement("a");
    link.href = url;
    link.download = "acompanhamento_ordens_carga.csv";
    document.body.appendChild(link);
    link.click();
    link.remove();
    URL.revokeObjectURL(url);
  });
})();
