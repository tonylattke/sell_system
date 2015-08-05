sellApp.service 'costumers_helpers', [
  'clients'
  (clients)->

    this.resetForm = ->
      f = {
        name : null
        dni : null
        id : null
        search : ""
      }
      return f

    this.UpdateActivateInClient = (client,active_value) ->
      clients.updateClient(client['id'],{  
        'X-CSRF-Token' : $('meta[name=csrf-token]').attr('content')
        'client' : 
          'id': client['id']
          'dni': client['dni']
          'active':active_value
      }).then((response) ->
        client['active'] = active_value
      )

    return this
]