require 'rails/generators'
require 'pry'

module Compadre
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      def create_migrations
        Dir["#{self.class.source_root}/migrations/*.rb"].sort.each do |filepath|
          name = File.basename(filepath)
          template "migrations/#{name}", "db/migrate/#{next_migration_number}_#{name}"
          sleep 1
        end
      end

      def create_initializer_file
        copy_file("compadre.rb", "config/initializers/compadre.rb")
      end

      private

      def next_migration_number
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end
    end
  end
end
