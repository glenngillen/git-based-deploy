set :application, "APP_NAME_HERE"
set :domain, 'mydomain.com'
default_run_options[:pty] = true
set :repository,  "ssh://git.#{domain}/var/git/#{application}.git"
set :branch, 'origin/master'
set :scm, :git
role :web, domain
role :app, domain
role :db,  domain, :primary => true
set :nginx_log_dir, '/var/log/nginx'
set :nginx_conf_dir, '/etc/nginx/sites-enabled'
set :nginx_pid, '/var/run/nginx.pid'
set :user, 'deploy'
set :deploy_to, "/var/www/apps/#{application}"
set :uses_ssl, false
set :ruby_path, "/usr/local/ruby19/bin"
set :web_server, :nginx