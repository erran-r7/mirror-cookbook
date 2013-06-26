#
# Cookbook Name:: mirror
# Attribute:: default
#
# Copyright 2013, Rapid7
#
# All rights reserved - Do Not Redistribute
#

# A hash in the format:
# {
#   :'chef-repo' => {
#     :repository => 'https://github.com/rapid7/chef-repo',
#     :reference => 'HEAD',
#   }
# }
#
# NOTE: You can add an "auxiliary path" by naming the repository with a / in the
#   name, i.e. :'repo-group/repo-name'
default[:mirror][:repositories] = {}
default[:mirror][:repository_path] = '/opt' # REVIEW
