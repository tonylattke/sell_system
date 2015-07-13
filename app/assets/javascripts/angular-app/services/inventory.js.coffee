sellApp.factory 'inventory', ['$http','$q', ($http,$q) ->
	
	dataFactory = {}

	dataFactory.createTagsWithProduct = (info) ->
		def = $q.defer()
		$http.post('/inventory/save_tags',info).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Tags cannot be associated with product")
		)
		return def.promise

	dataFactory.getProductDetails = (id) ->
		def = $q.defer()
		$http.get('/inventory/product_details/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Product details cannot be found")
		)
		return def.promise

	dataFactory.getComboDetails = (id) ->
		def = $q.defer()
		$http.get('/inventory/combo_details/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Combo details cannot be found")
		)
		return def.promise

	dataFactory.searchTagsByProduct = (id) ->
		def = $q.defer()
		$http.get('/inventory/tags_by_product/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Tags of product cannot be found")
		)
		return def.promise

	dataFactory.searchProvidersByProduct = (id) ->
		def = $q.defer()
		$http.get('/inventory/providers_by_product/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Tags of product cannot be found")
		)
		return def.promise

	dataFactory.createProvidersWithProduct = (info) ->
		def = $q.defer()
		$http.post('/inventory/save_providers',info).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Providers cannot be associated with product")
		)
		return def.promise

	dataFactory.deleteProductTags = (product) ->
		def = $q.defer()
		$http.delete('/inventory/delete_tags/' + product).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Tag product association cannot be deleted")
		)
		return def.promise

	dataFactory.deleteProductProviders = (product) ->
		def = $q.defer()
		$http.delete('/inventory/delete_providers/' + product).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Provider product association cannot be deleted")
		)
		return def.promise

	return dataFactory
]