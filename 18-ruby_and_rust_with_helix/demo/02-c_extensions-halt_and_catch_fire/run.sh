#!/usr/bin/env bash

echo "################################"
echo "## BUILDING NATIVE EXTENSIONS ##"
echo "################################"
echo ""

ruby extconf.rb && make

echo ""
echo "#############"
echo "## RUNNING ##"
echo "#############"
echo ""

ruby hello_world.rb
