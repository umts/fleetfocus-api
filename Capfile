# frozen_string_literal: true

%w[setup deploy scm/git pending bundler passenger].each do |lib|
  require "capistrano/#{lib}"
end

install_plugin Capistrano::SCM::Git

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
