sellApp.factory 'tags', ['$http','$q', ($http,$q) ->
	
	urlBase = '/api/tags'
	dataFactory = {}

	dataFactory.getTags = ->
		def = $q.defer()
		$http.get(urlBase).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Tags cannot be listed")
		)
		return def.promise

	dataFactory.getTag = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Tag cannot be found")
		)
		return def.promise

	dataFactory.createTag = (info) ->
		def = $q.defer()
		$http.post(urlBase,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Tag cannot be created")
		)
		return def.promise

	dataFactory.updateTag = (id,info) ->
		def = $q.defer()
		$http.put(urlBase + '/' + id,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Tag cannot be updated")
		)
		return def.promise

	dataFactory.deleteTag = (id) ->
		def = $q.defer()
		$http.delete(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Tag cannot be deleted")
		)
		return def.promise

	dataFactory.searchTag = (info) ->
		def = $q.defer()
		$http.get(urlBase + '/search/' + info).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Tags cannot be searched")
		)
		return def.promise

	return dataFactory
]