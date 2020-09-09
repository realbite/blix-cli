module Blix
  module Cli

    # create a file system directory
    class DirectoryOperation < Operation

      attr_reader :path

      def initialize(path)
        @path = path
      end

      def description
        "create directory #{path}"
      end

      def run
        Dir.mkdir(path)
      end

      def undo
        Dir.rmdir(path)
      end
    end


  end
end
