<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="main">
	<title>Inventario</title>
	<r:require modules="bootstrap-css, bootstrap-collapse, filterStock, app"/>
</head>
<body>
	<h2 id="medicine" style="cursor:pointer;">MEDICINAS</h2>
	<div id="medicines">
		<g:set var="totalStock" value="${0}"/>
		<g:each in="${medicines}" var="medicine" status="index">
			<table class="table table-hover">
				<caption class="bg-info capStock">
					<strong>Nombre:</strong> ${medicine} - <strong>Codigo:</strong> #${medicine.code} - <strong>Ubicacion:</strong> ${medicine.location} - <strong>Laboratorio:</strong> ${medicine.provider}
				</caption>
				<colgroup>
					<col span="1" style="width: 20%;">
					<col span="1" style="width: 20%;">
					<col span="1" style="width: 20%;">
					<col span="1" style="width: 20%;">
					<col span="1" style="width: 20%;">
				</colgroup>
				<g:if test="${index == 0}">
					<thead>
						<th>Presentacion</th>
						<th>Medida</th>
						<th>Cantidad</th>
						<sec:ifAnyGranted roles="ROLE_ADMIN">
							<th>Precio de venta</th>
						</sec:ifAnyGranted>
						<sec:ifAnyGranted roles="ROLE_ADMIN">
							<th>Monto Total</th>
						</sec:ifAnyGranted>
					</thead>
				</g:if>
				<tbody>
					<g:each in="${ni.sb.MedicineOrder.findAllByProduct(medicine)}" var="m">
						<tr>
							<td>${m.presentation}</td>
							<td>${m.measure}</td>
							<td>${m.quantity}</td>
							<sec:ifAnyGranted roles="ROLE_ADMIN">
								<td>${m.sellingPrice}</td>
							</sec:ifAnyGranted>
							<sec:ifAnyGranted roles="ROLE_ADMIN">
								<td>${m.sellingPrice * m.quantity}</td>
							</sec:ifAnyGranted>
							<g:set var="totalStock" value="${totalStock + (m.sellingPrice * m.quantity)}"/>
						</tr>
					</g:each>
				</tbody>
			</table>
		</g:each>
		
		<sec:ifAnyGranted roles="ROLE_ADMIN">
			<div class="col-md-12 bg-primary totalStock">
				<h4 class="pull-right">TOTAL PRODUCTOS DE MEDICINA: C$ 
				<g:formatNumber number="${totalStock}" type="number" maxFractionDigits="2"/></h4>
			</div>
		</sec:ifAnyGranted>

	</div>
	
	<br><br><br>

	<h2 id="item" style="cursor:pointer;">PRODUCTOS</h2>
	<table class="table table-hover" id="items">
		<colgroup>
			<col span="1" style="width: 20%;">
			<col span="1" style="width: 20%;">
			<col span="1" style="width: 20%;">
			<col span="1" style="width: 20%;">
			<col span="1" style="width: 20%;">
		</colgroup>
		<thead>
			<th>Producto</th>
			<th>Ubicacion</th>
			<th>Cantidad</th>
			<sec:ifAnyGranted roles="ROLE_ADMIN">
				<th>Precio de venta</th>
			</sec:ifAnyGranted>
			<sec:ifAnyGranted roles="ROLE_ADMIN">
				<th>Monto total</th>
			</sec:ifAnyGranted>
		</thead>
		<tbody>
			<g:each in="${items}" var="item">
				<tr>
					<td>${item.product}</td>
					<td>${item.location}</td>
					<td>${item.quantity}</td>
					<sec:ifAnyGranted roles="ROLE_ADMIN">
						<td>${item.sellingPrice}</td>
					</sec:ifAnyGranted>
					<sec:ifAnyGranted roles="ROLE_ADMIN">
						<td>${item.total}</td>
					</sec:ifAnyGranted>
				</tr>
			</g:each>			
		</tbody>
	</table>

	<sec:ifAnyGranted roles="ROLE_ADMIN">
		<div class="col-md-12 bg-primary totalStock">
			<h4 class="pull-right">TOTAL EN PRODUCTOS: C$ 
			<g:formatNumber number="${items.total.sum()}" type="number" maxFractionDigits="2"/></h4>
		</div>
	</sec:ifAnyGranted>

	<br><br><br>
	<h2 id="brandProduct" style="cursor:pointer;">PRODUCTOS DE MARCA</h2>
	<div id="brandProducts">
		<g:set var="totalStock" value="${0}"/>
		<g:each in="${brandProducts}" var="brandProduct" status="index">
			<table class="table table-hover">
				<caption class="bg-info capStock"><strong>Nombre:</strong> ${brandProduct} - <strong>Ubicacion:</strong> ${brandProduct.location}</caption>
				<colgroup>
					<col span="1" style="width: 20%;">
					<col span="1" style="width: 20%;">
					<col span="1" style="width: 20%;">
					<col span="1" style="width: 20%;">
					<col span="1" style="width: 20%;">
				</colgroup>
				<g:if test="${index == 0}">
					<thead>
						<th>Marca</th>
						<th>Detalle</th>
						<th>Cantidad</th>
						<sec:ifAnyGranted roles="ROLE_ADMIN">
							<th>Precio de venta</th>
						</sec:ifAnyGranted>
						<sec:ifAnyGranted roles="ROLE_ADMIN">
							<th>Monto Total</th>
						</sec:ifAnyGranted>
					</thead>
				</g:if>
				<tbody>
					<g:each in="${ni.sb.BrandProductOrder.findAllByProduct(brandProduct)}" var="b">
						<tr>
							<td>${b.brand}</td>
							<td>${b.detail}</td>
							<td>${b.quantity}</td>
							<sec:ifAnyGranted roles="ROLE_ADMIN">
								<td>${b.sellingPrice}</td>
							</sec:ifAnyGranted>
							<sec:ifAnyGranted roles="ROLE_ADMIN">
								<td>${b.quantity * b.sellingPrice}</td>
							</sec:ifAnyGranted>
						</tr>
						<g:set var="totalStock" value="${totalStock + (b.quantity * b.sellingPrice)}"/>
					</g:each>
				</tbody>
			</table>
		</g:each>
		<sec:ifAnyGranted roles="ROLE_ADMIN">
			<div class="col-md-12 bg-primary totalStock">
				<h4 class="pull-right">TOTAL PRODUCTOS DE MARCA: C$ 
				<g:formatNumber number="${totalStock}" type="number" maxFractionDigits="2"/></h4>
			</div>
		</sec:ifAnyGranted>
		
	</div>

	<style>
		caption {
			color:#000;
		}
	</style>
</body>
</html>
