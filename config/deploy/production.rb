# frozen_string_literal: true

server 'af-transit-app3.admin.umass.edu',
       roles: %w(app web),
       ssh_options: { forward_agent: false }
