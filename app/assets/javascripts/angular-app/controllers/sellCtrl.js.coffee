angular.module('app.sellApp').controller("SellCtrl", [
  '$scope','$http',
  ($scope,$http)->

    $scope.clients = []
    $http.get('/clients.json').success((data) ->
        $scope.clients = data
    )

    $scope.sellValue = "Hello angular and rails"

    console.log $scope.clients
    console.log 'sellCtrl running'
])