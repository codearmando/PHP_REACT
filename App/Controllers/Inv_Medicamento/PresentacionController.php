<?php

// require_once __DIR__ . '/../Models/Inv_Medicamento/TipoAlmacenModel.php';
require_once __DIR__ . '/../../Models/Inv_Medicamento/PresentacionModel.php';

Class PresentacionController {

    private $tipoalmacen;

    public function __construct($conexion)
    {
        $this->tipoalmacen = new PresentacionModel($conexion);
    }

    public function Table (){
        $tipAlmacen =  $this->tipoalmacen->getSelect('*');
        echo json_encode($tipAlmacen);
    }
}