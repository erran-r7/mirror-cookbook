#
# Cookbook Name:: mirror
# Recipe:: server
#
# Copyright 2013, Rapid7
#
# All rights reserved - Do Not Redistribute
#

node[:mirror][:flavors].each(&method(:include_recipe))
node[:mirror][:repositories].each(&method(:sync_repository))
