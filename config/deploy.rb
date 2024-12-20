set :application, 'alertkun'
set :repo_url, "git@github.com:kenjirouzamurai/alertkun.git"
set :user, "kyamada"
set :puma_service_unit_name, 'puma_alertkun.service'

set :ssh_options, {
  keys: [File.expand_path('~/.ssh/rivelty.pem')],
  forward_agent: true
}
set :keep_releases, 1
set :deploy_to, '/var/www/html/alertkun'
set :linked_dirs, %w{log tmp/backup tmp/pids tmp/cache tmp/sockets vendor/bundle}
append :linked_files, 'config/database.yml', 'config/master.key', '.env'
set :bundle_bins, fetch(:bundle_bins).to_a.concat(%w{ puma pumactl })
set :asdf_map_ruby_bins, %w{rake gem bundle ruby rails}
append :asdf_map_ruby_bins, 'puma', 'pumactl'
set :nvm_type, :user
set :nvm_node, "v17.9.0"
set :nvm_map_bins, %w{npm node yarn rake}
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

namespace :deploy do
  desc 'restart nginx'
  task :nginx_restart do
    on roles(:app) do
      execute "sudo service nginx stop"
      execute "sudo service nginx start"
    end
  end

  after :finished, :nginx_restart

  desc 'db_reset'
  task :db_reset do
    set :rails_env, :production
    set :disable_database_environnment_check, 1

    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:drop DISABLE_DATABASE_ENVIRONMENT_CHECK=1'
          execute :bundle, :exec, :rake, 'db:create'
          execute :bundle, :exec, :rake, 'db:migrate'
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end
end
