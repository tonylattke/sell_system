sellApp.factory 'tags', ['$http', ($http) ->
	
	urlBase = '/api/tags'
	dataFactory = {}

	dataFactory.getTags = ->
		return $http.get(urlBase)

	dataFactory.getTag = (id) ->
		return $http.get(urlBase + '/' + id)

	dataFactory.createTag = (info) ->
		return $http.post(urlBase,info)

	dataFactory.updateTag = (id) ->
		return $http.put(urlBase + '/' + id)

	dataFactory.deleteTag = (id) ->
		return $http.delete(urlBase + '/' + id)

	dataFactory.searchTag = (id) ->
		return $http.get(urlBase + '/search/' + id)

	return dataFactory
]