%w(models relations helpers commands mappers).each do |dir|
  Dir[Application.config.root.join("app/#{dir}/**/*.rb")].each { |f| require f }
end

require 'app'
