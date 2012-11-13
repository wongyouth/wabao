# add config/deploy to load_path
$: << File.expand_path('../deploy/', __FILE__)

require 'bundler/capistrano'
require 'capistrano_database'

set :application, "wabao"
set :repository,  "git@wongyouth.dyndns.info:wabao.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, 'ryan'
set :use_sudo, true
default_run_options[:pty] = true

role :web, "wongyouth.dyndns.info"                          # Your HTTP server, Apache/etc
role :app, "wongyouth.dyndns.info"                          # This may be the same as your `Web` server
role :db,  "wongyouth.dyndns.info", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :deploy do
  namespace :assets do
    desc "deploy the precompiled assets"
    task :precompile, :roles => :web, :except => { :no_release => true } do
      run_locally("rake assets:clean assets:precompile RAILS_ENV=#{rails_env} #{asset_env}")
      top.upload("public/assets", "#{release_path}/public/", :via => :scp, :recursive => true)
      run_locally("rm -rf public/assets")
    end
  end
end


require 'capistrano-unicorn'
#after 'deploy:restart', 'unicorn:restart' # app IS NOT preloaded
#after 'deploy:restart', 'unicorn:reload'  # app preloaded

after 'deploy:start', 'unicorn:start'
after 'deploy:stop', 'unicorn:stop'
