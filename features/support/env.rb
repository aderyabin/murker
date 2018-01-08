require 'pry'
def example_path
  rails_version = ENV['BUNDLE_GEMFILE'].to_s.match(/rails_\d/).to_s
  raise 'Use `appraisal rails-5 cucumber ...`' unless rails_version == 'rails_5'

  File.expand_path('../../../test_apps/rails_51', __FILE__)
end

require 'fileutils'
require 'aruba/cucumber'

require 'rspec/expectations'

require "#{example_path}/config/environment"

Before do
  @dirs = [example_path]
  @aruba_timeout_seconds = 30
end
