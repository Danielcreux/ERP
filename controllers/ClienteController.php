<?php

require_once 'models/Cliente.php';

class ClienteController
{
    private $clienteModel;

    public function __construct($db)
    {
        $config = require 'config/config.php';
        $this->clienteModel = new Cliente($config);
    }

   public function index()
    {
        $clientes = $this->clienteModel->all();

        $viewFile = 'views/clientes.php';
        require 'views/layout.php';
    }

}
