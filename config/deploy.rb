# frozen_string_literal: true
# config valid only for current version of Capistrano
lock '~> 3.14'

set :application, 'fleetfocus-api'
set :repo_url, 'https://github.com/umts/fleetfocus-api.git'
set :deploy_to, "/srv/#{fetch :application}"

set :log_level, :info

set :capistrano_pending_role, :app

append :linked_files, 'config/database.yml'
append :linked_dirs, '.bundle', 'log', 'tmp/pids'

set :passenger_restart_with_sudo, true
