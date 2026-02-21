<div class="card">
    <h2>Clientes Activos</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Email</th>
        </tr>

        <?php foreach ($clientes as $c): ?>
        <tr>
            <td><?= $c['id'] ?></td>
            <td><?= $c['nombre'] ?></td>
            <td><?= $c['email'] ?></td>
        </tr>
        <?php endforeach; ?>
    </table>
</div>
