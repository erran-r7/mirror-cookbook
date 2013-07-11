#
# Cookbook Name:: mirror
# Recipe:: default
#
# Copyright 2013, Rapid7
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'homebrew' if platform? 'mac'
node[:mirror][:flavors].each(&method(:include_recipe))
node[:mirror][:repositories].each(&method(:sync_repository))
