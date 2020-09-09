module Blix
  module Cli

    # create a file system directory
    class FileOperation < Operation

      attr_reader :path, :content

      def initialize(path, content, overwrite=false)
        @path = path
        @content = content
        @overwrite = overwrite
      end

      def description
        str = if File.file?(path)
          "overwrite file   "
        else
          "create file      "
        end
        str += path
        str += "*" if content
        str
      end

      def run
        File.write(path, content || '')
      end

      def undo
        #File.unlink(path)
      end
    end


  end
end
