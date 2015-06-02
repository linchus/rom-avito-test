
Dir[File.expand_path('../v1/**/*.rb', __FILE__)].each { |f| require f }

module Avito
  module API
    module V1
      class Init < Grape::API
        version 'v1', using: :path

        mount Users
        mount Advertisements
        mount Payments
      end
    end
  end
end
