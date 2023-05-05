<?php

Class ListTicketModel extends Orm {
    public function __construct($connection)
    {
        parent::__construct('LISTA_TICKET_VIEW',$connection);
    }
}