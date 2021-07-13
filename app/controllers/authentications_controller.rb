class AuthenticationsController < JwtApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create]
  
  # POST 
  def create
    @user_jwt = UserJwt.find_by_email(params[:email])
    if @user_jwt&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user_jwt.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     username: @user_jwt.username }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end