<?php

require_once __DIR__ . '/../../Models/Ticket/ListTicketModel.php';

class TicketController
{

    private $ListTicketModel;

    public function __construct($conexion)
    {
        $this->ListTicketModel = new ListTicketModel($conexion);
    }

    public function Table()
    {
        $ListaTickets = $this->ListTicketModel->getSelect('CEDULA_CIUDADANO,NOMBRE_TICKET,NRO_TICKET,ESTATUS');
        echo json_encode($ListaTickets);
    }
    public function CrearTicket()
    {
        $Post_Data = file_get_contents('php://input');
        $body = json_decode($Post_Data, true);

        $out = 0;
        $array_data = [
            ':i_tipo_ticket' => $body['tipoticket'],
            ':i_cedula_ciudadano' => $body['cedula'],
        ];

        $AddTickets = $this->ListTicketModel->PdoProcedure('crear_ticket(:i_tipo_ticket,
        :i_cedula_ciudadano,
        :retorno)', $array_data, $out);

        echo json_encode($out);
    }
}
