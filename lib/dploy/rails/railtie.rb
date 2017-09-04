require 'rails'

module Dploy
  module Rails
    class Railtie < ::Rails::Railtie
      railtie_name :deploy_rails
      rake_tasks do
        load 'tasks/deploy.rake'
      end
    end
  end
end
