angular.module('app.sellApp').controller("ManagerCtrl2", [
  '$scope','$http','cash_transactions','transactions_bills','manager'
  ($scope,$http,cash_transactions,transactions_bills,manager)->

    $scope.bills = []  
    $scope.cash_transactions = []
    $scope.sale_transactions = []

    $scope.consult_from = new Date().toISOString().split("T")[0]
    $scope.consult_to = new Date().toISOString().split("T")[0]

    $scope.report_from = new Date().toISOString().split("T")[0]
    $scope.report_to = new Date().toISOString().split("T")[0]

    $scope.manager_mode = 'day_begin'

    $scope.total = 0
    $scope.diference = 0

    $scope.cash_recharge = 0
    $scope.cash_sell = 0

    $scope.cash_transaction = 0
    $scope.adjust_transaction = 0

    $scope.total_system = 0

    cash_init_values = {
      'v_1' : 0
      'v_2' : 0
      'v_5' : 0
      'v_10' : 0
      'v_20' : 0
      'v_50' : 0
      'v_100' : 0
      'v_500' : 0
    }

    ###############################   Helpers  ################################
    
    initializeCashAmounts = ->
      $scope.cash = cash_init_values

    getTransactionsToday = ->
      manager.getTransactionsToday().then((data) ->
        if data['error']
          alert data['msg']
        else
          $scope.cash_transactions = data['cash_transactions']
          $scope.sale_transactions = data['sale_transactions']
          
          sellsCashTransactionsUpdate()
      )

    $scope.cash1Update = ->
      if $scope.cash.v_1 == null or isNaN($scope.cash.v_1)
        $scope.cash.v_1 = 0
      $scope.cash.v_1 = parseInt($scope.cash.v_1, 10)
      $scope.cashUpdate()

    $scope.cash2Update = ->
      if $scope.cash.v_2 == null or isNaN($scope.cash.v_2)
        $scope.cash.v_2 = 0
      $scope.cash.v_2 =  parseInt($scope.cash.v_2, 10)
      $scope.cashUpdate()

    $scope.cash5Update = ->
      if $scope.cash.v_5 == null or isNaN($scope.cash.v_5)
        $scope.cash.v_5 = 0
      $scope.cash.v_5 =  parseInt($scope.cash.v_5, 10)
      $scope.cashUpdate()

    $scope.cash10Update = ->
      if $scope.cash.v_10 == null or isNaN($scope.cash.v_10)
        $scope.cash.v_10 = 0
      $scope.cash.v_10 =  parseInt($scope.cash.v_10, 10)
      $scope.cashUpdate()

    $scope.cash20Update = ->
      if $scope.cash.v_20 == null or isNaN($scope.cash.v_20)
        $scope.cash.v_20 = 0
      $scope.cash.v_20 =  parseInt($scope.cash.v_20, 10)
      $scope.cashUpdate()

    $scope.cash50Update = ->
      if $scope.cash.v_50 == null or isNaN($scope.cash.v_50)
        $scope.cash.v_50 = 0
      $scope.cash.v_50 =  parseInt($scope.cash.v_50, 10)
      $scope.cashUpdate()

    $scope.cash100Update = ->
      if $scope.cash.v_100 == null or isNaN($scope.cash.v_100)
        $scope.cash.v_100 = 0
      $scope.cash.v_100 =  parseInt($scope.cash.v_100, 10)
      $scope.cashUpdate()

    $scope.cash500Update = ->
      if $scope.cash.v_500 == null or isNaN($scope.cash.v_500)
        $scope.cash.v_500 = 0
      $scope.cash.v_500 =  parseInt($scope.cash.v_500, 10)
      $scope.cashUpdate()

    $scope.cashUpdate = ->
      aux = 0
      aux += $scope.cash.v_1
      aux += $scope.cash.v_2 * 2
      aux += $scope.cash.v_5 * 5
      aux += $scope.cash.v_10 * 10
      aux += $scope.cash.v_20 * 20
      aux += $scope.cash.v_50 * 50
      aux += $scope.cash.v_100 * 100
      aux += $scope.cash.v_500 * 500
      $scope.total = aux

      $scope.diference = $scope.total - $scope.total_system

    sellsCashTransactionsUpdate = ->
      $scope.cash_sell = 0
      $scope.cash_recharge = 0
      $scope.cash_transaction = 0
      $scope.adjust_transaction = 0

      $scope.total_system = 0
      for s_t in $scope.sale_transactions
        if s_t.type_t == 'cash'
          $scope.total_system += s_t.amount
          $scope.cash_sell += s_t.amount
        if s_t.type_t == 'u_recharge'
          $scope.total_system += s_t.amount
          $scope.cash_recharge += s_t.amount
        # if s_t.type_t == 'u_balance'
          # $scope.total_system

      for c_t in $scope.cash_transactions
        if c_t.type_t == 'begin_day'
          $scope.total_system += c_t.amount
          $scope.cash_transaction += c_t.amount
        if c_t.type_t == 'adjust_day'
          $scope.total_system += c_t.amount
          $scope.adjust_transaction += c_t.amount
        if c_t.type_t == 'deposit'
          $scope.total_system += c_t.amount
          $scope.cash_transaction += c_t.amount
        if c_t.type_t == 'withdraw'
          $scope.total_system -= c_t.amount
          $scope.cash_transaction -= c_t.amount
      
      $scope.total_system = $scope.cash_transaction + $scope.adjust_transaction + $scope.cash_sell + $scope.cash_recharge

    ########################### Buttons operations ############################

    $scope.ConsultDay = ->
      from = $scope.consult_from
      # to = $scope.consult_to
      
      $scope.sale_transactions = []
      $scope.cash_transactions = []

      manager.getTransactionsFromTo(from,from).then((data) ->
        if data['error']
          alert data['msg']
        else
          $scope.cash_transactions = data['cash_transactions']
          $scope.sale_transactions = data['sale_transactions']
          
          sellsCashTransactionsUpdate()

          $scope.manager_mode = 'days_consult'
      )

    $scope.DayBegin = ->
      initializeCashAmounts()

      $scope.total = 0
      
      $scope.manager_mode = 'day_begin'

    $scope.DayEnd = ->
      getTransactionsToday()

      initializeCashAmounts()

      $scope.total = 0
      $scope.diference = $scope.total - $scope.total_system

      $scope.manager_mode = 'day_end'

    $scope.CountCashBeginDone = ->
      manager.createCashTransactionBegin({
        'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        'cash_transaction' : 
          'amount': $scope.total
      }).then((response) ->
        window.location.href = "/transactions_bills"
      )

    validOperation = ->
      aux_status = false

      # Cash transactions exists
      for c_t in $scope.cash_transactions
        if c_t.type_t == 'begin_day'
          aux_status = true
          break

      return aux_status

    $scope.CountCashEndDone = ->
      if validOperation() and $scope.diference != 0
        manager.createCashTransactionEnd({
          'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
          'cash_transaction' : 
            'amount': $scope.diference
        }).then((response) ->
          window.location.href = "/transactions_bills"
        )
      else
        alert "You need to initialize or an adjust is not necessary"

    $scope.GenerateReport = ->
      window.location.href = "/manager/report/" + $scope.report_from + "/" + $scope.report_to

    ############################## Initialize #################################

    $scope.DayBegin()
    getTransactionsToday()
    
])