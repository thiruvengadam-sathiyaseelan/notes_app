class ApplicationController < ActionController::API

  include ExceptionHandler
  include SessionsHelper
  include ActionController::Cookies

  before_filter :set_locale

  def default_url_options
    { locale: I18n.locale }
  end

  private
  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
  end
end


# module, concern