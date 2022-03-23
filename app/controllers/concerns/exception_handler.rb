
module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { error: I18n.t(:not_found, scope: [:common]) }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { error: e.message }, status: :unprocessable_entity
    end

    rescue_from ActionController::InvalidAuthenticityToken do |e|
      render json: {error: e.message }, status: 403
    end

  end
end
