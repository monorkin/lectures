# frozen_string_literal: true

require 'mkmf'

EXTENSION_NAME = 'demo'

dir_config(EXTENSION_NAME)
create_makefile(EXTENSION_NAME)
