<?php session_start();

if (isset($_SESSION['userid'])) {
// En nuestro ejemplo sabemos que siempre va a ser correcto,
// pero lo comprobamos para tener el código completo.
	$userid = $_SESSION['userid'];
?>
<!DOCTYPE html>
<html lang="es">
    <head>
        <title>Felicidades</title>
    </head>
    <body>
        <?php
            echo '<p>Felicidades, has accedido correctamente como el usuario:&nbsp;'.$userid.'</p>';
        ?>
    </body>
</html>
<?php
}
    else {
    // Si se ha llamado directamente a este PHP se envía al HTML de login.
        header('Location: ./login.html');
    }
?>