package tienda;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet") // Puedes cambiar esta ruta según tu configuración
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

   @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String usuario = request.getParameter("usuario");
		String clave = request.getParameter("clave");
		String url = request.getParameter("url");

		HttpSession session = request.getSession(true);

		AccesoBD con = AccesoBD.getInstance();
		if (url == null || url.isEmpty()) {
			url = "index.jsp";
		}

		if ((usuario != null) && (clave != null)) {
			int codigo = con.comprobarUsuarioBD(usuario, clave);
			if (codigo > 0) {
				session.setAttribute("codigo", codigo);
				session.setAttribute("usuario", usuario);
				session.setAttribute("loginStatus", "success");
				System.out.println("Usuario autenticado: " + usuario);
			} else {
				session.setAttribute("mensaje", "Usuario y/o clave incorrectos");
				session.setAttribute("tipoMensaje", "error");
				session.setAttribute("loginStatus", "error");
				System.out.println("Usuario y/o clave incorrectos");
			}
		} else {
			System.out.println("Error: Usuario o clave no proporcionados.");
		}

		request.getRequestDispatcher(url).forward(request, response);
	}


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
