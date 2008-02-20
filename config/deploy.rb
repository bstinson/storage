set :application, "storage"
set :repository,  "http://svn.usdol.net/repos/storage/trunk"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
 set :deploy_to, "/var/www/html/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "209.211.21.25"
role :web, "209.211.21.25"
role :db,  "209.211.21.25", :primary => true

set :user, "brad"  # CHANGE THIS LINE TO USE YOUR OCS USERNAME
set :password, "privilege"
set :use_sudo, false
set :port_number, "3010"

namespace :deploy do
	
  task :start, :roles => :app do
    run "cd #{deploy_to}/current; mongrel_rails start -e production -p #{port_number} -d"
  end
  task :stop, :roles => :app do
    run "cd #{deploy_to}/current; mongrel_rails stop"
  end
  task :restart, :roles => :app do
    run "cd #{deploy_to}/current; mongrel_rails stop; mongrel_rails start -e production -p #{port_number} -d"
    run "echo \"WEBSITE HAS BEEN DEPLOYED\""
  end

end
