package Modelo;

public class Empleado {

    private int    idEmpleado;
    private String cedula;
    private String nombre;
    private String apellido;
    private String fechaIngreso;
    private String estado;

    public Empleado() {}

    public Empleado(int idEmpleado, String cedula, String nombre,
                    String apellido, String fechaIngreso, String estado) {
        this.idEmpleado   = idEmpleado;
        this.cedula       = cedula;
        this.nombre       = nombre;
        this.apellido     = apellido;
        this.fechaIngreso = fechaIngreso;
        this.estado       = estado;
    }

    public int    getIdEmpleado()   { return idEmpleado; }
    public String getCedula()       { return cedula; }
    public String getNombre()       { return nombre; }
    public String getApellido()     { return apellido; }
    public String getNombreCompleto(){ return nombre + " " + apellido; }
    public String getFechaIngreso() { return fechaIngreso; }
    public String getEstado()       { return estado; }

    public void setIdEmpleado(int idEmpleado)     { this.idEmpleado   = idEmpleado; }
    public void setCedula(String cedula)          { this.cedula       = cedula; }
    public void setNombre(String nombre)          { this.nombre       = nombre; }
    public void setApellido(String apellido)      { this.apellido     = apellido; }
    public void setFechaIngreso(String fechaIngreso){ this.fechaIngreso = fechaIngreso; }
    public void setEstado(String estado)          { this.estado       = estado; }
}
