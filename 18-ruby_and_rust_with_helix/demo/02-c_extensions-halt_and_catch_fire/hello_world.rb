# frozen_string_literal: true

require_relative 'demo'
include Demo

begin
  Demo.halt_and_catch_fire
rescue
  puts 'All is good'
ensure
  puts "The VM didn't crash this time"
end
