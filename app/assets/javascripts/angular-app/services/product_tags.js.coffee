sellApp.factory 'product_tags', ['$http', ($http) ->
	
	urlBase = '/api/product_tags'
	dataFactory = {}

	dataFactory.getProductTags = ->
		return $http.get(urlBase)

	dataFactory.getProductTag = (id) ->
		return $http.get(urlBase + '/' + id)

	dataFactory.createProductTag = (info) ->
		return $http.post(urlBase,info)

	dataFactory.updateProductTag = (id) ->
		return $http.put(urlBase + '/' + id)

	dataFactory.deleteProductTag = (id) ->
		return $http.delete(urlBase + '/' + id)

	dataFactory.searchProductTags = (tag,product) ->
		return $http.get(urlBase + '/search/' + tag + '/' + product)

	dataFactory.searchProductTagsByTag = (id) ->
		return $http.get(urlBase + '/search_by_tag/' + id)

	dataFactory.searchProductTagsByProduct = (id) ->
		return $http.get(urlBase + '/search_by_product/' + id)

	return dataFactory
]