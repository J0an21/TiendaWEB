<?php
    require_once('baseDatos.php');

    if (isset($_POST['codigo'], $_POST['precio'], $_POST['existencias'])) {
        $codigo = $_POST['codigo'];
        $precio = $_POST['precio'];
        $existencias = $_POST['existencias'];

        $conn = conectar();
        $stmt = $conn->prepare("UPDATE productos SET precio=?, existencias=? WHERE codigo=?");
        $stmt->bind_param("dii", $precio, $existencias, $codigo);
        $stmt->execute();
        $stmt->close();
        $conn->close();
    }

    header("Location: productos.php");
    exit;
?>