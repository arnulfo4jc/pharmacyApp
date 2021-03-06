<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="main">
	<title>Abonos</title>
	<r:require modules="bootstrap-css, bootstrap-collapse, pay"/>
</head>
<body>
<style>hr{ margin-bottom: 5px; margin-top: 25px;};</style>
	<div class="row">
		<div class="col-md-9">
		<g:set var="totalPayment" value="${0}"/>
		<g:set var="lastBalance" value="${0}"/>
			<g:if test="${payInstance}">
				<h4>Abonos efectuados</h4>
				<table class="table">
					<thead>
						<th>Fecha</th>
						<th>Atendido por</th>
						<th>Recibo</th>
						<th>Abono</th>
						<th>Vuelto</th>
						<th>Saldo</th>
						<th width="1"></th>
					</thead>
					<tbody>
						<g:each in="${payInstance}" var="pay" status="i">
							<g:set var="lastBalance" value="${lastBalance + pay.payment}"/>
							<tr>
								<td>${pay.dateCreated.format("dd-MM-yyyy")}</td>
								<td>${pay.user}</td>
								<td>${pay.receiptNumber}</td>
								<td>${pay.payment}</td>
								<td>${pay.change}</td>
								<td>${saleInstance.balance - lastBalance}</td>
								<td width="1">
									<g:if test="${(i+1) == payInstance.size()}">
										<g:link action="delete" params="[idPay:"${pay.id}", id:"${saleInstance.id}"]" title="Eliminar">
											<span class="glyphicon glyphicon-trash"></span>
										</g:link>
									</g:if>
								</td>
							</tr>
							<g:set var="totalPayment" value="${totalPayment + pay.payment}"/>
						</g:each>
						<tr>
							<td colspan="5">TOTAL</td>
							<td colspan="2"><strong>${saleInstance?.balance - totalPayment}</strong></td>
						</tr>
					</tbody>
				</table>
			</g:if>
		</div>
		<div class="col-md-3">
			<g:if test="${saleInstance.status != "Cancelado"}">
				<g:form controller= "sale" action="pay">
					<g:set var="receiptNumber" value="${pharmacyApp.calcReceiptNumber()}"/>
					<g:hiddenField name="balance" value="${saleInstance.balance - totalPayment}"/>
					<g:hiddenField name="user" value=""/>
					<g:hiddenField name="id" value="${saleInstance.id}"/>
					<g:hiddenField name="change" value="change"/>
					<div class="form-group">
						<label for="payment">Cantidad a abonar</label>
						<g:textField type="payment" class="form-control" name="payment" required="" autocomplete='off'/>
					</div>
					<div class="form-group">
						<label for="payment">Cantidad con la que paga</label>
						<g:textField type="amountPayment" class="form-control" name="amountPayment" required="" autocomplete='off'/>
					</div>
					<div class="form-group">
						<label for="payment">Numero de Recibo</label>
						<g:textField type="receiptNumber" class="form-control" name="receiptNumber" required="" autocomplete='off' value="${receiptNumber}"/>
					</div>
					<div class="panel panel-default">
					  <div class="panel-body">
					  <div class="row">
					  		<div class="col-md-7">CUENTA</div>
						   	<div class="col-md-5">${saleInstance.balance}</div>
						   	<hr>
					  		<div class="col-md-7">SALDO</div>
						   	<div class="col-md-5">${saleInstance?.balance - totalPayment}</div>
						   	<hr>
						   	<div class="col-md-7">SALDO ACTUAL</div>
						   	<div class="col-md-5" id="currentBalance"></div>
						   	<hr>
					  		<div class="col-md-7">CAMBIO</div>
						   	<div class="col-md-5" id="changeLabel"></div>
						   	<hr>
						   	<div class="col-md-12"><strong><p id="info"></p></strong></div>
					  </div>
					  </div>
					</div>
					<div>
						<g:submitButton name="btnregistration" value="Registrar" class="btn btn-primary pull-right"/>
					</div>
				</g:form>
			</g:if>
			<g:else>
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="col-md-12">
							<h4>La venta ha sido cancelada</h4>
						</div>
					</div>
				</div>
			</g:else>
		</div>
	</div>
</body>
</html>
