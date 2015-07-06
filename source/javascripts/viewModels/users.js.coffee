class UsersVM

	constructor: () ->
		@listContacts = ko.observableArray()
		@name = ko.observable()
		@phone = ko.observable()
		@cellphone = ko.observable()
		@formContactId = ko.observable()
		@typeForm = ko.observable()

	getContacts: ->
		userID = window.localStorage.getItem('UserId')
		agendaID = window.localStorage.getItem('AgendaId')
		Request.requestApi("GET", "/users/#{userID}/agendas/#{agendaID}/contacts", {}, (data, err) =>
				if err
					alert "error contacts"
				@listContacts(data)
			)

	actionContact: (method, id) ->
		params =
			name: @name()
			phone: @phone()
			cellphone: @cellphone()
		userID = window.localStorage.getItem('UserId')
		agendaID = window.localStorage.getItem('AgendaId')
		Request.requestApi(method, "/users/#{userID}/agendas/#{agendaID}/contacts/#{id}", params, (data, erro) =>
				if data
					@getContacts()
				else
					alert 'error contact'
			)

	editContact: (contact) ->  
		@formContactId(contact.id)
		@typeForm("form-edit-contact")
		$('#myModal').modal('show')
		@name(contact.name)
		@phone(contact.phone)
		@cellphone(contact.name)

	destroyContact: (contact) =>
		userID = window.localStorage.getItem('UserId')
		agendaID = window.localStorage.getItem('AgendaId')
		Request.requestApi("DELETE", "/users/#{userID}/agendas/#{agendaID}/contacts/#{contact.id}", {}, (data, err) =>
				if data
					@listContacts.remove(contact)
				else
					alert 'Error destroy'
			)

	requestForm: ->
		if @typeForm() == "form-create-contact"
			@actionContact("POST", "")
		else
			@actionContact("PUT", @formContactId())
		$('#myModal').modal('hide')
		@name("")
		@phone("")
		@cellphone("")

	createButton: ->
		@formContactId("")
		@typeForm("form-create-contact")
		@name("")
		@phone("")
		@cellphone("")

$ ->
	viewModelUsers = new UsersVM 
	ko.applyBindings(viewModelUsers)
	viewModelUsers.getContacts()
		
