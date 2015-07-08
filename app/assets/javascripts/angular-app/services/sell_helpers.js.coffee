sellApp.service 'sell_helpers', [
  'sell'
  (sell)->

    this.rebootClient = ->
      f = {
        id : null
        dni : "-"
        name : "-"
        balance : 0
      }
      return f

    return this
]