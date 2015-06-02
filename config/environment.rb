# Load the Rails application.
require 'pathname'

env = ENV['RACK_ENV'] || 'development'

root_path = Pathname.new File.expand_path('../..', __FILE__)
$LOAD_PATH.unshift(root_path.join('app').to_s, root_path.to_s)

require 'bundler/setup'
Bundler.require(:default, env.to_sym)

module Application
  include ActiveSupport::Configurable
end

Application.configure do |config|
  config.root = root_path
  config.env = ActiveSupport::StringInquirer.new(env)
  config.default_timezone = :utc
  config.logger = Logger.new STDOUT
end

specific_environment = "config/environments/#{Application.config.env}.rb"
require specific_environment if File.exist? specific_environment

db_config_text = File.read(Application.config.root.join('config/database.yml'))
db_config = YAML.load(ERB.new(db_config_text).result)[Application.config.env]
db_url = URI::Generic.build db_config.with_indifferent_access
ROM.setup :sql, db_url.to_s

require 'config/application'

Application.config.rom =  ROM.finalize.env
ROM.env.repositories[:default].connection.logger = Application.config.logger
