sellApp.factory 'providers', ['$http','$q', ($http,$q) ->
	
	urlBase = '/api/providers'
	dataFactory = {}

	dataFactory.getProviders = ->
		def = $q.defer()
		$http.get(urlBase).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Providers cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.getProvider = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Provider cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.createProvider = (info) ->
		def = $q.defer()
		$http.post(urlBase,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Provider cannot be created"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.updateProvider = (id,info) ->
		def = $q.defer()
		$http.put(urlBase + '/' + id,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Provider cannot be updated"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.deleteProvider = (id) ->
		def = $q.defer()
		$http.delete(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Provider cannot be deleted"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.searchProvider = (info) ->
		def = $q.defer()
		$http.get(urlBase + '/search/' + info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Providers cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	return dataFactory
]