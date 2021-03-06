set :application, "application_name_here"
default_run_options[:pty] = true
set :branch, "origin/master"
set :scm, :git
set :repository,  "git@git.myserver.com:/#{application}.git"
set :uses_ssl, false
set :normal_symlinks, %w(
  config/database.yml
)
set :weird_symlinks, {
  "system"             => "public/system",
  "logs"               => "log"
}
