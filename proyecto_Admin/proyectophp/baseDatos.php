<?php

function conectar() {
   $bbdd = mysqli_connect("localhost","root","DawLab","daw");
   if (mysqli_connect_error()) {
      printf("Error conectando a la base de datos: %s\n",mysqli_connect_error());
      exit();
   }
   return $bbdd;
}



function desconectar($bbdd) {
   mysqli_close($bbdd);
}

function obtenerProductos() {
   $bbdd = conectar();
   $consulta = "SELECT * FROM productos";
   $resultado = mysqli_query($bbdd,$consulta);
   desconectar($bbdd);
   return $resultado;
}

function obtenerPedidos(){
   $bbdd = conectar();
   $consulta = "SELECT * FROM pedidos";
   $resultado = mysqli_query($bbdd,$consulta);
   desconectar($bbdd);
   return $resultado;

}

function obtenerUsuarios() {
   $bbdd = conectar();
   $consulta = "SELECT * FROM usuarios";
   $resultado = mysqli_query($bbdd,$consulta);
   desconectar($bbdd);
   return $resultado;
}

function obtenerUsuarioCod ($codigo){
   $bbdd = conectar();
   $consulta = "SELECT * FROM usuarios WHERE codigo = '$codigo'";
   $resultado = mysqli_query($bbdd,$consulta);
   desconectar($bbdd);
   return $resultado;
}

function obtenerPedidosUsuario($codigo) {
   $bbdd = conectar();
   $consulta = "SELECT * FROM pedidos WHERE persona = '$codigo'";
   $resultado = mysqli_query($bbdd,$consulta);
   desconectar($bbdd);
   return $resultado;
}

function detallesPedido($codigo) {
   $bbdd = conectar();
   $consulta = "SELECT p.imagen, p.nombre, d.unidades, p.precio FROM productos p JOIN detalle d ON p.codigo = d.codigo_producto WHERE d.codigo_pedido = '$codigo'";
   $resultado = mysqli_query($bbdd,$consulta);
   desconectar($bbdd);
   return $resultado;
}

function obtenerproductoPedido($codigo) {
   $bbdd = conectar();
   $consulta = "SELECT * FROM pedidos ped JOIN detalle d ON ped.codigo = d.codigo_pedido  WHERE d.codigo_producto = '$codigo'";
   $resultado = mysqli_query($bbdd,$consulta);
   desconectar($bbdd);
   return $resultado;
}

function usuarioAdmin($usuario, $clave) {
   $bbdd = conectar();
   $consulta = "SELECT * FROM usuarios WHERE codigo = '$codigo' AND admin = 1";
   $resultado = mysqli_query($bbdd,$consulta);
   desconectar($bbdd);
   return $resultado;
}
?>