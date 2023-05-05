<?php

// require_once __DIR__ . '/../Models/Inv_Medicamento/ListMedicamentoModel.php';
require_once __DIR__ . '/../../Models/Medicamentos/ListUnidadMedidaModel.php';

Class ListUnidadMedidaController {

    private $medicamentos;

    public function __construct($conexion)
    {
        $this->medicamentos = new ListUnidadMedidaModel($conexion);
    }

    public function Table (){
        $listmedicamentos =  $this->medicamentos->getSelect('NOMBRE_MEDICAMENTO,UNIDAD_MEDIDA,PRESENT_MEDICAMENTO,FK_MEDICAMENTO');
        echo json_encode($listmedicamentos);
    }
}