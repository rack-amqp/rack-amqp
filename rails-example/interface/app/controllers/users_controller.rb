class UsersController < ApplicationController
  respond_to :html

  def index
    @users = Userland::User.all
    respond_with @users
  end
end
