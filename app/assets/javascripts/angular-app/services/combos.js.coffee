sellApp.factory 'combos', ['$http','$q', ($http,$q) ->
	
	urlBase = '/api/combos'
	dataFactory = {}

	dataFactory.getCombos = ->
		def = $q.defer()
		$http.get(urlBase).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Combos cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.getCombo = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Combo cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.createCombo = (info) ->
		def = $q.defer()
		$http.post(urlBase,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Combo cannot be created"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.updateCombo = (id,info) ->
		def = $q.defer()
		$http.put(urlBase + '/' + id,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Combo data cannot be updated"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.deleteCombo = (id) ->
		def = $q.defer()
		$http.delete(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Combo cannot be deleted"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.getCombosBestsellers = ->
		def = $q.defer()
		$http.get('/api/combos_bestsellers').success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Best seller combos cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.searchCombos = (info) ->
		def = $q.defer()
		$http.get(urlBase + '/search/' + info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Combos cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	return dataFactory
]