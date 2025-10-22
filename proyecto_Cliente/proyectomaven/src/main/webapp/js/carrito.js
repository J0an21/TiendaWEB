class ProductoCarrito {
    constructor(codigo, descripcion, imagen, cantidad, precioUnitario, existencias) {
        this.codigo = codigo;
        this.descripcion = descripcion;
        this.imagen = imagen;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
        this.precio = precioUnitario * cantidad;
        this.existencias = existencias;
    }
}

var carrito = [];

function anyadirCarrito(index, vnombre, image, can, price, existencias) {
    cargarCarrito();
    let productoExistente = carrito.find(producto => producto.codigo === index);

    if (productoExistente) {
        if (productoExistente.cantidad + can <= existencias) {
            productoExistente.cantidad += can;
            productoExistente.precio = productoExistente.precioUnitario * productoExistente.cantidad;
        }
        else {
            Swal.fire({
                icon: 'error',
                title: '¡Error!',
                text: `No hay suficiente stock de "${vnombre}".`,
                timer: 3000,
                showConfirmButton: false
            });
            return;
        }
    } else {
        let producto = new ProductoCarrito(index, vnombre, image, can, price, existencias);
        carrito.push(producto);
    }
    MostrarMensaje(vnombre);
    guardarCarrito();
    mostrarCarrito();
    /*
        console.log("Contenido del carrito:");
        carrito.forEach((producto, index) => {
        console.log(`Producto ${index + 1}:`);
        console.log(`  Código: ${producto.codigo}`);
        console.log(`  Descripción: ${producto.descripcion}`);
        console.log(`  Imagen: ${producto.imagen}`);
        console.log(`  Cantidad: ${producto.cantidad}`);
        console.log(`  Precio: ${producto.precio}`);
        console.log(`  Existencias: ${producto.existencias}`);  
    });
    */
}

function actualizarBotonPagar() {
    const btn = document.getElementById("comprar");
    if (!btn) return;
    cargarCarrito();
    if (carrito.length > 0) {
        btn.disabled = false;
    } else {
        btn.disabled = true;
    }
}

function cargarCarrito() {
    const almacenado = localStorage.getItem("mi-carrito-almacenado");
    if (almacenado) {
        carrito = JSON.parse(almacenado);
    }
}

function guardarCarrito() {
	localStorage.setItem("mi-carrito-almacenado",JSON.stringify(carrito));
}

function eliminarProducto(codigo) {
    carrito.splice(codigo, 1);
    guardarCarrito();
    mostrarCarrito();
}

function mostrarCarrito() {
    cargarCarrito();
    const carritoContainer = document.querySelector(".col-md-8"); // Contenedor de los productos
    const resumenContainer = document.querySelector(".col-md-4 ul"); // Lista en el resumen
    const totalResumen = document.querySelector(".col-md-4 p b"); // Total en el resumen

    // Limpiar contenedores por si ya hay contenido
    carritoContainer.querySelectorAll(".border").forEach(el => el.remove());
    resumenContainer.innerHTML = "";

    let total = 0;

    carrito.forEach((producto, index) => {
        const divProducto = document.createElement("div");
        divProducto.className = "border rounded p-3 shadow-sm position-relative d-flex align-items-center justify-content-between mb-3";
        divProducto.style.backgroundColor = "#343a40";

        divProducto.innerHTML = `
           <i class="bi bi-trash3 text-white position-absolute top-0 end-0 m-2" style="cursor: pointer; font-size: 0.85rem;" onclick="eliminarProducto(${index})"></i>
            <img src="${producto.imagen}" class="img-fluid me-3" alt="${producto.descripcion}" style="width: 100px;">
            <div>
                <h6><b>${producto.descripcion}</b></h6>
                <p>${producto.precio / producto.cantidad} €</p>
            </div>
            <div class="d-flex align-items-center gap-2">
                <button class="btn btn-sm btn-light" onclick="cambiarCantidad(${index}, -1)">-</button>
                <span class="badge bg-light text-dark p-2 mb-0">Cantidad: ${producto.cantidad}</span>
                <button class="btn btn-sm btn-light" onclick="cambiarCantidad(${index}, 1)">+</button>
            </div>
        `;

        carritoContainer.appendChild(divProducto);

        resumenContainer.innerHTML += `<li>${producto.cantidad}x ${producto.descripcion} - ${producto.precio} €</li>`;

        total += producto.precio;
    });
    
    let totalFormateado = total.toFixed(2).replace('.', ',');
    totalResumen.innerText = `Total: ${totalFormateado} €`;

    guardarCarrito();
    actualizarBotonPagar();
}

function mostrarCarritoResumen() {
    cargarCarrito();
    const resumenContainer = document.getElementById("cart-summary"); // Cambiado a ID
    const totalResumen = document.getElementById("cart-total"); // Cambiado a ID
    resumenContainer.innerHTML = "";

    let total = 0;

    carrito.forEach((producto) => {
        resumenContainer.innerHTML += `<li>${producto.cantidad}x ${producto.descripcion} - ${producto.precio} €</li>`;
        total += producto.precio;
    });

    let totalFormateado = total.toFixed(2).replace('.', ',');
    totalResumen.innerText = totalFormateado;
}

function MostrarMensaje(nombre) {
    Swal.fire({
        icon: 'success',
        title: '¡Añadido al carrito!',
        text: `El producto "${nombre}" ha sido añadido al carrito.`,
        timer: 3000,
        showConfirmButton: false
    });
}

function cambiarCantidad(index, num) {
    cargarCarrito();
    const producto = carrito[index];
    if (!producto) return;

    const nuevaCantidad = producto.cantidad + num;

    if (nuevaCantidad <= 0) {
        eliminarProducto(index);
        mostrarCarrito();
        return;
    }

    if (nuevaCantidad > producto.existencias) {
        Swal.fire({
            icon: 'error',
            title: '¡Stock insuficiente!',
            text: `No hay suficientes unidades disponibles.`,
            timer: 2000,
            showConfirmButton: false
        });
        return;
    }

    producto.precio = producto.precio / producto.cantidad;
    producto.cantidad = nuevaCantidad;
    producto.precio = producto.precio * producto.cantidad;

    guardarCarrito();
    mostrarCarrito();
}

function tramitarPedido() {
    const direccion = document.getElementById('direccion').value.trim();
    const numeroTarjeta = document.getElementById('numeroTarjeta').value.trim();
    const fechaExp = document.getElementById('fechaExp').value.trim();
    const cvv = document.getElementById('cvv').value.trim();

    if (!direccion || !numeroTarjeta || !fechaExp || !cvv) {
        Swal.fire("Campos incompletos", "Por favor completa todos los campos.", "warning");
        return;
    }

    // Aquí puedes hacer validaciones adicionales si deseas...

    // Cerrar modal
    const modal = bootstrap.Modal.getInstance(document.getElementById('checkoutModal'));
    modal.hide();

    // Llamar a la función original de pago
    EnviarCarrito('ProcesarPedido', carrito);
}

document.addEventListener("DOMContentLoaded", function() {
    mostrarCarrito();
    actualizarBotonPagar();
});