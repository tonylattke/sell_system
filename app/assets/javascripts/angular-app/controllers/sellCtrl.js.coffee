angular.module('app.sellApp').controller("SellCtrl", [
  '$scope','$http','clients','combos','products','prices'
  ($scope,$http,clients,combos,products,prices)->

    #################################### Initialize #####################################

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

    ################################   Helpers  ###############################

    setBestsellers = ->
      # Combos
      combos.getCombosBestsellers().then((data) ->
        if data
          $scope.top_articles['combos'] = data
          for aux_combo in $scope.top_articles['combos']
            aux_combo['amount'] = 1
            aux_combo['price'] = aux_combo['prices'][0]['value']
      )
      # Products
      products.getProductsBestsellers().then((data) ->
        if data
          $scope.top_articles['products'] = data.slice(0,5 - $scope.top_articles['combos'].length)
          for aux_product in $scope.top_articles['products']
            aux_product['amount'] = 1
            aux_product['price'] = aux_product['prices'][0]['value']
      )
      

    ############################ Buttons operations ###########################

    # Search Products or combos
    $scope.searchArticles = ->
      $scope.articles_founded = {
        'products' : []
        'combos' : []
      }
      # Combos
      combos.searchCombos($scope.articles_search).then((data) ->
        if data
          $scope.articles_founded['combos'] = data
          for aux_combo in $scope.articles_founded['combos']
            aux_combo['amount'] = 1
            aux_combo['price'] = aux_combo['prices'][0]['value']
      )
      # Products
      products.searchProducts($scope.articles_search).then((data) ->
        if data
          $scope.articles_founded['products'] = data
          for aux_product in $scope.articles_founded['products']
            aux_product['amount'] = 1
            aux_product['price'] = aux_product['prices'][0]['value']
      )

    # Search Client
    $scope.searchClient = ->
      $scope.client = {
        id : null
        dni : "-"
        name : "-"
        balance : 0
      }
      clients.searchClients($scope.data_client).then((data) ->
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
        clients.createClient({
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

    setBestsellers()
    
])