class ContactsController < ApplicationController
  
  def index
    if agenda = Agenda.find_by(id: params[:agenda_id])
      contacts = @current_user.sa ? agenda.contacts : @current_user.contacts 
      if contacts 
        render json: contacts, status: :ok
      end
    else
      head(400)
    end
  end

  def show
    contact = @current_user.sa ? Contact.find_by(id: params[:id]) : @current_user.contacts.find_by(id: params[:id])
    if contact
      render json: contact, status: :ok
    else
      head(400)
    end
  end

  def create
    contact = @current_user.agenda.contacts.build(params_contact)
    if contact.save
      render json: contact, status: 201
    else
      render json: { errors: contact.errors }, status: 400
    end
  end

  def edit
    contact = @current_user.sa ? Contact.find_by(id: params[:id]) : @current_user.contacts.find_by(id: params[:id])
    if contact
      render json: contact, status: :ok
    else
      head(400)
    end
  end

  def update
    contact = @current_user.contacts.find_by(id: params[:id])
    if contact
      contact.update(params_contact)
      if contact.save
        render json: contact, status: 201
      else
        render json: { errors: contact.errors }, status: 400
      end
    else
      head(400)
    end
  end

  def destroy
    contact = @current_user.sa ? Contact.find_by(id: params[:id]) : @current_user.contacts.find_by(id: params[:id])
    if contact
      contact.destroy
      render json: { message: "ok" }, status: :ok
    else
      head(400)
    end
  end

  private
  def params_contact
    params.permit(:name, :last_name, :phone, :cellphone, :address)
  end
end
