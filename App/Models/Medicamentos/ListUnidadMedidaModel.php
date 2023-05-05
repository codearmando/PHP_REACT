<?php

class ListUnidadMedidaModel extends Orm {
    public function __construct($connection)
    {
        parent::__construct('MEDICAMENTO_UNIDAD_MEDIDA_VIEW',$connection);
    }
}