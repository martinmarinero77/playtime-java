package sesiones;

import entidades.Reserva;
import entidades.ReservaJugador;
import entidades.ReservaJugadorPK;
import entidades.Usuario;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@Stateless
public class ReservaJugadorFacade extends AbstractFacade<ReservaJugador> {

    @PersistenceContext(unitName = "PlayTimeAppPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ReservaJugadorFacade() {
        super(ReservaJugador.class);
    }

    /**
     * Crea una invitación para que un usuario se una a una reserva.
     * @param idReserva El ID de la reserva.
     * @param idUsuarioInvitado El ID del usuario a invitar.
     * @return Un string indicando el resultado: "exito", "ya_invitado".
     */
    public String crearInvitacion(int idReserva, int idUsuarioInvitado) {
        ReservaJugadorPK pk = new ReservaJugadorPK(idReserva, idUsuarioInvitado);
        
        if (find(pk) != null) {
            return "ya_invitado";
        }
        
        ReservaJugador nuevaInvitacion = new ReservaJugador(pk);
        nuevaInvitacion.setEstadoInvitacion("PENDIENTE"); // Estado inicial en mayúsculas
        nuevaInvitacion.setCamiseta("NINGUNO"); // Valor por defecto para el ENUM de la BD
        
        // Asignar las relaciones usando proxies para eficiencia
        Reserva reservaProxy = em.getReference(Reserva.class, idReserva);
        Usuario usuarioProxy = em.getReference(Usuario.class, idUsuarioInvitado);
        nuevaInvitacion.setReserva(reservaProxy);
        nuevaInvitacion.setUsuario(usuarioProxy);
        
        em.persist(nuevaInvitacion);
        return "exito";
    }
    
    /**
     * Añade al anfitrión (dueño) de la reserva como el primer jugador aceptado.
     * @param idReserva El ID de la reserva.
     * @param idUsuarioAnfitrion El ID del usuario anfitrión.
     */
    public void addAnfitrion(int idReserva, int idUsuarioAnfitrion) {
        ReservaJugadorPK pk = new ReservaJugadorPK(idReserva, idUsuarioAnfitrion);

        // Solo proceder si el anfitrión no ha sido añadido previamente
        if (find(pk) == null) {
            ReservaJugador anfitrion = new ReservaJugador(pk);
            anfitrion.setEstadoInvitacion("ACEPTADA");
            anfitrion.setCamiseta("NINGUNO");

            Reserva reservaProxy = em.getReference(Reserva.class, idReserva);
            Usuario usuarioProxy = em.getReference(Usuario.class, idUsuarioAnfitrion);
            anfitrion.setReserva(reservaProxy);
            anfitrion.setUsuario(usuarioProxy);

            em.persist(anfitrion);
        }
    }

    /**
     * Busca todos los jugadores y sus estados para una reserva específica.
     * @param idReserva El ID de la reserva.
     * @return Una lista de entidades ReservaJugador.
     */
    public List<ReservaJugador> findJugadoresByReserva(int idReserva) {
        return getEntityManager().createNamedQuery("ReservaJugador.findByIdReserva", ReservaJugador.class)
                .setParameter("idReserva", idReserva)
                .getResultList();
    }

    /**
     * Busca todas las invitaciones pendientes para un usuario específico.
     * @param idUsuario El ID del usuario.
     * @return Una lista de invitaciones pendientes.
     */
    public List<ReservaJugador> findInvitacionesByUsuario(int idUsuario) {
        return getEntityManager().createQuery(
                "SELECT rj FROM ReservaJugador rj WHERE rj.reservaJugadorPK.idUsuario = :idUsuario AND rj.estadoInvitacion = 'PENDIENTE'", ReservaJugador.class)
                .setParameter("idUsuario", idUsuario)
                .getResultList();
    }
    
    /**
     * Permite a un usuario responder a una invitación.
     * @param idReserva El ID de la reserva.
     * @param idUsuario El ID del usuario que responde.
     * @param aceptada true si acepta, false si rechaza.
     * @return true si la operación fue exitosa, false si no se encontró la invitación.
     */
    public boolean responderInvitacion(int idReserva, int idUsuario, boolean aceptada) {
        ReservaJugadorPK pk = new ReservaJugadorPK(idReserva, idUsuario);
        ReservaJugador invitacion = find(pk);

        if (invitacion != null && "PENDIENTE".equals(invitacion.getEstadoInvitacion())) {
            if (aceptada) {
                invitacion.setEstadoInvitacion("ACEPTADA");
                em.merge(invitacion);
            } else {
                // Si rechaza, simplemente eliminamos la invitación.
                em.remove(invitacion);
            }
            return true;
        }
        return false;
    }
    
    /**
     * Elimina todos los jugadores asociados a una reserva.
     * @param idReserva El ID de la reserva a limpiar.
     * @return el número de registros eliminados.
     */
    public int deleteByReserva(int idReserva) {
        return getEntityManager().createQuery(
                "DELETE FROM ReservaJugador rj WHERE rj.reservaJugadorPK.idReserva = :idReserva")
                .setParameter("idReserva", idReserva)
                .executeUpdate();
    }
    
    /**
     * Elimina a un jugador de una reserva (acción de abandonar equipo).
     * @param idReserva El ID de la reserva.
     * @param idUsuario El ID del usuario que abandona.
     * @return true si el jugador fue encontrado y eliminado, false en caso contrario.
     */
    public boolean abandonarEquipo(int idReserva, int idUsuario) {
        ReservaJugadorPK pk = new ReservaJugadorPK(idReserva, idUsuario);
        ReservaJugador jugador = find(pk);
        if (jugador != null) {
            em.remove(jugador);
            return true;
        }
        return false;
    }
    
    /**
     * Asigna una camiseta (equipo) a un jugador dentro de una reserva.
     * @param idReserva El ID de la reserva.
     * @param idUsuario El ID del usuario.
     * @param camiseta El equipo a asignar ("CLARA", "OSCURA", "NINGUNO").
     * @return true si la operación fue exitosa, false en caso contrario.
     */
    public boolean asignarCamiseta(int idReserva, int idUsuario, String camiseta) {
        // Validar que la camiseta sea uno de los valores permitidos para evitar datos corruptos.
        if (!"CLARA".equals(camiseta) && !"OSCURA".equals(camiseta) && !"NINGUNO".equals(camiseta)) {
            return false;
        }
        
        ReservaJugadorPK pk = new ReservaJugadorPK(idReserva, idUsuario);
        ReservaJugador jugador = find(pk);
        
        if (jugador != null) {
            jugador.setCamiseta(camiseta);
            em.merge(jugador);
            return true;
        }
        return false;
    }
    
    /**
     * Permite a un usuario unirse a una reserva pública, y si se llena, la hace privada.
     * @param idReserva El ID de la reserva.
     * @param idUsuario El ID del usuario que se une.
     * @return Un string indicando el resultado: "exito", "ya_invitado", "error".
     */
    public String unirseAPartidoPublico(int idReserva, int idUsuario) {
        // Paso 1: Intentar crear la invitación. Si ya existe, no se puede unir de nuevo.
        ReservaJugadorPK pk = new ReservaJugadorPK(idReserva, idUsuario);
        if (find(pk) != null) {
            return "ya_invitado";
        }
        
        crearInvitacion(idReserva, idUsuario);

        // Paso 2: Aceptar la invitación automáticamente.
        boolean aceptado = responderInvitacion(idReserva, idUsuario, true);
        if (!aceptado) {
            // Si falla la aceptación (algo raro si la creación fue exitosa), revertir.
            return "error";
        }

        // Paso 3: Verificar si la reserva se ha llenado.
        try {
            Reserva reserva = em.find(Reserva.class, idReserva);
            if (reserva == null) {
                return "error"; // La reserva ya no existe.
            }

            // Contar solo los jugadores aceptados.
            long jugadoresAceptados = countAceptadosByReserva(idReserva);
            
            // Obtener capacidad de la cancha.
            int capacidadCancha = reserva.getCanchaidCancha().getCapacidad();
            int maxJugadores = capacidadCancha * 2;

            // Si el número de jugadores alcanza o supera el máximo, hacer la reserva privada.
            if (jugadoresAceptados >= maxJugadores) {
                reserva.setEsPublica(false);
                em.merge(reserva);
            }
        } catch (Exception e) {
            // En un entorno real, aquí iría un log.
            return "error";
        }

        return "exito";
    }
    
    /**
     * Cuenta el número de jugadores aceptados en una reserva.
     * @param idReserva El ID de la reserva.
     * @return El número de jugadores con estado 'ACEPTADA'.
     */
    public long countAceptadosByReserva(int idReserva) {
        return getEntityManager().createQuery(
            "SELECT COUNT(rj) FROM ReservaJugador rj WHERE rj.reservaJugadorPK.idReserva = :idReserva AND rj.estadoInvitacion = 'ACEPTADA'", Long.class)
            .setParameter("idReserva", idReserva)
            .getSingleResult();
    }
}
