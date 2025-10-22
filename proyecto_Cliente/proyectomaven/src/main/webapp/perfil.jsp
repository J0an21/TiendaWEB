<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, tienda.*" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/svg+xml" href="imagenes/icono.svg">
        <title>Mi tienda</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    
        <link rel="stylesheet" href="css/estilos.css">
    </head>
<body>
    <mi-cabecera></mi-cabecera>
    <br>
    <%
        Integer codigo = (Integer) session.getAttribute("codigo");
        AccesoBD acceso = AccesoBD.getInstance();
        int codigoInt = codigo;
        UsuarioBD usuario_p = acceso.obtenerUsuario(codigoInt);
    %>
    
    <div class="border rounded p-3 shadow-sm container" style="margin-top:100px;">
        <div class="d-flex align-items-center justify-content-center">
            <h2 class="text-center mb-0">Perfil de Usuario</h2>
            <i class="bi bi-person-circle ms-2" style="color:white; font-size: 2rem;"></i>
        </div>
        <hr>
        <div class="row">
            <h4>Datos Personales</h4>
            <div class="col-md-6">
                <p><strong>Nombre:</strong> <%= usuario_p.getNombre() %></p>
                <p><strong>Apellidos:</strong> <%= usuario_p.getApellidos() %></p>
                <p><strong>DNI:</strong> <%= usuario_p.getDni() %></p>
                <p><strong>Correo Electrónico:</strong> <%= usuario_p.getEmail() %></p>
                <p><strong>Teléfono:</strong> <%= usuario_p.getTelefono() %></p>
            </div>
            <div class="col-md-6">
                <p><strong>Provincia:</strong> <%= usuario_p.getProvincia() %></p>
                <p><strong>Dirección:</strong> <%= usuario_p.getDireccion() %></p>
                <p><strong>Ciudad:</strong> <%= usuario_p.getCiudad() %></p>
                <p><strong>Código Postal:</strong> <%= usuario_p.getCp() %></p>
            </div>
        </div>
        <hr>
        <h4>Datos de la Cuenta</h4>
        <p><strong>Nombre de Usuario:</strong> <%= usuario_p.getUsuario() %></p>
        <p><strong>Contraseña:</strong> ********</p>
        <hr>
        <div class="d-flex justify-content-center flex-wrap gap-3 mt-3">
            <a class="btn btn-primary px-4" href="pedidos_perfil.jsp">Consultar Pedidos</a>
            <a class="btn btn-primary px-4" href="editar_perfil.jsp">Editar Perfil</a>
            <a class="btn btn-primary px-4" href="cambiar_cont.jsp">Cambiar Contraseña</a>

            <form id="logoutForm" method="post" action="LogoutServlet">
                <input type="hidden" name="redirect" value="index.jsp">
                <button type="submit" class="btn btn-danger px-4" id="cerrarSesionBtn">Cerrar Sesión</button>
            </form>
        </div>
    </div>
   <%
        String loginStatus = (String) session.getAttribute("loginStatus");
        String usuario = (String) session.getAttribute("usuario");
    %>
    <script>
        window.loginStatus = "<%= loginStatus %>";
        window.nombreUsuario = "<%= usuario %>";
    </script>

    
    <br>
    <br>
    <br>
    <br>
    <mi-footer></mi-footer>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/cabecera.js"></script>
    <script src="js/footer.js"></script>
</body>
</html>