<?php

require_once 'models/Producto.php';

class ProductoController
{
    private $db;
    private $productoModel;

    public function __construct($db)
    {
        $this->db = $db;
        $config = require 'config/config.php';
        $this->productoModel = new Producto($config);
    }

public function index()
{
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $nombre = trim($_POST['nombre'] ?? '');
        $precio = floatval($_POST['precio'] ?? 0);
        $stock  = intval($_POST['stock'] ?? 0);

        if ($nombre !== '' && $precio > 0) {
            $this->productoModel->create($nombre, $precio, $stock);
            header("Location: /ERP-empresa/productos");
            exit;
        }
    }

    $productos = $this->productoModel->all();

    $viewFile = 'views/productos.php';
    require 'views/layout.php';
    
}


}


