package tienda;

import java.math.BigDecimal;
import java.sql.Date;

public class PedidoBD {
    private int codigo;
    private int persona;
    private Date fecha;
    private BigDecimal importe;
    private int estado;

    // Constructor vacío
    public PedidoBD() {
    }

    // Constructor con todos los campos
    public PedidoBD(int codigo, int persona, Date fecha, BigDecimal importe, int estado) {
        this.codigo = codigo;
        this.persona = persona;
        this.fecha = fecha;
        this.importe = importe;
        this.estado = estado;
    }

    // Getters y Setters

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public int getPersona() {
        return persona;
    }

    public void setPersona(int persona) {
        this.persona = persona;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public BigDecimal getImporte() {
        return importe;
    }

    public void setImporte(BigDecimal importe) {
        this.importe = importe;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }
}
