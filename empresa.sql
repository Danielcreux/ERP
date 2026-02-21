-- ==========================
-- CREAR BASE DE DATOS
-- ==========================

DROP DATABASE IF EXISTS empresa;
CREATE DATABASE empresa
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE empresa;

-- ==========================
-- TABLA USUARIOS
-- ==========================

CREATE TABLE usuarios (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    rol ENUM('admin','empleado') DEFAULT 'empleado',
    activo BOOLEAN DEFAULT TRUE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ==========================
-- TABLA CLIENTES
-- ==========================

CREATE TABLE clientes (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    telefono VARCHAR(30),
    direccion TEXT,
    estado ENUM('activo','inactivo') DEFAULT 'activo',
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ==========================
-- TABLA PROVEEDORES
-- ==========================

CREATE TABLE proveedores (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    contacto VARCHAR(150),
    telefono VARCHAR(30),
    email VARCHAR(150),
    direccion TEXT,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ==========================
-- TABLA CATEGORIAS
-- ==========================

CREATE TABLE categorias (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ==========================
-- TABLA PRODUCTOS
-- ==========================

CREATE TABLE productos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    categoria_id INT UNSIGNED,
    proveedor_id INT UNSIGNED,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    activo BOOLEAN DEFAULT TRUE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
        
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
        
    INDEX idx_nombre (nombre),
    INDEX idx_precio (precio)
) ENGINE=InnoDB;

-- ==========================
-- TABLA FACTURAS
-- ==========================

CREATE TABLE facturas (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT UNSIGNED NOT NULL,
    usuario_id INT UNSIGNED NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(12,2) DEFAULT 0,
    estado ENUM('pendiente','pagada','cancelada') DEFAULT 'pendiente',
    
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
        
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
        
    INDEX idx_fecha (fecha)
) ENGINE=InnoDB;

-- ==========================
-- TABLA DETALLE FACTURAS
-- ==========================

CREATE TABLE detalle_facturas (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    factura_id INT UNSIGNED NOT NULL,
    producto_id INT UNSIGNED NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    
    FOREIGN KEY (factura_id) REFERENCES facturas(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
        
    FOREIGN KEY (producto_id) REFERENCES productos(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
        
    INDEX idx_factura (factura_id)
) ENGINE=InnoDB;

-- ==========================
-- TABLA PAGOS
-- ==========================

CREATE TABLE pagos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    factura_id INT UNSIGNED NOT NULL,
    monto DECIMAL(12,2) NOT NULL,
    metodo ENUM('efectivo','tarjeta','transferencia') NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (factura_id) REFERENCES facturas(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
        
    INDEX idx_metodo (metodo)
) ENGINE=InnoDB;

-- ==========================
-- USUARIOS
-- ==========================

INSERT INTO usuarios (nombre, email, password, rol) VALUES
('Administrador General', 'admin@empresa.com', '$2y$10$hashsimulado', 'admin'),
('Laura Martínez', 'laura@empresa.com', '$2y$10$hashsimulado', 'empleado'),
('Carlos Gómez', 'carlos@empresa.com', '$2y$10$hashsimulado', 'empleado');

-- ==========================
-- CLIENTES
-- ==========================

INSERT INTO clientes (nombre, email, telefono, direccion) VALUES
('Juan Pérez', 'juan@email.com', '555-1001', 'Calle Principal 123'),
('María López', 'maria@email.com', '555-1002', 'Avenida Central 456'),
('Empresa ABC S.A.', 'contacto@abc.com', '555-1003', 'Zona Industrial 789');

-- ==========================
-- PROVEEDORES
-- ==========================

INSERT INTO proveedores (nombre, contacto, telefono, email, direccion) VALUES
('Distribuidora Tech', 'Pedro Ruiz', '555-2001', 'ventas@tech.com', 'Parque Tecnológico'),
('Suministros Globales', 'Ana Torres', '555-2002', 'info@global.com', 'Centro Empresarial');

-- ==========================
-- CATEGORIAS
-- ==========================

INSERT INTO categorias (nombre, descripcion) VALUES
('Electrónica', 'Productos electrónicos y tecnológicos'),
('Oficina', 'Artículos de oficina'),
('Servicios', 'Servicios empresariales');

-- ==========================
-- PRODUCTOS
-- ==========================

INSERT INTO productos (categoria_id, proveedor_id, nombre, descripcion, precio, stock) VALUES
(1, 1, 'Laptop Empresarial', 'Laptop 16GB RAM SSD 512GB', 1200.00, 15),
(1, 1, 'Monitor 24 pulgadas', 'Monitor Full HD', 250.00, 30),
(2, 2, 'Silla ergonómica', 'Silla de oficina ajustable', 180.00, 20),
(2, 2, 'Escritorio ejecutivo', 'Escritorio de madera premium', 450.00, 10),
(3, NULL, 'Servicio de instalación', 'Instalación de equipos tecnológicos', 150.00, 9999);

-- ==========================
-- FACTURAS
-- ==========================

INSERT INTO facturas (cliente_id, usuario_id, total, estado) VALUES
(1, 2, 1450.00, 'pagada'),
(2, 3, 180.00, 'pendiente'),
(3, 2, 1650.00, 'pendiente');

-- ==========================
-- DETALLE FACTURAS
-- ==========================

-- Factura 1 (Laptop + Monitor)
INSERT INTO detalle_facturas (factura_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(1, 1, 1, 1200.00, 1200.00),
(1, 2, 1, 250.00, 250.00);

-- Factura 2 (Silla)
INSERT INTO detalle_facturas (factura_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(2, 3, 1, 180.00, 180.00);

-- Factura 3 (Escritorio + Servicio)
INSERT INTO detalle_facturas (factura_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(3, 4, 1, 450.00, 450.00),
(3, 5, 8, 150.00, 1200.00);

-- ==========================
-- PAGOS
-- ==========================

-- Pago completo factura 1
INSERT INTO pagos (factura_id, monto, metodo) VALUES
(1, 1450.00, 'transferencia');

-- Pago parcial factura 3
INSERT INTO pagos (factura_id, monto, metodo) VALUES
(3, 500.00, 'tarjeta');
