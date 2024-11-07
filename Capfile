require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"

require 'capistrano/puma'
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Systemd

install_plugin Capistrano::SCM::Git
# require 'capistrano/rvm'
require 'capistrano/rbenv'


require "capistrano/bundler"
require "capistrano/rails/migrations"
# require 'capistrano/yarn'
require 'whenever/capistrano'

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
