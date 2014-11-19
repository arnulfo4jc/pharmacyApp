<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="main">
	<title>Inventario</title>
	<r:require modules="bootstrap-css, bootstrap-collapse"/>
</head>
<body>
	<h4>Medicinas</h4>
	<g:each in="${medicines}" var="medicine" status="index">
		<table class="table table-hover">
			<caption>${medicine}, ${medicine.location}</caption>
			<colgroup>
				<col span="1" style="width: 15%;">
				<col span="1" style="width: 70%;">
				<col span="1" style="width: 15%;">
			</colgroup>
			<g:if test="${index == 0}">
				<thead>
					<th>Presentacion</th>
					<th>Medida</th>
					<th>Cantidad</th>
				</thead>
			</g:if>
			<tbody>
				<g:each in="${ni.sb.MedicineOrder.findAllByProduct(medicine)}" var="m">
					<tr>
						<td>${m.presentation}</td>
						<td>${m.measure}</td>
						<td>${m.quantity}</td>
					</tr>
				</g:each>
			</tbody>
		</table>
	</g:each>

	<h4>Productos</h4>
	<table class="table table-hover">
		<colgroup>
			<col span="1" style="width: 15%;">
			<col span="1" style="width: 70%;">
			<col span="1" style="width: 15%;">
		</colgroup>
		<thead>
			<th>Producto</th>
			<th>Cantidad</th>
			<th>Ubicacion</th>
		</thead>
		<tbody>
			<g:each in="${items}" var="item">
				<tr>
					<g:if test="${!(item.product.instanceOf(ni.sb.Medicine)) && !(item.product.instanceOf(ni.sb.BrandProduct))}">
						<td>${item.product}</td>
						<td>${item.quantity}</td>
						<td>${item.product.location}</td>
					</g:if>
				</tr>
			</g:each>
		</tbody>
	</table>

	<h4>Pruductos de marca</h4>
	<g:each in="${brandProducts}" var="brandProduct" status="index">
		<table class="table table-hover">
			<caption>${brandProduct}, ${brandProduct.location}</caption>
			<colgroup>
				<col span="1" style="width: 15%;">
				<col span="1" style="width: 70%;">
				<col span="1" style="width: 15%;">
			</colgroup>
			<g:if test="${index == 0}">
				<thead>
					<th>Marca</th>
					<th>Detalle</th>
					<th>Cantidad</th>
				</thead>
			</g:if>
			<tbody>
				<g:each in="${ni.sb.BrandProductOrder.findAllByProduct(brandProduct)}" var="b">
					<tr>
						<td>${b.brand}</td>
						<td>${b.detail}</td>
						<td>${b.quantity}</td>
					</tr>
				</g:each>
			</tbody>
		</table>
	</g:each>
</body>
</html>
