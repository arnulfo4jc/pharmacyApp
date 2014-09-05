<div class="form-group">
	<label for="name">Nombre</label>
	<g:textField name="name" value="${provider?.name}" class="form-control"/>
</div>
<div class="form-group">
	<label for="address">Direccion</label>
	<g:textField name="address" value="${provider?.address}" class="form-control"/>
</div>
<div class="form-group">
	<label for="phone">Telefono</label>
	<g:textField name="phone" value="${provider?.phone}" class="form-control"/>
</div>
<g:if test="${actionName == 'show'}">
	<div class="form-group">
		<label for="status">Estado</label>
		<g:select name="status" from="${['Activo', 'Inactivo']}" keys="[true, false]" value="${provider?.status}" class="form-control"/>
	</div>
</g:if>