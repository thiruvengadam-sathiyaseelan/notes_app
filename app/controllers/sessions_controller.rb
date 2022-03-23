
class SessionsController < ApplicationController

  def create
    user = User.authenticate(params[:email], params[:password])
    if user.nil?
      raise ActionController::InvalidAuthenticityToken.new( I18n.t(:invalid_credential, scope: [:session]))
    else
      sign_in user
      render json: {message: I18n.t(:signed_in, scope: [:session])}, status: 200
    end
  end

  def destroy
    sign_out
    render json: {message: I18n.t(:signed_out, scope: [:session])}, status: 200
  end
end
