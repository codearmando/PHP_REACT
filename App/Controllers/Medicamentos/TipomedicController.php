<?php

// require_once __DIR__ . '/../Models/Inv_Medicamento/TipoMedicamentoModel.php';
require_once __DIR__ . '/../../Models/Medicamentos/TipoMedicamentoModel.php';

Class TipomedicController {
    private $tipMedicamento ;

    public function __construct($conexion)
    {
        $this->tipMedicamento = new TipoMedicamentoModel($conexion);
    }

    public function Table (){
        $tipoMedicamento = $this->tipMedicamento->getSelect('*');

        // echo '<span>';
        // var_dump($tipoMedicamento);
        // echo '</span>';

        echo json_encode($tipoMedicamento);
    }
}