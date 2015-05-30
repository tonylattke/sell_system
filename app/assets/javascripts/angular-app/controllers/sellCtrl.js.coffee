angular.module('app.sellApp').controller("SellCtrl", [
  '$scope','$http',
  ($scope,$http)->

    $scope.client_dni = "-"
    $scope.client_name = "-"
    $scope.client_balance = 0

    # Search
    $scope.searchClient = ->
      $scope.client_dni = "-"
      $scope.client_name = "-"
      $scope.client_balance = 0
      $http.get('/api/clients/search/' + $scope.data_client).success((data) ->
        if data['dni']
          $scope.client_dni = data['dni']
          $scope.client_name = data['name']
          $scope.client_balance = data['balance']
      )

    # Sell
    $scope.sell = ->
      $http.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
      
      $http({
          url: '/api/clients',
          method: "POST",
          data:  
            'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
            'client' : 
              'dni' : $scope.new_client_dni
              'name': $scope.new_client_name
              'balance' : $scope.client_cash_used
      }).then((response) ->
        console.log 'hola'
      )
    
])