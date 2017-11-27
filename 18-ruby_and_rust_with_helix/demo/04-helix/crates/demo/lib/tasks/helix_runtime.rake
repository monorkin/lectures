require 'helix_runtime/build_task'

HelixRuntime::BuildTask.new('demo')

task default: :build
