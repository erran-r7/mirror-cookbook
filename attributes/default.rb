#
# Cookbook Name:: mirror
# Attribute:: default
#
# Copyright 2013, Rapid7
#
# All rights reserved - Do Not Redistribute
#

default[:mirror][:flavors] = [:git]
# A hash in the format:
# {
#   :'chef-repo' => {
#     :repository => 'https://github.com/rapid7/chef-repo',
#     :reference => 'HEAD',
#   }
# }
default[:mirror][:repositories] = {}

# NOTE: This path is created by the git::server recipe
#       The git::server recipe uses git::shell
default[:mirror][:repository_path] = '/srv/git'
default[:mirror][:server] = false
