/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sesiones;

import entidades.Cancha;
import entidades.Complejo;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

/**
 *
 * @author martinLocal
 */
@Stateless
public class CanchaFacade extends AbstractFacade<Cancha> {

    @PersistenceContext(unitName = "PlayTimeAppPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CanchaFacade() {
        super(Cancha.class);
    }
    
    public List<Cancha> findByIdComplejo(Complejo idComplejo) {
        return getEntityManager().createNamedQuery("Cancha.findByIdComplejo", Cancha.class)
                .setParameter("idComplejo", idComplejo)
                .getResultList();
    }
}
