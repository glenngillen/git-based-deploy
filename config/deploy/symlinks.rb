set :normal_symlinks, %w(
  config/database.yml
)
 
set :weird_symlinks, {
  'system'             => 'public/system'
}
 
namespace :symlinks do
  task :make, :roles => :app, :except => { :no_release => true } do
    run "mkdir -p #{current_path}/tmp"
    commands = normal_symlinks.map do |path|
      "rm -rf #{current_path}/#{path} && \
       ln -s #{shared_path}/#{path} #{current_path}/#{path}"
    end
     
    commands += weird_symlinks.map do |from, to|
      "rm -rf #{current_path}/#{to} && \
       ln -s #{shared_path}/#{from} #{current_path}/#{to}"
    end
     
    run <<-CMD
      cd #{current_path} &&
      #{commands.join(" && ")}
    CMD
  end
end 
after "deploy:update_code", "symlinks:make"