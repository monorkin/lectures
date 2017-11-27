# frozen_string_literal: true

# Optional and KV arguments are not yet supported
Demo.hello_world(nil)
Demo.hello_world('Ruby Zagreb!')

begin
  Demo.hello_world(Object.new)
rescue TypeError
  puts 'Rescued from TypeError'
end
