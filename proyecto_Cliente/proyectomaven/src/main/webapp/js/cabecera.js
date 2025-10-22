class MiCabecera extends HTMLElement {
    constructor() {
        super();

        // Crear un link hacia el CSS externo
        const linkElement = document.createElement("link");
        linkElement.setAttribute("rel", "stylesheet");
        linkElement.setAttribute("href", "estilos.css");
        document.head.appendChild(linkElement);

        // Insertar el HTML del navbar
        this.innerHTML = `
            <nav class="navbar navbar-dark p-3">
                <a class="navbar-brand" href="index.jsp">Tienda de Juegos</a>
                <div class="me-auto d-flex">
                    <a class="nav-link text-white mx-2" href="tienda.jsp">Productos</a>
                    <a class="nav-link text-white mx-2" href="contacto.jsp">Contactanos</a>
                    <a class="nav-link text-white mx-2" href="info.jsp">Empresa</a>
                </div>
                <nav>
                    <button id="carritoBtn" class="btn p-0 m-0" style="background:none; border:none;">
                        <i class="bi bi-bag fs-2" style="color:white; margin-right: 20px;"></i>
                    </button>
                </nav>
                ${
                    window.loginStatus === "success"|| window.loginStatus === "true"
                        ? `
                        <div>
                            <form id="logoutForm" method="post" action="LogoutServlet" style="display:inline;">
                                <div class="dropdown" style="display:inline;">
                                <button class="btn btn-primary dropdown-toggle" type="button" id="usuarioDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                    ${window.nombreUsuario}
                                </button>
                                <ul class="dropdown-menu" aria-labelledby="usuarioDropdown">
                                    <li><a class="dropdown-item" href="perfil.jsp">Datos del perfil</a></li>
                                    <li>
                                        <form id="logoutForm" method="post" action="LogoutServlet">
                                            <input type="hidden" name="redirect" value="index.jsp">
                                            <button type="submit" class="dropdown-item" id="cerrarSesionBtn">Cerrar Sesión</button>
                                        </form>
                                    </li>
                                </ul>
                                </div>
                            </form>
                        </div>
                        `
                        : `
                        <button class="btn btn-primary" id="openModalBtn">Inicio Sesión</button>
                        <div id="modal" class="modal">
                            <div class="modal-content">
                                <form method="post" action="LoginServlet">
                                    <span class="close">&times;</span>
                                    <h2>Inicio de Sesión</h2>
                                    <div class="formulario-container">
                                        <div class="formulario-group mb-3">
                                            <label for="usuario" class="formulario2">Nombre de Usuario:</label>
                                            <input id="usuario" type="text" name="usuario" class="form-control">
                                        </div>
                                        <div class="formulario-group mb-3">
                                            <label for="clave" class="formulario2">Contraseña:</label>
                                            <input id="clave" type="password" name="clave" class="form-control">
                                        </div>
                                    </div>
                                    <a href="#password">He olvidado mi contraseña</a><br><br>
                                    <button class="btn btn-primary">Iniciar Sesión</button>
                                    <hr>
                                    <h3>¿No tienes cuenta aún?</h3>
                                    <a href="registro.jsp" class="btn btn-primary">Registrarse</a>
                                </form>
                            </div>
                        </div>
                        `
                }
            </nav>
        `;

        // Esperar a que el DOM del componente esté completamente insertado
        setTimeout(() => {
            // Botón del carrito
            const carritoBtn = document.getElementById("carritoBtn");
            if (carritoBtn) {
                carritoBtn.addEventListener("click", (e) => {
                    if (window.loginStatus === "success") {
                        window.location.href = "carrito.jsp";
                    } else {
                        e.preventDefault();
                        Swal.fire({
                            icon: 'warning',
                            title: 'Acceso restringido',
                            text: 'Debes iniciar sesión para acceder al carrito.',
                            confirmButtonText: 'Entendido'
                        });
                    }
                });
            }

            // Mensajes de inicio de sesión
            if (window.loginStatus === "success" && !sessionStorage.getItem("mensajeMostrado")) {
                Swal.fire({
                    icon: "success",
                    title: "¡Sesión iniciada!",
                    text: `Se ha iniciado sesión con el usuario: "${window.nombreUsuario}".`,
                    timer: 3000,
                    showConfirmButton: false
                });
                sessionStorage.setItem("mensajeMostrado", "true");
            } else if (window.loginStatus === "error") {
                Swal.fire({
                    icon: "error",
                    title: "¡Error!",
                    text: "Usuario y/o contraseña incorrectos.",
                    timer: 3000,
                    showConfirmButton: false
                });
            }

            // Restablecer mensaje al cerrar sesión
            const cerrarSesionBtn = document.getElementById("cerrarSesionBtn");
            if (cerrarSesionBtn) {
                cerrarSesionBtn.addEventListener("click", restablecerMensaje);
            }
        }, 0);
    }
}
customElements.define("mi-cabecera", MiCabecera);

function restablecerMensaje() {
    sessionStorage.setItem("mensajeMostrado", "false");
}

// Manejo de modal
document.addEventListener("DOMContentLoaded", () => {
    const modal = document.getElementById("modal");
    const openModalBtn = document.getElementById("openModalBtn");
    const closeModal = document.querySelector(".close");

    openModalBtn?.addEventListener("click", () => {
        modal.style.display = "block";
    });

    closeModal?.addEventListener("click", () => {
        modal.style.display = "none";
    });

    window.addEventListener("click", (e) => {
        if (e.target === modal) {
            modal.style.display = "none";
        }
    });
});
``

