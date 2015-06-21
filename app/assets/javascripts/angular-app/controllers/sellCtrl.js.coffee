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
    
    AddItemToCart = (item,list) ->
      exist = false
      for aux_item in list
        if aux_item['id'] == item['id']
          exist = true
          aux_item['amount'] = aux_item['amount'] + 1
          break
      if not exist
        list.push(item)

    DeleteItemOfCart = (item,list) ->
      item['amount'] = 1
      i = 0
      for aux_item in list
        if aux_item['id'] == item['id']
          list.splice(i, 1)
          break
        i++

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
      AddItemToCart(item,$scope.cart_articles['combos'])

    $scope.AddProductToCart = (item) ->
      AddItemToCart(item,$scope.cart_articles['products'])

    $scope.DeleteComboOfCart = (item) ->
      DeleteItemOfCart(item,$scope.cart_articles['combos'])

    $scope.DeleteProductOfCart = (item) ->
      DeleteItemOfCart(item,$scope.cart_articles['products'])

    $scope.ItemAmountControl = (item) ->
      if item['amount'] < 1
        item['amount'] = 1
      if item['amount'] > item['stock_amount']
        item['amount'] = item['stock_amount']

    setBestsellers()
    
])