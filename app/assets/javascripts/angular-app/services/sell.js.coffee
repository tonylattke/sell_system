sellApp.factory 'sell', ['$http','$q', ($http,$q) ->
	
	dataFactory = {}

	dataFactory.searchArticlesByTag = (info) ->
		def = $q.defer()
		$http.get('/sell/search_articles_by_tag/' + info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Articles cannot be searched by Tag"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.generateSell = (info) ->
		def = $q.defer()
		$http.post('/sell/generate_sell', info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Sell transaction cannot be realized"
			}
			def.resolve(bad_news)
		)
		return def.promise

	return dataFactory	
]