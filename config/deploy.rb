set :application, "teatercamp.no"
set :deploy_to, "www/#{application}"

set :scm, :git
 set :scm_passphrase, "lekmedmeg" 
set :repository, "git://github.com/andreaslyngstad/CMS_A.git"
set :branch, "master"
set :deploy_via, :remote_cache
set :current_path, "www/#{application}/current"
set :user, "teatercamp"


set :use_sudo, false




# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion


set :copy_remote_dir, "home/app/#{user}/"




role :app, application
role :web, application
role :db,  application, :primary => true

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    
  end
  
  
end
after 'deploy:update_code', 'deploy:symlink_shared'