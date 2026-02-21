<?php

class Router
{
    private array $routes = [];
    private string $basePath;

    public function __construct()
    {
        $this->basePath = '/ERP-empresa';
    }

    public function get(string $path, callable $callback)
    {
        $this->routes['GET'][$this->normalize($path)] = $callback;
    }
    
     public function post(string $path, callable $callback)
    {
        $this->routes['POST'][$this->normalize($path)] = $callback;
    }

    public function dispatch(string $uri)
    {
        $method = $_SERVER['REQUEST_METHOD'];

        $path = parse_url($uri, PHP_URL_PATH);

        // Eliminar basePath
        if (strpos($path, $this->basePath) === 0) {
            $path = substr($path, strlen($this->basePath));
        }

        $path = $this->normalize($path);

        if (isset($this->routes[$method][$path])) {
            $this->routes[$method][$path]();
        } else {
            http_response_code(404);
            echo "<h1 style='color:white;background:#0f172a;padding:40px'>404 - Ruta no encontrada</h1>";
        }
    }

    private function normalize(string $path): string
    {
        $path = rtrim($path, '/');

        if ($path === '') {
            $path = '/';
        }

        return $path;
    }
}
