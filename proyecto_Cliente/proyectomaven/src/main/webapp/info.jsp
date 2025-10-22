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

    <div class="container" style="padding-top: 100px">
        <div class="border rounded p-3 shadow-sm">
            <h2>Historia de la Empresa</h2><hr>
            <p>Nuestra tienda de videojuegos nació en 2010 con la misión de ofrecer los mejores títulos a los gamers más exigentes. Desde entonces, hemos crecido hasta convertirnos en un referente del sector.</p>
        </div>
        <br>
        <div class="border rounded p-3 shadow-sm">
            <h2>Actividad</h2><hr>
            <p>Nos especializamos en la venta de videojuegos, consolas y accesorios, ofreciendo tanto títulos físicos como digitales. Además, organizamos eventos y torneos para la comunidad gamer.</p>
        </div>
        <br>
        <div class="border rounded p-3 shadow-sm">
            <h2>Controles de Calidad</h2><hr>
            <p>Garantizamos la autenticidad y calidad de todos nuestros productos. Cada juego y accesorio es verificado antes de su venta para asegurar la mejor experiencia.</p>
        </div>
        <br>
        <div class="border rounded p-3 shadow-sm">
            <h2>Organización</h2><hr>
            <p>Nuestro equipo está formado por expertos en videojuegos, apasionados por brindar el mejor servicio y asesoramiento a nuestros clientes.</p>
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
    
    <br><br><br>
    <mi-footer></mi-footer>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/cabecera.js"></script>
    <script src="js/footer.js"></script>
</body>
</html>