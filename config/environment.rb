# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem "thoughtbot-clearance", 
    :lib     => 'clearance', 
    :source  => 'http://gems.github.com', 
    :version => '0.5.3'
  
  config.gem 'mislav-will_paginate', 
    :lib => 'will_paginate',
    :source => 'http://gems.github.com',
    :version => '2.3.8'
  
  config.gem 'twitter', :version => '0.6.15'
  
  config.time_zone = 'UTC'
end

DO_NOT_REPLY = "donotreply@example.com"

ConsumerConfig = YAML.load(File.read(Rails.root + 'config' + 'consumer.yml'))