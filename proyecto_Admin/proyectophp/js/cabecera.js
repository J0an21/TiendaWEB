class Cabecera extends HTMLElement {
  connectedCallback() {
    this.innerHTML = `
      <header class="bg-dark text-dark text-center py-3">
        <h1>Administración de la Tienda de Juegos</h1>
      </header>
      <nav class="navbar navbar-dark p-3">
        <div class="me-auto d-flex">
          <a class="nav-link text-white mx-2" href="usuarios.php">Usuarios</a>
          <a class="nav-link text-white mx-2" href="productos.php">Productos</a>
          <a class="nav-link text-white mx-2" href="pedidos.php">Pedidos</a>
          <a class="nav-link text-white mx-2" href="admin_ini.html">Cerrar Sesión</a>
        </div>
      </nav>
    `;
  }
}

customElements.define('mi-cabecera', Cabecera);

