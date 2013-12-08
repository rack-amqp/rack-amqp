class UsersController < ApplicationController
  respond_to :json

  def index
    respond_with User.all
  end

  def create
    User.create user_params
    head :ok
  end

  def show
    respond_with User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update_attributes user_params
    respond_with user
  end

  private

  def user_params
    params.require(:login, :password)
  end
end
