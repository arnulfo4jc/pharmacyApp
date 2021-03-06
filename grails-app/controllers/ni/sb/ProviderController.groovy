package ni.sb

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN"])
class ProviderController {
	static defaultAction = "list"
	static allowedMethods = [
		list:"GET",
    create:["GET", "POST"],
		show:"GET",
    update:"POST"
	]

  def list() {
    def status = params?.status ?: true

  	[providers:Provider.findAllByStatus(status)]
  }

  def create() {
    def provider = new Provider(params)

    if (request.method == "POST") {
      if (!provider.save()) {
        return [provider:provider]
      }

      flash.message = "Proveedor creado"
    } else {
      [provider:provider]
    }
  }

  def show(Integer id) {
  	def provider = Provider.get id

  	if (!provider) { response.sendError 404 }

  	[provider:provider]
  }

  def update(Integer id) {
    def provider = Provider.get(id)

    if (!provider) { response.sendError 404 }

    provider.properties = params

    if (!provider.save()) {
      render view:"show", model:[id:id, provider:provider]
      return
    }

    flash.message = "Actualizado"
    redirect action:"show", id:id
  }
}
