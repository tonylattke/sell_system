sellApp.factory 'bills', ['$http','$q', ($http,$q) ->
	
	urlBase = '/api/bills'
	dataFactory = {}

	dataFactory.getBills = ->
		def = $q.defer()
		$http.get(urlBase).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Bills cannot be listed")
		)
		return def.promise

	dataFactory.getBill = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Bill cannot be found")
		)
		return def.promise

	dataFactory.createBill = (info) ->
		def = $q.defer()
		$http.post(urlBase,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Bill cannot be created")
		)
		return def.promise

	dataFactory.updateBill = (id,info) ->
		def = $q.defer()
		$http.put(urlBase + '/' + id,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Bill cannot be updated")
		)
		return def.promise

	dataFactory.deleteBill = (id) ->
		def = $q.defer()
		$http.delete(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Bill cannot be deleted")
		)
		return def.promise

	dataFactory.getBillsToday = ->
		def = $q.defer()
		$http.get(urlBase + '/today').success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Bills of today cannot be listed")
		)
		return def.promise

	dataFactory.getBillsFromTo = (from,to) ->
		def = $q.defer()
		$http.get(urlBase + '/from/' + from + '/to/' + to).success((data) ->
			def.resolve(data)
		).error((data) ->
			alert("No conection - Bills in a range cannot be listed")
		)
		return def.promise

	return dataFactory
]