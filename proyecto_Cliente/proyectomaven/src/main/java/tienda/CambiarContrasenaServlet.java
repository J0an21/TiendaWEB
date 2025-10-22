package tienda;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CambiarContrasenaServlet")
public class CambiarContrasenaServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("codigo") == null) {
            response.sendRedirect("perfil.jsp");
            return;
        }

        int codigoUsuario = (Integer) session.getAttribute("codigo");

        String contrasenaActual = request.getParameter("contrasenaActual");
        String nuevaContrasena = request.getParameter("nuevaContrasena");
        String repetirContrasena = request.getParameter("repetirContrasena");

        if (!nuevaContrasena.equals(repetirContrasena)) {
            request.setAttribute("error", "Las nuevas contraseñas no coinciden.");
            request.getRequestDispatcher("cambiar_contrasena.jsp").forward(request, response);
            return;
        }

        AccesoBD acceso = AccesoBD.getInstance();
        UsuarioBD usuario = acceso.obtenerUsuario(codigoUsuario);

        if (usuario == null) {
            request.setAttribute("error", "Usuario no encontrado.");
            request.getRequestDispatcher("cambiar_contrasena.jsp").forward(request, response);
            return;
        }

        if (!usuario.getPassword().equals(contrasenaActual)) {
            request.setAttribute("error", "La contraseña actual no es correcta.");
            request.getRequestDispatcher("cambiar_contrasena.jsp").forward(request, response);
            return;
        }

        boolean actualizada = acceso.actualizarContrasena(codigoUsuario, nuevaContrasena);

        if (actualizada) {
            request.setAttribute("mensaje", "Contraseña actualizada correctamente.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Error al actualizar la contraseña.");
            request.getRequestDispatcher("cambiar_contrasena.jsp").forward(request, response);
        }
    }
}


