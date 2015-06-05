#$(document).ready ->
#  $('#table_inventory').dataTable()

angular.module('app.sellApp').controller("InventoryCtrl", [
  '$scope','$http',
  ($scope,$http)->

    ################################ Initialize ###############################
    $scope.articles = {
      'products' : []
      'combos' : []
    }

    $http.get('/api/products').success((data) ->
      if data
        $scope.articles['products'] = data
    )

    $scope.new_product = null

    ################################   Helpers  ###############################
    resetForm = ->
      $scope.new_product_name = null
      $scope.new_product_photo = null
      $scope.new_product_price = null
      $scope.new_product_stock_amount = null
      $scope.new_product_tags = null
      $scope.new_product_providers = null

    saveProduct = ->
      $http.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
      $http({
          url: '/api/products',
          method: "POST",
          data:  
            'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
            'product' : 
              'name': $scope.new_product_name
              'stock_amount' : $scope.new_product_stock_amount
              'photo' : 'https://dl.dropboxusercontent.com/u/6144287/man-profile.png'
      }).then((response) ->
        $scope.new_product = response['data']
      )

    saveTags = (tags) ->
      tags_saved = []
      for tag_name in tags
          $http.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
          $http({
              url: '/api/tags',
              method: "POST",
              data:  
                'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
                'tag': 
                  'name' : tag_name
          }).then((response) ->
            tags_saved.push(response['data'])
          )
      return tags_saved

    saveProviders = (providers) ->
      providers_saved = []
      for provider_name in providers
          $http.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
          $http({
              url: '/api/providers',
              method: "POST",
              data:  
                'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
                'provider': 
                  'name' : provider_name
          }).then((response) ->
            providers_saved.push(response['data'])
          )
      return providers_saved

    ############################ Buttons operations ###########################

    $scope.CreateProduct = ->
      console.log 'CreateProduct'
      
      saveProduct()
      $scope.articles['products'].push($scope.new_product)
      
      tags = $scope.new_product_tags.split(",")
      providers = $scope.new_product_providers.split(",")

      tags_saved = saveTags(tags)
      providers_saved = saveProviders(providers)
      
      resetForm()
      
      console.log 'Operation finished'

    $scope.AddInventory = ->
      console.log 'AddInventory'

    $scope.CreateCombo = ->
      console.log 'CreateCombo'

    $scope.ExportList = ->
      console.log 'ExportList'

    $scope.orderCriteria = (order) ->
      $scope.order_selected = order
    
])