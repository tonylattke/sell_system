#$(document).ready ->
#  $('#table_inventory').dataTable()

angular.module('app.sellApp').controller("CostumersCtrl", [
  '$scope','$http','clients'
  ($scope,$http,clients)->

    ################################ Initialize ###############################

    $scope.clients = []

    $scope.new_client = null

    ################################   Helpers  ###############################
    
    getClients = ->
      clients.getClients().then((data) ->
        if data
          $scope.clients = data
      )

    resetForm = ->
      $scope.new_client_form = {
        name : null
        dni : null
      }

    ############################ Buttons operations ###########################

    $scope.CreateClient = ->
      clients.createClient({  
        'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        'client' : 
          'name': $scope.new_client_form['name']
          'dni': $scope.new_client_form['dni']
      }).then((response) ->
        $scope.new_client = response
        $scope.clients.push($scope.new_client)
        resetForm()
      )

    $scope.ExportList = ->
      console.log 'ExportList'

    $scope.orderCriteria = (order) ->
      $scope.order_selected = order

    ###############################     Main     ##############################

    getClients()
    
])