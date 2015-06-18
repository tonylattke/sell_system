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
      clients.getClients().success((data) ->
        if data
          $scope.clients = data
      )

    resetForm = ->
      $scope.new_client_form = {
        name : null
        dni : null
      }

    ############################ Buttons operations ###########################

    getClients()

    $scope.CreateClient = ->
      console.log 'CreateClient'        
      console.log 'Operation finished'

    $scope.ExportList = ->
      console.log 'ExportList'

    $scope.orderCriteria = (order) ->
      $scope.order_selected = order
    
])