<?php

require_once __DIR__ . '/../Models/DeportesModel.php';

Class PageController {

    private $DeporteModel;

    public function __construct($conexion)
    {
        $this->DeporteModel = new Deporte($conexion);
    }
                    
    public function home(){
        $deportes = $this->DeporteModel->getSelect('*');
        // echo '<pre>';
        // var_dump($deportes);
        // echo '</pre>';
        echo json_encode($deportes);
        
    }

    
}