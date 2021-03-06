module SessionsHelper
  extend ActiveSupport::Concern

  included do
    def sign_in(user)
      cookies.permanent.signed[:remember_token] = [user.id, user.salt]
      current_user = nil
    end

    def sign_out
      cookies.delete(:remember_token)
      current_user = nil
    end

    def signed_in?
      !current_user.nil?
    end

    def check_session_and_raise
      # if !signed_in?
      #   raise ActionController::InvalidAuthenticityToken.new("Invalid session!")
      # end
      #
      # unless signed_in?
      #   raise ActionController::InvalidAuthenticityToken.new("Invalid session!")
      # end

      raise ActionController::InvalidAuthenticityToken.new("Invalid session!") unless signed_in?
    end

    def current_user=(user)
      @current_user = user
    end

    def current_user
      @current_user ||= user_from_remember_token
    end

    private
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
  end

end
