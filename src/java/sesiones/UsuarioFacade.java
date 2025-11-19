/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sesiones;

import entidades.Usuario;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

/**
 *
 * @author martinLocal
 */
@Stateless
public class UsuarioFacade extends AbstractFacade<Usuario> {

    @PersistenceContext(unitName = "PlayTimeAppPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UsuarioFacade() {
        super(Usuario.class);
    }
    
    /**
     * Busca un usuario por su dirección de email.
     * @param email El email del usuario a buscar.
     * @return El objeto Usuario si se encuentra, o null si no existe.
     */
    public Usuario findByEmail(String email) {
        try {
            // Usamos la NamedQuery definida en la entidad Usuario
            // Añadimos un cast explícito (Usuario) para asegurar el tipo de retorno y evitar errores de compilación.
            return (Usuario) getEntityManager().createNamedQuery("Usuario.findByEmail")
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (jakarta.persistence.NoResultException e) {
            // Es normal que no se encuentre un usuario, en ese caso devolvemos null.
            return null;
        }
    }
}
