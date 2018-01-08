require 'yaml'
require 'diffy'

module Murker
  # Format validation error
  class ErrorFormatter
    # Schemas are ruby hashes
    def self.call(new_schema, stored_schema)
      new_yaml = YAML.dump new_schema
      stored_yaml = YAML.dump stored_schema
      Diffy::Diff.new(stored_yaml, new_yaml).to_s
    end
  end
end
