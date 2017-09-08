lock "3.9.0"

set :application, "ienpop-website"
set :repo_url, "https://github.com/makingdevs/Ienpop-website"
set :rbenv_ruby, '2.4.0'

set :puma_user, fetch(:user)
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

namespace :bower do

  desc "Install the current Bower environment"
  task :install do
    on roles(:app) do
      execute "cd #{release_path} && bower install"
    end
  end

end

after "deploy:symlink:linked_dirs", "bower:install"
