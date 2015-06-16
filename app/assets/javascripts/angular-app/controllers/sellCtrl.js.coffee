angular.module('app.sellApp').controller("SellCtrl", [
  '$scope','$http', 'clients'
  ($scope,$http,clients)->

    $scope.dato = clients
    $scope.testclients = []

    getClients = ->
      $scope.dato.getClients().success((data) ->
        $scope.testclients = data
      ).error(
        console.log 'asd error'
      )
    
    # Initialize
    $scope.client = {
      id : null
      dni : "-"
      name : "-"
      balance : 0
    }
    $scope.total = 0
    $scope.client_cash_used = $scope.total
    $scope.articles_search = ""

    $scope.top_articles = {
      'products' : []
      'combos' : []
    }

    $scope.articles_founded = {
      'products' : []
      'combos' : []
    }

    $scope.cart_articles = {
      'products' : []
      'combos' : []
    }

    # Set Bestsellers 
    $http.get('/api/combos_bestsellers').success((data) ->
      if data
        $scope.top_articles['combos'] = data
        for aux_combo in $scope.top_articles['combos']
          aux_combo['amount'] = 1
          $http.get('/api/prices/search_by_combo/' + aux_combo['id']).success((data_prices) ->
            if data_prices
              aux_combo['price'] = data_prices[0]['value']
          )
    )
    $http.get('/api/products_bestsellers').success((data) ->
      if data
        $scope.top_articles['products'] = data.slice(0,5 - $scope.top_articles['combos'].length)
        for aux_product in $scope.top_articles['products']
          aux_product['amount'] = 1
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
            aux_combo['amount'] = 1
            $http.get('/api/prices/search_by_combo/' + aux_combo['id']).success((data_prices) ->
              if data_prices
                aux_combo['price'] = data_prices[0]['value']
            )
      )
      $http.get('/api/products/search/' + $scope.articles_search).success((data) ->
        if data
          $scope.articles_founded['products'] = data
          for aux_product in $scope.articles_founded['products']
            aux_product['amount'] = 1
            $http.get('/api/prices/search_by_product/' + aux_product['id']).success((data_prices) ->
              if data_prices
                aux_product['price'] = data_prices[0]['value']
            )
      )

    # Search Client
    $scope.searchClient = ->
      $scope.client = {
        id : null
        dni : "-"
        name : "-"
        balance : 0
      }
      $http.get('/api/clients/search/' + $scope.data_client).success((data) ->
        if data['dni']
          $scope.client = {
            id : data['id']
            dni : data['dni']
            name : data['name']
            balance : data['balance']
          }
      )

    # Sell
    $scope.sell = ->      
      # Client Exist
      if $scope.client['id']
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
    
    $scope.AddComboToCart = (item) ->
      exist = false
      for aux_combo in $scope.cart_articles['combos']
        if aux_combo['id'] == item['id']
          exist = true
          aux_combo['amount'] = aux_combo['amount'] + 1
          break
      if not exist
        $scope.cart_articles['combos'].push(item)

    $scope.AddProductToCart = (item) ->
      exist = false
      for aux_product in $scope.cart_articles['products']
        if aux_product['id'] == item['id']
          exist = true
          aux_product['amount'] = aux_product['amount'] + 1
          break
      if not exist
        $scope.cart_articles['products'].push(item)
])