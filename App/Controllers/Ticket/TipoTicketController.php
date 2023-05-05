<?php

// require_once __DIR__ . '/../Models/Inv_Medicamento/TipoAlmacenModel.php';
require_once __DIR__ . '/../../Models/Ticket/TipoTicketModel.php';

Class TipoTicketController {

    private $TipoTicket;

    public function __construct($conexion)
    {
        $this->TipoTicket = new TipoTicketModel($conexion);
    }

    public function Table (){
        $tipTicket =  $this->TipoTicket->getSelect('*');
        echo json_encode($tipTicket);
    }
}