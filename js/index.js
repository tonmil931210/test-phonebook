$(document).ready(function(){
  var viewModelLogin = function() {
    var self = this;
    self.username = ko.observable();
    self.password = ko.observable();
    self.createSession = function() {
      var data = {
        username: self.username(),
        password: self.password()
      }
      request("POST", "/login", data, function(data, error) {
        if (data) {
          window.localStorage.setItem('Authorization', data.user.token)
          window.localStorage.setItem('UserId', data.user.id)
          window.localStorage.setItem('AgendaId', data.agendaId)
          window.location = "users.html"
        } else {
          alert(error)
        }
      })
    }
  }
  ko.applyBindings(new viewModelLogin)
})