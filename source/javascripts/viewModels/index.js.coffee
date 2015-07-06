class IndexVM

  constructor: ->
    @username = ko.observable()
    @password = ko.observable()

  createSession: ->
    data = 
      username: @username()
      password: @password()
    Request.requestApi("POST", "/login", data, (data, error) -> 
        if data 
          window.localStorage.setItem('Authorization', data.user.token)
          window.localStorage.setItem('UserId', data.user.id)
          window.localStorage.setItem('AgendaId', data.agendaId)
          window.location = "users.html" 
        else
          alert error
      )

$ ->
  viewModel = new IndexVM
  ko.applyBindings(viewModel)