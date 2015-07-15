sellApp.factory 'prices', ['$http','$q', ($http,$q) ->
	
	urlBase = '/api/prices'
	dataFactory = {}

	dataFactory.getPrices = ->
		def = $q.defer()
		$http.get(urlBase).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Prices cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.getPrice = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Price cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.createPrice = (info) ->
		def = $q.defer()
		$http.post(urlBase,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Price cannot be created"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.updatePrice = (id,info) ->
		def = $q.defer()
		$http.put(urlBase + '/' + id,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Price cannot be updated"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.deletePrice = (id) ->
		def = $q.defer()
		$http.delete(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Price cannot be deleted"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.searchPriceByProduct = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/search_by_product/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Price searched by product cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.searchPriceByCombo = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/search_by_combo/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Price searched by combo cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	return dataFactory
]