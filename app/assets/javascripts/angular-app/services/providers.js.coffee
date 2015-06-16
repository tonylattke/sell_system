sellApp.factory 'providers', ['$http', ($http) ->
	
	urlBase = '/api/providers'
	dataFactory = {}

	dataFactory.getProviders = ->
		return $http.get(urlBase)

	dataFactory.getProvider = (id) ->
		return $http.get(urlBase + '/' + id)

	dataFactory.createProvider = (info) ->
		return $http.post(urlBase,info)

	dataFactory.updateProvider = (id) ->
		return $http.put(urlBase + '/' + id)

	dataFactory.deleteProvider = (id) ->
		return $http.delete(urlBase + '/' + id)

	dataFactory.searchProvider = (info) ->
		return $http.get(urlBase + '/search/' + info)

	return dataFactory
]