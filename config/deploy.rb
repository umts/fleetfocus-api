# frozen_string_literal: true
# config valid only for current version of Capistrano
lock '~> 3.11.0'

set :application, 'fleetfocus-api'
set :repo_url, 'https://github.com/umts/fleetfocus-api.git'
set :deploy_to, "/srv/#{fetch :application}"

set :log_level, :info

set :linked_files, fetch(:linked_files, []).push('config/database.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids')

set :keep_releases, 5
