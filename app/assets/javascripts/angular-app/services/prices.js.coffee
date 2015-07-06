sellApp.factory 'prices', ['$http','$q', ($http,$q) ->
	
	urlBase = '/api/prices'
	dataFactory = {}

	dataFactory.getPrices = ->
		def = $q.defer()
		$http.get(urlBase).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Prices cannot be listed")
		)
		return def.promise

	dataFactory.getPrice = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Price cannot be found")
		)
		return def.promise

	dataFactory.createPrice = (info) ->
		def = $q.defer()
		$http.post(urlBase,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Price cannot be created")
		)
		return def.promise

	dataFactory.updatePrice = (id,info) ->
		def = $q.defer()
		$http.put(urlBase + '/' + id,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Price cannot be updated")
		)
		return def.promise

	dataFactory.deletePrice = (id) ->
		def = $q.defer()
		$http.delete(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Price cannot be deleted")
		)
		return def.promise

	dataFactory.searchPriceByProduct = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/search_by_product/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Price searched by product cannot be found")
		)
		return def.promise

	dataFactory.searchPriceByCombo = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/search_by_combo/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Price searched by combo cannot be found")
		)
		return def.promise

	return dataFactory
]