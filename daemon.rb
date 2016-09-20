require 'daemons'
PWD = File.dirname(__FILE__)
options = {
    :app_name => "btsu_worker",
    :dir_mode => :normal,
    :dir => PWD + "/logs",
    :log => PWD + "/logs",
    :log_output => true,
    :backtrace => true,
    :monitor => true,
    :keep_pid_files => true
}

Daemons.run(PWD + "/app.rb", options)
