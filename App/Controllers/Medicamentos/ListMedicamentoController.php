<?php

// require_once __DIR__ . '/../Models/Inv_Medicamento/ListMedicamentoModel.php';
require_once __DIR__ . '/../../Models/Medicamentos/ListMedicamentoModel.php';

Class ListMedicamentoController {

    private $medicamentos;

    public function __construct($conexion)
    {
        $this->medicamentos = new ListMedicamentoModel($conexion);
    }

    public function Table (){
        $listmedicamentos =  $this->medicamentos->getSelect('*');
        echo json_encode($listmedicamentos);
    }
}