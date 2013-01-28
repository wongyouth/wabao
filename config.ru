# This file is used by Rack-based servers to start the application.
require ::File.expand_path('../config/environment',  __FILE__)

if Rails.env.profile?
  use Rack::RubyProf, path: ::File.expand_path('../tmp/profile',  __FILE__)
end

run Wabao::Application
