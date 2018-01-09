require 'murker/spy'

if defined?(RSpec) && RSpec.respond_to?(:configure)
  RSpec.configure do |config|
    config.around(:each, :murker) do |ex|
      Murker.capture(&ex)
    end
  end
end
