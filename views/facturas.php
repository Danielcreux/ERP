<div class="card">
    <h2>Listado de Facturas</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Cliente</th>
            <th>Total</th>
            <th>Estado</th>
            <th>Fecha</th>
        </tr>

        <?php foreach ($facturas as $f): ?>
        <tr>
            <td><?= $f['id'] ?></td>
            <td><?= $f['cliente'] ?></td>
            <td>$<?= $f['total'] ?></td>
            <td><?= $f['estado'] ?></td>
            <td><?= $f['fecha'] ?></td>
        </tr>
        <?php endforeach; ?>
    </table>
</div>
