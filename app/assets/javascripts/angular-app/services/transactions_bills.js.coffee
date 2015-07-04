sellApp.factory 'transactions_bills', ['$http','$q', ($http,$q) ->
	
	dataFactory = {}

	dataFactory.ConsultBill = (id) ->
		def = $q.defer()
		$http.get('/transactions_bills/consult_bill/' + id).success((data) ->
			def.resolve(data)
		)
		return def.promise

	return dataFactory
]