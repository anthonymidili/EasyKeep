# Used with gem 'rack-timeout' to tell web server puma to terminate long running requests and locate their source.
Rack::Timeout.timeout = 20  # seconds
