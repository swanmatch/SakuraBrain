# encoding: utf-8
source 'https://rubygems.org'
#ruby '1.9.3', :engine => 'jruby', :engine_version => '1.7.27'
#ruby '2.0.0', engine: "jruby", engine_version: "1.7.26"
ruby '2.3.1', engine: :ruby

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.7.1'
# Use jdbcmysql as the database for Active Record
# Include database gems for the adapters found in the database
# configuration file
require 'erb'
require 'yaml'
database_file = File.join(File.dirname(__FILE__), "config/database.yml")
if File.exist?(database_file)
  database_config = YAML::load(ERB.new(IO.read(database_file)).result)
  adapters = database_config.values.map {|c| c['adapter']}.compact.uniq
  if adapters.any?
    adapters.each do |adapter|
      case adapter
      when 'mysql2'
        gem "mysql2", "~> 0.3.11", :platforms => [:mri, :mingw, :x64_mingw]
        gem "activerecord-jdbcmysql-adapter", :platforms => :jruby
      when 'mysql'
        gem "activerecord-jdbcmysql-adapter", :platforms => :jruby
      when /postgresql/
        gem "pg", "~> 0.18.1", :platforms => [:mri, :mingw, :x64_mingw]
        gem "activerecord-jdbcpostgresql-adapter", :platforms => :jruby
      when /sqlite3/
        gem "sqlite3", :platforms => [:mri, :mingw, :x64_mingw]
        gem "jdbc-sqlite3", ">= 3.8.10.1", :platforms => :jruby
        gem "activerecord-jdbcsqlite3-adapter", :platforms => :jruby
      when /sqlserver/
        gem "tiny_tds", "~> 0.6.2", :platforms => [:mri, :mingw, :x64_mingw]
        gem "activerecord-sqlserver-adapter", :platforms => [:mri, :mingw, :x64_mingw]
      else
        warn("Unknown database adapter `#{adapter}` found in config/database.yml, use Gemfile.local to load your own database gems")
      end
    end
  else
    warn("No adapter found in config/database.yml, please configure it first")
  end
else
  warn("Please configure your config/database.yml first")
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyrhino'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'mime-types', '< 3', require: false

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]



group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
#  gem 'byebug'
  # i18n
  gem 'i18n_generators'
  # better active record console
  gem 'hirb'
  gem 'hirb-unicode'
  # log制御
  gem 'quiet_assets'
  gem 'better_errors'
  # gem 'binding_of_caller'
  # migration edit on web
  gem 'ryakuzu', '0.2.6'
  gem 'bullet'
end

#group :development do
#  # Access an IRB console on exception pages or by using <%= console %> in views
##  gem 'web-console', '~> 2.0'
#
#  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
##  gem 'spring'
#end

#group :production do
#  gem 'rails_12factor'
#end

# shirotori_add
gem 'pry-rails'
gem 'pry-doc'

gem 'rb-readline', require: false
gem 'simple_form'

gem 'bootstrap-sass'

# app server
gem 'puma'

# log out with lotate by date
gem 'log4r'

# shirotori_add for save_user_info management
gem 'record_with_operator'

# save session to active record
gem 'activerecord-session_store'

gem "select2-rails"
#gem 'momentjs-rails'
#gem 'bootstrap-datepicker-rails', '1.1.1.11'
gem 'jquery-ui-rails'

gem 'kaminari', '0.17.0'

gem 'seed_dump'

gem 'enum_help', '0.0.15'

gem 'ruby_brain'
