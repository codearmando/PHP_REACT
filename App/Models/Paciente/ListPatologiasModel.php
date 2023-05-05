<?php

class ListPatologiasModel extends Orm {
    public function __construct($connection)
    {
        parent::__construct('PATOLOGIAS_VIEW',$connection);
    }
}