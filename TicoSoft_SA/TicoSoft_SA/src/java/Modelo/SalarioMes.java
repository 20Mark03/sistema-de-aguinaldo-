package Modelo;


public class SalarioMes {

    private int    mes;
    private int    anio;
    private double salarioBruto;

    
    private static final String[] MESES = {
        "", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
        "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
    };

    public SalarioMes() {}

    public SalarioMes(int mes, int anio, double salarioBruto) {
        this.mes         = mes;
        this.anio        = anio;
        this.salarioBruto = salarioBruto;
    }

    public int    getMes()         { return mes; }
    public int    getAnio()        { return anio; }
    public double getSalarioBruto(){ return salarioBruto; }

    public String getMesNombre() {
        if (mes >= 1 && mes <= 12) {
            return MESES[mes] + " " + anio;
        }
        return mes + "/" + anio;
    }

    public void setMes(int mes)                 { this.mes         = mes; }
    public void setAnio(int anio)               { this.anio        = anio; }
    public void setSalarioBruto(double s)       { this.salarioBruto = s; }
}
