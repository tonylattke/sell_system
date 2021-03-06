sellApp.factory 'product_tags', ['$http','$q', ($http,$q) ->
	
	urlBase = '/api/product_tags'
	dataFactory = {}

	dataFactory.getProductTags = ->
		def = $q.defer()
		$http.get(urlBase).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Tag product associations cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.getProductTag = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Tag product association cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.createProductTag = (info) ->
		def = $q.defer()
		$http.post(urlBase,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Tag cannot be associated with product"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.updateProductTag = (id,info) ->
		def = $q.defer()
		$http.put(urlBase + '/' + id,info).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Tag product association cannot be updated"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.deleteProductTag = (id) ->
		def = $q.defer()
		$http.delete(urlBase + '/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Tag product association cannot be deleted"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.searchProductTags = (tag,product) ->
		def = $q.defer()
		$http.get(urlBase + '/search/' + tag + '/' + product).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Tag product associations cannot be found"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.searchProductTagsByTag = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/search_by_tag/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Tag product associations searched by Tag cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	dataFactory.searchProductTagsByProduct = (id) ->
		def = $q.defer()
		$http.get(urlBase + '/search_by_product/' + id).success((data) ->
			def.resolve(data)
		).error((data) ->
			bad_news = {
				'error' : true
				'msg' : "Tag product associations searched by Product cannot be listed"
			}
			def.resolve(bad_news)
		)
		return def.promise

	return dataFactory
]