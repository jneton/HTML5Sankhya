<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>

<?xml version="1.0" encoding="UTF-8"?>
<component name="ComponenteData" file="componenteData.html">
    <filters>
        <!-- Filtro que o usuário vai preencher na tela -->
        <filter name="XDT" type="DATA" label="Data de referência"/>
    </filters>

    <params>
        <!-- Parâmetro que recebe o valor do filtro -->
        <param name="XDT" type="DATA" source="filter"/>
    </params>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Componente Sankhya - Data</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .data-box { padding: 10px; border: 1px solid #ccc; width: fit-content; }
    </style>
</head>
<body>
    <h2>Exemplo de Componente HTML5</h2>
    <div class="data-box">
        <p>Data recebida (XDT): <span id="dataXDT"></span></p>
    </div>

    <script>
        // Recupera o parâmetro injetado pelo Sankhya
        const dataXDT = (typeof sknParams !== "undefined" ? sknParams.XDT : params.XDT);

        if (dataXDT) {
            const dataFormatada = new Date(dataXDT).toLocaleDateString("pt-BR");
            document.getElementById("dataXDT").innerText = dataFormatada;
            console.log("Data recebida (XDT):", dataXDT);
            
        } else {
            document.getElementById("dataXDT").innerText = "Nenhuma data selecionada";
            console.warn("Parâmetro XDT não encontrado.");
        }
    </script>
</body>
</html>