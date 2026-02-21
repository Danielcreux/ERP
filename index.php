<?php

$config = require 'config/config.php';

require_once 'core/danielcreux.php';
require_once 'core/Router.php';

require_once 'controllers/DashboardController.php';
require_once 'controllers/ClienteController.php';
require_once 'controllers/ProductoController.php';
require_once 'controllers/FacturaController.php';

$db = danielcreux::getInstance($config);

$router = new Router();

$router->get('/', fn() => (new DashboardController($db))->index());
$router->get('/clientes', fn() => (new ClienteController($db))->index());
$router->get('/productos', fn() => (new ProductoController($db))->index());
$router->get('/facturas', fn() => (new FacturaController($db))->index());
$router->post('/productos', fn() => (new ProductoController($db))->index());

$router->dispatch($_SERVER['REQUEST_URI']);
