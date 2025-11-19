package controladores;

import com.google.gson.Gson;
import dto.ComplejoDTO;
import dto.ReservaDTO;
import entidades.Complejo;
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
import sesiones.ComplejoFacade;
import sesiones.ReservaFacade;
import sesiones.ReservaJugadorFacade;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "ManejadorServlet", urlPatterns = {"/ManejadorServlet"})
public class ManejadorServlet extends HttpServlet {

    @EJB
    private ComplejoFacade complejoFacade;
    @EJB
    private ReservaFacade reservaFacade;
    @EJB
    private ReservaJugadorFacade reservaJugadorFacade; // Inyectar ReservaJugadorFacade

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");

        if (usuarioLogueado == null) {
            response.sendRedirect(request.getContextPath() + "/vistas/login.jsp");
            return;
        }

        if (action == null) {
            action = "home"; // Por defecto, la acción es ir a la home.
        }

        switch (action) {
            case "home":
                cargarHome(request, response, usuarioLogueado);
                break;
            case "comunidad":
                cargarComunidad(request, response, usuarioLogueado);
                break;
            case "searchComplejosAjax":
                searchComplejosAjax(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/ManejadorServlet?action=home");
        }
    }

    private void searchComplejosAjax(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String searchTerm = request.getParameter("searchTerm");
        List<ComplejoDTO> resultados = new ArrayList<>();

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            // Asumimos que el método searchComplejos existe en la fachada
            resultados = complejoFacade.searchComplejos(searchTerm, 5); 
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new Gson().toJson(resultados));
    }
    
    private void cargarHome(HttpServletRequest request, HttpServletResponse response, Usuario usuarioLogueado)
            throws ServletException, IOException {
        
        // 1. Obtener complejos destacados
        List<ComplejoDTO> complejosDestacados = complejoFacade.findDestacados(3);
        request.setAttribute("complejosDestacados", complejosDestacados);

        // 2. Obtener próximos partidos y enriquecerlos con el conteo de jugadores
        List<Reserva> proximosPartidos = reservaFacade.findByUsuario(usuarioLogueado);
        List<ReservaDTO> partidosDTO = new ArrayList<>();
        for (Reserva partido : proximosPartidos) {
            ReservaDTO dto = new ReservaDTO();
            dto.setReserva(partido);
            long conteoJugadores = reservaJugadorFacade.countAceptadosByReserva(partido.getIdReserva());
            dto.setJugadoresAceptados(conteoJugadores);
            partidosDTO.add(dto);
        }
        
        // Aplicar el límite después de haber procesado todo
        request.setAttribute("proximosPartidos", partidosDTO.stream().limit(2).collect(Collectors.toList()));

        // 3. Reenviar a home.jsp
        request.getRequestDispatcher("/vistas/home.jsp").forward(request, response);
    }

    private void cargarComunidad(HttpServletRequest request, HttpServletResponse response, Usuario usuarioLogueado)
            throws ServletException, IOException {
        
        // 1. Obtener invitaciones pendientes del usuario
        List<ReservaJugador> invitaciones = reservaJugadorFacade.findInvitacionesByUsuario(usuarioLogueado.getIdUsuario());
        request.setAttribute("invitaciones", invitaciones);

        // 2. Obtener reservas públicas con conteo de jugadores
        List<ReservaDTO> publicasDTO = reservaFacade.findPublicasConConteo(10, usuarioLogueado);
        request.setAttribute("reservasPublicas", publicasDTO);

        // 3. Reenviar a Comunidad.jsp
        request.getRequestDispatcher("/vistas/Comunidad.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet manejador para acciones generales y carga de vistas";
    }
}
