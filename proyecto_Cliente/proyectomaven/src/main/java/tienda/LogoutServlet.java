package tienda;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        // Obtener la sesión actual (si existe)
        HttpSession session = request.getSession(false); // No crea una nueva si no existe
        if (session != null) {
            // Invalidar la sesión (eliminar los atributos de la sesión)
            session.invalidate();
        }

        // Recuperar el parámetro "redirect" para saber a dónde redirigir
        String redirectURL = request.getParameter("redirect");
        if (redirectURL == null || redirectURL.isEmpty()) {
            // Página por defecto a la que se redirige si no se especificó "redirect"
            redirectURL = "index.jsp";
        }
        System.out.println("Sesion cerrada");
        // Redirigir al usuario a la URL indicada
        response.sendRedirect(redirectURL);
    }
}
