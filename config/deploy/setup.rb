namespace :deploy do
  desc "Setup a GitHub-style deployment."
  task :setup, :except => { :no_release => true } do
    commands = ["git clone #{repository} #{current_path}",
                "mkdir -p #{deploy_to}/shared/config",
                "mkdir -p #{deploy_to}/shared/logs"]
    run commands.join(" && ")
  end
end