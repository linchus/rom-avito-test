require 'rack/test'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include AuthenticationHelpers
  config.include RequestHelpers

  def app
    Avito::App.instance
  end
end
