namespace :deploy do
  task :start do
  end
  task :stop do
  end

  desc "Restart the application"    
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  namespace :web do
    tast :setup, :roles => :app do
      eval("deploy.#{web_server.to_s}.setup")
    end
    
    task :restart, :roles => :app do
      eval("deploy.#{web_server.to_s}.restart")
    end
  end
end
after "deploy:setup", "deploy:web:restart"