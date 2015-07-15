sellApp.factory 'tags', ['$http','$q', ($http,$q) ->
	
	urlBase = '/api/tags'
	dataFactory = {}

	dataFactory.getTags = ->
		def = $q.defer()
		$http.get(urlBase).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Tags cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.getTag = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Tag cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.createTag = (info) ->
		def = $q.defer()
		$http.post(urlBase,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Tag cannot be created"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.updateTag = (id,info) ->
		def = $q.defer()
		$http.put(urlBase + '/' + id,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Tag cannot be updated"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.deleteTag = (id) ->
		def = $q.defer()
		$http.delete(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Tag cannot be deleted"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.searchTag = (info) ->
		def = $q.defer()
		$http.get(urlBase + '/search/' + info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Tags cannot be searched"
			}
			def.resolve(bad_news)
		)
		return def.promise

	return dataFactory
]