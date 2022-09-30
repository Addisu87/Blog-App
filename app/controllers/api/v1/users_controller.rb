class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @users = User.all

    respond_to do |format|
      format.html { render json: @users }
      format.json { render json: @users }
    end
  end
end
