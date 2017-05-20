# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server 'example.com', user: 'deploy', roles: %w{app db web}, my_property: :my_value
# server 'example.com', user: 'deploy', roles: %w{app web}, other_property: :other_value
# server 'db.example.com', user: 'deploy', roles: %w{db}



# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any  hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }

lock '3.6.1'

set :application, 'weather'
set :repo_url, 'git@github.com:airavata-courses/TeamCodeRing.git' # Edit this to match your repository
set :branch, :Dockerization
set :deploy_to, '/home/deploy/CodeRing'
set :keep_releases, 1
set :ssh_options, keys: ["config/deploy_id_rsa"] if File.exist?("config/deploy_id_rsa")
set :use_sudo, true
role :docker, %w{ec2-52-15-153-136.us-east-2.compute.amazonaws.com}, user: 'deploy'
# server 'ubuntu@ec2-35-161-229-183.us-west-2.compute.amazonaws.com', user: 'deploy', roles: %w{docker}, :primary => true
# server 'ubuntu@ec2-52-15-149-191.us-east-2.compute.amazonaws.com', user: 'deploy', roles: %w{docker}

namespace :custom do
  task :setup_container do
    on roles(:docker) do |host|
      puts "================Starting Docker setup===================="
      execute "docker stop $(docker ps -a -q)"
      execute "docker rm $(docker ps -a -q)"
      execute "cd #{release_path} && docker-compose up -d --build"
      exit
    end
  end
end

after "deploy:updating", "custom:setup_container"
after "deploy:finishing", "deploy:cleanup"