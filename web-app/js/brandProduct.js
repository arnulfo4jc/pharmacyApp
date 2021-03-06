$(document).ready(function() {
	var ItemBuilder = (function() {

		var getBrandsByBrandProduct = function(id) {
			$.ajax({
				url:"getBrandsByBrandProduct/",
				data:{ id:id },
				dataType:"JSON",
				success:function(res) {
					var brand = $("#brand"),
							detail = $("#detail"),
							brands = res;

					brand.find("option").remove()
					detail.find("option").remove()

					for (var i = brands.length - 1; i >= 0; i--){
						var opt = $("<option>", { value:brands[i].id, text:brands[i].name });

						//add measures only for first presentation
						if (i == brands.length - 1) {
							for (var j = brands[i].details.length - 1; j >= 0; j--) {
								var o = $("<option>", { value:brands[i].details[j], text:brands[i].details[j] })

								detail.append(o)
							};
						}

						brand.append(opt)
					}
				}
			})
		}

		var getDetailsInBrand = function(id) {
			$.ajax({
				url:"getDetailsInBrand/",
				data:{ id:id },
				dataType:"JSON",
				success:function(res) {
					var detail = $("#detail");
					detail.find("option").remove()

					for (var i = res.length - 1; i >= 0; i--) {
						var option = $("<option>", { value:res[i], text:res[i] })

						detail.append(option)
					};
				}
			})
		}

		return {
			getBrandsByBrandProduct:getBrandsByBrandProduct,
			getDetailsInBrand:getDetailsInBrand
		}
	})();

	ItemBuilder.getBrandsByBrandProduct($("#product").val())

	$("#product").on("change", function(){
		ItemBuilder.getBrandsByBrandProduct($(this).val())
	})

	$("#brand").on("change", function(){
		ItemBuilder.getDetailsInBrand($(this).val())
	})

	$('[data-toggle=tooltip]').tooltip();
});
