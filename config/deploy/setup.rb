namespace :deploy do
  desc "Setup a GitHub-style deployment."
  task :setup, :except => { :no_release => true } do
    commands = ["mkdir -p #{deploy_to}",
                "git clone #{repository} #{current_path}",
                "mkdir -p #{current_path}/tmp",
                "mkdir -p #{deploy_to}/shared/config",
                "mkdir -p #{deploy_to}/shared/logs"]
    run commands.join(" && ")
  end
  after "deploy:setup", "gems:install"
  
  desc "Sets up and starts a new application."
  task :cold do
    deploy.setup
  end
end