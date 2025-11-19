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
@Table(name = "deportes")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Deportes.findAll", query = "SELECT d FROM Deportes d"),
    @NamedQuery(name = "Deportes.findByIdDeporte", query = "SELECT d FROM Deportes d WHERE d.idDeporte = :idDeporte"),
    @NamedQuery(name = "Deportes.findByNombre", query = "SELECT d FROM Deportes d WHERE d.nombre = :nombre")})
public class Deportes implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "idDeporte")
    private Integer idDeporte;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "nombre")
    private String nombre;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idDeporte")
    private Collection<Cancha> canchaCollection;

    public Deportes() {
    }

    public Deportes(Integer idDeporte) {
        this.idDeporte = idDeporte;
    }

    public Deportes(Integer idDeporte, String nombre) {
        this.idDeporte = idDeporte;
        this.nombre = nombre;
    }

    public Integer getIdDeporte() {
        return idDeporte;
    }

    public void setIdDeporte(Integer idDeporte) {
        this.idDeporte = idDeporte;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    @XmlTransient
    public Collection<Cancha> getCanchaCollection() {
        return canchaCollection;
    }

    public void setCanchaCollection(Collection<Cancha> canchaCollection) {
        this.canchaCollection = canchaCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idDeporte != null ? idDeporte.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Deportes)) {
            return false;
        }
        Deportes other = (Deportes) object;
        if ((this.idDeporte == null && other.idDeporte != null) || (this.idDeporte != null && !this.idDeporte.equals(other.idDeporte))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidades.Deportes[ idDeporte=" + idDeporte + " ]";
    }
    
}
