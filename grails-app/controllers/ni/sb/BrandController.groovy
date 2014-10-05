package ni.sb

import grails.plugin.springsecurity.annotation.Secured

@Secured(["ROLE_ADMIN"])
class BrandController {
	static defaultAction = "show"
	static allowedMethods = [
		show:"GET",
		update:"POST"
	]

  def show(Integer id) {
  	def brandProduct = BrandProduct.get id

  	if (!brandProduct) {
  		response.sendError 404
  	}

    def brands = brandProduct.brands
  	def distinctBrands = Brand.distinctBrands.list()
    def availableBrands = distinctBrands - brands.name

  	[brandProduct:brandProduct, brands:brands, availableBrands:availableBrands]
  }

  def update(Integer id) {
  	def brandProduct = BrandProduct.get id

  	if (!brandProduct) {
  		response.sendError 404
  	}

  	brandProduct.name = params?.name

  	if (!brandProduct.save()) {
  		chain action:"show", params:[id:id]
  		return
  	}

  	flash.message = "Producto actualizado"
  	redirect action:"show", id:id
  }
}
