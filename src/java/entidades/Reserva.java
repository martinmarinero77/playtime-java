/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entidades;

import jakarta.persistence.Basic;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.persistence.UniqueConstraint;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.util.Collection;
import java.util.Date;

/**
 *
 * @author martinLocal
 */
@Entity
@Table(name = "reserva",
        uniqueConstraints = {
           @UniqueConstraint(columnNames = {"cancha_idCancha", "fechaHoraInicio", "estado"})
       }
)
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Reserva.findAll", query = "SELECT r FROM Reserva r"),
    @NamedQuery(name = "Reserva.findByIdReserva", query = "SELECT r FROM Reserva r WHERE r.idReserva = :idReserva"),
    @NamedQuery(name = "Reserva.findByFechaHoraInicio", query = "SELECT r FROM Reserva r WHERE r.fechaHoraInicio = :fechaHoraInicio"),
    @NamedQuery(name = "Reserva.findByEstado", query = "SELECT r FROM Reserva r WHERE r.estado = :estado")})
public class Reserva implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idReserva")
    private Integer idReserva;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fechaHoraInicio")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaHoraInicio;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "estado")
    private String estado;
    @Column(name = "esPublica")
    private boolean esPublica = false; // Nuevo campo, por defecto false
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "reserva")
    private Collection<ReservaJugador> reservaJugadorCollection;
    @JoinColumn(name = "cancha_idCancha", referencedColumnName = "idCancha")
    @ManyToOne(optional = false)
    private Cancha canchaidCancha;
    @JoinColumn(name = "idUsuarioReserva", referencedColumnName = "idUsuario")
    @ManyToOne(optional = false)
    private Usuario idUsuarioReserva;

    public Reserva() {
    }

    public Reserva(Integer idReserva) {
        this.idReserva = idReserva;
    }

    public Reserva(Integer idReserva, Date fechaHoraInicio, String estado) {
        this.idReserva = idReserva;
        this.fechaHoraInicio = fechaHoraInicio;
        this.estado = estado;
    }

    public Integer getIdReserva() {
        return idReserva;
    }

    public void setIdReserva(Integer idReserva) {
        this.idReserva = idReserva;
    }

    public Date getFechaHoraInicio() {
        return fechaHoraInicio;
    }

    public void setFechaHoraInicio(Date fechaHoraInicio) {
        this.fechaHoraInicio = fechaHoraInicio;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public boolean isEsPublica() {
        return esPublica;
    }

    public void setEsPublica(boolean esPublica) {
        this.esPublica = esPublica;
    }

    @XmlTransient
    public Collection<ReservaJugador> getReservaJugadorCollection() {
        return reservaJugadorCollection;
    }

    public void setReservaJugadorCollection(Collection<ReservaJugador> reservaJugadorCollection) {
        this.reservaJugadorCollection = reservaJugadorCollection;
    }

    public Cancha getCanchaidCancha() {
        return canchaidCancha;
    }

    public void setCanchaidCancha(Cancha canchaidCancha) {
        this.canchaidCancha = canchaidCancha;
    }

    public Usuario getIdUsuarioReserva() {
        return idUsuarioReserva;
    }

    public void setIdUsuarioReserva(Usuario idUsuarioReserva) {
        this.idUsuarioReserva = idUsuarioReserva;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idReserva != null ? idReserva.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Reserva)) {
            return false;
        }
        Reserva other = (Reserva) object;
        if ((this.idReserva == null && other.idReserva != null) || (this.idReserva != null && !this.idReserva.equals(other.idReserva))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidades.Reserva[ idReserva=" + idReserva + " ]";
    }
    
}
