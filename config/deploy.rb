default_run_options[:pty] = true

set :application, "statusboard"
set :repository,  "https://github.com/rocky-jaiswal/statusboard"
set :scm, :git
set :user, "torquebox"
set :deploy_to, "/opt/torquebox/statusboard"
set :torquebox_home, "/opt/torquebox/current"
set :use_sudo, false

role :web, "statusboard.in"                          # Your HTTP server, Apache/etc
role :app, "statusboard.in"                          # This may be the same as your `Web` server
role :db,  "statusboard.in", :primary => true        # This is where Rails migrations will run


namespace :torquebox do
  task :deploy do
    puts "==================Stop and Undeploy======================"
    sudo "service torquebox stop; true && killall java; true"
    run  "rm -rf #{torquebox_home}/jboss/standalone/deployments/*"
    puts "==================Bundle======================"
    run  "cd #{deploy_to}/current && export PATH=#{torquebox_home}/jruby/bin:$PATH && export TORQUEBOX_HOME=#{torquebox_home} && export JBOSS_HOME=$TORQUEBOX_HOME/jboss && export JRUBY_HOME=$TORQUEBOX_HOME/jruby && bundle install --deployment --without development test"
    puts "==================Deploy and Run======================"
    run  "cd #{deploy_to}/current && export PATH=#{torquebox_home}/jruby/bin:$PATH && export TORQUEBOX_HOME=#{torquebox_home} && export JBOSS_HOME=$TORQUEBOX_HOME/jboss && export JRUBY_HOME=$TORQUEBOX_HOME/jruby && torquebox deploy"
    sudo "service torquebox start"
  end
  task :symlink_shared do
    run "ln -s #{shared_path}/application.yml #{deploy_to}/current/config/application.yml"
  end
end

after "deploy", "torquebox:symlink_shared"
after "torquebox:symlink_shared", "torquebox:deploy"
# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"
