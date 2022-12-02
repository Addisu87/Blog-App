class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  # POST /api/v1/login
  def create
    @user = User.find_by(name: user_login_params[:username])
    # @user.authenticate('password')
    if @user&.authenticate(user_login_params[:password])
      @token = encode_token({ user_id: @user.id })
      time = Time.now + 24.hours.to_i
      render json: { user: UserSerializer.new(@user), jwt: @token, exp: time.strftime('%m-%d-%Y %H:%M') }, status: :accepted
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  private

  def user_login_params
    # { user: { username: 'Chandler Bing', password: 'hi' } }
    params.require(:user).permit(:username, :password)
  end
end
