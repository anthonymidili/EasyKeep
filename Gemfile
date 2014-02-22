source 'https://rubygems.org'

ruby '1.9.3'

gem 'dotenv-rails', '~> 0.9.0', groups: [ :development, :test ]

gem 'rails', '3.2.16'

gem 'jquery-rails',     '~> 3.0.4'
gem 'devise',           '~> 3.2.2'
gem 'devise_invitable', '~> 1.3.2'
gem 'bcrypt',           '~> 3.1.6'
gem 'kaminari',         '~> 0.15.0'

group :development, :test do
  gem 'sqlite3',     '~> 1.3.8'
  gem 'rspec-rails', '~> 2.14.0'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'hirb'
end

group :assets do
  gem 'sass-rails',                  '~> 3.2.6'
  # Can not update beyond '5.0.3.0' until issue 'Gem foundation-rails 5.1.1.0 incompatible with the Rails asset pipeline #4494' is resolved.
  gem 'foundation-rails',            '5.0.3.0'
  gem 'foundation-icons-sass-rails', '~> 3.0.0'
  gem 'coffee-rails',                '~> 3.2.2'
  gem 'uglifier',                    '~> 2.3.2'
  gem 'jquery-ui-sass-rails',        '~> 4.0.3'
end

group :production do
  gem 'pg', '~> 0.17.0'
end
