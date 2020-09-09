# frozen_string_literal: true

require 'thor'

module Blix
  module Cli
    class Error < StandardError; end
  end
end


require_relative 'cli/version'
require_relative 'cli/operation'
require_relative 'cli/operations/null'
require_relative 'cli/operations/directory'
require_relative 'cli/operations/file'
require_relative 'cli/operations/command'
require_relative 'cli/application'

require_relative 'cli/commands'
