
module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ error: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ error: e.message }, :unprocessable_entity)
    end

    #rescue_from ActiveRecord::ActiveRecordError do |e|
    #  json_response({ errors: e.record.errors }, :unprocessable_entity)
    #end
    #

    rescue_from ActionController::InvalidAuthenticityToken do |e|
      json_response({ error: e.message }, 403)
    end

  end
end
