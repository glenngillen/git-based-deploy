namespace :gems do
  desc "Install gems"
  task :install, :roles => :app do
    run "cd #{current_release} && bundle install vendor --without test development"
  end
end
after "deploy:update_code", "gems:install"