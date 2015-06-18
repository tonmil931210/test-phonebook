class UsersController < ApplicationController
  
  #before_action :require_sa

  def index
    render json: User.all, status: 201
  end

  def show
    if user = User.find_by(id: params[:id])
      render json: user, status: :ok
    else
      head(400)
    end 
  end

  def create
    user = User.new(params_user)
    if user.save
      user.build_agenda.save
      render json: user, status: 201
    else
      render json: { errors: user.errors }, status: 400
    end
  end

  def edit
    if user = User.find_by(id: params[:id])
      render json: user, status: :ok
    else
      head(400)
    end 
  end

  def update
    user = User.find_by(id: params[:id])
    if user
      user.update(params_user)
      if user.save
        render json: user, status: 202 
      else
        render json: { errors: user.errors }, status: 400 
      end
    else
      head(400)
    end
  end

  def destroy
    if user = User.find_by(id: params[:id])
      user.destroy
      render json: user, status: :ok
    else
      head(400)
    end    
  end

  private
  def params_user
    params.permit(:username, :password, :password_confirmation, :sa)
  end

  def require_sa
    unless @current_user.sa
      head 401
    end
  end
end
