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

    $scope.AddInventory = ->
      console.log 'AddInventory'

    $scope.CreateCombo = ->
      console.log 'CreateCombo'

    $scope.ExportList = ->
      console.log 'ExportList'

    $scope.orderCriteria = (order) ->
      $scope.order_selected = order
    
])