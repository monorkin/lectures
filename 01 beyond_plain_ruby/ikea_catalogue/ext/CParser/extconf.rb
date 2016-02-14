require 'mkmf'

# Give it a name
extension_name = 'CParser'

# The destination
dir_config(extension_name)

# Do the work
create_makefile(extension_name)
