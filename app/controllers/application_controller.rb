class ApplicationController < ActionController::API
  before_action :authorized
  # SAMPLE
  # >  payload = { beef: 'steak' }

  # > jwt = JWT.encode(payload, 'boeuf')
  # => "eyJhbGciOiJIUzI1NiJ9.eyJiZWVmIjoic3RlYWsifQ._IBTHTLGX35ZJWTCcY30tLmwU9arwdpNVxtVU0NpAuI"

  # > decoded_hash = JWT.decode(jwt, 'boeuf')
  # => [{"beef"=>"steak"}, {"alg"=>"HS256"}]

  # > data = decoded_hash[0]
  # => {"beef"=>"steak"}

  def encode_token(payload)
    # {user_id: 2}
    JWT.encode(payload, 'my_s3cr3t')
    # issue a token, store payload in token
  end

  def auth_header
    request.headers['Authorization'] # Bearer <token>
  end

  def decoded_token
    return unless auth_header

    token = auth_header.split[1] # [Bearer, <token>]
    begin
      JWT.decode(token, 'my_s3cr3t', true, algorithm: 'HS256')
      # JWT.decode => [{ "user_id"=>"2" }, { "alg"=>"HS256" }]
    rescue JWT::DecodeError || ActiveRecord::RecordNotFound
      nil
    end
  end

  def current_user
    return unless decoded_token

    user_id = decoded_token[0]['user_id']
    # [{ "user_id"=>"2" }, { "alg"=>"HS256" }]
    @user = User.find_by(id: user_id)
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
