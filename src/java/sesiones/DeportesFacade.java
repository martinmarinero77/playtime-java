package sesiones;

import entidades.Complejo;
import entidades.Deportes;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class DeportesFacade extends AbstractFacade<Deportes> {

    @PersistenceContext(unitName = "PlayTimeAppPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public DeportesFacade() {
        super(Deportes.class);
    }
    
    /**
     * Encuentra todos los deportes que están asociados al menos a una cancha.
     * Utiliza un JOIN para eficiencia y DISTINCT para evitar duplicados.
     * @return Una lista de entidades Deportes únicas y disponibles.
     */
    public List<Deportes> findDeportesDisponibles() {
        // JPQL (Java Persistence Query Language) es muy similar a SQL
        // "SELECT DISTINCT d" -> Selecciona objetos Deporte únicos
        // "FROM Deportes d" -> De la tabla de Deportes (representada por la entidad Deportes)
        // "JOIN d.canchaCollection c" -> Une con la colección de canchas. Esto asegura que solo
        // se seleccionen deportes que tengan al menos una cancha en su colección.
        return getEntityManager().createQuery("SELECT DISTINCT d FROM Deportes d JOIN d.canchaCollection c", Deportes.class)
                .getResultList();
    }
    
    /**
     * Encuentra los deportes únicos para un complejo específico.
     * @param idComplejo El complejo del cual se quieren obtener los deportes.
     * @return Una lista de entidades Deportes únicas para ese complejo.
     */
    public List<Deportes> findDeportesByComplejo(Complejo idComplejo) {
        return getEntityManager().createQuery("SELECT DISTINCT d FROM Deportes d JOIN d.canchaCollection c WHERE c.idComplejo = :idComplejo", Deportes.class)
                .setParameter("idComplejo", idComplejo)
                .getResultList();
    }
}