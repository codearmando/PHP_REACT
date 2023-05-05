<?php

class Oci_DB {

    private $Connection;

    public function __construct()
    {
        self::Connection();
    }

    public function Connection(){

        DEFINE('DB','PRUEBA');
        DEFINE('USER','FARMACIA_ALTO_COSTO');
        DEFINE('PASS','1234567');

        $db = DB;
        $user =USER;
        $pass =PASS;
        // $charset_utf8 = 'charset=utf8';
        $charset_Al = 'charset=AL32UTF8';
        $option =[
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
        ];

        try {
            $this->Connection = new PDO("oci:dbname=$db;$charset_Al",$user,$pass,$option);
            
            if(!$this->Connection){
                throw new Exception("Error no hay conexion a BD");

            }
            // else{
            //     echo 'Conectado a BD';
            // }
        } catch (\Exception $e) {
            echo 'ERROR : ' . $e->getMessage(), "\n";
            //throw $th;
        }


    }
    public function getRetornoConn(){
        return $this->Connection;
    }
    public function getCloseConn(){
        $this->Connection = null;
    }
}