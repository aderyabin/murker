require 'json-diff'

module Murker
  # Format validation error
  class ErrorFormatter
    # Schemas are ruby hashes
    def self.call(new_schema, stored_schema)
      JsonDiff.diff(
        stored_schema,
        new_schema,
        include_was: true,
      )
    end
  end
end
