source :rubygems

gem 'rails', '3.0.0'
gem 'mysql'
gem 'authlogic', :git => 'git://github.com/odorcicd/authlogic.git', :branch => 'rails3' 
gem "authlogic-oid", '>= 1.0.4', :require => "authlogic_openid"
gem "ruby-openid", '>= 2.1.7', :require => "openid"
gem 'nokogiri', '>= 1.3.2'
gem 'rdiscount', '>= 1.3.5'
gem 'feedzirra', '>= 0.0.20'
gem 'delayed_job', '>= 1.8.4'
gem 'unindentable', '>= 0.0.1'
gem 'paperclip', '>= 2.3.3'
gem 'aws-s3', '>= 0.6.2'
gem 'awesome_nested_set', :git => "git://github.com/FreakyDazio/awesome_nested_set.git"
gem 'will_paginate', '2.3.15'
gem 'acts_as_versioned', :git => "git://github.com/xspond/acts_as_versioned.git", :branch => "rails3"

group :test do
  gem 'shoulda', ">= 2.10.0", :require => 'shoulda'
  gem 'rr', '>= 0.10.0'
  gem 'machinist', ">= 1.0.6"
  gem 'faker', '>= 0.3.1'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'cucumber'
  gem 'rspec-rails'
  gem 'spork'
  gem 'launchy'    # So you can do Then show me the page
end

group :development, :test do
  gem 'mongrel'
  gem 'ruby-debug'
end
