#
# Cookbook Name:: mirror
# Attribute:: mac_os_x
#
# Copyright 2013, Rapid7
#
# All rights reserved - Do Not Redistribute
#


if platform? 'mac_os_x'
  default[:mirror][:git_version] = '1.8.3.2'
  default[:mirror][:git_checksum] = '6817f6a2ea2ce4b40a445f5e3c58a7e4e97d95a9'
  default[:mirror][:git_package] = "https://git-osx-installer.googlecode.com/files/git-#{node[:mirror][:git_version]}-intel-universal-snow-leopard.dmg"
end
