<?php

// require_once __DIR__ . '/../Models/Inv_Medicamento/InventarioModel.php';
require_once __DIR__ . '/../../Models/Medicamentos/ListMedicamentoModel.php';

class  MedicamentoController
{

    private $MedicamentoModel;

    public function __construct($conexion)
    {
        $this->MedicamentoModel =  new ListMedicamentoModel($conexion);
    }

    public function Table()
    {
        $Medicamentos = $this->MedicamentoModel->getSelect('*');

        // echo '<span>';
        // var_dump($Medicamentos);
        // echo '</span>';

        echo json_encode($Medicamentos);
    }
    public function Insert()
    {

        $Post_Data = file_get_contents('php://input');
        $body = json_decode($Post_Data, true);

        $out = 0;

        $array_data = [
            ':i_nombre_medicamento' => $body['medicamento'],
            ':i_tipo_medicamento' => $body['tipomedicamento'],
            ':i_componente_princ' => $body['componentprinc'],
        ];

        $InsertMedicamentos = $this->MedicamentoModel->PdoProcedure('insert_medicamento(:i_nombre_medicamento,
        :i_tipo_medicamento,
        :i_componente_princ,
        :retorno)', $array_data, $out);

        echo json_encode($out);
    }
    public function Update()
    {

        $Post_Data = file_get_contents('php://input');
        $body = json_decode($Post_Data, true);

        $out = 0;

        $array_data = [
            ':u_pk_nombre_medicamento' => $body['medicamentoactual'],
            ':u_nombre_medicamento' => $body['medicamento'],
            ':u_tipo_medicamento' => $body['tipomedicamento'],
            ':u_componente_princ' => $body['componenteprinc']
        ];

        $UpdateMedicamento = $this->MedicamentoModel->PdoProcedure('update_medicamento(:u_pk_nombre_medicamento,
        :u_nombre_medicamento,
        :u_tipo_medicamento,
        :u_componente_princ,
        :retorno)', $array_data, $out);

        echo json_encode($out);
    }
    public function Delete()
    {
        $Post_Data = file_get_contents('php://input');
        $body = json_decode($Post_Data,true);

        $out = 0;

        $array_data = [
            ':d_medicamento' => $body['medicamento']
        ];

        $DeleteMedicamento = $this->MedicamentoModel->PdoProcedure('delete_medicamento(:d_medicamento,
        :retorno)', $array_data, $out);

        echo json_encode($out);
    }
}
