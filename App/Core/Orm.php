<?php


class Orm
{

    protected $table;
    protected $bd;

    public function __construct($table, $connection)
    {
        $this->table = $table;
        $this->bd = $connection;
    }

    public function getSelect($parameters = null, $condition = null, $valor = null)
    {
        if ($parameters != null && $condition != null && $valor != null) {
            $sql = "SELECT $parameters FROM {$this->table} WHERE $condition = :dato ";
            $stm = $this->bd->prepare($sql);
            $stm->bindValue(":dato", $valor);
            $stm->execute();
            return $stm->fetch();
        } else if ($parameters != null) {
            $sql = "SELECT $parameters FROM {$this->table}";
            $stm = $this->bd->prepare($sql);
            $stm->execute();
            return $stm->fetchAll();
        }
    }
    public function getSelectID($parameters = null, $condition = null, $valor = null)
    {
        if ($parameters != null && $condition != null && $valor != null) {
            $sql = "SELECT $parameters FROM {$this->table} WHERE $condition = :dato ";
            $stm = $this->bd->prepare($sql);
            $stm->bindValue(":dato", $valor);
            $stm->execute();
            return $stm->fetch();
        }
    }

    public function PdoProcedure($procedure_name, $parameters, &$output)
    {

        $sql = "BEGIN " . $procedure_name . "; END;";
        $stm = $this->bd->prepare($sql);

        foreach ($parameters as $key => $value) {
            // bindValue : para asociar el valor con su nombre
            $stm->bindValue($key, $value);
        }
        // binParam : permite que el valor de salida sea correcto y evitar un bucle(en este caso)
        $stm->bindParam(':retorno', $output, PDO::PARAM_INT | PDO::PARAM_INPUT_OUTPUT, 4000);

        try {

            $stm->execute();
            return $output;

        } catch (PDOException $e) {

            echo 'ERROR: ' .'NOMBRE PRECEDIMIENTO :  '. $procedure_name . '  '. $e->getMessage();
            return false;
        }

        // $stmt = $pdo->prepare("begin myproc(:p1, :p2); end;");
        // $stmt->bindParam(':p1', $p1, PDO::PARAM_INT);
        // $stmt->bindParam(':p2', $p2, PDO::PARAM_INT);
        // $stmt->execute();

    }

}
