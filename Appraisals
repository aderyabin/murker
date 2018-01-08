appraise 'rails-5' do
  gem 'rails', '5.1.4'

  source 'https://rubygems.org'

  git_source(:github) do |repo_name|
    repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
    "https://github.com/#{repo_name}.git"
  end

  # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
  gem 'rails', '~> 5.1.4'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  # Use Puma as the app server
  gem 'puma', '~> 3.7'

  # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
  gem 'turbolinks', '~> 5'
  # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
  gem 'jbuilder', '~> 2.5'

  # Use Capistrano for deployment
  # gem 'capistrano-rails', group: :development
  gem 'active_model_serializers'

  group :development, :test do
    gem 'rspec-rails', '~> 3.6'
  end

  group :development do
    # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
    gem 'web-console', '>= 3.3.0'
    gem 'listen', '>= 3.0.5', '< 3.2'
    gem 'spring'
    gem 'spring-watcher-listen', '~> 2.0.0'
    gem 'nested_scaffold'
  end

  # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
  gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
end
