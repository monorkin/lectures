#!/bin/bash

cd /usr/src/app

# ./bin/delayed_job start
# rake db:drop db:create db:migrate
rake db:create db:migrate
./bin/rails server -b 0.0.0.0 --pid /tmp/server.pid
