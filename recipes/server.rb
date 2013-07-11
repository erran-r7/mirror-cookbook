#
# Cookbook Name:: mirror
# Recipe:: server
#
# Copyright 2013, Rapid7
#
# All rights reserved - Do Not Redistribute
#
# Currently this recipe will mirror git and mercurial repositories

node.set[:mirror][:server] = true
include_recipe 'mirror::default'
