/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entidades;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.validation.constraints.NotNull;
import java.io.Serializable;

/**
 *
 * @author martinLocal
 */
@Embeddable
public class ReservaJugadorPK implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Column(name = "idReserva")
    private int idReserva;
    @Basic(optional = false)
    @NotNull
    @Column(name = "idUsuario")
    private int idUsuario;

    public ReservaJugadorPK() {
    }

    public ReservaJugadorPK(int idReserva, int idUsuario) {
        this.idReserva = idReserva;
        this.idUsuario = idUsuario;
    }

    public int getIdReserva() {
        return idReserva;
    }

    public void setIdReserva(int idReserva) {
        this.idReserva = idReserva;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idReserva;
        hash += (int) idUsuario;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ReservaJugadorPK)) {
            return false;
        }
        ReservaJugadorPK other = (ReservaJugadorPK) object;
        if (this.idReserva != other.idReserva) {
            return false;
        }
        if (this.idUsuario != other.idUsuario) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidades.ReservaJugadorPK[ idReserva=" + idReserva + ", idUsuario=" + idUsuario + " ]";
    }
    
}
