# unicorn_rails -c /home/vinyldb/VinylDB/config/unicorn.rb -E production -D
# Picked from https://github.com/blog/517-unicorn

rails_env = ENV['RAILS_ENV'] || 'production'

# ADAPT TO YOUR APP HERE
USER="stock.example.com"
GROUP=USER
USER_ROOT="/home/" + USER
RAILS_ROOT=USER_ROOT + "/electrostock"
# STOP EDIT

# 10 workers and 1 master
worker_processes (rails_env == 'production' ? 5 : 4)

pid RAILS_ROOT + "/tmp/pids/unicorn.pid"

stderr_path RAILS_ROOT + "/log/unicorn.stderr.log"
stdout_path RAILS_ROOT + "/log/unicorn.stdout.log"

# Load the app into the master before forking workers for super-fast worker spawn times
preload_app true

# Restart any workers that haven't responded in 30 seconds
timeout 30

# Listen on an Unix data socket
listen USER_ROOT + '/electrostock.sock', :backlog => 2048

###
# Ree
# http://www.rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
if GC.respond_to?(:copy_on_write_friendly=)
    GC.copy_on_write_friendly = true
end

before_fork do |server, worker|
  ##
  # When sent a USR2, Unicorn will suffix its pidfile with .oldbin and
  # immediately start loading up a new version of itself (loaded with a new
  # version of our app). When this new Unicorn is completely loaded
  # it will begin spawning workers. The first worker spawned will check to
  # see if an .oldbin pidfile exists. If so, this means we've just booted up
  # a new Unicorn and need to tell the old one that it can now die. To do so
  # we send it a QUIT.
  #
  # Using this method we get 0 downtime deploys.

  old_pid = RAILS_ROOT + '/tmp/pids/unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection

  # Unicorn master is started as root, wich is fine, but let's
  # drop the workers to vinyldb:users

  begin
    uid, gid = Process.euid, Process.egid
    user, group = USER, GROUP
    target_uid = Etc.getpwnam(user).uid
    target_gid = Etc.getgrnam(group).gid
    worker.tmp.chown(target_uid, target_gid)
    if uid != target_uid || gid != target_gid
      Process.initgroups(user, target_gid)
      Process::GID.change_privilege(target_gid)
      Process::UID.change_privilege(target_uid)
    end
  rescue => e
    if RAILS_ENV == 'development'
      STDERR.puts "couldn't change user, oh well"
    else
      raise e
    end
  end
end

