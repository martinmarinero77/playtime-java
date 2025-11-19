/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entidades;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;

/**
 *
 * @author martinLocal
 */
@Entity
@Table(name = "reserva_jugador")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ReservaJugador.findAll", query = "SELECT r FROM ReservaJugador r"),
    @NamedQuery(name = "ReservaJugador.findByIdReserva", query = "SELECT r FROM ReservaJugador r WHERE r.reservaJugadorPK.idReserva = :idReserva"),
    @NamedQuery(name = "ReservaJugador.findByIdUsuario", query = "SELECT r FROM ReservaJugador r WHERE r.reservaJugadorPK.idUsuario = :idUsuario"),
    @NamedQuery(name = "ReservaJugador.findByEstadoInvitacion", query = "SELECT r FROM ReservaJugador r WHERE r.estadoInvitacion = :estadoInvitacion"),
    @NamedQuery(name = "ReservaJugador.findByCamiseta", query = "SELECT r FROM ReservaJugador r WHERE r.camiseta = :camiseta"),
    @NamedQuery(name = "ReservaJugador.findByApodo", query = "SELECT r FROM ReservaJugador r WHERE r.apodo = :apodo")})
public class ReservaJugador implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected ReservaJugadorPK reservaJugadorPK;
    @Size(min = 1, max = 9)
    @Column(name = "estadoInvitacion")
    private String estadoInvitacion;
    @Size(min = 1, max = 7)
    @Column(name = "camiseta")
    private String camiseta;
    @Size(max = 45)
    @Column(name = "apodo")
    private String apodo;
    @JoinColumn(name = "idReserva", referencedColumnName = "idReserva", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Reserva reserva;
    @JoinColumn(name = "idUsuario", referencedColumnName = "idUsuario", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Usuario usuario;

    public ReservaJugador() {
    }

    public ReservaJugador(ReservaJugadorPK reservaJugadorPK) {
        this.reservaJugadorPK = reservaJugadorPK;
    }

    public ReservaJugador(int idReserva, int idUsuario) {
        this.reservaJugadorPK = new ReservaJugadorPK(idReserva, idUsuario);
    }

    public ReservaJugadorPK getReservaJugadorPK() {
        return reservaJugadorPK;
    }

    public void setReservaJugadorPK(ReservaJugadorPK reservaJugadorPK) {
        this.reservaJugadorPK = reservaJugadorPK;
    }

    public String getEstadoInvitacion() {
        return estadoInvitacion;
    }

    public void setEstadoInvitacion(String estadoInvitacion) {
        this.estadoInvitacion = estadoInvitacion;
    }

    public String getCamiseta() {
        return camiseta;
    }

    public void setCamiseta(String camiseta) {
        this.camiseta = camiseta;
    }

    public String getApodo() {
        return apodo;
    }

    public void setApodo(String apodo) {
        this.apodo = apodo;
    }

    public Reserva getReserva() {
        return reserva;
    }

    public void setReserva(Reserva reserva) {
        this.reserva = reserva;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (reservaJugadorPK != null ? reservaJugadorPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ReservaJugador)) {
            return false;
        }
        ReservaJugador other = (ReservaJugador) object;
        if ((this.reservaJugadorPK == null && other.reservaJugadorPK != null) || (this.reservaJugadorPK != null && !this.reservaJugadorPK.equals(other.reservaJugadorPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidades.ReservaJugador[ reservaJugadorPK=" + reservaJugadorPK + " ]";
    }
    
}
