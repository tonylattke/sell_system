#$(document).ready ->
#  $('#table_inventory').dataTable()

angular.module('app.sellApp').controller("InventoryCtrl", [
  '$scope','$http','products','combos','prices','tags','providers','inventory'
  ($scope,$http,products,combos,prices,tags,providers,inventory)->

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
        $scope.new_product = response
        $scope.articles['products'].push($scope.new_product)
        
        list_tags = $scope.new_product_form['tags'].split(",")
        list_providers = $scope.new_product_form['providers'].split(",")

        tags_saved = saveTags($scope.new_product,list_tags)
        providers_saved = saveProviders($scope.new_product,list_providers)

        createPriceToProduct()
        
        resetForm()
      )

    saveTags = (product,list_tags) ->
      tags_saved = []
      inventory.createTagsWithProduct({
        'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        'inventory':
          'tags': list_tags
          'product_id': product['id']
      }).then((response) ->
        tags_saved.push(response)
      )
      return tags_saved

    saveProviders = (product,list_providers) ->
      providers_saved = []
      inventory.createProvidersWithProduct({
        'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        'inventory':
          'providers': list_providers
          'product_id': product['id']
      }).then((response) ->
        providers_saved.push(response)
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
        $scope.new_product['price'] = response
      )

    ############################ Buttons operations ###########################

    $scope.CreateProduct = ->
      console.log 'Create Product'
      saveProduct()
      console.log 'Operation finished'

    $scope.DeleteProduct = (product) ->
      conf = confirm("Are you sure?")
      if conf
        inventory.deleteProductTags(product['id'])
        inventory.deleteProductProviders(product['id'])
        products.deleteProduct(product['id'])
        i = 0
        for aux_item in $scope.articles['products']
          if aux_item['id'] == product['id']
            $scope.articles['products'].splice(i, 1)
            break
          i++

    $scope.ActivateCombo = (combo) ->
      combos.updateCombo(combo['id'],{  
        'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        'combo' : 
          'id': combo['id']
          'active':true
      }).then((response) ->
        combo['active'] = true
      )
    
    $scope.ActivateProduct = (product) ->
      products.updateProduct(product['id'],{  
        'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        'product' : 
          'id': product['id']
          'active':true
      }).then((response) ->
        product['active'] = true
      )

    $scope.DeleteCombo = (combo) ->
      console.log 'Delete combo'

    $scope.AddInventory = ->
      console.log 'AddInventory'

    $scope.CreateCombo = ->
      console.log 'CreateCombo'

    $scope.ExportList = ->
      console.log 'ExportList'

    $scope.orderCriteria = (order) ->
      $scope.order_selected = order
    
    ###############################     Main     ##############################

    combos.getCombos().then((data) ->
      if data
        $scope.articles['combos'] = data
        for aux_combo in $scope.articles['combos']
          aux_combo['price'] = aux_combo['prices'][0]
    )

    products.getProducts().then((data) ->
      if data
        $scope.articles['products'] = data
        for aux_product in $scope.articles['products']
          aux_product['price'] = aux_product['prices'][0]
    )
    
])