angular.module('app.sellApp').controller("TransactionsBillsCtrl", [
  '$scope','$http','bills','transactions_bills'
  ($scope,$http,bills,transactions_bills)->

    ################################ Initialize ###############################

    $scope.bills = []  

    ################################   Helpers  ###############################
    

    ############################ Buttons operations ###########################

    $scope.ConsultBill = (bill) ->
      transactions_bills.ConsultBill(bill['id']).then((data) ->
        if data
          console.log data
      )

    $scope.CreateTransaction = ->
      console.log "Transaction Created"
    
    $scope.Consult = ->
      console.log "Consult"

    ###############################     Main     ##############################

    bills.getBillsToday().then((data) ->
      if data
        $scope.bills = data
    )
    
])