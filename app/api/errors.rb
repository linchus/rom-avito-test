module Avito
  module API
    module Errors
      extend ActiveSupport::Concern

      included do
        rescue_from Grape::Exceptions::ValidationErrors do |error|
          Avito::API::Errors.error_response error: error, status: 422
        end

        rescue_from User::Unauthorized do |error|
          Avito::API::Errors.error_response error: error, status: 401
        end

        rescue_from User::Forbidden do |error|
          Avito::API::Errors.error_response error: error, status: 403
        end

        rescue_from ROM::TupleCountMismatchError do |error|
          Avito::API::Errors.error_response error: error, status: 404
        end

        rescue_from :all do |error|
          Avito::API::Errors.error_response error: error
        end
      end

      def self.error_response(error:, details: nil, status: 500)
        Application.config.logger.error error
        message = serialize_error(error, details, status)
        Rack::Response.new([message.to_json]) do |response|
          response.status = status
          response.header['Content-type'] = 'application/json; charset=UTF-8'
        end.finish
      end

      def self.serialize_error(error, details, status)
        {
          error: error.class.name,
          message: error.message,
          status: status
        }.tap do |hash|
          hash[:details] = details if details
        end
      end
    end
  end
end
