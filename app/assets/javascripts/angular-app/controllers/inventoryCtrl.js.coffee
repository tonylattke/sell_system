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

    $scope.searchArticles = ->
      console.log 'Inventory'

    $scope.orderCriteria = (order) ->
      $scope.order_selected = order
    
])