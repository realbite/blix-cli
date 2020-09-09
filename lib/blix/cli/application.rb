require 'open3'
require 'liquid'

module Blix
  module Cli


    class Application

      DIR_LIST = %w(
        app assets config doc features lib bin spec www
        app/controllers app/managers app/models app/views app/views/layouts
        assets/css assets/js
        config/assets
        features/support
        www/assets
      )

      FILE_LIST = %w(
        app/application.rb
        app/controllers/application_controller.rb
        app/views/layouts/application.html.erb
        app/views/welcome.html.erb
        assets/css/application.scss
        assets/js/application.js
        config/application.yml
        features/support/setup.rb
        features/application.feature
        config.ru
        Gemfile
        README.md
        Guardfile
        bin/console
        bin/bundle
      )

      WEBPACK_FILES = %w(
        webpack.config.js
        assets/js/application.webpack.js
      )

      VUE_FILES = %w(
        assets/js/components/app.vue
      )

      TEMPLATE_DIR =  File.absolute_path(File.dirname(__FILE__) + '/../../../templates')

      attr_reader :options, :root

      def initialize(root, options={})
        @root = root
        @options = Thor::CoreExt::HashWithIndifferentAccess.new.merge options
        @options[:vuebasic] = options[:vue] && !options[:webpack]
      end

      # ensure that the directory exists.
      def ensure_directory(name)
        path = File.join(root,name)
        if File.exist?(path)
          if File.directory?(path)
            NullOperation.new("have directory   #{path}")
          else
            raise Error, "cannot create directory:#{path}"
          end
        else
          DirectoryOperation.new(path)
        end
      end

      def get_template(name)
        template_name = name.gsub('/','-')
        template_path = File.join(TEMPLATE_DIR,template_name)
        if File.file?( template_path )
          File.read( template_path )
          template = Liquid::Template.parse(File.read( template_path ))
          template.render(options)
        else
          nil
        end
      end

      # ensure that the file exists.
      def ensure_file(name)
        path = File.join(root,name)
        new_contents = get_template(name)
        if File.exist?(path)
          if File.file?(path)
            old_contents = File.read(path)
            if (old_contents != new_contents) && (options[:overwrite] || confirm("overwrite file #{path}"))
              FileOperation.new(path, new_contents )
            else
              NullOperation.new("have file   #{path}")
            end
          else
            raise Error, "cannot create file:#{path}"
          end
        else
          FileOperation.new(path, new_contents )
        end
      end

      def check_command(name, version=nil)
         std, err, stat = Open3.capture3("#{name} --version")
         raise Error, err unless stat.success?
         raise Error, "need #{name} version #{version} or higher" if version && (std < version)
         true
      end

      VALID_RESPONSE = ['yes','y','no','n']

      def confirm(message)
        return true if options[:y]
        resp = nil
        loop do
          print message + '? (y/n): '
          resp = VALID_RESPONSE.index $stdin.gets.chomp.strip.downcase
          break if resp
        end
        resp < 2   # the yes responses.
      end

      # add a node package unless it exists.
      def node_package(package)
        if File.exist? File.join(root,'node_modules',package)
          NullOperation.new("have node package   #{package}")
        else
          CommandOperation.new(root, "npm install #{package} --save-dev", "install     #{package}")
        end
      end

      # setup webpack
      # npm init -y    # created package.json file
      # npm install webpack webpack-cli --save-dev
      # npm install coffeescript coffee-loader --save-dev
      #
      def webpack

        check_command("node", '4.0.0')
        check_command("npm", '6.0.0')

        CommandOperation.new(root, 'npm init -y', 'initialise       node.js') unless File.exist?(File.join(root,'package.json'))
        node_package('webpack')
        node_package('webpack-cli')
        node_package('coffeescript')
        node_package('coffee-loader')


        if options[:vue]
          node_package('vue')
          node_package('vue-template-compiler')
          node_package('vue-loader')
          node_package('vue-style-loader')
          node_package('vue-router')
          node_package('css-loader')
          node_package('sass-loader')
          ensure_directory('assets/js/components')
          VUE_FILES.sort.each{|p| ensure_file(p) }
        end

        WEBPACK_FILES.sort.each{|p| ensure_file(p) }
      end

      # generate a new application framework
      def framework
        ensure_directory('')
        DIR_LIST.sort.each{|p| ensure_directory(p) }
        FILE_LIST.sort.each{|p| ensure_file(p) }
        CommandOperation.new(File.join(root,'bin'), 'chmod a+x *', 'set permissions on bin dir') 
      end

      # setup the environment for the given options.
      def setup
        framework

        if options[:webpack]
           webpack
        end

        if (options[:'dry-run'])
          puts "dry run .."
          Operation.describe_all
        else
          Operation.execute_all
        end
      end



    end
  end
end
