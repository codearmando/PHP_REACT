<?php

class EsatusModel extends Orm {
    public function __construct($connection)
    {
        parent::__construct('ESTATUS_INV_MEDICAMENTO',$connection);
    }
}