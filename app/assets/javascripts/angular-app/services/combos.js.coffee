sellApp.factory 'combos', ['$http','$q', ($http,$q) ->
	
	urlBase = '/api/combos'
	dataFactory = {}

	dataFactory.getCombos = ->
		def = $q.defer()
		$http.get(urlBase).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Combo cannot be listed")
		)
		return def.promise

	dataFactory.getCombo = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Combo cannot be found")
		)
		return def.promise

	dataFactory.createCombo = (info) ->
		def = $q.defer()
		$http.post(urlBase,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Combo cannot be created")
		)
		return def.promise

	dataFactory.updateCombo = (id,info) ->
		def = $q.defer()
		$http.put(urlBase + '/' + id,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Combo cannot be updated")
		)
		return def.promise

	dataFactory.deleteCombo = (id) ->
		def = $q.defer()
		$http.delete(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Combo cannot be deleted")
		)
		return def.promise

	dataFactory.getCombosBestsellers = ->
		def = $q.defer()
		$http.get('/api/combos_bestsellers').success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Best seller combos cannot be found")
		)
		return def.promise

	dataFactory.searchCombos = (info) ->
		def = $q.defer()
		$http.get(urlBase + '/search/' + info).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Combos cannot be found")
		)
		return def.promise

	return dataFactory
]