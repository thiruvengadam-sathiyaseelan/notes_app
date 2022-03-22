class ApplicationController < ActionController::API
  #protect_from_forgery with: :null_session
  include Response
  include ExceptionHandler
  include ::SessionsHelper
  include ActionController::Cookies

  # before_filter check_session_and_raise, proc: , skip

end


# module, concern