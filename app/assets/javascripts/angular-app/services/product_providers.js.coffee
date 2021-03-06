sellApp.factory 'product_providers', ['$http','$q', ($http,$q) ->
	
	urlBase = '/api/product_providers'
	dataFactory = {}

	dataFactory.getProductProviders = ->
		def = $q.defer()
		$http.get(urlBase).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Provider product associations cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.getProductProvider = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Provider product association cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.createProductProvider = (info) ->
		def = $q.defer()
		$http.post(urlBase,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Provider product association cannot be created"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.updateProductProvider = (id,info) ->
		def = $q.defer()
		$http.put(urlBase + '/' + id,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Provider product association cannot be updated"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.deleteProductProvider = (id) ->
		def = $q.defer()
		$http.delete(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Provider product association cannot be deleted"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.searchProductProviders = (provider,product) ->
		def = $q.defer()
		$http.get(urlBase + '/search/' + provider + '/' + product).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Provider product associations cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.searchProductProvidersByProvider = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/search_by_provider/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Provider product associations searched by Provider cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.searchProductProvidersByProduct = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/search_by_product/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Provider product associations searched by Product cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	return dataFactory
]