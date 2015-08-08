angular.module('app.sellApp').controller("SellCtrl", [
  '$scope','$http','clients','combos','products','prices','bills','sell','sell_helpers', 'cash_transactions'
  ($scope,$http,clients,combos,products,prices,bills,sell,sell_helpers,cash_transactions)->

    ################################   Helpers  ###############################
    
    Initialize = ->
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

      $scope.data_client = ""

      $scope.new_client_dni = ""
      $scope.new_client_name = ""

      $scope.client = sell_helpers.rebootClient()

      $scope.retire_products = false

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
      #products.getProductsBestsellers().then((data) ->
      #  if data
      #    $scope.top_articles['products'] = data.slice(0,5 - $scope.top_articles['combos'].length)
      #    for aux_product in $scope.top_articles['products']
      #      aux_product['amount'] = 1
      #      aux_product['price'] = aux_product['prices'][0]
      #)

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

    validOperation = ->  
      aux_status = false

      # Cash transactions exists
      for c_t in $scope.cash_transactions_today
        if c_t.type_t == 'begin_day'
          aux_status = true
          break

      # Client Exist
      if $scope.client['id'] and ($scope.new_client_dni or $scope.new_client_name)
        return false
        alert 'New or old User?'

      if not $scope.client['id'] and (((not $scope.new_client_dni) and  $scope.new_client_name) or ($scope.new_client_dni and  (not $scope.new_client_name)))
        return false
        alert 'New User need DNI and Name!'

      return aux_status

    ############################ Buttons operations ###########################

    # Search Products or combos
    $scope.searchArticles = ->
      $scope.articles_founded = {
        'products' : []
        'combos' : []
      }
      if $scope.articles_search != ""
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
              if aux_product['stock_amount'] > 0
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
              exists = false
              i = 0
              for aux_item in $scope.articles_founded['combos']
                if aux_item['id'] == aux_combo['id']
                  exists = true
                  break
                i++
              if not exists
                aux_combo['amount'] = 1
                aux_combo['price'] = aux_combo['prices'][0]
                $scope.articles_founded['combos'].push(aux_combo)
        )

    # Search Client
    $scope.searchClient = ->
      $scope.client = sell_helpers.rebootClient()
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
      valid_operation = validOperation()

      if $scope.retire_products and valid_operation
        data = {
          'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        }

        data['cart'] = $scope.cart_articles

        sell.retireProducts(data).then((response) ->
          console.log 'Bill registered'
        )

        # Reboot    
        Initialize()
        setBestsellers()

      else

        if valid_operation
          data = {
            'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
          }

          data['client_new'] = false

          if $scope.client['id']
            data['client'] = {
              'id' : $scope.client['id']
            }
          else
            data['client'] = null

          # New Client ?
          if $scope.new_client_dni and $scope.new_client_name
            data['client_new'] = true
            data['client'] = {
              'dni' : $scope.new_client_dni
              'name': $scope.new_client_name
            }
          data['recharge_amount'] = $scope.recharge_amount
          data['use_from_account'] = $scope.use_from_account
          data['client_cash_used'] = $scope.client_cash_used

          data['cart'] = $scope.cart_articles

          sell.generateSell(data).then((response) ->
            console.log 'Bill registered'
          )

          # Reboot    
          Initialize()
          setBestsellers()
        else
          alert "You need start"
          window.location.href = "/manager"

    $scope.AddComboToCart = (item) ->
      # AddItemToCart
      exist = false
      for aux_item in $scope.cart_articles['combos']
        if aux_item['id'] == item['id']
          exist = true
          aux_item['amount'] = aux_item['amount'] + 1
          break
      if not exist
        $scope.cart_articles['combos'].push(item)

      UpdateTotal()
      $scope.cashUsed()

    $scope.AddProductToCart = (item) ->
      # AddItemToCart
      exist = false
      for aux_item in $scope.cart_articles['products']
        if aux_item['id'] == item['id']
          exist = true
          if aux_item['amount'] < aux_item['stock_amount']
            aux_item['amount'] = aux_item['amount'] + 1
          break
      if not exist
        $scope.cart_articles['products'].push(item)

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

    $scope.UpdateAmount = (product) ->
      product['amount'] = parseInt(product['amount'], 10);
      UpdateTotal()
      $scope.cashUsed()

    $scope.NewClientDataUpdate = ->
      $scope.cashUsed()

    $scope.cashUsed = ->
      $scope.use_from_account = 0
      $scope.recharge_amount = 0
      if $scope.client['id']
        if $scope.client_cash_used < $scope.total && ($scope.client['balance'] >= $scope.total - $scope.client_cash_used)
          $scope.use_from_account = $scope.total - $scope.client_cash_used
      if $scope.client['id'] || ($scope.new_client_dni.length > 0 && $scope.new_client_name.length > 0)
        if $scope.client_cash_used - $scope.total > 0
          $scope.recharge_amount = $scope.client_cash_used - $scope.total

    #################################### Initialize #####################################

    Initialize()
    setBestsellers()
    
    cash_transactions.getCashTransactionsToday().then((data) ->
      if data['error']
        alert data['msg']
      else
        $scope.cash_transactions_today = data
    )

])