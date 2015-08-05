#$(document).ready ->
#  $('#table_inventory').dataTable()

angular.module('app.sellApp').controller("CostumersCtrl", [
  '$scope','$http','clients','costumers_helpers'
  ($scope,$http,clients,costumers_helpers)->

    ################################ Initialize ###############################

    $scope.costumers_mode = 'list'

    $scope.clients = []

    $scope.new_client = null

    $scope.edit_client = null

    $scope.new_client_form = costumers_helpers.resetForm()

    ################################   Helpers  ###############################
    
    getClients = ->
      clients.getClients().then((data) ->
        if data
          $scope.clients = data
      )

    ############################ Buttons operations ###########################

    # List client

    $scope.CreateClient = ->
      clients.createClient({  
        'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        'client' : 
          'name': $scope.new_client_form['name']
          'dni': $scope.new_client_form['dni']
      }).then((response) ->
        $scope.new_client = response
        $scope.clients.push($scope.new_client)
        $scope.new_client_form = costumers_helpers.resetForm()
      )

    $scope.activate = (client) ->
      costumers_helpers.UpdateActivateInClient(client,true)

    $scope.deactivate = (client) ->
      costumers_helpers.UpdateActivateInClient(client,false)

    $scope.ExportList = ->
      window.location.href = "/costumers/report";

    $scope.orderCriteria = (order) ->
      $scope.order_selected = order

    $scope.editClient = (client) ->
      $scope.edit_client = {
        id : client['id']
        name : client['name']
        dni : client['dni']
      }
      $scope.costumers_mode = 'client_edit'

    # Edit client

    $scope.EditClientCancel = ->
      $scope.edit_client = costumers_helpers.resetForm()
      $scope.costumers_mode = 'list'

    $scope.EditClientSubmit = ->
      clients.updateClient($scope.edit_client['id'],{  
        'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        'client' : 
          'id': $scope.edit_client['id']
          'name': $scope.edit_client['name']
          'dni': $scope.edit_client['dni']
      }).then((response) ->
        for aux_client in $scope.clients
          if aux_client['id'] == $scope.edit_client['id']
            aux_client['name'] = $scope.edit_client['name']
            aux_client['dni'] = $scope.edit_client['dni']
            break
        $scope.edit_client = costumers_helpers.resetForm()
      )
      $scope.costumers_mode = 'list'

    ###############################     Main     ##############################

    getClients()
    
])