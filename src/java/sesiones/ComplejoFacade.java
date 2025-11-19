/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sesiones;

import dto.ComplejoDTO;
import entidades.Complejo;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

@Stateless
public class ComplejoFacade extends AbstractFacade<Complejo> {

    @PersistenceContext(unitName = "PlayTimeAppPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ComplejoFacade() {
        super(Complejo.class);
    }
    
    public List<ComplejoDTO> getComplejosDTO() {
        List<Complejo> complejos = this.findAll();
        List<ComplejoDTO> dtoList = new ArrayList<>();
        for (Complejo comp : complejos) {
            ComplejoDTO dto = new ComplejoDTO();
            dto.setIdComplejo(comp.getIdComplejo());
            dto.setNombre(comp.getNombre());
            dto.setDireccion(comp.getDireccion());
            dto.setLocalidad(comp.getLocalidad());
            dto.setTelefono(comp.getTelefono());
            Set<String> deportesDelComplejo = comp.getCanchaCollection().stream()
                    .map(cancha -> cancha.getIdDeporte() != null ? cancha.getIdDeporte().getNombre() : null)
                    .filter(Objects::nonNull)
                    .collect(Collectors.toSet());
            dto.setDeportes(deportesDelComplejo);
            dtoList.add(dto);
        }
        return dtoList;
    }
    
    public List<ComplejoDTO> findDestacados(int limit) {
        List<Complejo> complejos = getEntityManager().createQuery("SELECT c FROM Complejo c ORDER BY c.idComplejo", Complejo.class)
                .setMaxResults(limit)
                .getResultList();
        
        List<ComplejoDTO> dtoList = new ArrayList<>();
        for (Complejo comp : complejos) {
            ComplejoDTO dto = new ComplejoDTO();
            dto.setIdComplejo(comp.getIdComplejo());
            dto.setNombre(comp.getNombre());
            dto.setDireccion(comp.getDireccion());
            dto.setLocalidad(comp.getLocalidad());
            dto.setTelefono(comp.getTelefono());
            Set<String> deportesDelComplejo = comp.getCanchaCollection().stream()
                    .map(cancha -> cancha.getIdDeporte() != null ? cancha.getIdDeporte().getNombre() : null)
                    .filter(Objects::nonNull)
                    .collect(Collectors.toSet());
            dto.setDeportes(deportesDelComplejo);
            dtoList.add(dto);
        }
        return dtoList;
    }
    
    /**
     * Busca complejos por un término de búsqueda que puede coincidir con nombre, deporte, localidad o provincia.
     * @param searchTerm El término de búsqueda.
     * @param limit El número máximo de resultados a devolver.
     * @return Una lista de ComplejoDTO que coinciden con el término de búsqueda.
     */
    public List<ComplejoDTO> searchComplejos(String searchTerm, int limit) {
        String jpql = "SELECT c FROM Complejo c WHERE " +
                      "LOWER(c.nombre) LIKE LOWER(:searchTerm) OR " +
                      "LOWER(c.direccion) LIKE LOWER(:searchTerm) OR " +
                      "LOWER(c.localidad) LIKE LOWER(:searchTerm) OR " +
                      "LOWER(c.provincia) LIKE LOWER(:searchTerm) OR " +
                      "EXISTS (SELECT 1 FROM c.canchaCollection ca JOIN ca.idDeporte d WHERE LOWER(d.nombre) LIKE LOWER(:searchTerm)) " +
                      "ORDER BY c.nombre";
        
        List<Complejo> complejos = getEntityManager().createQuery(jpql, Complejo.class)
                .setParameter("searchTerm", "%" + searchTerm + "%")
                .setMaxResults(limit)
                .getResultList();
        
        List<ComplejoDTO> dtoList = new ArrayList<>();
        for (Complejo comp : complejos) {
            ComplejoDTO dto = new ComplejoDTO();
            dto.setIdComplejo(comp.getIdComplejo());
            dto.setNombre(comp.getNombre());
            dto.setDireccion(comp.getDireccion());
            dto.setLocalidad(comp.getLocalidad());
            dto.setProvincia(comp.getProvincia()); // Added this line
            dto.setTelefono(comp.getTelefono());
            Set<String> deportesDelComplejo = comp.getCanchaCollection().stream()
                    .map(cancha -> cancha.getIdDeporte() != null ? cancha.getIdDeporte().getNombre() : null)
                    .filter(Objects::nonNull)
                    .collect(Collectors.toSet());
            dto.setDeportes(deportesDelComplejo);
            dtoList.add(dto);
        }
        return dtoList;
    }
}
