class AgendasController < ApplicationController
  

  def index
    agendas = @current_user.sa ? Agenda.all : @current_user.agenda 
    if agendas
      render json: agendas, status: :ok
    else
      head(400)
    end
  end

  def create
    agenda = @current_user.build_agenda
    if agenda.save
      render json: agenda, status: 201
    else
      head(400)
    end
  end

  def destroy
    agenda = @current_user.sa ? Agenda.find_by(id: params[:id]) : @current_user.agenda 
    if agenda
      agenda.destroy
      render json: agenda, status: :ok
    else
      head(400)
    end
  end
end
