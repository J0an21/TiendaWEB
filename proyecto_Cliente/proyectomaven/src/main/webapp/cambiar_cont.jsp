<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, tienda.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Cambiar Contraseña</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
    <mi-cabecera></mi-cabecera>
    <br><br><br>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Cambiar Contraseña</h2>

        <form action="CambiarContrasenaServlet" method="post" class="mx-auto" style="max-width: 400px;">
            <div class="mb-3">
                <label for="contrasenaActual" class="form-label">Contraseña Actual</label>
                <input type="password" class="form-control" id="contrasenaActual" name="contrasenaActual" required>
            </div>
            <div class="mb-3">
                <label for="nuevaContrasena" class="form-label">Nueva Contraseña</label>
                <input type="password" class="form-control" id="nuevaContrasena" name="nuevaContrasena" required>
            </div>
            <div class="mb-3">
                <label for="repetirContrasena" class="form-label">Repetir Nueva Contraseña</label>
                <input type="password" class="form-control" id="repetirContrasena" name="repetirContrasena" required>
            </div>
            <div class="d-grid">
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

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/cabecera.js"></script>
    <script src="js/footer.js"></script>
</body>
</html>