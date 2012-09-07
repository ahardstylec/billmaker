class Billmaker < Padrino::Application
  register SassInitializer
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Routing
  register Padrino::Helpers
  register Padrino::Admin::AccessControl

  

  enable :sessions
  require 'awesome_print' 
  require 'magic_encoding'
  
  # -*- encoding : utf-8 -*-
  #require "pony"

  ##
  # Application configuration options
  #
  # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
  # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
  # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
  # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
  # set :public_folder, "foo/bar" # Location for static assets (default root/public)
  # set :reload, false            # Reload application files (default in development)
  # set :default_builder, "foo"   # Set a custom form builder (default 'StandardFormBuilder')
  # set :locale_path, "bar"       # Set path for I18n translations (default your_app/locales)
  # disable :sessions             # Disabled sessions by default (enable if needed)
  # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
  # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
  #

  ##
  # You can configure for a specified environment like:
  #
  #   configure :development do
  #     set :foo, :bar
  #     disable :asset_stamp # no asset timestamping for dev
  #   end
  #

  ##
  # You can manage errors like:
  #
  #   error 404 do
  #     render 'errors/404'
  #   end
  #
  #   error 505 do
  #     render 'errors/505'
  #   end
  #

  enable :authentication
  enable :store_location
  set    :login_page, "/login/new"

  access_control.roles_for :any do |role|
    role.protect "/"
    role.allow :sessions
    role.allow "/login"
    role.allow "/login/create"
  end

  access_control.roles_for :user do |role|
    role.allow "home"
    role.allow "clients"
    role.allow "/login/destroy"
  end  

  access_control.roles_for :admin do |role|
    role.allow "base"
    role.allow "login/destroy"
    role.project_module :accounts, '/accounts'
  end

end