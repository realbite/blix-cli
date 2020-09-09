# frozen_string_literal: true

require 'blix/rest'
require 'blix/utils'
require 'blix/assets'

require_relative 'controllers/application_controller.rb'

class Application

  VERSION = '0.1.1'

  class << self

    # get the application configuration as specified in the
    # configuration yml file.
    def config
      @config ||= Blix::YamlConfig.new(:name => 'application')
    end

    # perform any initialization for your application here .. eg set up your
    # database.

    def initialize(*args); end

  end

end
