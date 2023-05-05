<?php

class InventarioModel extends Orm
{
    public function __construct($connection)
    {
        parent::__construct('INVENTARIO_MEDICAMENTOS_VIEW', $connection);
    }
}
