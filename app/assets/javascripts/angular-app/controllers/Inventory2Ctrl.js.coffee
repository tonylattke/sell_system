angular.module('app.sellApp').controller("Inventory2Ctrl", [
  '$scope','$http','products','combos','prices','tags','providers','inventory','inventory_helpers','product_tags','product_providers','combo_products'
  ($scope,$http,products,combos,prices,tags,providers,inventory,inventory_helpers,product_tags,product_providers,combo_products)->

    ################################ Initialize ###############################

    $scope.inventory_mode = 'list'

    $scope.articles = {
      'products' : []
      'combos' : []
    }

    $scope.search_products = ""

    $scope.founded_products = []

    # Product variables for operations

    $scope.new_product = null

    $scope.edit_product = null

    $scope.details_product = null

    # Combo variables for operations

    $scope.new_combo = null

    $scope.edit_combo = null

    $scope.details_combo = null


    ################################   Helpers  ###############################

    getCombosInit = ->
      combos.getCombos().then((data) ->
        if data
          $scope.articles['combos'] = data
          for aux_combo in $scope.articles['combos']
            aux_combo['price'] = aux_combo['prices'][0]
      )

    getProductsInit = ->
      products.getProducts().then((data) ->
        if data
          $scope.articles['products'] = data
          for aux_product in $scope.articles['products']
            aux_product['price'] = aux_product['prices'][0]
      )

    createComboProducts = (combo_id,products) ->
      for product in products
        combo_products.createComboProduct({
          'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
          'combo_product' : 
            'combo_id': combo_id
            'product_id': product['id']
            'product_amount': product['amount']
        }).then((response) ->
          console.log response
        )

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
        'products':[]
      }
      $scope.search_products = ""
      $scope.founded_products = []
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

      $("#myModalProduct").modal('show')
      return $scope.details_product

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

      getProductsInit()

      $scope.inventory_mode = 'list'

    $scope.ValidateStockAmount = (product) ->
      product['stock_amount'] = parseInt(product['stock_amount'], 10)

    $scope.CreateComboSubmit = ->
      combos.createCombo({
        'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        'combo' : 
          'name': $scope.new_combo['name']
          'stock_amount' : $scope.new_combo['stock_amount']
          'photo' : 'https://dl.dropboxusercontent.com/u/6144287/man-profile.png'
      }).then((response) ->
        aux_new_combo = response        
        $scope.articles['combos'].push(aux_new_combo)
        
        createComboProducts(aux_new_combo['id'],$scope.new_combo['products'])

        createPriceToCombo(aux_new_combo['price'],aux_new_combo["id"])

        getCombosInit()

        $scope.inventory_mode = "list"
      )

    $scope.CreateComboCancel = ->
      aux_confirm = confirm("Are you sure?")
      if aux_confirm
        $scope.inventory_mode = "list"

    $scope.SearchProducts = ->
      $scope.founded_products = []
      $scope.search_products = "f"
      products.searchProducts($scope.search_products).then((data) ->
        if data
          $scope.founded_products = data
          for aux_product in $scope.founded_products
            aux_product['amount'] = 1
            aux_product['price'] = aux_product['prices'][0]
      )

    $scope.AddProductToCombo = (product) ->
      exist = false
      for aux_item in $scope.new_combo['products']
        if aux_item['id'] == product['id']
          exist = true
          if aux_item['amount'] < aux_item['stock_amount']
            aux_item['amount'] = aux_item['amount'] + 1
          break
      if not exist
        $scope.new_combo['products'].push(product)

    $scope.UpdateAmountProduct = (product) ->
      product['amount'] = parseInt(product['amount'], 10)

    $scope.DeleteProductOfCombo = (product) ->
      product['amount'] = 1
      i = 0
      for aux_item in $scope.new_combo['products']
        if aux_item['id'] == product['id']
          $scope.new_combo['products'].splice(i, 1)
          break
        i++

    $scope.ViewDetailsCombo = (combo) ->
      $scope.details_combo = combo
      inventory.getComboDetails(combo['id']).then((data) ->
        if data
          $scope.details_combo['products'] = data
      )
      $("#myModalCombo").modal('show')
      return $scope.details_combo

    $scope.EditCombo = (combo) ->
      $scope.edit_combo = {
        'id'    : combo['id'],
        'name'  : combo['name'],
        'photo'  : combo['photo'],
        'active'  : combo['active'],
        'stock_amount': combo['stock_amount'],
        'sales_amount': combo['sales_amount'],
        'price' : {
          'id'    : combo['price']['id'],
          'value'  : combo['price']['value']
        }
      }
      $scope.edit_combo_backup = combo
      
      $scope.inventory_mode = 'combo_edit'




















    $scope.EditComboCancel = ->
      aux_confirm = confirm("Are you sure?")
      if aux_confirm
        $scope.inventory_mode = 'list'

    $scope.EditComboSubmit = ->
      combo_info = {
        'id': $scope.edit_combo['id']
      }
      combo_change = false
      
      combo_info['name'] =  $scope.edit_combo['name']
      if ($scope.edit_combo['name'] != $scope.edit_combo_backup['name'])
        combo_change = true
      
      if $scope.edit_combo['photo_new'] 
        combo_info['photo'] = $scope.edit_combo['photo_new'] 
        combo_change = true
      
      if combo_change
        combos.updateCombo($scope.edit_combo['id'],{  
          'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
          'combo' : combo_info
        }).then((response) ->
          if response['error']
            alert 'Update name or photo is not posible. Name is unique and photo must be valid'
        )
      
      if ($scope.edit_combo['price']['value'] != $scope.edit_combo_backup['price']['value'])
        prices.createPrice({
          'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
          'price' :
            'type_option' : 'c'
            'value' : $scope.edit_combo['price']['value']
            'combo_id' : $scope.edit_combo['id']
        }).then((response) ->
          if response['error']
            alert 'Update price is not posible'
        )
      

      getCombosInit()

      $scope.inventory_mode = 'list'


    ###############################     Main     ##############################

    getCombosInit()
    getProductsInit()

])