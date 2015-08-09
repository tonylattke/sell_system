sellApp.factory 'manager', ['$http','$q', ($http,$q) ->
  
  dataFactory = {}
  urlBase = 'manager'

  dataFactory.getTransactionsFromTo = (from,to) ->
    def = $q.defer()
    $http.get(urlBase + '/transactions/from/' + from + '/to/' + to).success((data) ->
      def.resolve(data)
    ).error((data) ->
      bad_news = {
        'error' : true
        'msg' : "Transactions cannot be listed"
      }
      def.resolve(bad_news)
    )
    return def.promise

  dataFactory.getTransactionsToday = ->
    def = $q.defer()
    $http.get(urlBase + '/transactions/today').success((data) ->
      def.resolve(data)
    ).error((data) ->
      bad_news = {
        'error' : true
        'msg' : "Sale transactions cannot be listed"
      }
      def.resolve(bad_news)
    )
    return def.promise

  dataFactory.createCashTransactionBegin = (info) ->
    def = $q.defer()
    info['cash_transaction']['type_t'] = 'begin_day'
    info['cash_transaction']['description'] = 'Begin Day'
    $http.post('/api/cash_transactions',info).success((data) ->
      def.resolve(data)
    ).error((data) ->
      bad_news = {
        'error' : true
        'msg' : "Cash Transaction Begin cannot be created"
      }
      def.resolve(bad_news)
    )
    return def.promise

  dataFactory.createCashTransactionEnd = (info) ->
    def = $q.defer()
    info['cash_transaction']['type_t'] = 'adjust_day'
    info['cash_transaction']['description'] = 'Adjust'
    $http.post('/api/cash_transactions',info).success((data) ->
      def.resolve(data)
    ).error((data) ->
      bad_news = {
        'error' : true
        'msg' : "Cash Transaction Begin cannot be created"
      }
      def.resolve(bad_news)
    )
    return def.promise

  return dataFactory
]