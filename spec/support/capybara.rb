require 'selenium-webdriver' #追記
require 'capybara/rspec' #追記

Capybara.configure do |config| #追記
  config.default_max_wait_time = 5   #追記
end #追記
