require 'open3'


module Blix
  module Cli

    # create a file system directory
    class CommandOperation < Operation

      attr_reader :path, :command

      def initialize(path, command, desc)
        @path = path
        @command = command
        @desc = desc
      end

      def description
        @desc || "run command: #{command}"
      end

      def run
        Dir.chdir(path) do
          std, err, stat = Open3.capture3("#{command}")
          unless stat.success?
            puts "----------------------------------------"
            puts err
            puts "----------------------------------------"
          end
        end
      end

      def undo

      end
    end


  end
end
