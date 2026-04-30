package Conexion;

import java.sql.Connection;
import java.sql.DriverManager;


public class Conexion {

    private static final String URL      = "jdbc:mysql://localhost:3306/TicoSoftRH?useSSL=false&serverTimezone=UTC";
    private static final String USUARIO  = "root";
    private static final String PASSWORD = "Admin-1234¡"; // Ajusta según tu configuración

    public static Connection getConexion() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(URL, USUARIO, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.err.println("[Conexion] Driver no encontrado: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("[Conexion] Error al conectar: " + e.getMessage());
        }
        return con;
    }
}
