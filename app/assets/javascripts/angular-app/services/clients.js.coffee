sellApp.factory 'clients', ['$http', ($http) ->
	
	urlBase = '/api/clients'
	dataFactory = {}

	dataFactory.getClients = ->
		return $http.get(urlBase)

	dataFactory.getClient = (id) ->
		return $http.get(urlBase + '/' + id)

	dataFactory.createClient = (info) ->
		return $http.post(urlBase,info)

	dataFactory.updateClient = (id) ->
		return $http.put(urlBase + '/' + id)

	dataFactory.deleteClient = (id) ->
		return $http.delete(urlBase + '/' + id)

	dataFactory.searchClients = (info) ->
		return $http.get(urlBase + '/search/' + info)

	return dataFactory
]