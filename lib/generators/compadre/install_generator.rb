require 'rails/generators'
require 'pry'

module Compadre
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      argument :user_class, type: :string, default: "User"

      def create_migrations
        Dir["#{self.class.source_root}/migrations/*.rb"].sort.each do |filepath|
          name = File.basename(filepath)
          template "migrations/#{name}", "db/migrate/#{next_migration_number}_#{name}"
          sleep 1
        end
      end

      def create_initializer_file
        # Refactor to match below implementation
        copy_file("compadre.rb", "config/initializers/compadre.rb")
        config = File.read("config/initializers/compadre.rb")
        config.gsub!(/klass/, "\"#{user_class.underscore.classify}\"")
        File.open("config/initializers/compadre.rb", "w") {|file| file.puts config }
      end

      def add_route_mount
        f    = "config/routes.rb"
        str  = "mount Compadre::Engine => '/#{user_class.underscore.pluralize}', as: 'compadre'"

        if File.exist?(File.join(destination_root, f))
          line = parse_file_for_line(f, str)

          unless line
            line = "Rails.application.routes.draw do"
            existing_user_class = false
          else
            existing_user_class = true
          end

          if parse_file_for_line(f, str)
            say_status("skipped", "Routes already exist at #{user_class.underscore}")
          else
            insert_after_line(f, line, str)

            if existing_user_class
              scoped_routes = ""+
                "as :#{user_class.underscore} do\n"+
                "    # Define routes for #{user_class} within this block.\n"+
                "  end\n"
              insert_after_line(f, str, scoped_routes)
            end
          end
        else
          say_status("skipped", "config/routes.rb not found. Add \"#{str}\" to your routes file.")
        end
      end

      private

      def next_migration_number
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end

      def insert_after_line(filename, line, str)
        gsub_file filename, /(#{Regexp.escape(line)})/mi do |match|
          "#{match}\n  #{str}"
        end
      end

      def parse_file_for_line(filename, str)
        match = false

        File.open(File.join(destination_root, filename)) do |f|
          f.each_line do |line|
            if line =~ /(#{Regexp.escape(str)})/mi
              match = line
            end
          end
        end
        match
      end
    end
  end
end
