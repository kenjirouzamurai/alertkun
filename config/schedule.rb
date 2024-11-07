# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
require File.expand_path(File.dirname(__FILE__) + '/environment')
set :environment, :production
set :output, "#{Rails.root}/log/cron.log"

every 10.minutes do
  rake 'ping:health_check'
end
