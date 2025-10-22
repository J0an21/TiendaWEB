function EnviarCarrito(url, valores) {
  // Convierte los campos numéricos a número
  const valoresNumericos = valores.map(item => ({
    ...item,
    id: Number(item.id),
    cantidad: Number(item.cantidad),
    precio: Number(item.precio)
  }));

  console.log("EnviarCarrito llamada", url, valoresNumericos);

  const options = {
    method: "POST",
    headers: {
      "Content-Type": "application/json; charset=utf-8"
    },
    body: JSON.stringify(valoresNumericos)
  };

  fetch(url, options)
    .then(response => response.text())
    .then(data => {
      document.body.innerHTML = data;
      // Limpia el carrito local
      localStorage.removeItem("mi-carrito-almacenado");
    })
    .catch(error => console.error(error));
}