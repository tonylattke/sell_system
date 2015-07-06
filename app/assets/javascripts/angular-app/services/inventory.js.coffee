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