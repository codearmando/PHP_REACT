<?php

// require_once __DIR__ . '/../Models/Inv_Medicamento/TipoAlmacenModel.php';
require_once __DIR__ . '/../../Models/Inv_Medicamento/EstatusModel.php';

Class EstatusController {

    private $estatus;

    public function __construct($conexion)
    {
        $this->estatus = new EsatusModel($conexion);
    }

    public function Table (){
        $estatusInv =  $this->estatus->getSelect('*');
        echo json_encode($estatusInv);
    }
}