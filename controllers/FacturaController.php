<?php

require_once 'models/Factura.php';

class FacturaController
{
    private $db;
    private $facturaModel;

    public function __construct($db)
    {
        $this->db = $db;
        $config = require 'config/config.php';
        $this->facturaModel = new Factura($config);
    }

   public function index()
{
    $facturas = $this->facturaModel->all();
    $resumen  = $this->facturaModel->resumenFinanciero();

    $viewFile = 'views/facturas.php';
    require 'views/layout.php';
}

}
