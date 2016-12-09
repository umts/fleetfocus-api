# frozen_string_literal: true
remote_user = Net::SSH::Config.for('af-transit-app3.admin.umass.edu')[:user] || ENV['USER']

server 'af-transit-app3.admin.umass.edu',
       roles: %w(app web),
       user: remote_user
set :tmp_dir, "/tmp/#{remote_user}"
