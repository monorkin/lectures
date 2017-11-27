# frozen_string_literal: true

require_relative 'demo'
include Demo

Demo.hello_world

Demo.hello_world('Ruby Zagreb!')

begin
  Demo.hello_world(Object.new)
rescue
  puts 'Caught error'
ensure
  puts 'Ensured something'
end
