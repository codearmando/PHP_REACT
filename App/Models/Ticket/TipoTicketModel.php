<?php

Class TipoTicketModel extends Orm {
    public function __construct($connection)
    {
        parent::__construct('TIPO_TICKET_VIEW',$connection);
    }
}