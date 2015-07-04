sellApp.factory 'sell', ['$http','$q', ($http,$q) ->
	
	dataFactory = {}

	dataFactory.searchArticlesByTag = (info) ->
		def = $q.defer()
		$http.get('/sell/search_articles_by_tag/' + info).success((data) ->
			def.resolve(data)
		)
		return def.promise

	dataFactory.generateSell = (info) ->
		def = $q.defer()
		$http.post('/sell/generate_sell', info).success((data) ->
			def.resolve(data)
		)
		return def.promise

	return dataFactory	
]