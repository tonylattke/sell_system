sellApp.factory 'inventory', ['$http','$q', ($http,$q) ->
	
	dataFactory = {}

	dataFactory.createTagsWithProduct = (info) ->
		def = $q.defer()
		$http.post('/inventory/save_tags',info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Tags cannot be associated with product"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.getProductDetails = (id) ->
		def = $q.defer()
		$http.get('/inventory/product_details/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Product details cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.getComboDetails = (id) ->
		def = $q.defer()
		$http.get('/inventory/combo_details/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Combo details cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.searchTagsByProduct = (id) ->
		def = $q.defer()
		$http.get('/inventory/tags_by_product/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Tags of product cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.searchProvidersByProduct = (id) ->
		def = $q.defer()
		$http.get('/inventory/providers_by_product/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Tags of product cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.createProvidersWithProduct = (info) ->
		def = $q.defer()
		$http.post('/inventory/save_providers',info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Providers cannot be associated with product"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.deleteProductTags = (product) ->
		def = $q.defer()
		$http.delete('/inventory/delete_tags/' + product).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Tag product association cannot be deleted"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.deleteProductProviders = (product) ->
		def = $q.defer()
		$http.delete('/inventory/delete_providers/' + product).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Provider product association cannot be deleted"
			}
			def.resolve(bad_news)
		)
		return def.promise

	return dataFactory
]