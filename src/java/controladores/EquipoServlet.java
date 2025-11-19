package controladores;

import entidades.Reserva;
import entidades.ReservaJugador;
import entidades.Usuario;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sesiones.ReservaFacade;
import sesiones.ReservaJugadorFacade;
import sesiones.UsuarioFacade;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "EquipoServlet", urlPatterns = {"/EquipoServlet"})
public class EquipoServlet extends HttpServlet {

    @EJB
    private ReservaJugadorFacade reservaJugadorFacade;
    @EJB
    private UsuarioFacade usuarioFacade;
    @EJB
    private ReservaFacade reservaFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");

        if (usuarioLogueado == null) {
            response.sendRedirect(request.getContextPath() + "/vistas/login.jsp?mensaje=Debe iniciar sesion.");
            return;
        }

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas");
            return;
        }

        switch (action) {
            case "verEquipo":
                verEquipo(request, response, usuarioLogueado);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");

        if (usuarioLogueado == null) {
            response.sendRedirect(request.getContextPath() + "/vistas/login.jsp?mensaje=Debe iniciar sesion para realizar esta accion.");
            return;
        }
        
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas");
            return;
        }

        switch (action) {
            case "invitarJugador":
                invitarJugador(request, response, usuarioLogueado);
                break;
            case "responderInvitacion":
                responderInvitacion(request, response, usuarioLogueado);
                break;
            case "eliminarJugador":
                eliminarJugador(request, response, usuarioLogueado);
                break;
            case "abandonarEquipo":
                abandonarEquipo(request, response, usuarioLogueado);
                break;
            case "asignarCamiseta":
                asignarCamiseta(request, response, usuarioLogueado);
                break;
            case "unirseAReservaPublica":
                unirseAReservaPublica(request, response, usuarioLogueado);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas");
        }
    }

    private void verEquipo(HttpServletRequest request, HttpServletResponse response, Usuario usuarioLogueado)
            throws ServletException, IOException {
        try {
            int idReserva = Integer.parseInt(request.getParameter("idReserva"));
            Reserva reserva = reservaFacade.find(idReserva);

            if (reserva == null) {
                response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&error=reserva_no_encontrada");
                return;
            }

            boolean esAnfitrion = reserva.getIdUsuarioReserva().equals(usuarioLogueado);
            List<ReservaJugador> jugadores = reservaJugadorFacade.findJugadoresByReserva(idReserva);
            
            boolean esParticipanteAceptado = false;
            for (ReservaJugador rj : jugadores) {
                if (rj.getUsuario().equals(usuarioLogueado) && "ACEPTADA".equals(rj.getEstadoInvitacion())) {
                    esParticipanteAceptado = true;
                    break;
                }
            }

            if (!esAnfitrion && !esParticipanteAceptado) {
                response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&error=no_autorizado");
                return;
            }
            
            if (esAnfitrion) {
                boolean anfitrionEnLista = false;
                for (ReservaJugador rj : jugadores) {
                    if (rj.getUsuario().equals(usuarioLogueado)) {
                        anfitrionEnLista = true;
                        break;
                    }
                }
                if (!anfitrionEnLista) {
                    reservaJugadorFacade.addAnfitrion(idReserva, usuarioLogueado.getIdUsuario());
                    jugadores = reservaJugadorFacade.findJugadoresByReserva(idReserva);
                }
            }

            request.setAttribute("reserva", reserva);
            request.setAttribute("jugadores", jugadores);
            request.getRequestDispatcher("/vistas/Equipo.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&error=id_invalido");
        }
    }

    private void asignarCamiseta(HttpServletRequest request, HttpServletResponse response, Usuario usuarioLogueado)
            throws IOException {
        try {
            int idReserva = Integer.parseInt(request.getParameter("idReserva"));
            int idUsuarioJugador = Integer.parseInt(request.getParameter("idUsuario"));
            String camiseta = request.getParameter("camiseta");
            
            Reserva reserva = reservaFacade.find(idReserva);
            if (reserva == null) {
                response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&error=reserva_no_encontrada");
                return;
            }

            boolean esAnfitrion = reserva.getIdUsuarioReserva().equals(usuarioLogueado);
            List<ReservaJugador> jugadores = reservaJugadorFacade.findJugadoresByReserva(idReserva);
            boolean esParticipanteAceptado = false;
            for (ReservaJugador rj : jugadores) {
                if (rj.getUsuario().equals(usuarioLogueado) && "ACEPTADA".equals(rj.getEstadoInvitacion())) {
                    esParticipanteAceptado = true;
                    break;
                }
            }

            if (!esAnfitrion && !esParticipanteAceptado) {
                response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&error=no_autorizado");
                return;
            }

            reservaJugadorFacade.asignarCamiseta(idReserva, idUsuarioJugador, camiseta);
            response.sendRedirect(request.getContextPath() + "/EquipoServlet?action=verEquipo&idReserva=" + idReserva);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&error=id_invalido");
        }
    }

    private void unirseAReservaPublica(HttpServletRequest request, HttpServletResponse response, Usuario usuarioLogueado)
            throws IOException {
        try {
            int idReserva = Integer.parseInt(request.getParameter("idReserva"));
            Reserva reserva = reservaFacade.find(idReserva);

            // Verificaciones previas en el servlet
            if (reserva == null || !reserva.isEsPublica() || !"CONFIRMADA".equals(reserva.getEstado())) {
                response.sendRedirect(request.getContextPath() + "/ManejadorServlet?action=comunidad&error=reserva_no_valida");
                return;
            }

            // La lógica de unirse y la verificación de si ya es miembro se delega al Facade
            String resultado = reservaJugadorFacade.unirseAPartidoPublico(idReserva, usuarioLogueado.getIdUsuario());

            switch (resultado) {
                case "exito":
                    response.sendRedirect(request.getContextPath() + "/ManejadorServlet?action=comunidad&exito=unido_a_reserva");
                    break;
                case "ya_invitado":
                    response.sendRedirect(request.getContextPath() + "/ManejadorServlet?action=comunidad&error=ya_eres_miembro");
                    break;
                default: // "error" u otro caso
                    response.sendRedirect(request.getContextPath() + "/ManejadorServlet?action=comunidad&error=unirse_fallido");
                    break;
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/ManejadorServlet?action=comunidad&error=id_invalido");
        } catch (Exception e) {
            // Captura más genérica para cualquier problema inesperado en el facade
            response.sendRedirect(request.getContextPath() + "/ManejadorServlet?action=comunidad&error=unirse_fallido");
        }
    }

    private void misInvitaciones(HttpServletRequest request, HttpServletResponse response, Usuario usuarioLogueado)
            throws ServletException, IOException {
        List<ReservaJugador> invitaciones = reservaJugadorFacade.findInvitacionesByUsuario(usuarioLogueado.getIdUsuario());
        request.setAttribute("invitaciones", invitaciones);
        request.getRequestDispatcher("/vistas/Comunidad.jsp").forward(request, response);
    }

    private void invitarJugador(HttpServletRequest request, HttpServletResponse response, Usuario usuarioLogueado)
            throws IOException {
        try {
            int idReserva = Integer.parseInt(request.getParameter("idReserva"));
            String emailInvitado = request.getParameter("email");
            
            Reserva reserva = reservaFacade.find(idReserva);
            if (reserva == null) {
                response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&error=reserva_no_encontrada");
                return;
            }

            // Seguridad: Anfitrión O participante aceptado pueden invitar.
            boolean esAnfitrion = reserva.getIdUsuarioReserva().equals(usuarioLogueado);
            List<ReservaJugador> jugadores = reservaJugadorFacade.findJugadoresByReserva(idReserva);
            boolean esParticipanteAceptado = false;
            for (ReservaJugador rj : jugadores) {
                if (rj.getUsuario().equals(usuarioLogueado) && "ACEPTADA".equals(rj.getEstadoInvitacion())) {
                    esParticipanteAceptado = true;
                    break;
                }
            }

            if (!esAnfitrion && !esParticipanteAceptado) {
                response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&error=no_autorizado_invitar");
                return;
            }

            Usuario invitado = usuarioFacade.findByEmail(emailInvitado);
            if (invitado == null) {
                response.sendRedirect(request.getContextPath() + "/EquipoServlet?action=verEquipo&idReserva=" + idReserva + "&error=UsuarioNoEncontrado");
                return;
            }

            if (invitado.equals(usuarioLogueado)) {
                response.sendRedirect(request.getContextPath() + "/EquipoServlet?action=verEquipo&idReserva=" + idReserva + "&error=InvitacionAUnoMismo");
                return;
            }

            String resultado = reservaJugadorFacade.crearInvitacion(idReserva, invitado.getIdUsuario());
            String feedbackParam;
            
            switch (resultado) {
                case "exito":
                    feedbackParam = "&exito=InvitacionEnviada";
                    break;
                case "ya_invitado":
                    feedbackParam = "&error=UsuarioYaInvitado";
                    break;
                default:
                    feedbackParam = "&error=ErrorDesconocido";
                    break;
            }
            response.sendRedirect(request.getContextPath() + "/EquipoServlet?action=verEquipo&idReserva=" + idReserva + feedbackParam);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&error=id_invalido");
        }
    }

    private void eliminarJugador(HttpServletRequest request, HttpServletResponse response, Usuario usuarioLogueado)
        throws IOException {
        try {
            int idReserva = Integer.parseInt(request.getParameter("idReserva"));
            int idUsuarioAEliminar = Integer.parseInt(request.getParameter("idUsuario"));
            Reserva reserva = reservaFacade.find(idReserva);

            // Chequeo de seguridad: solo el anfitrión puede eliminar, y no a sí mismo.
            if (reserva == null || !reserva.getIdUsuarioReserva().equals(usuarioLogueado) || idUsuarioAEliminar == usuarioLogueado.getIdUsuario()) {
                response.sendRedirect(request.getContextPath() + "/EquipoServlet?action=verEquipo&idReserva=" + idReserva + "&error=eliminacion_no_autorizada");
                return;
            }

            boolean exito = reservaJugadorFacade.abandonarEquipo(idReserva, idUsuarioAEliminar);

            if (exito) {
                response.sendRedirect(request.getContextPath() + "/EquipoServlet?action=verEquipo&idReserva=" + idReserva + "&exito=jugador_eliminado");
            } else {
                response.sendRedirect(request.getContextPath() + "/EquipoServlet?action=verEquipo&idReserva=" + idReserva + "&error=eliminacion_fallida");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&error=id_invalido");
        }
    }
    
    private void responderInvitacion(HttpServletRequest request, HttpServletResponse response, Usuario usuarioLogueado)
            throws IOException {
        try {
            int idReserva = Integer.parseInt(request.getParameter("idReserva"));
            String respuesta = request.getParameter("respuesta");

            boolean aceptada = "aceptar".equals(respuesta);
            boolean exito = reservaJugadorFacade.responderInvitacion(idReserva, usuarioLogueado.getIdUsuario(), aceptada);

            if (exito) {
                response.sendRedirect(request.getContextPath() + "/EquipoServlet?action=misInvitaciones&exito=RespuestaEnviada");
            } else {
                response.sendRedirect(request.getContextPath() + "/EquipoServlet?action=misInvitaciones&error=InvitacionNoEncontrada");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&error=id_invalido");
        }
    }
    
    private void abandonarEquipo(HttpServletRequest request, HttpServletResponse response, Usuario usuarioLogueado)
            throws IOException {
        try {
            int idReserva = Integer.parseInt(request.getParameter("idReserva"));
            Reserva reserva = reservaFacade.find(idReserva);

            if (reserva == null || reserva.getIdUsuarioReserva().equals(usuarioLogueado)) {
                response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&error=abandono_no_autorizado");
                return;
            }

            boolean exito = reservaJugadorFacade.abandonarEquipo(idReserva, usuarioLogueado.getIdUsuario());

            if (exito) {
                response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&exito=equipo_abandonado");
            } else {
                response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&error=abandono_fallido");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&error=id_invalido");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para gestionar equipos y jugadores en una reserva";
    }
}