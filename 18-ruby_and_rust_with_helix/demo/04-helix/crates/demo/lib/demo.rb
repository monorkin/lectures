require 'helix_runtime'

begin
  require 'demo/native'
rescue LoadError
  warn 'Unable to load demo/native. Please run `rake build`'
end
