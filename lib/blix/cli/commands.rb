
module Blix
  module Cli
    class Commands < Thor

      desc 'new NAME', 'create a new blix application'
      option :'dry-run', :type => :boolean, :desc=>'do not perform any updates to the system'
      option :overwrite, :type => :boolean, :desc=>'overwrite files if they already exist!'
      option :webpack, :type => :boolean, :desc=>'initialize webpack environment'
      option :vue, :type => :boolean, :desc=>'initialize vue.js environment'
      option :y, :type => :boolean, :desc=>'answer yes to all confirm prompts'

      def new(name)

        raise Error, "invalid path" unless name =~ /^[a-zA-Z_\-\.0-9]+$/

        app = Application.new(name, options)
        app.setup

      end

      #-------------------------------------------------------------------------

      desc 'update', 'update an application directory'
      option :'dry-run', :type => :boolean, :desc=>'do not perform any updates to the system'
      option :overwrite, :type => :boolean, :desc=>'overwrite files if they already exist!'
      option :webpack, :type => :boolean, :desc=>'initialize webpack environment'
      option :vue, :type => :boolean, :desc=>'initialize vue.js environment'
      option :y, :type => :boolean, :desc=>'answer yes to all confirm prompts'

      def update

        app = Application.new('.', options)
        app.setup

      end


    end
  end
end
