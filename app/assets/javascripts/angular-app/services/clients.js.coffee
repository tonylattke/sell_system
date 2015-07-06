sellApp.factory 'clients', ['$http','$q', ($http,$q) ->
	
	urlBase = '/api/clients'
	dataFactory = {}

	dataFactory.getClients = ->
		def = $q.defer()
		$http.get(urlBase).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Clients cannot be listed")
		)
		return def.promise

	dataFactory.getClient = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Client cannot be found")
		)
		return def.promise

	dataFactory.createClient = (info) ->
		def = $q.defer()
		$http.post(urlBase,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Client cannot be created")
		)
		return def.promise

	dataFactory.updateClient = (id,info) ->
		def = $q.defer()
		$http.put(urlBase + '/' + id,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Client cannot be updated")
		)
		return def.promise
	
	dataFactory.deleteClient = (id) ->
		def = $q.defer()
		$http.delete(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Client cannot be deleted")
		)
		return def.promise

	dataFactory.searchClients = (info) ->
		def = $q.defer()
		$http.get(urlBase + '/search/' + info).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Clients cannot be searched")
		)
		return def.promise

	return dataFactory
]