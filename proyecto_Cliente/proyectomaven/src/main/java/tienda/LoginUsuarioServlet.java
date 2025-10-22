package tienda;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/LoginUsuarioServlet")
public class LoginUsuarioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        // Obtener parámetros del formulario
        String nombre = request.getParameter("nombre_r");
        String apellidos = request.getParameter("apel");
        String dni = request.getParameter("dni");
        String email = request.getParameter("correo");
        String telefono = request.getParameter("telf");
        String domicilio = request.getParameter("direc");
        String poblacion = request.getParameter("ciudad");
        String provincia = request.getParameter("prov");
        String cp = request.getParameter("cp");
        String usuario = request.getParameter("nombre_u");
        String password = request.getParameter("pass");
        String password2 = request.getParameter("n_pass");


        if (!password.equals(password2)) {
            response.sendRedirect("registro.jsp?error=claveNoCoincide");
            return;
        }

        try {
            AccesoBD acceso = AccesoBD.getInstance();
            Connection conexion = acceso.getConexion();

            if(acceso.comprobarUsuarioBD(usuario, password) != -1) {
                response.sendRedirect("registro.jsp?error=usuario");
                return;
            }

            String sql = "INSERT INTO usuarios (usuario, clave, activo, admin, nombre, apellidos, domicilio, poblacion, provincia, cp, telefono, dni, correo_electronico) "
                       + "VALUES (?, ?, 1, 0, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement stmt = conexion.prepareStatement(sql);
            stmt.setString(1, usuario);
            stmt.setString(2, password);
            stmt.setString(3, nombre);
            stmt.setString(4, apellidos);
            stmt.setString(5, domicilio);
            stmt.setString(6, poblacion);
            stmt.setString(7, provincia);
            stmt.setString(8, cp);
            stmt.setString(9, telefono);
            stmt.setString(10, dni);
            stmt.setString(11, email);

            stmt.executeUpdate();

            response.sendRedirect("index.jsp?registro=ok");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registro.jsp?error=bd");
        }
    }
}

