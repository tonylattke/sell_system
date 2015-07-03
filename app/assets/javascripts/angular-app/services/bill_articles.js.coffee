sellApp.factory 'bill_articles', ['$http','$q', ($http,$q) ->
	
	urlBase = '/api/bill_articles'
	dataFactory = {}

	dataFactory.getBillArticles = ->
		def = $q.defer()
		$http.get(urlBase).success((data) ->
			def.resolve(data)
		)
		return def.promise

	dataFactory.getBillArticle = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		)
		return def.promise

	dataFactory.createBillArticle = (info) ->
		def = $q.defer()
		$http.post(urlBase,info).success((data) ->
			def.resolve(data)
		)
		return def.promise

	dataFactory.updateBillArticle = (id,info) ->
		def = $q.defer()
		$http.put(urlBase + '/' + id,info).success((data) ->
			def.resolve(data)
		)
		return def.promise

	dataFactory.deleteBillArticle = (id) ->
		def = $q.defer()
		$http.delete(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		)
		return def.promise

	return dataFactory
]