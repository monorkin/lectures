#!/usr/bin/env bash

echo "################################"
echo "## BUILDING NATIVE EXTENSIONS ##"
echo "################################"
echo ""

cd crates/demo && bundle install && rake build && cd ../..

echo ""
echo "#############"
echo "## RUNNING ##"
echo "#############"
echo ""

ruby app.rb
