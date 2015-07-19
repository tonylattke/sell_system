sellApp.factory 'transactions_bills', ['$http','$q', ($http,$q) ->
	
	urlBase = '/transactions_bills'
	dataFactory = {}

	dataFactory.ConsultBill = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/consult_bill/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Bill cannot be consulted"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.DeleteBill = (id) ->
		def = $q.defer()
		$http.delete(urlBase + '/delete_bill/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Bill cannot be deleted"
			}
			def.resolve(bad_news)
		)
		return def.promise

	return dataFactory
]