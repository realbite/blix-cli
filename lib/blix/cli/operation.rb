module Blix
  module Cli

    class Operation

      class << self
        def list
          @@_list ||= []
        end

        def reset!
          list.clear
        end

        def execute_all
          list.each(&:perform)
        end

        def describe_all
          list.each(&:describe)
        end

        alias :old_new :new

        def new(*args)

          o = old_new(*args)
          self.list << o
          o
        end

      end

      def description
        ''
      end

      def describe
        puts description
      end

      def perform
        puts description
        run
      end

      def run
      end

      def undo
      end

    end



  end
end
