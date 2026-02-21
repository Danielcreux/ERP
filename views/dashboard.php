<div class="card">
    <h2>Resumen General</h2>
    <p>Clientes: <?= $data['clientes'] ?></p>
    <p>Productos: <?= $data['productos'] ?></p>
    <p>Facturas: <?= $data['facturas'] ?></p>
    <p>Total facturado: $<?= number_format($data['facturado'], 2) ?></p>
</div>
