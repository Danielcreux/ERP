<?php
require_once 'core/danielcreux.php';

class Producto
{
    private $db;

    public function __construct($config)
    {
        $this->db = danielcreux::getInstance($config);
    }

    public function all()
    {
        return $this->db->fetchAll("
            SELECT p.*, c.nombre as categoria
            FROM productos p
            LEFT JOIN categorias c ON p.categoria_id = c.id
            WHERE p.activo = 1
        ");
    }

    public function create($nombre, $precio, $stock)
    {
        return $this->db->execute(
            "INSERT INTO productos (nombre, precio, stock) VALUES (?, ?, ?)",
            [$nombre, $precio, $stock]
        );
    }
}
