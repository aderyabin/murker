require 'pry'

def example_path
  rails_version = ENV['BUNDLE_GEMFILE'].to_s.match(/rails_\d/)
  if rails_version
    path = File.expand_path("../../../test_apps/rails_51", __FILE__)
    puts '********'
    puts path
    puts '********'
    path
  else
    raise "Use `appraisal rails-XY cucumber ...` or export BUNDLE_GEMFILE=gemfiles/... explicitly"
  end
end

require 'fileutils'
require 'aruba/cucumber'

require 'rspec/expectations'

require "#{example_path}/config/environment"

World(RSpec::Matchers)

Before do
  @dirs = [example_path]
  @aruba_timeout_seconds = 30
end
