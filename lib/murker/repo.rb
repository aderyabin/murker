require 'murker/generator'
require 'fileutils'

module Murker
  # Repo to store and retreive schemas for interactions
  # Repo serializes schemas to yml and deserializes to ruby objects to retreive
  class Repo
    SCHEMAS_PATH = 'spec/murker'.freeze

    def self.store_schema_for(interaction)
      schema = Generator.call(interaction: interaction)
      path = path_for(interaction)
      store(schema, path)
    end

    def self.retreive_schema_for(interaction)
      deserialize_schema File.read(path_for(interaction))
    end

    def self.has_schema_for?(interaction)
      File.exist? path_for(interaction)
    end

    def self.path_for(interaction)
      endpoint_path = interaction.endpoint_path
      verb = interaction.verb.to_s.upcase
      name = File.join(SCHEMAS_PATH, endpoint_path, verb)
      name.gsub!(/:/, '__')
      "#{name}.yml"
    end

    def self.store(schema, path)
      ensure_directory_exists(path)
      File.write path, serialize_schema(schema)
    end

    def self.ensure_directory_exists(path)
      dirname = File.dirname(path)
      FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
    end

    def self.serialize_schema(schema)
      YAML.dump schema
    end

    def self.deserialize_schema(schema)
      YAML.safe_load schema
    end
  end
end
