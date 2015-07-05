angular.module('app.sellApp').controller("TransactionsBillsCtrl", [
  '$scope','$http','bills','transactions_bills'
  ($scope,$http,bills,transactions_bills)->

    ################################ Initialize ###############################

    $scope.bills = []  

    $scope.consult_from = new Date().toISOString().split("T")[0]
    $scope.consult_to = new Date().toISOString().split("T")[0]

    ################################   Helpers  ###############################
    

    ############################ Buttons operations ###########################

    $scope.ConsultBill = (bill) ->
      transactions_bills.ConsultBill(bill['id']).then((data) ->
        if data
          bill['extra_data'] = data
      )

    $scope.Consult = ->
      from = $scope.consult_from
      to = $scope.consult_to
      
      bills.getBillsFromTo(from,to).then((data) ->
        if data
          $scope.bills = data
      )

    $scope.CreateTransaction = ->
      console.log "Transaction Created"
    

    ###############################     Main     ##############################

    bills.getBillsToday().then((data) ->
      if data
        $scope.bills = data
    )
    
])