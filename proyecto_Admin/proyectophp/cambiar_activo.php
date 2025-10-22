<?php
    require_once('baseDatos.php');

    if (isset($_GET['codigo'])) {
        $codigo = $_GET['codigo'];
    } elseif (isset($_POST['codigo'])) {
        $codigo = $_POST['codigo'];
    } else {
        die("Código de usuario no especificado.");
    }

    $bbdd = conectar();

    // Obtener el estado actual
    $consulta = "SELECT activo FROM usuarios WHERE codigo = ?";
    $stmt = mysqli_prepare($bbdd, $consulta);
    mysqli_stmt_bind_param($stmt, "s", $codigo);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_bind_result($stmt, $activo_actual);
    mysqli_stmt_fetch($stmt);
    mysqli_stmt_close($stmt);

    // Cambiar el estado
    $nuevo_estado = ($activo_actual == 1) ? 0 : 1;
    $update = "UPDATE usuarios SET activo = ? WHERE codigo = ?";
    $stmt2 = mysqli_prepare($bbdd, $update);
    mysqli_stmt_bind_param($stmt2, "is", $nuevo_estado, $codigo);
    mysqli_stmt_execute($stmt2);
    mysqli_stmt_close($stmt2);

    desconectar($bbdd);

    // Redirigir de vuelta a la página de usuarios
    header("Location: usuarios.php");
    exit();
?>