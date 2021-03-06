package ni.sb

class BrandProductOrder extends Item {
	Brand brand
  String detail

  static constraints = {
    brand nullable:false
    detail blank:false
  }

  static mapping = {
  	version false
    brand fetch: 'join'
  }

  String toString() { product }
}
