<div class="form-group">
	<label for="name" class="sr-only">Nombre del producto</label>
	<g:textField name="name" value="${product?.name}" class="form-control" placeholder="Nombre del producto" autofocus="true"/>
</div>
<g:if test="${actionName == 'createMedicine' || product instanceof ni.sb.Medicine}">
	<div class="form-group">
		<label for="code" class="sr-only">Codigo</label>
		<g:textField name="code" value="${product?.code}" class="form-control" placeholder="Codigo"/>
	</div>
</g:if>
<g:if test="${actionName == 'createBrandProduct' || product instanceof ni.sb.BrandProduct}">
	<div class="form-group">
		<label for="brand" class="sr-only">Marca</label>
		<g:textField name="brand" value="${product?.brand}" class="form-control" placeholder="Marca"/>
	</div>
	<div class="form-group">
		<label for="detail" class="sr-only">Detalle</label>
		<g:textField name="detail" value="${product?.detail}" class="form-control" placeholder="Detalle"/>
	</div>
</g:if>
<g:if test="${actionName == 'show'}">
	<div class="form-group">
		<label for="status" class="sr-only">Estado</label>
		<g:select name="status" from="['Activo', 'Inactivo']" keys="[true, false]" value="${product?.status}" class="form-control"/>
	</div>
</g:if>