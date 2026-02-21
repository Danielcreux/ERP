<div class="card">
    <h2>Nuevo Producto</h2>

    <form method="POST">
        <input type="text" name="nombre" placeholder="Nombre" required>
        <input type="number" step="0.01" name="precio" placeholder="Precio" required>
        <input type="number" name="stock" placeholder="Stock" required>
        <button type="submit">Guardar</button>
    </form>
</div>

<div class="card">
    <h2>Lista Productos</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Precio</th>
            <th>Stock</th>
        </tr>

        <?php foreach ($productos as $p): ?>
        <tr>
            <td><?= $p['id'] ?></td>
            <td><?= $p['nombre'] ?></td>
            <td>$<?= $p['precio'] ?></td>
            <td><?= $p['stock'] ?></td>
        </tr>
        <?php endforeach; ?>
    </table>
</div>
