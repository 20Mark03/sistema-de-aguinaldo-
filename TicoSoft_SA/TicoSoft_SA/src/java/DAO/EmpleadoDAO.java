package DAO;

import Conexion.Conexion;
import Modelo.Empleado;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class EmpleadoDAO {

        public List<Empleado> obtenerTodos() {
        List<Empleado> lista = new ArrayList<>();
        String sql = "SELECT id_empleado, cedula, nombre, apellido, fecha_ingreso, estado " +
                     "FROM Empleados WHERE estado = 'ACTIVO' ORDER BY apellido, nombre";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Empleado e = new Empleado(
                    rs.getInt("id_empleado"),
                    rs.getString("cedula"),
                    rs.getString("nombre"),
                    rs.getString("apellido"),
                    rs.getString("fecha_ingreso"),
                    rs.getString("estado")
                );
                lista.add(e);
            }

        } catch (Exception ex) {
            System.err.println("[EmpleadoDAO] Error al obtener empleados: " + ex.getMessage());
        }

        return lista;
    }


    public Empleado obtenerPorId(int idEmpleado) {
        String sql = "SELECT id_empleado, cedula, nombre, apellido, fecha_ingreso, estado " +
                     "FROM Empleados WHERE id_empleado = ?";
        Empleado emp = null;

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idEmpleado);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    emp = new Empleado(
                        rs.getInt("id_empleado"),
                        rs.getString("cedula"),
                        rs.getString("nombre"),
                        rs.getString("apellido"),
                        rs.getString("fecha_ingreso"),
                        rs.getString("estado")
                    );
                }
            }

        } catch (Exception ex) {
            System.err.println("[EmpleadoDAO] Error al buscar empleado: " + ex.getMessage());
        }

        return emp;
    }
}
