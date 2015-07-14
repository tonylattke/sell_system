sellApp.factory 'products', ['$http','$q', ($http,$q) ->
	
	urlBase = '/api/products'
	dataFactory = {}

	dataFactory.getProducts = ->
		def = $q.defer()
		$http.get(urlBase).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Products cannot be listed")
		)
		return def.promise

	dataFactory.getProduct = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Product cannot be found")
		)
		return def.promise

	dataFactory.createProduct = (info) ->
		def = $q.defer()
		$http.post(urlBase,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Product cannot be created")
		)
		return def.promise

	dataFactory.updateProduct = (id,info) ->
		def = $q.defer()
		$http.put(urlBase + '/' + id,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.deleteProduct = (id) ->
		def = $q.defer()
		$http.delete(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Product cannot be deleted")
		)
		return def.promise

	dataFactory.getProductsBestsellers = ->
		def = $q.defer()
		$http.get('/api/products_bestsellers').success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Best seller products cannot be found")
		)
		return def.promise

	dataFactory.searchProducts = (info) ->
		def = $q.defer()
		$http.get(urlBase + '/search/' + info).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Products cannot be searched")
		)
		return def.promise

	return dataFactory
]