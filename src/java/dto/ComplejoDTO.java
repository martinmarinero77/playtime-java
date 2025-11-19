package dto;

import java.io.Serializable;
import java.util.Set;
import java.util.stream.Collectors;

public class ComplejoDTO implements Serializable {

    private int idComplejo;
    private String nombre;
    private String direccion;
    private String localidad;
    private String telefono;
    private Set<String> deportes;

    public ComplejoDTO() {
    }

    public int getIdComplejo() {
        return idComplejo;
    }

    public void setIdComplejo(int idComplejo) {
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
    
            private String provincia;
    
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

    public Set<String> getDeportes() {
        return deportes;
    }

    public void setDeportes(Set<String> deportes) {
        this.deportes = deportes;
    }
    
    /**
     * Método de utilidad para el JSP. Convierte el Set de deportes
     * en una cadena separada por comas (ej: "fútbol,tenis,pádel")
     * para usarla en los atributos de datos (data-*) de HTML.
     * @return Una cadena con los deportes.
     */
    public String getDeportesAsString() {
        if (deportes == null || deportes.isEmpty()) {
            return "";
        }
        // Convierte cada deporte a minúsculas ANTES de unirlos
        return deportes.stream()
                       .map(String::toLowerCase)
                       .collect(Collectors.joining(","));
    }
}
