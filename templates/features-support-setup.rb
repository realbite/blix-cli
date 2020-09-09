require 'bundler'
Bundler.setup(:default, :test)

require 'blix/rest/cucumber'
require_relative '../../app/application'



# the application get loaded from config.ru automatically
# when the first test is run.

# need to setup the database here and not in config.ru for
# the tests because we need it setup for the clear database
# hook which is run before the first test.

Application.initialize
