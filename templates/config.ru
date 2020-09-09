MODE = ENV['RACK_ENV']

require_relative 'app/application'

Application.initialize

if MODE=='production'

   use Rack::Static, :urls => ['/static', '/assets'], :root => 'www'

elsif MODE=='development'

   puts 'development mode'

   require 'rack-livereload'
   require 'sprockets'

   {%- if vuebasic %}
   require 'vue/sprockets'
   Vue::Compiler.set_options :version => '2.6'
   VueSprocketsCompiler.set_root %w[app]
   {%- endif %}

   {%- if webpack  %}
   require 'sprockets/webpackit'
   {%- endif %}

   use Rack::Static, :urls => ['/static'], :root => 'www'
   use Rack::Reloader
   use Rack::LiveReload, :no_swf=>true

   map '/assets' do
     environment = Sprockets::Environment.new
     environment.append_path 'assets/js'
     environment.append_path 'assets/css'

     run environment
   end

 else # test
   ;
 end

 run Blix::Rest::Server.new
