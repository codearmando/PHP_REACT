<?php

class ListMedicosModel extends Orm {
    public function __construct($connection)
    {
        parent::__construct('MEDICOS_VIEW',$connection);
    }
}