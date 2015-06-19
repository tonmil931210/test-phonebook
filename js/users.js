$(document).ready(function(){

  function getContacts() {
    var userID = window.localStorage.getItem('UseriId')
    var AgendaID = window.localStorage.getItem('AgendaId')
    request("GET", "/users/"+ userID +"/agendas/"+ AgendaID +"/contacts", {}, function(data, error) {
      if (data) {
        $('#info-contacts').empty()
        $.each(data, function(i, contact) {
          var buttonEdit = "<button class='btn btn-primary edit-contact' data-contact-id="+ contact.id +">Editar</button>"
          var buttonDestroy = "<button data-contact-id=" + contact.id + " class='btn btn-danger destroy-contact'>Eliminar</button>"
          var row = $("<tr><td>"+ contact.id +"</td><td>"+ contact.name +"</td><td>"+ contact.last_name +"</td><td>"+ contact.phone +"</td><td>"+ contact.cellphone +"</td><td>"+ contact.address +"</td><td>"+ buttonEdit +"</td><td>"+ buttonDestroy +"</td></tr>")
          row.appendTo("#info-contacts")
        })
        $('.destroy-contact').click(function(e) {
          var contactId = $(this).data('contact-id');
          var userID = window.localStorage.getItem('UseriId')
          var AgendaID = window.localStorage.getItem('AgendaId')
          request("DELETE", "/users/"+ userID +"/agendas/"+ AgendaID +"/contacts/" + contactId, {}, function(data, err) {
            if (data) {
              getContacts()
            } else {
              alert('Error destroy')
            }
          })
        }) 

        $('.edit-contact').click(function(e) {
          var contactId = $(this).data('contact-id');
          var userID = window.localStorage.getItem('UseriId')
          var AgendaID = window.localStorage.getItem('AgendaId')
           request("GET", "/users/"+ userID +"/agendas/"+ AgendaID +"/contacts/" + contactId, {}, function(data, err) {
            if (data) {
              $("#form").removeClass("form-create-contact");
              $("#form").addClass("form-edit-contact");
              $('#form').attr('data-contact-id', contactId);
              $('#myModal').modal('show');
              $("input[name=name]").val(data.name);
              $("input[name=phone]").val(data.phone);
              $("input[name=cellphone]").val(data.cellphone); 
            } else {
              alert('Error edit')
            }
          })
        })  
      } else {
        alert('error en users')
      }
    })
  }
  
  function actionForm(type, method, id) {
      var name = $("input[name=name]").val();
      var phone = $("input[name=phone]").val();
      var cellphone = $("input[name=cellphone]").val();
      var params = {
        name: name,
        phone: phone,
        cellphone: cellphone
      }
      var userID = window.localStorage.getItem('UseriId')
      var AgendaID = window.localStorage.getItem('AgendaId')
      request(method, "/users/"+ userID +"/agendas/"+ AgendaID +"/contacts/" + id, params, function(data, erro) {
        if (data) {
          getContacts();
        } else {
          alert('error contacts')
        }
      })
      $('#myModal').modal('hide');
      $('#form input[name=name]').val("")
      $('#form input[name=phone]').val("")
      $('#form input[name=cellphone]').val("")
  }
  $("#form").submit(function(event) {
    event.preventDefault();
    if ($('#form').hasClass('form-create-contact')) {
      actionForm('create', 'POST', '')
    } else {
      actionForm('edit', 'PUT', $(this).data('contact-id'));
    }
  })
  $("#button-create").click(function(event) {
    event.preventDefault()
    $("#form").removeClass("form-edit-contact");
    $("#form").addClass("form-create-contact");
    $('#form').attr('data-contact-id', "");
    $('#form input[name=name]').val("")
    $('#form input[name=phone]').val("")
    $('#form input[name=cellphone]').val("")
  })
  
  getContacts()
})