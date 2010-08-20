namespace :deploy do
  task :start do
  end
  task :stop do
  end

  desc "Restart the application"    
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :nginx do
  desc "Start"    
  task :start, :roles => :web do
    sudo "/etc/init.d/nginx start" 
  end

  desc "Kill nginx"    
  task :stop, :roles => :web do
    sudo "/etc/init.d/nginx stop" 
  end

  desc "Restart nginx"    
  task :restart, :roles => :web do
    sudo "/etc/init.d/nginx restart"
  end
end
after "deploy:setup", "nginx:restart"