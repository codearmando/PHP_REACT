<?php

// require_once __DIR__ . '/../Models/Inv_Medicamento/TipoAlmacenModel.php';
require_once __DIR__ . '/../../Models/Paciente/ListPatologiasModel.php';

Class ListPatologiasController {

    private $patologia;

    public function __construct($conexion)
    {
        $this->patologia = new ListPatologiasModel($conexion);
    }

    public function Table (){
        $dataPatologia =  $this->patologia->getSelect('*');
        echo json_encode($dataPatologia);
    }
}