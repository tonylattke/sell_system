sellApp.factory 'combo_products', ['$http','$q', ($http,$q) ->
	
	urlBase = '/api/combo_products'
	dataFactory = {}

	dataFactory.getComboProducts = ->
		def = $q.defer()
		$http.get(urlBase).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Combo product associations cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.getComboProduct = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Combo product association cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.createComboProduct = (info) ->
		def = $q.defer()
		$http.post(urlBase,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Combo product association cannot be created"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.updateComboProduct = (id,info) ->
		def = $q.defer()
		$http.put(urlBase + '/' + id,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Combo product association cannot be updated"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.deleteComboProduct = (id) ->
		def = $q.defer()
		$http.delete(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Combo product association cannot be deleted"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.searchComboProducts = (combo,product) ->
		def = $q.defer()
		$http.get(urlBase + '/search/' + combo + '/' + product).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Combo product associations cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.searchComboProductsByCombo = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/search_by_combo/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Combo product association cannot be found by combo"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.searchComboProductsByProduct = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/search_by_product/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Combo product association cannot be found by product"
			}
			def.resolve(bad_news)
		)
		return def.promise

	return dataFactory
]