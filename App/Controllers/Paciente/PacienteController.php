<?php

// require_once __DIR__ . '/../Models/Inv_Medicamento/TipoAlmacenModel.php';
require_once __DIR__ . '/../../Models/Paciente/PacienteModel.php';

Class PacienteController {

    private $paciente;

    public function __construct($conexion)
    {
        $this->paciente = new PacienteModel($conexion);
    }

    public function Table (){
        $Post_Data = file_get_contents('php://input');
        $body = json_decode($Post_Data,true);

        $dataPaciente =  $this->paciente->getSelectID('*','CEDULA',$body['cedulanac']);
        echo json_encode($dataPaciente);
    }
    public function Insert()
    {

        $Post_Data = file_get_contents('php://input');
        $body = json_decode($Post_Data, true);

        $out = 0;

        $array_data = [
            ':i_pk_cedula_ciudadano' => $body['pk_ciudadano'],
            ':i_cedula_ciudadano' => $body['cedula'],
            ':i_cedula_pariente' => $body['pk_ciud_pariente'],
            ':i_patologia' => $body['patologia'],
            ':i_medico' => $body['medico'],
            ':i_peso' => $body['peso'],
            ':i_altura' => $body['altura'],
            ':i_superficie_corp' => $body['supcorporal'],
            ':i_correo' => $body['correo'],
            ':i_telefono' => $body['tlf'],
            ':i_tlf_alterno' => $body['tlfalterno'],
        ];

        $InsertPaciente = $this->paciente->PdoProcedure('insert_paciente(:i_pk_cedula_ciudadano,
        :i_cedula_ciudadano,
        :i_cedula_pariente,
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
    public function InsertPaciRetirado()
    {

        $Post_Data = file_get_contents('php://input');
        $body = json_decode($Post_Data, true);

        $out = 0;

        $array_data = [
            ':i_ciudadano' => $body['ci'],
            ':i_nro_cedula' => $body['cedula'],
        ];

        $InsertPaciente = $this->paciente->PdoProcedure('insert_paciente_retirado(:i_ciudadano,
        :i_nro_cedula,
        :retorno)', $array_data, $out);

        echo json_encode($out);
    }
}