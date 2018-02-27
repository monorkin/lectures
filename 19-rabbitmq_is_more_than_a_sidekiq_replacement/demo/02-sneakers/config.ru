#\ -s puma -o 0.0.0.0
# frozen_string_literal: true

APP_ENV = ENV['RACK_ENV'] || 'development'

require 'bundler'
Bundler.require :default, APP_ENV.to_sym

require_relative 'app'

run App.freeze.app
