package controladores;

import com.google.gson.Gson;
import entidades.Reserva;
import entidades.Usuario;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import sesiones.ReservaFacade;

@WebServlet(name = "ReservaServlet", urlPatterns = {"/ReservaServlet", "/reservas"})
public class ReservaServlet extends HttpServlet {

    @EJB
    private ReservaFacade reservaFacade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no especificada.");
            return;
        }

        switch (action) {
            case "getHorarios":
                getHorariosDisponibles(request, response);
                break;
            case "mis_reservas":
                misReservas(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción desconocida.");
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
            case "crearReserva":
                crearReserva(request, response);
                break;
            case "cancelar":
                cancelarReserva(request, response);
                break;
            case "togglePublica":
                togglePublica(request, response, usuarioLogueado);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas");
        }
    }
    
    private void togglePublica(HttpServletRequest request, HttpServletResponse response, Usuario usuarioLogueado) throws IOException {
        try {
            int idReserva = Integer.parseInt(request.getParameter("idReserva"));
            boolean makePublic = Boolean.parseBoolean(request.getParameter("makePublic"));
            
            Reserva reserva = reservaFacade.find(idReserva);

            if (reserva == null || !reserva.getIdUsuarioReserva().equals(usuarioLogueado)) {
                response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&error=toggle_no_autorizado");
                return;
            }

            boolean exito = reservaFacade.togglePublica(idReserva, makePublic);

            if (exito) {
                String mensaje = makePublic ? "reserva_publicada" : "reserva_privatizada";
                response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&exito=" + mensaje);
            } else {
                response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&error=toggle_fallido");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&error=id_invalido");
        }
    }

    private void cancelarReserva(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int idReserva = Integer.parseInt(request.getParameter("idReserva"));
            HttpSession session = request.getSession();
            Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");

            if (usuarioLogueado == null) {
                response.sendRedirect(request.getContextPath() + "/vistas/login.jsp?error=DebeIniciarSesion");
                return;
            }

            Reserva reserva = reservaFacade.find(idReserva);

            if (reserva == null || !reserva.getIdUsuarioReserva().equals(usuarioLogueado)) {
                response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&error=cancelacion_no_autorizada");
                return;
            }

            String resultado = reservaFacade.cancelarReserva(idReserva);
            String feedbackParam;

            switch (resultado) {
                case "exito":
                    feedbackParam = "&exito=reserva_cancelada";
                    break;
                case "fuera_de_tiempo":
                    feedbackParam = "&error=fuera_de_tiempo";
                    break;
                default:
                    feedbackParam = "&error=cancelacion_fallida";
                    break;
            }
            response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas" + feedbackParam);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/reservas?action=mis_reservas&error=id_invalido");
        }
    }
    
    private void misReservas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");

        if (usuarioLogueado == null) {
            response.sendRedirect(request.getContextPath() + "/vistas/login.jsp?error=DebeIniciarSesion");
            return;
        }

        List<Reserva> misReservas = reservaFacade.findByUsuario(usuarioLogueado);
        request.setAttribute("misReservas", misReservas);
        request.getRequestDispatcher("/vistas/Reservas.jsp").forward(request, response);
    }

    private void getHorariosDisponibles(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        try {
            int idCancha = Integer.parseInt(request.getParameter("idCancha"));
            String fechaStr = request.getParameter("fecha");

            if (fechaStr == null || fechaStr.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "La fecha es obligatoria.");
                return;
            }

            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date fecha = formatter.parse(fechaStr);

            List<Reserva> reservas = reservaFacade.findHorariosOcupados(idCancha, fecha);

            List<Integer> horasOcupadas = reservas.stream()
                                                  .map(reserva -> {
                                                      java.util.Calendar cal = java.util.Calendar.getInstance();
                                                      cal.setTime(reserva.getFechaHoraInicio());
                                                      return cal.get(java.util.Calendar.HOUR_OF_DAY);
                                                  })
                                                  .collect(Collectors.toList());

            String json = new Gson().toJson(horasOcupadas);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de cancha inválido.");
        } catch (ParseException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Formato de fecha inválido. Use yyyy-MM-dd.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al procesar la solicitud.");
        }
    }

    private void crearReserva(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            Usuario usuarioLogueado = 
                    (Usuario) request.getSession().getAttribute("usuarioLogueado");

            if (usuarioLogueado == null) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Debe iniciar sesión para reservar.");
                return;
            }

            Gson gson = new Gson();
            ReservaData data = gson.fromJson(request.getReader(), ReservaData.class);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date fechaHora = sdf.parse(data.horaInicio);

            reservaFacade.crearReserva(
                data.idCancha,
                usuarioLogueado.getIdUsuario(),
                fechaHora
            );

            response.setStatus(HttpServletResponse.SC_CREATED);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"status\":\"success\", \"message\":\"Reserva creada exitosamente.\"}");

        } catch (ParseException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"message\":\"Formato de fecha inválido.\"}");
        } catch (jakarta.persistence.PersistenceException e) {
            response.setStatus(HttpServletResponse.SC_CONFLICT);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"message\":\"El horario acaba de ser ocupado por otra persona.\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"message\":\"Error interno del servidor: " + e.getMessage() + "\"}");
        }
    }
    
    private static class ReservaData {
        int idCancha;
        String horaInicio;
    }

    @Override
    public String getServletInfo() {
        return "Servlet para gestionar reservas y horarios";
    }
}
