
class SessionsController < ApplicationController

  def create
    user = User.authenticate(params[:email], params[:password])
    if user.nil?
      raise ActionController::InvalidAuthenticityToken.new("Invalid credential")
    else
      sign_in user
      render json: {message: 'User successfully signed-in.'}, status: 200
    end
  end

  def destroy
    sign_out
    render json: {message: 'User successfully signed-out.'}, status: 200
  end
end
