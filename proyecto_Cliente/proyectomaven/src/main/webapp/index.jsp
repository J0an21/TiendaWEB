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
    <br><br><br><br>
    
    <div class="novedades" style="margin-left: 43%; ">
        <i style="display: inline-block; width: 20px; height: 20px; background-image: url('imagenes/nuevo.png'); background-size: contain; background-repeat: no-repeat; vertical-align: middle;"></i>
        Novedades
    </div>

    <div id="carouselExampleSlidesOnly" class="carousel slide carrusel-pequeno" data-bs-ride="carousel" data-bs-interval="3500">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="imagenes/pokemon_y.jpg" alt="Pokemon Y">
            </div>
            <div class="carousel-item">
                <img src="imagenes/ie3.jpg" alt="Inazuma Eleven 3">
            </div>
            <div class="carousel-item">
                <img src="imagenes/fifa15.jpg" alt="FIFA 15">
            </div>
        </div>
        <a class="carousel-control-prev" href="#carouselExampleSlidesOnly" role="button" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only"></span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleSlidesOnly" role="button" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only"></span>
        </a>
    </div>
    <%
        String loginStatus = (String) session.getAttribute("loginStatus");
        String usuario = (String) session.getAttribute("usuario");
    %>
    <script>
        window.loginStatus = "<%= loginStatus != null ? loginStatus : ";" %>";
        window.nombreUsuario = "<%= usuario != null ? usuario : ";" %>";
    </script>

    
    <mi-footer></mi-footer>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/cabecera.js" defer></script>
    <script src="js/footer.js"></script>
</body>
</html>


