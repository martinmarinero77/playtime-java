package sesiones;

import entidades.Cancha;
import entidades.Reserva;
import entidades.Usuario;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.Date;
import java.util.List;

@Stateless
public class ReservaFacade extends AbstractFacade<Reserva> {

    @PersistenceContext(unitName = "PlayTimeAppPU")
    private EntityManager em;
    
    @EJB
    private ReservaJugadorFacade reservaJugadorFacade;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ReservaFacade() {
        super(Reserva.class);
    }
    
    public List<Reserva> findHorariosOcupados(int idCancha, Date fecha) {
        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.setTime(fecha);
        cal.set(java.util.Calendar.HOUR_OF_DAY, 0);
        cal.set(java.util.Calendar.MINUTE, 0);
        cal.set(java.util.Calendar.SECOND, 0);
        Date startOfDay = cal.getTime();
        cal.set(java.util.Calendar.HOUR_OF_DAY, 23);
        cal.set(java.util.Calendar.MINUTE, 59);
        cal.set(java.util.Calendar.SECOND, 59);
        Date endOfDay = cal.getTime();
        return em.createQuery(
                "SELECT r FROM Reserva r WHERE r.canchaidCancha.idCancha = :idCancha AND r.estado = 'CONFIRMADA' AND r.fechaHoraInicio BETWEEN :startOfDay AND :endOfDay", Reserva.class)
                .setParameter("idCancha", idCancha)
                .setParameter("startOfDay", startOfDay)
                .setParameter("endOfDay", endOfDay)
                .getResultList();
    }
    
    public void crearReserva(int idCancha, int idUsuario, Date horaInicio) {
        Reserva nuevaReserva = new Reserva();
        Cancha canchaProxy = em.getReference(Cancha.class, idCancha);
        Usuario usuarioProxy = em.getReference(Usuario.class, idUsuario);
        nuevaReserva.setCanchaidCancha(canchaProxy);
        nuevaReserva.setIdUsuarioReserva(usuarioProxy);
        nuevaReserva.setFechaHoraInicio(horaInicio);
        nuevaReserva.setEstado("CONFIRMADA");
        nuevaReserva.setEsPublica(false); // Por defecto, una reserva es privada
        em.persist(nuevaReserva);
    }
    
    /**
     * Cambia el estado de visibilidad pública de una reserva.
     * @param idReserva El ID de la reserva.
     * @param makePublic true para hacerla pública, false para hacerla privada.
     * @return true si la operación fue exitosa, false si la reserva no fue encontrada.
     */
    public boolean togglePublica(int idReserva, boolean makePublic) {
        Reserva reserva = find(idReserva);
        if (reserva != null) {
            reserva.setEsPublica(makePublic);
            
            // Si se está haciendo pública, añadir al anfitrión como jugador.
            if (makePublic) {
                reservaJugadorFacade.addAnfitrion(reserva.getIdReserva(), reserva.getIdUsuarioReserva().getIdUsuario());
            }
            
            em.merge(reserva);
            return true;
        }
        return false;
    }
    
    /**
     * Busca todas las reservas que son públicas y están confirmadas, ordenadas por fecha,
     * excluyendo aquellas en las que el usuario ya participa.
     * @param limit El número máximo de reservas a devolver.
     * @param usuario El usuario logueado, para excluir sus propias reservas o aquellas en las que ya participa.
     * @return Una lista de reservas públicas.
     */
    public List<Reserva> findPublicas(int limit, Usuario usuario) {
        return getEntityManager().createQuery(
            "SELECT r FROM Reserva r WHERE r.esPublica = TRUE AND r.estado = 'CONFIRMADA' AND r.fechaHoraInicio >= :now " +
            "AND r.idUsuarioReserva != :usuario " + // Excluir reservas del propio usuario
            "AND r.idReserva NOT IN (SELECT rj.reservaJugadorPK.idReserva FROM ReservaJugador rj WHERE rj.usuario = :usuario AND rj.estadoInvitacion = 'ACEPTADA') " + // Excluir reservas donde ya es participante
            "ORDER BY r.fechaHoraInicio ASC", Reserva.class)
            .setParameter("now", new Date())
            .setParameter("usuario", usuario)
            .setMaxResults(limit)
            .getResultList();
    }
    
    /**
     * Busca reservas públicas y las devuelve como DTOs con el conteo de jugadores.
     * @param limit El número máximo de reservas a devolver.
     * @param usuario El usuario logueado, para excluir sus propias reservas.
     * @return Una lista de ReservaDTO.
     */
    public List<dto.ReservaDTO> findPublicasConConteo(int limit, Usuario usuario) {
        List<Reserva> publicas = findPublicas(limit, usuario);
        List<dto.ReservaDTO> dtos = new java.util.ArrayList<>();
        
        for (Reserva reserva : publicas) {
            dto.ReservaDTO dto = new dto.ReservaDTO();
            dto.setReserva(reserva);
            long conteo = reservaJugadorFacade.countAceptadosByReserva(reserva.getIdReserva());
            dto.setJugadoresAceptados(conteo);
            dtos.add(dto);
        }
        
        return dtos;
    }
    
    public List<Reserva> findByUsuario(Usuario usuario) {
        return getEntityManager().createQuery(
            "SELECT r FROM Reserva r WHERE " +
            "(r.idUsuarioReserva = :usuario OR r.idReserva IN (SELECT rj.reservaJugadorPK.idReserva FROM ReservaJugador rj WHERE rj.usuario = :usuario AND rj.estadoInvitacion = 'ACEPTADA')) " +
            "AND r.estado = 'CONFIRMADA' " +
            "AND r.fechaHoraInicio >= :now " +
            "ORDER BY r.fechaHoraInicio ASC", Reserva.class)
            .setParameter("usuario", usuario)
            .setParameter("now", new Date())
            .getResultList();
    }
    
    public String cancelarReserva(int idReserva) {
        Reserva reservaACancelar = find(idReserva);
        if (reservaACancelar != null && "CONFIRMADA".equals(reservaACancelar.getEstado())) {
            // Regla de negocio: No se puede cancelar con 1 hora o menos de antelación.
            long diffInMillis = reservaACancelar.getFechaHoraInicio().getTime() - new Date().getTime();
            long diffInHours = diffInMillis / (60 * 60 * 1000);
            if (diffInHours < 1) {
                return "fuera_de_tiempo";
            }
            reservaJugadorFacade.deleteByReserva(idReserva);
            List<Reserva> canceladasExistentes = getEntityManager().createQuery(
                "SELECT r FROM Reserva r WHERE r.canchaidCancha = :cancha AND r.fechaHoraInicio = :fecha AND r.estado = 'CANCELADA'", Reserva.class)
                .setParameter("cancha", reservaACancelar.getCanchaidCancha())
                .setParameter("fecha", reservaACancelar.getFechaHoraInicio())
                .getResultList();
            if (canceladasExistentes.isEmpty()) {
                reservaACancelar.setEstado("CANCELADA");
                em.merge(reservaACancelar);
            } else {
                em.remove(reservaACancelar);
            }
            return "exito";
        }
        return "no_encontrada";
    }
}
