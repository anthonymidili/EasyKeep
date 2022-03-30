source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.2'

# puma in place of Default Webrick
gem 'puma', '~> 4.3.12'

gem 'devise', '~> 4.7.1'
gem 'devise_invitable', '~> 2.0.1'

gem 'haml-rails', '~> 2.0.1'

gem 'bcrypt', '~> 3.1.10'
gem 'kaminari', '~> 1.2.0'
gem 'pg', '~> 1.2.2'
gem 'dynamic_sitemaps', '~> 2.0.0'
# https://github.com/zurb/foundation-rails
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.8'
gem 'responders', '~> 3.0'
# https://github.com/norman/friendly_id turns ids into friendly addresses
gem 'friendly_id', '~> 5.3.0'
# Dynamic nested forms using jQuery
gem 'cocoon', '~> 1.2.12'

gem 'mini_magick', '~> 4.10.1'
gem 'carrierwave', '~> 2.1.0'
gem 'fog-aws', '~> 3.6.2'

gem 'rspec-rails', '~> 4.0.0', group: [:development, :test]

gem 'bootsnap', '~> 1.4.0'

gem 'webpacker', '~> 5.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Shim to load environment variables from .env
  gem 'dotenv-rails', '~> 2.7.5'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 2.1.0'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # N+1 Finder
  gem 'bullet'
end
