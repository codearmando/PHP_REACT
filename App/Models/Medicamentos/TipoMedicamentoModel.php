<?php

class TipoMedicamentoModel extends Orm {
    public function __construct($connection)
    {
        parent::__construct('TIPO_MEDICAMENTOS_VIEW',$connection);
    }
}