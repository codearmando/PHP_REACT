<?php

class PresentacionModel extends Orm {
    public function __construct($connection)
    {
        parent::__construct('PRESENTACION_MEDICAMENTO_VIEW',$connection);
    }
}