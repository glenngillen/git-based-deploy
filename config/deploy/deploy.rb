namespace :deploy do
  desc "Deploy the application"
  task :default do
    update
    restart
  end
 
  desc "Setup a GitHub-style deployment."
  task :setup, :except => { :no_release => true } do
    commands = ["git clone #{repository} #{current_path}",
                "mkdir -p #{deploy_to}/shared/config",
                "mkdir -p #{deploy_to}/shared/logs"]
    run commands.join(" && ")
  end
  
  task :symlink do
  end
 
  desc "Update the deployed code."
  task :update_code, :except => { :no_release => true } do
    commands = ["cd #{current_path}",
                "git fetch origin"
                "git reset --hard #{branch}"
                "git submodule update --init"
                "bundle install --without test development"]
    run commands.join("; ")
  end
  
  desc <<-DESC
    Run the migrate rake task. You can specify additional environment variables \
    to pass to rake via the migrate_env variable. 
  DESC
  task :migrate, :roles => :db, :only => { :primary => true } do
    rails_env = fetch(:rails_env, "production")
    migrate_env = fetch(:migrate_env, "")
    run "cd #{current_path}; bundle exec #{rake} RAILS_ENV=#{rails_env} #{migrate_env} db:migrate"
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