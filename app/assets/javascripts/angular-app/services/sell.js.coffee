sellApp.factory 'sell', ['$http','$q', ($http,$q) ->
	
	dataFactory = {}

	dataFactory.searchArticlesByTag = (info) ->
		def = $q.defer()
		$http.get('/sell/search_articles_by_tag/' + info).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Articles cannot be searched by Tag")
		)
		return def.promise

	dataFactory.generateSell = (info) ->
		def = $q.defer()
		$http.post('/sell/generate_sell', info).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Sell transaction cannot be realized")
		)
		return def.promise

	return dataFactory	
]