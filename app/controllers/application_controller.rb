class ApplicationController < ActionController::API
  #protect_from_forgery with: :null_session
  include Response
  include ExceptionHandler
  include ::SessionsHelper
  include ActionController::Cookies

end
