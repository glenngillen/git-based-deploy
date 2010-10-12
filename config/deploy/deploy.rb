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
      reverse_migrations_cmd = [
        "git diff #{branch} --name-only --diff-filter=A",
        "egrep -e '^db/migrate/[0-9]{14}_'",
        "cut -d/ -f 3",
        "cut -d_ -f 1",
        "sort -r",
        "xargs bundle exec rake db:migrate:down VERSION="]
      commands = ["cd #{current_path}",
                  reverse_migrations_cmd.join(" | ")]
      run commands.join("; ")
      deploy.default
    end

    task :default do
      rollback.code
    end
  end
end