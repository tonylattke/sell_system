sellApp.factory 'product_providers', ['$http', ($http) ->
	
	urlBase = '/api/product_providers'
	dataFactory = {}

	dataFactory.getProductProviders = ->
		return $http.get(urlBase)

	dataFactory.getProductProvider = (id) ->
		return $http.get(urlBase + '/' + id)

	dataFactory.createProductProvider = (info) ->
		return $http.post(urlBase,info)

	dataFactory.updateProductProvider = (id) ->
		return $http.put(urlBase + '/' + id)

	dataFactory.deleteProductProvider = (id) ->
		return $http.delete(urlBase + '/' + id)

	dataFactory.searchProductProviders = (provider,product) ->
		return $http.get(urlBase + '/search/' + provider + '/' + product)

	dataFactory.searchProductProvidersByProvider = (id) ->
		return $http.get(urlBase + '/search_by_provider/' + id)

	dataFactory.searchProductProvidersByProduct = (id) ->
		return $http.get(urlBase + '/search_by_product/' + id)

	return dataFactory
]