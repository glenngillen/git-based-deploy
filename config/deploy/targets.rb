task :production do
  role :web, domain
  role :app, domain
  role :db,  domain, :primary => true
  set :web_server, :nginx
  set :web_port, "80"
end

task :staging do
  role :web, domain
  role :app, domain
  role :db,  domain, :primary => true
  set :web_server, :nginx
  set :web_port, "80"
end