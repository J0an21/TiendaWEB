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
    <div class="container" style="margin-top: 80px;">
        <div class="border rounded p-3 shadow-sm">
            <h2>Ubicación de la tienda local</h2>
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3080.2213327647505!2d-0.3953811168519258!3d39.46432825092897!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd604f6ae1740785%3A0xa14c2ea04c4ae05e!2sParque%20del%20Oeste!5e0!3m2!1ses!2ses!4v1740875471762!5m2!1ses!2ses" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>
        <br>
        <div class="border rounded p-3 shadow-sm">
            <h2>Información de Contacto</h2>
            <p><strong>Teléfono:</strong> +34 123 456 789</p>
            <p><strong>Correo Electrónico:</strong> contacto@tiendavideojuegos.com</p>
            <p><strong>Horario de Atención:</strong></p>
            <p>Lunes a Viernes: 9:00 - 20:00</p>
            <p>Sábado: 10:00 - 18:00</p>
            <p>Domingo: Cerrado</p>
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
    <mi-footer></mi-footer>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/cabecera.js"></script>
    <script src="js/footer.js"></script>
</body>
</html>
