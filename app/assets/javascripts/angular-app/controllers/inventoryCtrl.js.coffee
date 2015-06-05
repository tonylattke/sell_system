#$(document).ready ->
#  $('#table_inventory').dataTable()

angular.module('app.sellApp').controller("InventoryCtrl", [
  '$scope','$http',
  ($scope,$http)->

    $scope.articles = {
      'products' : []
      'combos' : []
    }

    $http.get('/api/products').success((data) ->
      if data
        $scope.articles['products'] = data
    )

    $scope.CreateProduct = ->
      console.log 'CreateProduct'
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
        aux_article = response['data']
        $scope.articles['products'].push(aux_article)
        tags = $scope.new_product_tags.split(",")
        providers = $scope.new_product_providers.split(",")
        
        # Reset form
        $scope.new_product_name = null
        $scope.new_product_photo = null
        $scope.new_product_price = null
        $scope.new_product_stock_amount = null
        $scope.new_product_tags = null
        $scope.new_product_providers = null
      )
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