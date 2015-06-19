#$(document).ready ->
#  $('#table_inventory').dataTable()

angular.module('app.sellApp').controller("InventoryCtrl", [
  '$scope','$http','products','combos','prices','tags','providers'
  ($scope,$http,products,combos,prices,tags,providers)->

    ################################ Initialize ###############################

    $scope.articles = {
      'products' : []
      'combos' : []
    }

    $scope.new_product = null

    ################################   Helpers  ###############################
    
    resetForm = ->
      $scope.new_product_form = {
        name : null
        photo : null
        price : null
        stock_amount : null
        tags : null
        providers : null
      }
      
    saveProduct = ->     
      products.createProduct({
        'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        'product' : 
          'name': $scope.new_product_form['name']
          'stock_amount' : $scope.new_product_form['stock_amount']
          'photo' : 'https://dl.dropboxusercontent.com/u/6144287/man-profile.png'
      }).then((response) ->
        $scope.new_product = response['data']
        $scope.articles['products'].push($scope.new_product)
        list_tags = $scope.new_product_form['tags'].split(",")
        list_providers = $scope.new_product_form['providers'].split(",")

        tags_saved = saveTags(list_tags)
        providers_saved = saveProviders(list_providers)

        createPriceToProduct()
        
        resetForm()
      )

    saveTags = (list_tags) ->
      tags_saved = []
      for tag_name in list_tags
        tags.createTag({
          'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
          'tag': 
            'name' : tag_name
        }).then((response) ->
          tags_saved.push(response['data'])
        )
      return tags_saved

    saveProviders = (list_providers) ->
      providers_saved = []
      for provider_name in list_providers
        providers.createProvider({
          'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
          'provider': 
            'name' : provider_name
        }).then((response) ->
          providers_saved.push(response['data'])
        )
      return providers_saved

    createPriceToProduct = ->
      prices.createPrice({
        'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        'price' : 
          'type_option': 'p'
          'value' : $scope.new_product_form['price']
          'product_id' : $scope.new_product["id"]
      }).then((response) ->
        $scope.new_product['price'] = response['data']['value']
      )

    ############################ Buttons operations ###########################

    $scope.CreateProduct = ->
      console.log 'CreateProduct'
      
      saveProduct()
      
      console.log 'Operation finished'

    $scope.AddInventory = ->
      console.log 'AddInventory'

    $scope.CreateCombo = ->
      console.log 'CreateCombo'

    $scope.ExportList = ->
      console.log 'ExportList'

    $scope.orderCriteria = (order) ->
      $scope.order_selected = order
    
    ###############################     Main     ##############################

    products.getProducts().success((data) ->
      if data
        $scope.articles['products'] = data
        for aux_product in $scope.articles['products']
          prices.searchPriceByProduct(aux_product['id']).success((data_prices) ->
            if data_prices
              aux_product['price'] = data_prices[0]['value']
          )
    )
    combos.getCombos().success((data) ->
      if data
        $scope.articles['combos'] = data
        for aux_combo in $scope.articles['combos']
          prices.searchPriceByCombo(aux_combo['id']).success((data_prices) ->
            if data_prices
              aux_combo['price'] = data_prices[0]['value']
          )
    )
])