def example_path
  rails_version = ENV['BUNDLE_GEMFILE'].to_s.match(/rails_\d/)
  if rails_version
    File.expand_path("../../../test_apps/rails_51", __FILE__)
  else
    raise "Use `appraisal rails-5 cucumber ...` or export BUNDLE_GEMFILE=gemfiles/... explicitly"
  end
end

require 'fileutils'
require 'aruba/cucumber'

require 'rspec/expectations'

require "#{example_path}/config/environment"

Before do
  @dirs = [example_path]
  @aruba_timeout_seconds = 30
end
