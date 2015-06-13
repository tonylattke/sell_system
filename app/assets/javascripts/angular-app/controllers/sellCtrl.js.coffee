angular.module('app.sellApp').controller("SellCtrl", [
  '$scope','$http',
  ($scope,$http)->

    # Initialize
    $scope.client_id = null
    $scope.client_dni = "-"
    $scope.client_name = "-"
    $scope.client_balance = 0
    $scope.total = 0
    $scope.client_cash_used = $scope.total

    $scope.top_articles = {
      'products' : []
      'combos' : []
    }

    $scope.articles_search = ""
    $scope.articles_founded = {
      'products' : []
      'combos' : []
    }

    # Set Bestsellers 
    $http.get('/api/combos_bestsellers').success((data) ->
      if data
        $scope.top_articles['combos'] = data
        for aux_combo in $scope.top_articles['combos']
          $http.get('/api/prices/search_by_combo/' + aux_combo['id']).success((data_prices) ->
            if data_prices
              aux_combo['price'] = data_prices[0]['value']
          )
    )
    $http.get('/api/products_bestsellers').success((data) ->
      if data
        $scope.top_articles['products'] = data.slice(0,5 - $scope.top_articles['combos'].length)
        for aux_product in $scope.top_articles['products']
          $http.get('/api/prices/search_by_product/' + aux_product['id']).success((data_prices) ->
            if data_prices
              aux_product['price'] = data_prices[0]['value']
          )
    )

    # Search Products or combos
    $scope.searchArticles = ->
      $scope.articles_founded = {
        'products' : []
        'combos' : []
      }
      $http.get('/api/combos/search/' + $scope.articles_search).success((data) ->
        if data
          $scope.articles_founded['combos'] = data
          for aux_combo in $scope.articles_founded['combos']
            $http.get('/api/prices/search_by_combo/' + aux_combo['id']).success((data_prices) ->
              if data_prices
                aux_combo['price'] = data_prices[0]['value']
            )
      )
      $http.get('/api/products/search/' + $scope.articles_search).success((data) ->
        if data
          $scope.articles_founded['products'] = data
          for aux_product in $scope.articles_founded['products']
            $http.get('/api/prices/search_by_product/' + aux_product['id']).success((data_prices) ->
              if data_prices
                aux_product['price'] = data_prices[0]['value']
            )
      )

    # Search Client
    $scope.searchClient = ->
      $scope.client_id = null
      $scope.client_dni = "-"
      $scope.client_name = "-"
      $scope.client_balance = 0
      $http.get('/api/clients/search/' + $scope.data_client).success((data) ->
        if data['dni']
          $scope.client_id = data['id']
          $scope.client_dni = data['dni']
          $scope.client_name = data['name']
          $scope.client_balance = data['balance']
      )

    # Sell
    $scope.sell = ->      
      # Client Exist
      if $scope.client_id
        console.log 'sell but not register'

      # New Client ?
      if $scope.new_client_dni and $scope.new_client_name
        $http.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
        $http({
            url: '/api/clients',
            method: "POST",
            data:  
              'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
              'client' : 
                'dni' : $scope.new_client_dni
                'name': $scope.new_client_name
                'balance' : $scope.client_cash_used
        }).then((response) ->
          console.log 'Client successfully registered'
        )
      else
        console.log 'Transaction dont realized'
    
])