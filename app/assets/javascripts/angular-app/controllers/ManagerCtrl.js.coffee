angular.module('app.sellApp').controller("ManagerCtrl", [
  '$scope','$http','cash_transactions','manager'
  ($scope,$http,cash_transactions,manager)->

    $scope.sale_transactions = []
    $scope.cash_transactions = []

    $scope.consult_from = new Date().toISOString().split("T")[0]
    $scope.consult_to = new Date().toISOString().split("T")[0]

    $scope.manager_mode = 'day_begin'

    $scope.total = 0
    $scope.diference = 0

    $scope.cash_recharge = 0
    $scope.cash_sell = 0

    $scope.cash_transaction = 0
    $scope.adjust_transaction = 0

    $scope.total_system = 0

    ###############################   Helpers  ################################
    
    

    ########################### Buttons operations ############################

    $scope.ConsultDay = ->
      from = $scope.consult_from
      to = $scope.consult_to
      
      $scope.sale_transactions = []
      $scope.cash_transactions = []

      manager.getSaleTransactionsFromTo(from,to).then((data) ->
        if data['error']
          alert data['msg']
        else
          $scope.sale_transactions = data
      )
      cash_transactions.getCashTransactionsFromTo(from,to).then((data) ->
        if data['error']
          alert data['msg']
        else
          $scope.cash_transactions = data
      )
      $scope.manager_mode = 'day_end'

    $scope.DayBegin = ->
      $scope.manager_mode = 'day_begin'

    $scope.DayEnd = ->
      $scope.sale_transactions = []
      $scope.cash_transactions = []

      manager.getSaleTransactionsToday().then((data) ->
        if data['error']
          alert data['msg']
        else
          $scope.sale_transactions = data
      )
      cash_transactions.getCashTransactionsToday().then((data) ->
        if data['error']
          alert data['msg']
        else
          $scope.cash_transactions = data
      )
      $scope.manager_mode = 'day_end'

    $scope.CountCashDone = ->
      alert "Count cash done"

    $scope.GenerateReport = ->
      alert "Generate Report on interval"

    ############################## Initialize #################################

    
    
])