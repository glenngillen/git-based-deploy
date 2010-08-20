task :production do
  role :web, domain
  role :app, domain
  role :db,  domain, :primary => true
end

task :staging do
  role :web, domain
  role :app, domain
  role :db,  domain, :primary => true
end