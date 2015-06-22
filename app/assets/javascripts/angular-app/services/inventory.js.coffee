sellApp.factory 'inventory', ['$http','$q', ($http,$q) ->
	
	dataFactory = {}

	dataFactory.createTagsWithProduct = (info) ->
		def = $q.defer()
		$http.post('/inventory_save_tags',info).success((data) ->
			def.resolve(data)
		)
		return def.promise

	dataFactory.createProvidersWithProduct = (info) ->
		def = $q.defer()
		$http.post('/inventory_save_providers',info).success((data) ->
			def.resolve(data)
		)
		return def.promise

	dataFactory.deleteProductTags = (product) ->
		def = $q.defer()
		$http.delete('/inventory_delete_tags/' + product).success((data) ->
			def.resolve(data)
		)
		return def.promise

	return dataFactory
]