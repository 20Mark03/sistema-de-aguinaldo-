<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Modelo.Empleado" %>
<%@ page import="Modelo.SalarioMes" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TicoSoft S.A. – Resultado Aguinaldo</title>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Segoe UI', system-ui, sans-serif;
            background: #f0f4f8;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* ── Navbar ─────────────────────────────── */
        nav {
            background: #1a3a5c;
            padding: 0 2rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            height: 64px;
            box-shadow: 0 2px 8px rgba(0,0,0,.25);
        }
        nav .brand {
            display: flex; align-items: center; gap: .6rem;
            text-decoration: none;
        }
        nav .brand-icon {
            width: 38px; height: 38px;
            background: #e8a020;
            border-radius: 8px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.3rem; font-weight: 900; color: #1a3a5c;
        }
        nav .brand-name { color: #fff; font-size: 1.1rem; font-weight: 700; }
        nav .brand-sub  { color: #90afc5; font-size: .75rem; }
        nav .spacer     { flex: 1; }
        nav .btn-back {
            background: rgba(255,255,255,.12);
            color: #fff;
            border: 1px solid rgba(255,255,255,.25);
            border-radius: 20px;
            padding: .35rem 1rem;
            font-size: .85rem;
            cursor: pointer;
            text-decoration: none;
            transition: background .2s;
        }
        nav .btn-back:hover { background: rgba(255,255,255,.22); }

        /* ── Hero ────────────────────────────────── */
        .hero {
            background: linear-gradient(135deg, #1a3a5c 0%, #0d5c8f 100%);
            color: #fff;
            padding: 2.5rem 2rem 3.5rem;
            text-align: center;
        }
        .hero h1       { font-size: 1.8rem; font-weight: 800; }
        .hero .sub     { color: #b8d4ea; font-size: .95rem; margin-top: .3rem; }

        /* ── Layout ──────────────────────────────── */
        .content {
            flex: 1;
            max-width: 860px;
            width: 100%;
            margin: -2rem auto 3rem;
            padding: 0 1rem;
            display: flex;
            flex-direction: column;
            gap: 1.2rem;
        }

        .card {
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 4px 20px rgba(0,0,0,.09);
            padding: 1.8rem 2rem;
        }
        .card-title {
            font-size: 1rem;
            font-weight: 700;
            color: #1a3a5c;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: .5rem;
        }
        .card-title::before {
            content: '';
            display: inline-block;
            width: 4px; height: 18px;
            background: #e8a020;
            border-radius: 2px;
        }

        /* ── Empleado info ───────────────────────── */
        .emp-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: .8rem;
        }
        .emp-item label {
            display: block;
            font-size: .75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: .5px;
            color: #718096;
            margin-bottom: .15rem;
        }
        .emp-item span {
            font-size: .95rem;
            color: #2d3748;
            font-weight: 600;
        }

        /* ── Tabla de salarios ───────────────────── */
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: .9rem;
        }
        thead th {
            background: #1a3a5c;
            color: #fff;
            padding: .7rem 1rem;
            text-align: left;
            font-weight: 600;
            font-size: .82rem;
            text-transform: uppercase;
            letter-spacing: .5px;
        }
        thead th:last-child { text-align: right; }
        tbody tr:nth-child(even) { background: #f7fafd; }
        tbody td {
            padding: .65rem 1rem;
            color: #4a5568;
            border-bottom: 1px solid #e8edf3;
        }
        tbody td:last-child { text-align: right; font-weight: 600; color: #2d3748; }
        tbody tr:last-child td { border-bottom: none; }

        /* ── Resumen aguinaldo ───────────────────── */
        .resumen {
            background: linear-gradient(135deg, #1a3a5c, #0d5c8f);
            border-radius: 14px;
            color: #fff;
            padding: 1.8rem 2rem;
            display: flex;
            align-items: center;
            gap: 1.5rem;
            box-shadow: 0 4px 20px rgba(13,92,143,.3);
        }
        .resumen-icon {
            font-size: 2.8rem;
            flex-shrink: 0;
        }
        .resumen-info h3 {
            font-size: .88rem;
            text-transform: uppercase;
            letter-spacing: .7px;
            color: #90c5e8;
            margin-bottom: .3rem;
        }
        .resumen-monto {
            font-size: 2rem;
            font-weight: 800;
            color: #e8a020;
            letter-spacing: .5px;
        }
        .resumen-detalle {
            font-size: .82rem;
            color: #90c5e8;
            margin-top: .2rem;
        }

        /* ── Sin datos ───────────────────────────── */
        .empty-state {
            text-align: center;
            padding: 2rem;
            color: #718096;
        }
        .empty-state .icon { font-size: 2.5rem; margin-bottom: .5rem; }
        .empty-state p     { font-size: .9rem; }

        /* ── Botón nueva consulta ────────────────── */
        .btn-nuevo {
            display: inline-block;
            padding: .75rem 1.8rem;
            background: linear-gradient(135deg, #e8a020, #d4871a);
            color: #fff;
            border-radius: 8px;
            font-weight: 700;
            text-decoration: none;
            font-size: .95rem;
            box-shadow: 0 3px 10px rgba(232,160,32,.35);
            transition: transform .15s, box-shadow .15s;
        }
        .btn-nuevo:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(232,160,32,.45);
        }

        footer {
            background: #1a3a5c;
            color: #7499b4;
            text-align: center;
            padding: 1rem;
            font-size: .78rem;
        }
    </style>
</head>
<body>

<%
    /* ── Recuperar atributos puestos por el Servlet ── */
    Empleado     empleado  = (Empleado)    request.getAttribute("empleado");
    List<SalarioMes> salarios = (List<SalarioMes>) request.getAttribute("salarios");
    Double       aguinaldo = (Double)      request.getAttribute("aguinaldo");
    Integer      anio      = (Integer)     request.getAttribute("anio");

    /* Formato de moneda costarricense */
    NumberFormat fmt = NumberFormat.getCurrencyInstance(new Locale("es", "CR"));

    /* Si por alguna razón llegan nulos, redirigir */
    if (empleado == null || salarios == null || aguinaldo == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
%>

<%-- ─── Navbar ─── --%>
<nav>
    <a href="index.jsp" class="brand">
        <div class="brand-icon">T</div>
        <div>
            <div class="brand-name">TicoSoft S.A.</div>
            <div class="brand-sub">Recursos Humanos</div>
        </div>
    </a>
    <div class="spacer"></div>
    <a href="index.jsp" class="btn-back">&#8592; Nueva Consulta</a>
</nav>

<%-- ─── Hero ─── --%>
<div class="hero">
    <h1>&#128200; Resultado del Aguinaldo</h1>
    <div class="sub">Período diciembre <%= anio - 1 %> &ndash; noviembre <%= anio %></div>
</div>

<%-- ─── Contenido ─── --%>
<div class="content">

    <%-- 1. Datos del empleado --%>
    <div class="card">
        <div class="card-title">Información del Empleado</div>
        <div class="emp-grid">
            <div class="emp-item">
                <label>Nombre completo</label>
                <span><%= empleado.getNombreCompleto() %></span>
            </div>
            <div class="emp-item">
                <label>Cédula</label>
                <span><%= empleado.getCedula() %></span>
            </div>
            <div class="emp-item">
                <label>Fecha de ingreso</label>
                <span><%= empleado.getFechaIngreso() %></span>
            </div>
            <div class="emp-item">
                <label>Estado</label>
                <span><%= empleado.getEstado() %></span>
            </div>
        </div>
    </div>

    <%-- 2. Tabla de salarios --%>
    <div class="card">
        <div class="card-title">Salarios del Período</div>

        <% if (salarios.isEmpty()) { %>
            <div class="empty-state">
                <div class="icon">&#128203;</div>
                <p>No se encontraron salarios registrados para el período de aguinaldo seleccionado.</p>
                <p style="margin-top:.5rem; font-size:.8rem;">
                    El período comprende desde diciembre <%= anio - 1 %> hasta noviembre <%= anio %>.
                </p>
            </div>
        <% } else { %>
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Período</th>
                        <th>Salario Bruto</th>
                    </tr>
                </thead>
                <tbody>
                    <% int fila = 1;
                       for (SalarioMes sm : salarios) { %>
                        <tr>
                            <td><%= fila++ %></td>
                            <td><%= sm.getMesNombre() %></td>
                            <td><%= fmt.format(sm.getSalarioBruto()) %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
            <p style="margin-top:.8rem; font-size:.8rem; color:#718096; text-align:right;">
                Total de meses registrados: <strong><%= salarios.size() %></strong> de 12
            </p>
        <% } %>
    </div>

    <%-- 3. Resultado del aguinaldo --%>
    <% if (!salarios.isEmpty()) { %>
    <div class="resumen">
        <div class="resumen-icon">&#127873;</div>
        <div class="resumen-info">
            <h3>Monto del Aguinaldo</h3>
            <div class="resumen-monto"><%= fmt.format(aguinaldo) %></div>
            <div class="resumen-detalle">
                Promedio de <%= salarios.size() %> salario(s) registrado(s) en el período
                &mdash; Año <%= anio %>
            </div>
        </div>
    </div>
    <% } %>

    <%-- 4. Botón volver --%>
    <div style="text-align:center; margin-top:.5rem;">
        <a href="index.jsp" class="btn-nuevo">&#8592; Realizar otra consulta</a>
    </div>

</div>

<footer>
    &copy; 2025 TicoSoft S.A. &mdash; Departamento de Recursos Humanos &mdash; Todos los derechos reservados
</footer>

</body>
</html>
