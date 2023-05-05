<?php

class TipoAlmacenModel extends Orm {
    public function __construct($connection)
    {
        parent::__construct('ALMACEN_DISPONIBLES_VIEW',$connection);
    }
}