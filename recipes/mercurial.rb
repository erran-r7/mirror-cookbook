#
# Cookbook Name:: mirror
# Recipe:: mercurial
#
# Copyright 2013, Rapid7
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'mercurial::pip'

if node[:mirror][:server]
  python_pip 'hg-git'
end

template "#{ENV['HOME']}/.hgrc"
