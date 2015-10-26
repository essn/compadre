module Compadre
  class Engine < ::Rails::Engine
    engine_name 'compadre'

    isolate_namespace Compadre

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end
