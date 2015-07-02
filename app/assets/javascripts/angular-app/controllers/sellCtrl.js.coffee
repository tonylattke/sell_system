angular.module('app.sellApp').controller("SellCtrl", [
  '$scope','$http','clients','combos','products','prices','sell'
  ($scope,$http,clients,combos,products,prices,sell)->

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

    $scope.use_from_account = 0
    $scope.recharge_amount = 0
    ################################   Helpers  ###############################

    setBestsellers = ->
      # Combos
      combos.getCombosBestsellers().then((data) ->
        if data
          $scope.top_articles['combos'] = data
          for aux_combo in $scope.top_articles['combos']
            aux_combo['amount'] = 1
            aux_combo['price'] = aux_combo['prices'][0]
      )
      # Products
      products.getProductsBestsellers().then((data) ->
        if data
          $scope.top_articles['products'] = data.slice(0,5 - $scope.top_articles['combos'].length)
          for aux_product in $scope.top_articles['products']
            aux_product['amount'] = 1
            aux_product['price'] = aux_product['prices'][0]
      )
    
    AddItemToCart = (item,list) ->
      exist = false
      for aux_item in list
        if aux_item['id'] == item['id']
          exist = true
          if aux_item['amount'] < aux_item['stock_amount']
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

    UpdateTotal = ->
      $scope.total = 0
      for combo in $scope.cart_articles['combos']
        $scope.total += combo['amount']*combo['price']['value']
      for product in $scope.cart_articles['products']
        $scope.total += product['amount']*product['price']['value']
      $scope.client_cash_used = $scope.total

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
            aux_combo['price'] = aux_combo['prices'][0]
      )
      # Products
      products.searchProducts($scope.articles_search).then((data) ->
        if data
          $scope.articles_founded['products'] = data
          for aux_product in $scope.articles_founded['products']
            aux_product['amount'] = 1
            aux_product['price'] = aux_product['prices'][0]
      )
      # Search by Tag
      sell.searchArticlesByTag($scope.articles_search).then((data) ->
        if data
          for aux_product in data['products']
            exists = false
            i = 0
            for aux_item in $scope.articles_founded['products']
              if aux_item['id'] == aux_product['id']
                exists = true
                break
              i++
            if not exists
              aux_product['amount'] = 1
              aux_product['price'] = aux_product['prices'][0]
              $scope.articles_founded['products'].push(aux_product)
          for aux_combo in data['combos']
            console.log 'TODO add combo'
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
          $scope.cashUsed()
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
      UpdateTotal()
      $scope.cashUsed()

    $scope.AddProductToCart = (item) ->
      AddItemToCart(item,$scope.cart_articles['products'])
      UpdateTotal()
      $scope.cashUsed()

    $scope.DeleteComboOfCart = (item) ->
      DeleteItemOfCart(item,$scope.cart_articles['combos'])
      UpdateTotal()
      $scope.cashUsed()

    $scope.DeleteProductOfCart = (item) ->
      DeleteItemOfCart(item,$scope.cart_articles['products'])
      UpdateTotal()
      $scope.cashUsed()

    $scope.UpdateAmount = ->
      UpdateTotal()
      $scope.cashUsed()

    $scope.cashUsed = ->
      $scope.use_from_account = 0
      $scope.recharge_amount = 0
      if $scope.client['id']
        if $scope.client_cash_used < $scope.total && ($scope.client['balance'] >= $scope.total - $scope.client_cash_used)
          $scope.use_from_account = $scope.total - $scope.client_cash_used
        if $scope.client_cash_used - $scope.total > 0
          $scope.recharge_amount = $scope.client_cash_used - $scope.total

    setBestsellers()
    
])