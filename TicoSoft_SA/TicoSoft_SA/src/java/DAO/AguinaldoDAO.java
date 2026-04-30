package DAO;

import Conexion.Conexion;
import Modelo.SalarioMes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class AguinaldoDAO {

  
    public List<SalarioMes> obtenerSalariosPeriodo(int idEmpleado, int anio) {
        List<SalarioMes> lista = new ArrayList<>();

        String sql = "SELECT mes, anio, salario_bruto " +
                     "FROM Salarios " +
                     "WHERE id_empleado = ? " +
                     "  AND ( (anio = ? AND mes = 12) " +
                     "     OR (anio = ? AND mes BETWEEN 1 AND 11) ) " +
                     "ORDER BY anio, mes";

        try (Connection con = Conexion.getConexion()) {

            if (con == null) {
                System.err.println("[AguinaldoDAO] No se pudo obtener conexión.");
                return lista;
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, idEmpleado);
                ps.setInt(2, anio - 1);  // diciembre del año anterior
                ps.setInt(3, anio);      // enero-noviembre del año actual

                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        SalarioMes sm = new SalarioMes(
                            rs.getInt("mes"),
                            rs.getInt("anio"),
                            rs.getDouble("salario_bruto")
                        );
                        lista.add(sm);
                    }
                }
            }

        } catch (Exception ex) {
            System.err.println("[AguinaldoDAO] Error en consulta: " + ex.getMessage());
        }

        return lista;
    }

 
    public double calcularAguinaldo(List<SalarioMes> salarios) {
        if (salarios == null || salarios.isEmpty()) {
            return 0.0;
        }
        double suma = 0;
        for (SalarioMes sm : salarios) {
            suma += sm.getSalarioBruto();
        }
        return suma / salarios.size();
    }
}
