<?php

class Cors {

    // private $dominioPermitido;

    public function __construct()
    {
        self::RunCors();
    }

    public function RunCors(){

        // indicarle a php qu evamos a proporcionar informacion y recibir mediantes los siguientes encabezados:

        $dominioPermitido = "http://localhost:5173/";
        header("Access-Control-Allow-Origin: *");
        header("Access-Control-Allow-Headers: content-type");
        header("Access-Control-Allow-Methods: OPTIONS,GET,PUT,POST,DELETE");//recibir informacion mediante estos metodos

    }
}