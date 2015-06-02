require 'api'

module Avito
  class App
    def self.instance
      @instance ||= Rack::Builder.new(Avito::Api.new) do
        use Rack::Config do |env|
          env['api.tilt.root'] = Application.config.root.join('app', 'views').to_s
        end
      end
    end
  end
end
