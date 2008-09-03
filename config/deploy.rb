set :application, "ubiquitybin"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/dholst/rails/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :repository, "git://github.com/darrinholst/ubiquitybin.git"
set :branch, "master"
set :deploy_via, :remote_cache

server "ubiquitybin.com", :app, :web, :db, :primary => true

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

 desc "create a shared/resources directory for common, non-svn files (like database.yml)"
  task :after_setup, :roles => [:app, :db, :web] do
    run <<-CMD
    mkdir -p -m 775 #{shared_path}/resources &&
    mkdir -p -m 775 #{shared_db} &&
    touch #{shared_path}/resources/database.yml
    chmod 600 #{shared_path}/resources/database.yml
    touch #{shared_path}/resources/mail.rb
    chmod 600 #{shared_path}/resources/mail.rb
    touch #{shared_path}/resources/site_keys.rb
    chmod 600 #{shared_path}/resources/site_keys.rb
    CMD
  end

  desc "create a symlink for the database.yml file for the current project (since it isn't in source control)"
  task :after_update_code, :roles => [:app, :db, :web] do
    run <<-CMD
    ln -nfs #{shared_path}/resources/database.yml #{release_path}/config/database.yml
    ln -nfs #{shared_path}/resources/mail.rb #{release_path}/config/initializers/mail.rb
    ln -nfs #{shared_path}/resources/site_keys.rb #{release_path}/config/initializers/site_keys.rb
    CMD
  end