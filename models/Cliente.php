<?php

require_once 'core/danielcreux.php';

class Cliente
{
    private $db;

    public function __construct($config)
    {
        $this->db = danielcreux::getInstance($config);
    }

    public function all()
    {
        return $this->db->fetchAll("SELECT * FROM clientes WHERE estado='activo'");
    }

    public function create($nombre, $email)
    {
        return $this->db->execute(
            "INSERT INTO clientes (nombre, email) VALUES (?, ?)",
            [$nombre, $email]
        );
    }
}
