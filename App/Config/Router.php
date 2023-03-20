<?php

class Routers {

    private $controller;
    private $method;

    public function __construct()
    {
        self::MatchRouter();
    }

    public function MatchRouter(){
        $url = explode('/',URL);

        $this->controller = !empty($url[1]) ? $url[1] : 'Page';
        $this->method = !empty($url[2]) ? $url[2] : 'Home';

        $this->controller = $this->controller . 'Controller';
        
        // require_once __DIR__ . '/Controllers/' . $this->controller . '.php';
        require_once __DIR__ . '/../Controllers/' . $this->controller . '.php';
        
    }

    public function Run(){
        // Conexion a BD
        $database = new Oci_DB();
        $conexion = $database->getRetornoConn();
        
        $controlador = new $this->controller($conexion);
        $metodo = $this->method;
        $controlador->$metodo();
    }
}