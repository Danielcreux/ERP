<?php
require_once 'core/danielcreux.php';

class Factura
{
    private $db;

    public function __construct($config)
    {
        $this->db = danielcreux::getInstance($config);
    }

    public function all()
    {
        return $this->db->fetchAll("
            SELECT f.id, c.nombre as cliente, f.total, f.estado, f.fecha
            FROM facturas f
            JOIN clientes c ON f.cliente_id = c.id
            ORDER BY f.fecha DESC
        ");
    }

    public function resumenFinanciero()
    {
        return $this->db->fetch("
            SELECT 
                COUNT(*) as total_facturas,
                SUM(total) as total_facturado
            FROM facturas
        ");
    }
}
