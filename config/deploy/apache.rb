namespace :deploy do
  namespace :apache do
    task :setup, :roles => :web do
      return unless web_server == :apache
      if uses_ssl
        deploy.apache.ssl.setup
      else
        apache_config_file = <<-EOF
          <VirtualHost *:80>
              ServerName www.#{domain}
              ServerAlias #{domain}
              DocumentRoot #{deploy_to}/current/public
              <Directory #{deploy_to}/current/public>
                  Allow from all
                  Options -MultiViews
              </Directory>
          </VirtualHost>
        EOF
        sudo_put apache_config_file, "#{apache_conf_dir}/#{application}.conf"
      end
    end
    namespace :ssl do
      task :setup, :roles => :web do
      end
    end
  end
  after "deploy:setup", "deploy:apache:setup"
end