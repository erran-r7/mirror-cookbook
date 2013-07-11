#
# Cookbook Name:: mirror
# Recipe:: git
#
# Copyright 2013, Rapid7
#
# All rights reserved - Do Not Redistribute
#

include_recipe(node[:mirror][:server] ? 'git::server' : 'git')
