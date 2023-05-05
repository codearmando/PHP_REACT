<?php

class PacienteModel extends Orm {
    public function __construct($connection)
    {
        parent::__construct('PACIENTES_PATOLOGIAS_VIEW',$connection);
    }
}