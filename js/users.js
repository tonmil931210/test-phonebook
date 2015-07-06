$(document).ready(function(){

  var viewModel = function(){
    var self = this;
    self.listContacts = ko.observableArray();
    self.name = ko.observable();
    self.phone = ko.observable();
    self.cellphone = ko.observable();
    self.formContactId = ko.observable();
    self.typeForm = ko.observable();
    self.getContacts = function() {
      var userID = window.localStorage.getItem('UserId');
      var agendaID = window.localStorage.getItem('AgendaId');
      request("GET", "/users/"+ userID +"/agendas/"+ agendaID +"/contacts", {}, function(data, error) {
        if (!data) {
          alert('error get contacts')  
        }
        self.listContacts(data);
      })
    }
    self.actionContact = function(method, id) {
      var params = {
        name: self.name(),
        phone: self.phone(),
        cellphone: self.cellphone()
      }
      var userID = window.localStorage.getItem('UserId');
      var agendaID = window.localStorage.getItem('AgendaId');
      request(method, "/users/"+ userID +"/agendas/"+ agendaID +"/contacts/" + id, params, function(data, erro) {
        if (data) {
          self.getContacts();
        } else {
          alert('error contact')
        }
      })
    }
    self.editContact = function(contact) {  
      self.formContactId(contact.id);
      self.typeForm("form-edit-contact");
      $('#myModal').modal('show');
      self.name(contact.name);
      self.phone(contact.phone);
      self.cellphone(contact.name);
    }
    self.destroyContact = function(contact) {
      var userID = window.localStorage.getItem('UserId');
      var agendaID = window.localStorage.getItem('AgendaId');
      request("DELETE", "/users/"+ userID +"/agendas/"+ agendaID +"/contacts/" + contact.id, {}, function(data, err) {
        if (data) {
          self.listContacts.remove(contact);
        } else {
          alert('Error destroy');
        }
      })
    }
    self.requestForm = function() {
      if (self.typeForm() == "form-create-contact") {
        self.actionContact("POST", "");
      } else {
        self.actionContact("PUT", self.formContactId());
      }
      $('#myModal').modal('hide');
      self.name("");
      self.phone("");
      self.cellphone("");
    }
    self.createButton = function() {
      self.formContactId("");
      self.typeForm("form-create-contact");
      self.name("");
      self.phone("");
      self.cellphone("");
    }
  }
  var view = new viewModel();
  ko.applyBindings(view);
  view.getContacts();
  
})