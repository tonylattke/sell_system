sellApp.factory 'cash_transactions', ['$http','$q', ($http,$q) ->
	
	urlBase = '/api/cash_transactions'
	dataFactory = {}

	dataFactory.getCashTransactions = ->
		def = $q.defer()
		$http.get(urlBase).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Cash Transactions cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.getCashTransaction = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Cash Transaction cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.createCashTransaction = (info) ->
		def = $q.defer()
		$http.post(urlBase,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Cash Transaction cannot be created"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.updateCashTransaction = (id,info) ->
		def = $q.defer()
		$http.put(urlBase + '/' + id,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Cash Transaction cannot be updated"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.deleteCashTransaction = (id) ->
		def = $q.defer()
		$http.delete(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Cash Transaction cannot be deleted"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.getCashTransactionsToday = ->
		def = $q.defer()
		$http.get(urlBase + '/today').success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Cash Transactions of today cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.getCashTransactionsFromTo = (from,to) ->
		def = $q.defer()
		$http.get(urlBase + '/from/' + from + '/to/' + to).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Cash Transactions in a range cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	return dataFactory
]