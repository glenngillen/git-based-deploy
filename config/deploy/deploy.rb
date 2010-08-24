namespace :deploy do
  desc "Deploy the application"
  task :default do
    update
    restart
  end
 
  task :symlink do
  end
 
  task :update_code, :except => { :no_release => true } do
    commands = ["cd #{current_path}",
                "git fetch origin",
                "git reset --hard #{branch}",
                "git submodule update --init"]
    run commands.join("; ")
  end
  
  namespace :rollback do
    desc "Rollback a single commit."
    task :code, :except => { :no_release => true } do
      set :branch, "HEAD^"
      deploy.default
    end

    task :default do
      rollback.code
    end
  end
end