require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module GrqphqlDemo
  class Application < Rails::Application
  end
end
