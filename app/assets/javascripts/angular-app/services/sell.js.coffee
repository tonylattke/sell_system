sellApp.factory 'sell', ['$http','$q', ($http,$q) ->
	
	dataFactory = {}

	dataFactory.searchProductsByTag = (info) ->
		def = $q.defer()
		$http.get('/sell/search_products_by_tag/' + info).success((data) ->
			def.resolve(data)
		)
		return def.promise

	return dataFactory
]