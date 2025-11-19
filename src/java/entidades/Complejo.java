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
@Table(name = "complejo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Complejo.findAll", query = "SELECT c FROM Complejo c"),
    @NamedQuery(name = "Complejo.findByIdComplejo", query = "SELECT c FROM Complejo c WHERE c.idComplejo = :idComplejo"),
    @NamedQuery(name = "Complejo.findByNombre", query = "SELECT c FROM Complejo c WHERE c.nombre = :nombre"),
    @NamedQuery(name = "Complejo.findByDireccion", query = "SELECT c FROM Complejo c WHERE c.direccion = :direccion"),
    @NamedQuery(name = "Complejo.findByLocalidad", query = "SELECT c FROM Complejo c WHERE c.localidad = :localidad"),
    @NamedQuery(name = "Complejo.findByProvincia", query = "SELECT c FROM Complejo c WHERE c.provincia = :provincia"),
    @NamedQuery(name = "Complejo.findByTelefono", query = "SELECT c FROM Complejo c WHERE c.telefono = :telefono")})
public class Complejo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idComplejo")
    private Integer idComplejo;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "nombre")
    private String nombre;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "direccion")
    private String direccion;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "localidad")
    private String localidad;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "provincia")
    private String provincia;
    @Size(max = 20)
    @Column(name = "telefono")
    private String telefono;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idComplejo")
    private Collection<Cancha> canchaCollection;

    public Complejo() {
    }

    public Complejo(Integer idComplejo) {
        this.idComplejo = idComplejo;
    }

    public Complejo(Integer idComplejo, String nombre, String direccion, String localidad, String provincia) {
        this.idComplejo = idComplejo;
        this.nombre = nombre;
        this.direccion = direccion;
        this.localidad = localidad;
        this.provincia = provincia;
    }

    public Integer getIdComplejo() {
        return idComplejo;
    }

    public void setIdComplejo(Integer idComplejo) {
        this.idComplejo = idComplejo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getLocalidad() {
        return localidad;
    }

    public void setLocalidad(String localidad) {
        this.localidad = localidad;
    }

    public String getProvincia() {
        return provincia;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
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
        hash += (idComplejo != null ? idComplejo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Complejo)) {
            return false;
        }
        Complejo other = (Complejo) object;
        if ((this.idComplejo == null && other.idComplejo != null) || (this.idComplejo != null && !this.idComplejo.equals(other.idComplejo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidades.Complejo[ idComplejo=" + idComplejo + " ]";
    }
    
}
