require ::File.expand_path('../config/environment', __FILE__)
load 'rom/sql/tasks/migration_tasks.rake'
Dir[Application.config.root.join('lib/tasks/**/*.rake')].each { |f| load f }

desc 'console'
task :console do
  binding.pry
end

task :setup do
end
