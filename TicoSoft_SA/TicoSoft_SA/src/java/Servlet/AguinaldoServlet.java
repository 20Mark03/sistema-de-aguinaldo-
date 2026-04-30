package Servlet;

import DAO.AguinaldoDAO;
import DAO.EmpleadoDAO;
import Modelo.Empleado;
import Modelo.SalarioMes;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
@WebServlet("/calcularAguinaldo")
public class AguinaldoServlet extends HttpServlet {

    private final AguinaldoDAO aguinaldoDAO = new AguinaldoDAO();
    private final EmpleadoDAO  empleadoDAO  = new EmpleadoDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String idParam   = request.getParameter("idEmpleado");
        String anioParam = request.getParameter("anio");

        // --- Validación básica de parámetros ---
        if (idParam == null || anioParam == null ||
            idParam.trim().isEmpty() || anioParam.trim().isEmpty()) {
            request.setAttribute("error", "Debe seleccionar un empleado y un año válido.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        int idEmpleado;
        int anio;

        try {
            idEmpleado = Integer.parseInt(idParam.trim());
            anio       = Integer.parseInt(anioParam.trim());
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Los datos ingresados no son válidos.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        if (anio < 2000 || anio > 2100) {
            request.setAttribute("error", "El año ingresado no es válido.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        // --- Consulta de empleado ---
        Empleado empleado = empleadoDAO.obtenerPorId(idEmpleado);
        if (empleado == null) {
            request.setAttribute("error", "No se encontró el empleado seleccionado.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        // --- Consulta de salarios y cálculo ---
        List<SalarioMes> salarios = aguinaldoDAO.obtenerSalariosPeriodo(idEmpleado, anio);
        double aguinaldo = aguinaldoDAO.calcularAguinaldo(salarios);

        // --- Enviar datos a la vista ---
        request.setAttribute("empleado",  empleado);
        request.setAttribute("salarios",  salarios);
        request.setAttribute("aguinaldo", aguinaldo);
        request.setAttribute("anio",      anio);

        request.getRequestDispatcher("/vistas/resultado.jsp").forward(request, response);
    }
}
