$(document).ready(function(){
  function loginUser() {
    var username = $("input[name=username]").val()
    var password = $("input[name=password]").val()
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
  $("#login-form").submit(function(event) {
    event.preventDefault();
    loginUser();
  })
})