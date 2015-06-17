#$(document).ready ->
#  $('#table_inventory').dataTable()

angular.module('app.sellApp').controller("CostumersCtrl", [
  '$scope','$http',
  ($scope,$http)->

    ################################ Initialize ###############################
    $scope.clients = []

    $scope.new_client = null

    ################################   Helpers  ###############################
    

    ############################ Buttons operations ###########################

    $scope.CreateClient = ->
      console.log 'CreateClient'
    
        
      console.log 'Operation finished'

    $scope.ExportList = ->
      console.log 'ExportList'

    $scope.orderCriteria = (order) ->
      $scope.order_selected = order
    
])