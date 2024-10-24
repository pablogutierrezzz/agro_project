<?php
require_once('./main.php');

if($_SERVER['REQUEST_METHOD'] == 'POST'){
    // Obtener los datos del POST

    //Suelo
    $suelo_temperatura = isset($_POST['suelo_temperatura']) ? $_POST['suelo_temperatura'] : '';
    $suelo_humedad = isset($_POST['suelo_humedad']) ? $_POST['suelo_humedad'] : '';
    $suelo_ph = isset($_POST['suelo_ph']) ? $_POST['suelo_ph'] : '';

    echo $suelo_ph;
    
    //Clima
    $clima_estado = isset($_POST['clima_estado']) ? $_POST['clima_estado'] : '';
    $clima_probPrecipitaciones = isset($_POST['clima_probPrecipitaciones']) ? $_POST['clima_probPrecipitaciones'] : '';
    
    //Ambiente
    $ambiente_temperatura = isset($_POST['ambiente_temperatura']) ? $_POST['ambiente_temperatura'] : '';
    $ambiente_luzSolar = isset($_POST['ambiente_luzSolar']) ? $_POST['ambiente_luzSolar'] : '';
    $ambiente_humedad = isset($_POST['ambiente_humedad']) ? $_POST['ambiente_humedad'] : '';

    $con = Conectar();

    $stmt_suelo = $con->prepare("INSERT INTO `suelo`(`suelo_ph`, `suelo_humedad`, `suelo_temperatura`, `suelo_fechayhora`) VALUES (?, ?, ?, current_timestamp())");
    $stmt_suelo->execute([$suelo_ph, $suelo_humedad, $suelo_temperatura]);

    $stmt_clima = $con->prepare("INSERT INTO `clima`(`clima_estado`, `clima_ProbPrecipitaciones`) VALUES (?, ?)");
    $stmt_clima->execute([$clima_estado, $clima_probPrecipitaciones]);

    $stmt_ambiente = $con->prepare("INSERT INTO `ambiente`(`ambiente_temperatura`, `ambiente_luzSolar`, `ambiente_humedad`, `ambiente_fechayhora`) VALUES (?, ?, ?, current_timestamp())");
    $stmt_ambiente->execute([$ambiente_temperatura, $ambiente_luzSolar, $ambiente_humedad]);
}
?>