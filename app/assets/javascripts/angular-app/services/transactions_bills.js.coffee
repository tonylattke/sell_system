sellApp.factory 'transactions_bills', ['$http','$q', ($http,$q) ->
	
	dataFactory = {}

	dataFactory.ConsultBill = (id) ->
		def = $q.defer()
		$http.get('/transactions_bills/consult_bill/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Bill cannot be consulted"
			}
			def.resolve(bad_news)
		)
		return def.promise

	return dataFactory
]