<?php

class DashboardController
{
    private $db;

    public function __construct($db)
    {
        $this->db = $db;
    }

 public function index()
{
    $data = [
        'clientes' => $this->db->fetch("SELECT COUNT(*) total FROM clientes")['total'] ?? 0,
        'productos' => $this->db->fetch("SELECT COUNT(*) total FROM productos")['total'] ?? 0,
        'facturas' => $this->db->fetch("SELECT COUNT(*) total FROM facturas")['total'] ?? 0,
        'facturado' => $this->db->fetch("SELECT SUM(total) total FROM facturas")['total'] ?? 0
    ];

    $viewFile = 'views/dashboard.php';
    require 'views/layout.php';
}


}
