#$(document).ready ->
#  $('#table_inventory').dataTable()

angular.module('app.sellApp').controller("InventoryCtrl", [
  '$scope','$http','products','combos','prices','tags','providers','inventory','inventory_helpers'
  ($scope,$http,products,combos,prices,tags,providers,inventory,inventory_helpers)->

    ################################ Initialize ###############################

    $scope.inventory_mode = 'list'

    $scope.articles = {
      'products' : []
      'combos' : []
    }

    $scope.new_product = null

    $scope.edit_product = null

    ################################   Helpers  ###############################
      
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

        saveTags($scope.new_product,list_tags)
        saveProviders($scope.new_product,list_providers)

        createPriceToProduct($scope.new_product_form['price'],$scope.new_product["id"])
        
        $scope.new_product_form = inventory_helpers.resetForm()
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
      # TODO

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
      # TODO

    createPriceToProduct = (value,product_id) ->
      prices.createPrice({
        'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        'price' : 
          'type_option': 'p'
          'value' : value
          'product_id' : product_id
      }).then((response) ->
        $scope.new_product['price'] = response
      )      

    ############################ Buttons operations ###########################

    # List products & combos

    $scope.CreateProduct = ->
      console.log 'Create Product'
      saveProduct()
      console.log 'Operation finished'

    $scope.DeleteProduct = (product) ->
      console.log 'Delete product'
      # Review
      # conf = confirm("Are you sure?")
      if false
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
      inventory_helpers.updateActiveInCombo(combo,true)
    
    $scope.DeactivateCombo = (combo) ->
      inventory_helpers.updateActiveInCombo(combo,false)

    $scope.ActivateProduct = (product) ->
      inventory_helpers.updateActiveInProduct(product,true)

    $scope.DeactivateProduct = (product) ->
      inventory_helpers.updateActiveInProduct(product,false)

    $scope.AddInventory = ->
      console.log 'AddInventory'

    $scope.CreateCombo = ->
      console.log 'CreateCombo'

    $scope.ExportList = ->
      console.log 'ExportList'

    $scope.orderCriteria = (order) ->
      $scope.order_selected = order

    $scope.EditProduct = (product) ->
      $scope.edit_product = product
      # Search Providers & Tags
      $scope.inventory_mode = 'product_edit'

    # Edit Product

    $scope.EditProductCancel = ->
      $scope.edit_product = inventory_helpers.resetForm()
      $scope.inventory_mode = 'list'

    $scope.EditProductSubmit = ->
      products.updateProduct($scope.edit_product['id'],{  
        'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        'product' :
          'id': $scope.edit_product['id']
          'name': $scope.edit_product['name']
      }).then((response) ->
        for aux_product in $scope.articles['products']
          if aux_product['id'] == $scope.edit_product['id']
            aux_product = $scope.edit_product
            break
        $scope.edit_product = inventory_helpers.resetForm()
      )
      $scope.inventory_mode = 'list'

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