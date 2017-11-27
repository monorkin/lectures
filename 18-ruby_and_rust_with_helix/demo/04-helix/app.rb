# frozen_string_literal: true

APP_ENV = ENV['RACK_ENV'] || 'development'

require 'bundler'
Bundler.require :default, APP_ENV.to_sym

require_relative 'hello_world'
