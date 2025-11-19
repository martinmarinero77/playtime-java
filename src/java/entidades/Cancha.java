/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entidades;

import jakarta.persistence.Basic;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.util.Collection;

/**
 *
 * @author martinLocal
 */
@Entity
@Table(name = "cancha")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Cancha.findAll", query = "SELECT c FROM Cancha c"),
    @NamedQuery(name = "Cancha.findByIdCancha", query = "SELECT c FROM Cancha c WHERE c.idCancha = :idCancha"),
    @NamedQuery(name = "Cancha.findByCapacidad", query = "SELECT c FROM Cancha c WHERE c.capacidad = :capacidad"),
    @NamedQuery(name = "Cancha.findByPrecio", query = "SELECT c FROM Cancha c WHERE c.precio = :precio"),
    @NamedQuery(name = "Cancha.findByTipo", query = "SELECT c FROM Cancha c WHERE c.tipo = :tipo"),
    @NamedQuery(name = "Cancha.findByNumero", query = "SELECT c FROM Cancha c WHERE c.numero = :numero"),
    @NamedQuery(name = "Cancha.findByIdDeporte", query = "SELECT c FROM Cancha c WHERE c.idDeporte = :idDeporte"),
    @NamedQuery(name = "Cancha.findByIdComplejo", query = "SELECT c FROM Cancha c WHERE c.idComplejo = :idComplejo ORDER BY c.idDeporte.nombre ASC, c.capacidad ASC, c.numero ASC")})
public class Cancha implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idCancha")
    private Integer idCancha;
    @Column(name = "capacidad")
    private Integer capacidad;
    @Size(max = 45)
    @Column(name = "precio")
    private String precio;
    @Size(max = 45)
    @Column(name = "tipo")
    private String tipo;
    @Size(max = 45)
    @Column(name = "numero")
    private String numero;
    @JoinColumn(name = "deportes_idDeporte", referencedColumnName = "idDeporte")
    @ManyToOne(optional = false)
    private Deportes idDeporte;
    @JoinColumn(name = "idComplejo", referencedColumnName = "idComplejo")
    @ManyToOne(optional = false)
    private Complejo idComplejo;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "canchaidCancha")
    private Collection<Reserva> reservaCollection;

    public Cancha() {
    }

    public Cancha(Integer idCancha) {
        this.idCancha = idCancha;
    }

    public Integer getIdCancha() {
        return idCancha;
    }

    public void setIdCancha(Integer idCancha) {
        this.idCancha = idCancha;
    }

    public Integer getCapacidad() {
        return capacidad;
    }

    public void setCapacidad(Integer capacidad) {
        this.capacidad = capacidad;
    }

    public String getPrecio() {
        return precio;
    }

    public void setPrecio(String precio) {
        this.precio = precio;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public Deportes getIdDeporte() {
        return idDeporte;
    }

    public void setIdDeporte(Deportes idDeporte) {
        this.idDeporte = idDeporte;
    }

    public Complejo getIdComplejo() {
        return idComplejo;
    }

    public void setIdComplejo(Complejo idComplejo) {
        this.idComplejo = idComplejo;
    }

    @XmlTransient
    public Collection<Reserva> getReservaCollection() {
        return reservaCollection;
    }

    public void setReservaCollection(Collection<Reserva> reservaCollection) {
        this.reservaCollection = reservaCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idCancha != null ? idCancha.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Cancha)) {
            return false;
        }
        Cancha other = (Cancha) object;
        if ((this.idCancha == null && other.idCancha != null) || (this.idCancha != null && !this.idCancha.equals(other.idCancha))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidades.Cancha[ idCancha=" + idCancha + " ]";
    }
    
}
