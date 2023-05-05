<?php

// require_once __DIR__ . '/../Models/Inv_Medicamento/InventarioModel.php';
require_once __DIR__ . '/../../Models/Inv_Medicamento/InventarioModel.php';

class  InventarioController
{

    private $InvModel;

    public function __construct($conexion)
    {
        $this->InvModel =  new InventarioModel($conexion);
    }

    public function Table()
    {
        $invMedicamentos = $this->InvModel->getSelect('*');

        // echo '<span>';
        // var_dump($invMedicamentos);
        // echo '</span>';

        echo json_encode($invMedicamentos);
    }
    public function Insert()
    {

        $Post_Data = file_get_contents('php://input');
        $body = json_decode($Post_Data, true);

        $out = 0;

        $array_data = [
            ':i_pk_nombre_medicamento' => $body['pk_medicamento'],
            ':i_presentacion_medicamento' => $body['presentacion'],
            ':i_almacen' => $body['almacen'],
            ':i_unidad_medida' => $body['unidadmedida'],
            ':i_cantidad' => $body['cantidad'],
            ':i_lote' => $body['lote'],
            ':i_estatus' => $body['estatus'],
            ':i_fecha_vencimiento' => $body['fechavencimiento'],
            ':i_observacion' => $body['observacion']
        ];

        $InsertMedicamentos = $this->InvModel->PdoProcedure('insert_inv_medicamento(:i_pk_nombre_medicamento,
        :i_presentacion_medicamento,
        :i_almacen,
        :i_unidad_medida,
        :i_cantidad,
        :i_lote,
        :i_estatus,
        :i_fecha_vencimiento,
        :i_observacion,
        :retorno)', $array_data, $out);

        echo json_encode($out);
    }
    public function InsertCantidad()
    {

        $Post_Data = file_get_contents('php://input');
        $body = json_decode($Post_Data, true);

        $out = 0;


        $array_data = [
            ':i_pk_medicamento' => $body['medicamento'],
            ':i_cantidad' => $body['cantidad'],
            ':i_lote' => $body['lote']
        ];

        $InsertCantidad = $this->InvModel->PdoProcedure('insert_cantidad_medicamentos(:i_pk_medicamento,
        :i_cantidad,
        :i_lote,
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
            ':u_presentacion_medicamento' => $body['presentacion'],
            ':u_gramos_medicamento' => $body['gramos'],
            ':u_almacen' => $body['almacen'],
            ':u_estatus' => $body['estatus']
        ];

        $UpdateMedicamento = $this->InvModel->PdoProcedure('update_inv_medicamento(:u_pk_nombre_medicamento,
        :u_presentacion_medicamento,
        :u_gramos_medicamento,
        :u_almacen,
        :u_estatus,
        :retorno)', $array_data, $out);

        echo json_encode($out);
    }
    public function Delete()
    {
        $Post_Data = file_get_contents('php://input');
        $body = json_decode($Post_Data,true);

        $out = 0;

        $array_data = [
            ':d_inv_medicamento' => $body['medicamento'],
            ':u_gramos_medicamento' => $body['gramos'],
            ':u_presentacion_medicamento' => $body['presentacion']
        ];

        $DeleteMedicamento = $this->InvModel->PdoProcedure('delete_inv_medicamento(:d_inv_medicamento,
        :u_gramos_medicamento,
        :u_presentacion_medicamento,
        :retorno)', $array_data, $out);

        echo json_encode($out);
    }
}
