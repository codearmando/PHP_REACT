<?php

class ListMedicamentoModel extends Orm {
    public function __construct($connection)
    {
        parent::__construct('MEDICAMENTOS_VIEW',$connection);
    }
}