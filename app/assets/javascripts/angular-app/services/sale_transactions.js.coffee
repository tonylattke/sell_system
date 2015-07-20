sellApp.factory 'sale_transactions', ['$http','$q', ($http,$q) ->
	
	urlBase = '/api/sale_transactions'
	dataFactory = {}

	dataFactory.getSaleTransactions = ->
		def = $q.defer()
		$http.get(urlBase).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Sale Transactions cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.getSaleTransaction = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Sale Transaction cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.createSaleTransaction = (info) ->
		def = $q.defer()
		$http.post(urlBase,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Sale Transaction cannot be created"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.updateSaleTransaction = (id,info) ->
		def = $q.defer()
		$http.put(urlBase + '/' + id,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Sale Transaction cannot be updated"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.deleteSaleTransaction = (id) ->
		def = $q.defer()
		$http.delete(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Sale Transaction cannot be deleted"
			}
			def.resolve(bad_news)
		)
		return def.promise

	return dataFactory
]