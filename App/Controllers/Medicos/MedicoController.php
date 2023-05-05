<?php

// require_once __DIR__ . '/../Models/Inv_Medicamento/TipoAlmacenModel.php';
require_once __DIR__ . '/../../Models/Medicos/ListMedicosModel.php';

Class MedicoController {

    private $medico;

    public function __construct($conexion)
    {
        $this->medico = new ListMedicosModel($conexion);
    }

    public function Table (){
        $Post_Data = file_get_contents('php://input');
        $body = json_decode($Post_Data,true);

        $dataMedico =  $this->medico->getSelect('*');
        echo json_encode($dataMedico);
    }
    public function Insert()
    {

        $Post_Data = file_get_contents('php://input');
        $body = json_decode($Post_Data, true);

        $out = 0;

        $array_data = [
            ':i_cedula_ciudadano' => $body['data'],
            ':i_patologia' => $body['data'],
            ':i_medico' => $body['data'],
            ':i_peso' => $body['data'],
            ':i_altura' => $body['data'],
            ':i_superficie_corp' => $body['data'],
            ':i_correo' => $body['data'],
            ':i_telefono' => $body['data'],
            ':i_tlf_alterno' => $body['data'],
        ];

        $InsertMedico = $this->medico->PdoProcedure('insert_paciente(:i_cedula_ciudadano,
        :i_patologia,
        :i_medico,
        :i_peso,
        :i_altura,
        :i_superficie_corp,
        :i_correo,
        :i_telefono,
        :i_tlf_alterno,
        :retorno)', $array_data, $out);

        echo json_encode($out);
    }
}