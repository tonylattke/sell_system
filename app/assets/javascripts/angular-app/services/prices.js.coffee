sellApp.factory 'prices', ['$http', ($http) ->
	
	urlBase = '/api/prices'
	dataFactory = {}

	dataFactory.getPrices = ->
		return $http.get(urlBase)

	dataFactory.getPrice = (id) ->
		return $http.get(urlBase + '/' + id)

	dataFactory.createPrice = (info) ->
		return $http.post(urlBase,info)

	dataFactory.updatePrice = (id) ->
		return $http.put(urlBase + '/' + id)

	dataFactory.deletePrice = (id) ->
		return $http.delete(urlBase + '/' + id)

	dataFactory.searchPriceByProduct = (id) ->
		return $http.get(urlBase + '/search_by_product/' + id)

	dataFactory.searchPriceByCombo = (id) ->
		return $http.get(urlBase + '/search_by_combo/' + id)	

	return dataFactory
]