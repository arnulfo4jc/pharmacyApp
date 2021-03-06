<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Iniciar sesion</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<div>
		<br>
		<form action='${postUrl}' method='POST' autocomplete='off' role="form">
			<div class="form-group">
				<label for='username' class="sr-only"><g:message code="springSecurity.login.username.label"/>:</label>
				<input type='text' class='form-control' name='j_username' id='username' placeholder="Correo electrónico" autofocus="true"/>
			</div>

			<div class="form-group">
				<label for='password' class="sr-only"><g:message code="springSecurity.login.password.label"/>:</label>
				<input type='password' class='form-control' name='j_password' id='password' placeholder="Contraseña"/>
			</div>

			<div class="form-group">
				<input type='submit' id="submit" value='Iniciar Sesion' class="btn btn-primary"/>
				<g:link controller='register' action='forgotPassword'>Olvido su contraseña</g:link>
			</div>
		</form>
	</div>
</body>
</html>