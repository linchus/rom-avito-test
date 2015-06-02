ENV['RACK_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
Dir[Application.config.root.join('spec/support/**/*.rb')].each { |file| require file }
Dir[Application.config.root.join('spec/shared/**/*.rb')].each { |file| require file }

RSpec.configure do |config|
  config.around(:each) do |example|
    ROM.env.repositories[:default].connection.transaction(rollback: :always, auto_savepoint: true) do
      example.run
    end
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  def rom
    ROM.env
  end
end
