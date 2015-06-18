class SessionsController < ApplicationController
  
  skip_before_action :require_login

  def create
    user = User.find_by(username: params[:username]).try(:authenticate, params[:password])
    if user
      token = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless User.exists?(token: random_token)
      end
      p user.token = token
      user.save
      render json: { user: user, agendaId: user.agenda.id }, status: 201
    else
      head(400)
    end
  end

  def destroy
    token = request.headers['Authorization']
    current_user = user.find_by(token: token)
    if current_user
      current_user.assign_attributes(token: nil).save
      render json: "ok", status: :ok
    else
      head(400)
    end
  end
end
