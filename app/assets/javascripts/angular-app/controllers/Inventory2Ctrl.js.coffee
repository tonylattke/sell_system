angular.module('app.sellApp').controller("Inventory2Ctrl", [
  '$scope','$http','products','combos','prices','tags','providers','inventory','inventory_helpers','product_tags','product_providers'
  ($scope,$http,products,combos,prices,tags,providers,inventory,inventory_helpers,product_tags,product_providers)->

    ################################ Initialize ###############################

    $scope.inventory_mode = 'list'

    $scope.articles = {
      'products' : []
      'combos' : []
    }

    $scope.new_product = null

    $scope.edit_product = null

    $scope.details_product = null

    $scope.new_combo = null

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
      inventory.createTagsWithProduct({
        'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        'inventory':
          'tags': list_tags
          'product_id': product['id']
      }).then((response) ->
        console.log "Tag saved"
      )

    saveProviders = (product,list_providers) ->
      inventory.createProvidersWithProduct({
        'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        'inventory':
          'providers': list_providers
          'product_id': product['id']
      }).then((response) ->
        console.log "Provider saved"
      )

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

    createPriceToCombo = (value,combo_id) ->
      prices.createPrice({
        'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        'price' : 
          'type_option': 'c'
          'value' : value
          'combo_id' : combo_id
      }).then((response) ->
        $scope.new_combo['price'] = response
      )

    ############################ Buttons operations ###########################

    # List products & combos

    $scope.CreateProduct = ->
      console.log 'Create Product'
      saveProduct()
      $scope.inventory_mode = "list"
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
      alert 'AddInventory'

    $scope.CreateCombo = ->
      $scope.new_combo = {
        'name': "",
        'stock_amount': 0,
        'price': 0,
        'photo': 'https://dl.dropboxusercontent.com/u/6144287/man-profile.png'
      }
      $scope.inventory_mode = 'combo_create'

    $scope.ExportList = ->
      console.log 'ExportList'

    $scope.orderCriteria = (order) ->
      $scope.order_selected = order

    $scope.ViewDetailsProduct = (product) ->
      $scope.details_product = product
      
      inventory.getProductDetails(product['id']).then((data) ->
        if data
          $scope.details_product['tags'] = data['tags']
          $scope.details_product['providers'] = data['providers']
      )

      $("#myModal").modal('show');

    $scope.DeleteTagFromProduct = (tag) ->
      product_tags.deleteProductTag(tag['product_tag_id']).then((data) ->
        i = 0
        for aux_item in $scope.edit_product['tags']
          if aux_item['id'] == tag['id']
            $scope.edit_product['tags'].splice(i, 1)
            break
          i++
      )

    $scope.DeleteProviderFromProduct = (provider) ->
      product_providers.deleteProductProvider(provider['product_provider_id']).then((data) ->
        i = 0
        for aux_item in $scope.edit_product['providers']
          if aux_item['id'] == provider['id']
            $scope.edit_product['providers'].splice(i, 1)
            break
          i++
      )

    # Edit Product

    $scope.EditProduct = (product) ->
      $scope.edit_product = {
        'id'    : product['id'],
        'name'  : product['name'],
        'photo'  : product['photo'],
        'active'  : product['active'],
        'stock_amount': product['stock_amount'],
        'sales_amount': product['sales_amount'],
        'price' : {
          'id'    : product['price']['id'],
          'value'  : product['price']['value']
        }
      }
      $scope.edit_product_backup = product
      
      # Search Providers & Tags
      inventory.searchTagsByProduct(product['id']).then((data) ->
        if data
          $scope.edit_product['tags'] = data
      )
      inventory.searchProvidersByProduct(product['id']).then((data) ->
        if data
          $scope.edit_product['providers'] = data
      )
      $scope.inventory_mode = 'product_edit'

    $scope.EditProductCancel = ->
      aux_confirm = confirm("Are you sure?")
      if aux_confirm
        $scope.edit_product = inventory_helpers.resetForm()
        $scope.inventory_mode = 'list'

    $scope.EditProductSubmit = ->
      product_info = {
        'id': $scope.edit_product['id']
      }
      product_change = false
      
      product_info['name'] =  $scope.edit_product['name']
      if ($scope.edit_product['name'] != $scope.edit_product_backup['name'])
        product_change = true
      
      if $scope.edit_product['photo_new'] 
        product_info['photo'] = $scope.edit_product['photo_new'] 
        product_change = true
      
      if product_change
        products.updateProduct($scope.edit_product['id'],{  
          'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
          'product' : product_info
        }).then((response) ->
          if response['error']
            alert 'Update name or photo is not posible. Name is unique and phot must be valid'
        )
      
      if ($scope.edit_product['price']['value'] != $scope.edit_product_backup['price']['value'])
        prices.createPrice({
          'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
          'price' :
            'type_option' : 'p'
            'value' : $scope.edit_product['price']['value']
            'product_id' : $scope.edit_product['id']
        }).then((response) ->
          if response['error']
            alert 'Update price is not posible'
        )
      
      $scope.edit_product = inventory_helpers.resetForm()

      products.getProducts().then((data) ->
        if data
          $scope.articles['products'] = data
          for aux_product in $scope.articles['products']
            aux_product['price'] = aux_product['prices'][0]
      )

      $scope.inventory_mode = 'list'

    $scope.ValidateStockAmount = (product) ->
      product['stock_amount'] = parseInt(product['stock_amount'], 10);

    $scope.CreateComboSubmit = ->
      combos.createCombo({
        'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        'combo' : 
          'name': $scope.new_combo['name']
          'stock_amount' : $scope.new_combo['stock_amount']
          'photo' : 'https://dl.dropboxusercontent.com/u/6144287/man-profile.png'
      }).then((response) ->
        $scope.new_combo = response
        $scope.articles['combos'].push($scope.new_combo)
        
        # createComboProduct
        
        
        createPriceToCombo($scope.new_combo['price'],$scope.new_combo["id"])
        
        # resetForm

        $scope.inventory_mode = "list"
      )

    $scope.CreateComboCancel = ->
      aux_confirm = confirm("Are you sure?")
      if aux_confirm
        $scope.inventory_mode = "list"

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