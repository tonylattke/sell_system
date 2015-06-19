sellApp.factory 'products', ['$http', ($http) ->
	
	urlBase = '/api/products'
	dataFactory = {}

	dataFactory.getProducts = ->
		return $http.get(urlBase)

	dataFactory.getProduct = (id) ->
		return $http.get(urlBase + '/' + id)

	dataFactory.createProduct = (info) ->
		return $http.post(urlBase,info)

	dataFactory.updateProduct = (id) ->
		return $http.put(urlBase + '/' + id)

	dataFactory.deleteProduct = (id) ->
		return $http.delete(urlBase + '/' + id)

	dataFactory.getProductsBestsellers = ->
		return $http.get('/api/products_bestsellers')

	dataFactory.searchProducts = (info) ->
		return $http.get(urlBase + '/search/' + info)

	return dataFactory
]