sellApp.factory 'combos', ['$http', ($http) ->
	
	urlBase = '/api/combos'
	dataFactory = {}

	dataFactory.getCombos = ->
		return $http.get(urlBase)

	dataFactory.getCombo = (id) ->
		return $http.get(urlBase + '/' + id)

	dataFactory.createCombo = (info) ->
		return $http.post(urlBase,info)

	dataFactory.updateCombo = (id) ->
		return $http.put(urlBase + '/' + id)

	dataFactory.deleteCombo = (id) ->
		return $http.delete(urlBase + '/' + id)

	dataFactory.getCombosBestsellers = ->
		return $http.get('/api/combos_bestsellers')

	dataFactory.searchCombos = (info) ->
		return $http.get(urlBase + '/search/' + info)

	return dataFactory
]