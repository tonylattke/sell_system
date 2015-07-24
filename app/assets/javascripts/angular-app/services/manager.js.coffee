sellApp.factory 'manager', ['$http','$q', ($http,$q) ->
	
	dataFactory = {}
	urlBase = 'manager'

	dataFactory.getSaleTransactionsFromTo = (from,to) ->
		def = $q.defer()
		$http.get(urlBase + '/sale_transactions/from/' + from + '/to/' + to).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Sale transactions cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.getSaleTransactionsToday = ->
		def = $q.defer()
		$http.get(urlBase + '/sale_transactions/today').success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Sale transactions cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	return dataFactory
]