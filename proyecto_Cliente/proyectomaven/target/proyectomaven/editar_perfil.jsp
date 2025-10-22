<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="tienda.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Perfil</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
<mi-cabecera></mi-cabecera>
   <%
    Integer codigo = (Integer) session.getAttribute("codigo");

    if (codigo == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    AccesoBD acceso = AccesoBD.getInstance();
    int codigoInt = codigo;
    UsuarioBD usuario_p = acceso.obtenerUsuario(codigoInt);

    if (usuario_p == null) {
        // Aquí podría haber un problema en la BD o el usuario fue borrado
        response.sendRedirect("error.jsp"); // o un mensaje adecuado
        return;
    }
    %>

<div class="container mt-5">
    <h2>Editar Datos Personales</h2>
    <form action="ActualizarPerfilServlet" method="post" class="row g-3">
        <div class="col-md-6">
            <label for="nombre" class="form-label">Nombre</label>
            <input type="text" class="form-control" id="nombre" name="nombre" value="<%= usuario_p.getNombre() %>" required>
        </div>
        <div class="col-md-6">
            <label for="apellidos" class="form-label">Apellidos</label>
            <input type="text" class="form-control" id="apellidos" name="apellidos" value="<%= usuario_p.getApellidos() %>" required>
        </div>
        <div class="col-md-6">
            <label for="dni" class="form-label">DNI</label>
            <input type="text" class="form-control" id="dni" name="dni" value="<%= usuario_p.getDni() %>" required>
        </div>
        <div class="col-md-6">
            <label for="email" class="form-label">Correo Electrónico</label>
            <input type="email" class="form-control" id="email" name="email" value="<%= usuario_p.getEmail() %>" required>
        </div>
        <div class="col-md-6">
            <label for="direccion" class="form-label">Dirección</label>
            <input type="text" class="form-control" id="direccion" name="direccion" value="<%= usuario_p.getDireccion() %>">
        </div>
        <div class="col-md-4">
            <label for="ciudad" class="form-label">Ciudad</label>
            <input type="text" class="form-control" id="ciudad" name="ciudad" value="<%= usuario_p.getCiudad() %>">
        </div>
        <div class="col-md-4">
            <label for="provincia" class="form-label">Provincia</label>
            <input type="text" class="form-control" id="provincia" name="provincia" value="<%= usuario_p.getProvincia() %>">
        </div>
        <div class="col-md-4">
            <label for="cp" class="form-label">Código Postal</label>
            <input type="text" class="form-control" id="cp" name="cp" value="<%= usuario_p.getCp() %>">
        </div>

        <div class="col-md-4">
            <label for="telefono" class="form-label">Teléfono</label>
            <input type="text" class="form-control" id="telefono" name="telefono" value="<%= usuario_p.getTelefono() %>">
        </div>
        <div class="col-12 text-center">
            <button type="submit" class="btn btn-primary px-4">Guardar Cambios</button>
            <a href="perfil.jsp" class="btn btn-secondary px-4">Cancelar</a>
        </div>
    </form>
</div>
   <%
        String loginStatus = (String) session.getAttribute("loginStatus");
        String usuario = (String) session.getAttribute("usuario");
    %>
    <script>
        window.loginStatus = "<%= loginStatus %>";
        window.nombreUsuario = "<%= usuario %>";
    </script>
<mi-footer></mi-footer>

<script src="js/cabecera.js"></script>
<script src="js/footer.js"></script>
</body>
</html>
