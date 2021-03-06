<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="main">
	<title>Ventas</title>
	<r:require modules="bootstrap-css, bootstrap-js, bootstrap-collapse, saleFilter, jquery-ui"/>
</head>
<body>
	<div class="row">
		<div class="col-md-12">
			<div class="pull-right">
				<g:link action="createSaleToClient" class="btn btn-primary">Vender</g:link>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-md-9">
			<g:if test="${sales}">
				<h4>Ventas</h4>

				<g:if test="${checkVentas == 'clients'}">

				<table class="table table-hover">
					<thead>
						<tr>
							<td colspan="6">
								<h3 class="pull-right montoVentas">
									MONTO VENDIDO: C$ <g:formatNumber number="${amount}" type="number" maxFractionDigits="2"/> 
								</h3>
							</td>
						</tr>
						<th width="1">#</th>
						<th>Fecha de venta</th>
						<th>Cliente</th>
						<th>Total de compra</th>
						<th>Tipo</th>
						<th>Vendedor</th>
					</thead>
					<tbody>
						<g:each in="${sales}" var="sale" status="index">
							<tr class="${sale.canceled ? 'active' : ''}">
								<td>
									<g:link action="show" id="${sale.id}">
										${index + 1}
									</g:link>
								</td>
								<td>
									<g:formatDate date="${sale.dateCreated}" formatName="custom.date.format" format="dd-MM-yyyy - hh:mm"/>
								</td>
								<td>
									<g:if test="${sale.instanceOf(ni.sb.SaleToClient)}">
										${sale.client}
									</g:if>
								</td>
								<td>C$ <g:formatNumber number="${sale.balance}" type="number" maxFractionDigits="2"/></td>
								<td>
									<g:if test="${sale.instanceOf(ni.sb.SaleToClient)}">
										${sale.typeOfPurchase}
									</g:if>
									<g:else>
										Contado
									</g:else>
								</td>
								<td>${sale.user.fullName}</td>
							</tr>
						</g:each>
					</tbody>
				</table>
			
			</g:if>


			<g:else>

				<table class="table table-hover">
				<thead>
					<tr>
						<td colspan="6">
							<h3 class="pull-right montoVentas">
								MONTO VENDIDO: C$ <g:formatNumber number="${amount}" type="number" maxFractionDigits="2"/> 
							</h3>
						</td>
					</tr>
					<th>Fecha</th>
					<th>Producto Vendido</th>
					<th>Cantidad</th>
					<th>Precio</th>
					<th>Total</th>
				</thead>
				<tbody>
					<g:each in="${sales}" var="sale" status="i">
						<g:each in="${sale.saleDetails}" var="saleD" status="e">
							<tr class="${sale.canceled ? 'active' : ''}">
								<td>
									${sale.dateCreated.format("dd-MM-yyyy - hh:mm")}
								</td>
								<td>
									${saleD.item}
								</td>
								<td>
									${saleD.quantity}
								</td>
								<td>
									C$ <g:formatNumber number="${saleD.total / saleD.quantity}" type="number" maxFractionDigits="2"/>
								</td>
								<td>
									C$ <g:formatNumber number="${saleD.total}" type="number" maxFractionDigits="2"/>
								</td>
							</tr>
						</g:each>
					</g:each>
				</tbody>
			</table>
			
			</g:else>
	

			</g:if>

			<g:else>
				<h4>Sin ventas que mostrar</h4>
			</g:else>
		</div>

		<div class="col-md-3">
			<h4>Diario</h4>
			<table class="table">
				<tbody>
					<tr>
						<td>Monto total vendido</td>
						<td>
							C$ <g:formatNumber number="${todaySaleAmount}" type="number" maxFractionDigits="2"/> 
						</td>
					</tr>
					<tr>
						<td>Ventas Contado</td>
						<td>
							C$ <g:formatNumber number="${ventasContado}" type="number" maxFractionDigits="2"/>
						</td>
					</tr>
					<tr>
						<td>Monto gasto diario</td>
						<td>C$ <g:formatNumber number="${amountOfDailyExpenses}" type="number" maxFractionDigits="2"/></td>
					</tr>
					<tr>
						<td>Monto en caja</td>
						<td>
							<g:if test="${ventasContado}">
								C$ <g:formatNumber number="${ventasContado - amountOfDailyExpenses}" type="number" maxFractionDigits="2"/>	
							</g:if>
							<g:else>
								C$ 0.00
							</g:else>
						</td>
					</tr>
				</tbody>
			</table>

			<h4 id="filterSale" style="cursor:pointer;">Filtrar</h4>
			<div id="filterSales">
				<g:form action="list" >
					
					<h5><strong>Fechas</strong></h5>
					<div class="form-group">
						<label for="from" class="sr-only">Desde</label>
						<g:textField name="from" value="${params?.from}" class="form-control" placeholder="Desde"/>
					</div>
					<div class="form-group">
						<label for="to" class="sr-only">Hasta</label>
						<g:textField name="to" value="${params?.to}" class="form-control" placeholder="Hasta"/>
					</div>
					
					<h5><strong>Clientes</strong></h5>
					<g:select name="clients" from="${clients}" optionKey="id" multiple="true" class="form-control"/>

					<h5><strong>Tipo de pago</strong></h5>
					<div class="checkbox">
						<label>
							<g:checkBox name="cash" value="Contado" checked="${params?.cash ? true : false}"/>
							Contado
						</label>
					</div>
					<div class="checkbox">
						<label>
							<g:checkBox name="credit" value="Credito" checked="${params?.credit ? true : false}"/>
							Credito
						</label>
					</div>

					<h5><strong>Estado</strong></h5>
					<div class="checkbox">
						<label>
							<g:checkBox name="isPending" value="Pendiente" checked="${params?.isPending ? true : false}"/>
							Pendiente
						</label>
					</div>
					<div class="checkbox">
						<label>
							<g:checkBox name="isCanceled" value="Cancelado" checked="${params?.isCanceled ? true : false}"/>
							Cancelado
						</label>
					</div>

					<h5><strong>Ventas</strong></h5>
					<div class="checkbox">
						<label>
							<g:radio name="checkVentas" value="clients"/>
							Por clientes
						</label>
					</div>
					<div class="checkbox">
						<label>
							<g:radio name="checkVentas" value="product"/>
							Por roductos
						</label>
					</div>

					<h5><strong>Anulado</strong></h5>
					<div class="checkbox">
						<label>
							<g:checkBox name="canceled" value="true" checked="${params?.canceled ? true : false}"/>
							Anulado
						</label>
					</div>

					<h5><strong>Vendedores</strong></h5>
					<g:each in="${users}" var="user">
						<div class="checkbox">
							<label>
								<g:checkBox name="users" value="${user.id}" checked="${params?.users?.contains(user.id.toString()) ? true : false}"/>
								${user.fullName}
							</label>
						</div>
					</g:each>

					<g:submitButton name="filter" value="Filtrar" class="btn btn-primary btn-block"/>
				</g:form>
			</div>
		</div>
	</div>
</body>
</html>
