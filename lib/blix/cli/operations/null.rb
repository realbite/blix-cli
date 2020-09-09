module Blix
  module Cli

    # create a file system directory
    class NullOperation < Operation

      attr_reader :message

      def initialize(message)
        @message = message
      end

      def description
        message
      end

      def run

      end

      def undo

      end
    end


  end
end
