angular.module('app.sellApp').controller("SellCtrl", [
  '$scope','$http',
  ($scope,$http)->

    $scope.clients = []
    $http.get('/clients.json').success((data) ->
      $scope.clients = data
    )

    $scope.client_dni = "-"
    $scope.client_name = "-"
    $scope.client_balance = 0

    console.log $scope.clients
    console.log 'sellCtrl running'

    $scope.searchClient = ->
      $scope.client_dni = "-"
      $scope.client_name = "-"
      $scope.client_balance = 0
      $http.get('/clients/search/' + $scope.data_client + '.json').success((data) ->
        if data['dni']
          $scope.client_dni = data['dni']
          $scope.client_name = data['name']
          $scope.client_balance = data['balance']
      )

])