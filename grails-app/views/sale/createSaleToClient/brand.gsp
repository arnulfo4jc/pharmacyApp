<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="main">
	<title>Administrar venta</title>
	<r:require modules="bootstrap-css, bootstrap-collapse"/>
</head>
<body>
	<div class="row">
		<div class="col-md-8">
			<g:render template="saleDetail"/>
		</div>
		<div class="col-md-4">
			<!--Client data-->
			<g:render template="createSaleToClient/clientData"/>

			<!--Balance-->
			<div class="well well-sm">
				Saldo: <pharmacyApp:getSaleBalance medicinesToSale="${medicinesToSale}" productsToSale="${productsToSale}" brandsToSale="${brandsToSale}"/>
			</div>

			<!--Tabs-->
			<ul class="nav nav-tabs" role="tablist" style="margin-bottom:10px;">
			  <li><g:link event="medicine">Medicina</g:link></li>
			  <li><g:link event="manageProducts">Producto</g:link></li>
			  <li class="active">
			  	<g:link event="manageBrands">Marca</g:link>
			  </li>
			</ul>

			<!--Brands-->
			<table class="table">
				<tbody>
					<g:each in="${brands.keySet()}" var="brand">
						<tr>
							<td colspan="4" style="border:0;"><strong>${brand}</strong></td>
						</tr>
						<g:each in="${brands[brand]}" var="item" status="index">
							<tr style="font-size:0.85em;">
								<g:form>
									<g:hiddenField name="id" value="${item.id}"/>

									<td style="vertical-align: middle;">${item}</td>
									<td style="vertical-align: middle;">${item.detail}</td>
									<td style="vertical-align: middle;"><small>${item.product.location}</small></td>
									<td style="vertical-align: middle;">
										<g:set var="q" value="${brandsToSale.find { it.item == item }?.quantity ?: 0}"/>
										<g:set var="quantity" value="${brandsToSale ? item.quantity - q : item.quantity}"/>

										<input type="number" name="quantity" id="quantity" min="1" max="${quantity}" required x-moz-errormessage="Requerido" class="form-control input-sm" placeholder="${quantity}"/>
									</td>
									<td style="vertical-align: middle;">
										<g:submitButton name="addItem" value="Ir" class="btn btn-primary btn-xs"/>
									</td>
								</g:form>
							</tr>
						</g:each>
					</g:each>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>