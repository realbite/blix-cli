class ApplicationController < Blix::Rest::Controller

   get '/version' do
     { :version=>Application::VERSION }
   end

   get '/welcome' , :accept=>:html do
     render_erb :welcome, :layout=>'layouts/application'
   end

   get '/*', :accept=>:html do
     redirect_to path_for('/welcome')
   end

end
