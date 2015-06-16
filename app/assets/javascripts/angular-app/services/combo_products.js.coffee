sellApp.factory 'combo_products', ['$http', ($http) ->
	
	urlBase = '/api/combo_products'
	dataFactory = {}

	dataFactory.getComboProducts = ->
		return $http.get(urlBase)

	dataFactory.getComboProduct = (id) ->
		return $http.get(urlBase + '/' + id)

	dataFactory.createComboProduct = (info) ->
		return $http.post(urlBase,info)

	dataFactory.updateComboProduct = (id) ->
		return $http.put(urlBase + '/' + id)

	dataFactory.deleteComboProduct = (id) ->
		return $http.delete(urlBase + '/' + id)

	dataFactory.searchComboProducts = (combo,product) ->
		return $http.get(urlBase + '/search/' + combo + '/' + product)

	dataFactory.searchComboProductsByCombo = (id) ->
		return $http.get(urlBase + '/search_by_combo/' + id)

	dataFactory.searchComboProductsByProduct = (id) ->
		return $http.get(urlBase + '/search_by_product/' + id)

	return dataFactory
]