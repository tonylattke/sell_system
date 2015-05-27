sellApp.factory 'Client', ['$resource', ($resource) ->
  $resource ('/clients/:id.json'), id: '@id', query: {method:'GET',isArray:true} 
]
