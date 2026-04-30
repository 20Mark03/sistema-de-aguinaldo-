<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="DAO.EmpleadoDAO" %>
<%@ page import="Modelo.Empleado" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Calendar" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TicoSoft - Aguinaldo</title>

    <style>
        body {
            font-family: Arial;
            background: #eef2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .card {
            background: white;
            padding: 25px;
            width: 380px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
            color: #333;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        button {
            width: 100%;
            padding: 10px;
            background: #2c7be5;
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #1a5fc1;
        }

        .nota {
            font-size: 12px;
            margin-top: 10px;
            color: #666;
        }
    </style>
</head>

<body>

<div class="card">

<h2>Calcular Aguinaldo</h2>

<%
    EmpleadoDAO empDAO = new EmpleadoDAO();
    List<Empleado> empleados = empDAO.obtenerTodos();
    int anioActual = Calendar.getInstance().get(Calendar.YEAR);
%>

<form method="post" action="calcularAguinaldo">

    <select name="idEmpleado" required>
        <option value="">Seleccione empleado</option>
        <% for (Empleado emp : empleados) { %>
            <option value="<%= emp.getIdEmpleado() %>">
                <%= emp.getNombreCompleto() %>
            </option>
        <% } %>
    </select>

    <input type="number" name="anio" value="<%= anioActual %>" required>

    <button type="submit">Calcular</button>

</form>

<div class="nota">
    Promedio de salarios entre diciembre y noviembre.
</div>

</div>

</body>
</html>