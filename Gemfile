source 'https://rubygems.org'

gem 'rails'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# For running under windows, see :
# http://stackoverflow.com/questions/8847969/installing-typo-with-bundle-install-error-on-bluecloth-gem
# About how to build bluecloth on windows, like with RailsInstaller
# I (rhaamo) recommands to use RailsInstaller bundle, better and easy than all pieces by hand
gem 'mysql2'

gem 'haml'
gem 'twitter-bootstrap-rails'

# Some gems aren't available under windows
platforms :ruby do
	gem 'unicorn'
	gem 'therubyracer'
	gem 'rmagick'
end

# And some ...
# Please follow https://github.com/rmagick/rmagick/wiki
# To install required stuff
# path=c:\RailsInstaller\ImageMagick-6.7.9-Q8;%path%
# gem install rmagick -- '--with-opt-dir="c:\RailsInstaller\ImageMagick-6.7.9-Q8"'
#gem 'rmagick'
gem 'mini_magick'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'newrelic_rpm'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'authlogic'
gem 'sentient_user'
gem 'kaminari'
gem 'cancan'
gem 'friendly_id'
gem 'randumb'   # https://github.com/spilliton/randumb
gem 'carrierwave' # https://github.com/jnicklas/carrierwave
gem "nested_form", :git => "git://github.com/ryanb/nested_form.git"
gem "bb-ruby", :git => "git://github.com/marcandre/bb-ruby.git"
gem 'markitup_rails', :git => "git://github.com/NuxosMinecraft/markitup_rails.git"
gem 'ledermann-rails-settings', :require => 'rails-settings', :git => "git://github.com/ledermann/rails-settings.git" # https://github.com/ledermann/rails-settings
gem 'redcarpet' # markdown
gem 'unread' # https://github.com/ledermann/unread
gem 'squeel' # https://github.com/ernie/squeel
gem 'activemerchant', :require => 'active_merchant'
gem 'by_star' # https://github.com/radar/by_star
gem 'exceptional' # https://www.exceptional.io/
gem 'jsonapi', :git => "git://github.com/kreeger/jsonapi-ruby.git" # JSONAPI bukkit/minecraft API
gem 'nokogiri'
