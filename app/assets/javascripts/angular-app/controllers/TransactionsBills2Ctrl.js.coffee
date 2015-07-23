angular.module('app.sellApp').controller("TransactionsBills2Ctrl", [
  '$scope','$http','bills','cash_transactions','transactions_bills'
  ($scope,$http,bills,cash_transactions,transactions_bills)->

    ################################ Initialize ###############################

    $scope.bills = []  
    $scope.cash_transactions = []

    $scope.consult_from = new Date().toISOString().split("T")[0]
    $scope.consult_to = new Date().toISOString().split("T")[0]

    ################################   Helpers  ###############################
    

    ############################ Buttons operations ###########################

    $scope.ConsultBill = (bill) ->
      if not bill['extra_data']
        transactions_bills.ConsultBill(bill['id']).then((data) ->
          if data
            bill['extra_data'] = data
            aux_total = 0
            for combo in bill['extra_data']['combos']
              aux_total += combo['price']*combo['amount']
            for product in bill['extra_data']['products']
              aux_total += product['price']*product['amount']
            bill['total'] = aux_total
        )

    $scope.Consult = ->
      from = $scope.consult_from
      to = $scope.consult_to
      
      $scope.bills = []
      $scope.cash_transactions = []

      bills.getBillsFromTo(from,to).then((data) ->
        if data['error']
          alert data['msg']
        else
          for bill in data
            bill['extra_data'] = null
          $scope.bills = data
      )

      bills.getCashTransactionsFromTo(from,to).then((data) ->
        if data['error']
          alert data['msg']
        else
          $scope.cash_transactions = data
      )

    $scope.DeleteBill = (bill) ->
      transactions_bills.DeleteBill(bill['id']).then((data) ->
        if data['error']
          alert data['msg']
        else
          i = 0
          for aux_bill in $scope.bills
            if aux_bill['id'] == bill['id']
              $scope.bills.splice(i, 1)
              break
            i++
      )

    $scope.DeleteTransaction = (cash_transaction) ->
      cash_transactions.deleteCashTransaction(cash_transaction['id']).then((data) ->
        if data['error']
          alert data['msg']
        else
          i = 0
          for aux_transaction in $scope.cash_transactions
            if aux_transaction['id'] == cash_transaction['id']
              $scope.cash_transactions.splice(i, 1)
              break
            i++
      )

    $scope.CreateTransaction = ->
      alert "Transaction Created"
    

    ###############################     Main     ##############################

    bills.getBillsToday().then((data) ->
      if data['error']
        alert data['msg']
      else
        for bill in data
          bill['extra_data'] = null
        $scope.bills = data
    )

    cash_transactions.getCashTransactionsToday().then((data) ->
      if data['error']
        alert data['msg']
      else
        $scope.cash_transactions = data
    )
    
])