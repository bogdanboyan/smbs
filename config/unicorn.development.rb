worker_processes 5

pid         'tmp/pids/unicorn.pid'
stderr_path 'log/unicorn.development.log'

listen File.expand_path("tmp/sockets/unicorn.sock"), :backlog => 64
listen 3000, :tcp_nopush => true

timeout 30
