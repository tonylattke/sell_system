sellApp.factory 'bills', ['$http','$q', ($http,$q) ->
	
	urlBase = '/api/bills'
	dataFactory = {}

	dataFactory.getBills = ->
		def = $q.defer()
		$http.get(urlBase).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Bills cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.getBill = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Bill cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.createBill = (info) ->
		def = $q.defer()
		$http.post(urlBase,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Bill cannot be created"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.updateBill = (id,info) ->
		def = $q.defer()
		$http.put(urlBase + '/' + id,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Bill cannot be updated"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.deleteBill = (id) ->
		def = $q.defer()
		$http.delete(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Bill cannot be deleted"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.getBillsToday = ->
		def = $q.defer()
		$http.get(urlBase + '/today').success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Bills of today cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.getBillsFromTo = (from,to) ->
		def = $q.defer()
		$http.get(urlBase + '/from/' + from + '/to/' + to).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Bills in a range cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	return dataFactory
]