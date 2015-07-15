sellApp.factory 'clients', ['$http','$q', ($http,$q) ->
	
	urlBase = '/api/clients'
	dataFactory = {}

	dataFactory.getClients = ->
		def = $q.defer()
		$http.get(urlBase).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Clients cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.getClient = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Client cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.createClient = (info) ->
		def = $q.defer()
		$http.post(urlBase,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Client cannot be created"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.updateClient = (id,info) ->
		def = $q.defer()
		$http.put(urlBase + '/' + id,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Client cannot be updated"
			}
			def.resolve(bad_news)
		)
		return def.promise
	
	dataFactory.deleteClient = (id) ->
		def = $q.defer()
		$http.delete(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Client cannot be deleted"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.searchClients = (info) ->
		def = $q.defer()
		$http.get(urlBase + '/search/' + info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Clients cannot be searched"
			}
			def.resolve(bad_news)
		)
		return def.promise

	return dataFactory
]