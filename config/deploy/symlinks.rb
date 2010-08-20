set :normal_symlinks, %w(
  config/database.yml
)
 
set :weird_symlinks, {
  'system'             => 'public/system'
}
 
namespace :symlinks do
  desc "Make all the symlinks"
  task :make, :roles => :app, :except => { :no_release => true } do
    run "mkdir -p #{current_path}/tmp"
    commands = normal_symlinks.map do |path|
      "rm -rf #{release_path}/#{path} && \
       ln -s #{shared_path}/#{path} #{release_path}/#{path}"
    end
     
    commands += weird_symlinks.map do |from, to|
      "rm -rf #{release_path}/#{to} && \
       ln -s #{shared_path}/#{from} #{release_path}/#{to}"
    end
     
    run <<-CMD
      cd #{release_path} &&
      #{commands.join(" && ")}
    CMD
  end
end 
after "deploy:update_code", "symlinks:make"