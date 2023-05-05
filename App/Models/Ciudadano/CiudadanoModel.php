<?php

class CiudadanoModel extends Orm {
    public function __construct($connection)
    {
        parent::__construct('CIUDADANOS_VIEW',$connection);
    }
}