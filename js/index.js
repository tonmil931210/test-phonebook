$(document).ready(function(){
  
  function loginUser(username, password) {
    var data = {
      username: username,
      password: password
    }
    request("POST", "/login", data, function(data, error) {
      if (data) {
        $("#message-info").append("Successfull")
        $(".alert").show()
        window.localStorage.setItem('Authorization', data.user.token)
        window.localStorage.setItem('UseriId', data.user.id)
        window.localStorage.setItem('AgendaId', data.agendaId)
        window.location = "users.html"
      } else {
        alert(error)
      }
    })
  }

  var viewModelLogin = function() {
    var self = this;
    self.username = ko.observable();
    self.password = ko.observable();
    self.createSession = function() {
      loginUser(self.username(), self.password());
    }
  }
  ko.applyBindings(new viewModelLogin)
})