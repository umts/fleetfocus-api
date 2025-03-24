# frozen_string_literal: true

namespace :db do
  desc 'Check that we can connect to the database'
  task :check do
    on roles(:app) do
      within release_path do
        with rack_env: fetch(:stage) do
          execute :rake, 'check'
        end
      end
    end
  end
end
