sellApp.service 'inventory_helpers', [
  'combos','products'
  (combos,products)->

    this.resetForm = () ->
      f = {
        name : null
        photo : null
        price : null
        stock_amount : null
        tags : null
        providers : null
      }
      return f

    this.updateActiveInCombo = (combo,active_value) ->
      combos.updateCombo(combo['id'],{  
        'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        'combo' : 
          'id': combo['id']
          'active':active_value
      }).then((response) ->
        combo['active'] = active_value
      )

    this.updateActiveInProduct = (product,active_value) ->
      products.updateProduct(product['id'],{  
        'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        'product' : 
          'id': product['id']
          'active': active_value
      }).then((response) ->
        product['active'] = active_value
      )

    return this
]