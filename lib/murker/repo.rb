require 'murker/generator'
require 'fileutils'

module Murker
  # Repo to store and retreive schemas for interactions
  class Repo
    SCHEMAS_PATH = 'spec/murker'.freeze

    def store_schema_for(interaction, generator_class: Generator)
      schema = generator_class.call(interaction: interaction)
      path = path_for(interaction)
      store(schema, path)
    end

    def retreive_schema_for(interaction)
      File.read path_for(interaction)
    end

    def has_schema_for?(interaction)
      File.exist? path_for(interaction)
    end

    def path_for(interaction)
      path = interaction.endpoint_path
      verb = interaction.verb.to_s.upcase
      name = File.join(SCHEMAS_PATH, path, verb.to_s.upcase)
      name.gsub!(/:/, '__')
      "#{name}.txt"
    end

    private

    def store(schema, path)
      ensure_directory_exists(path)
      File.write path, schema
    end

    def ensure_directory_exists(path)
      dirname = File.dirname(path)
      FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
    end
  end
end
