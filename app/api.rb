require 'api/errors'
require 'api/v1'

module Avito
  class Api < Grape::API
    prefix :api
    format :json
    content_type :json, 'application/json; charset=UTF-8'
    formatter :json, Grape::Formatter::Jbuilder
    helpers Helpers::Auth

    Application.config.logger.formatter = GrapeLogging::Formatters::Default.new
    use GrapeLogging::Middleware::RequestLogger, logger: Application.config.logger

    include API::Errors

    before do
      authenticate! unless route.route_skip_auth
    end

    get '/', skip_auth: true do
      { status: 'ok' }
    end

    mount API::V1::Init
  end
end
