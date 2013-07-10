#
# Cookbook Name:: mirror
# Recipe:: git
#
# Copyright 2013, Rapid7
#
# All rights reserved - Do Not Redistribute
#

package 'git'

case node[:mirror][:git][:protocol]
when :git
when :http
when :ssh
  user 'git' do
    shell '/usr/bin/git-shell'
    group 'git'
  end

  if platform?('mac_os_x')
    # The script is from: http://themacadmin.com/?p=49
    # ---
    # # Turn on remote login
    # systemsetup -setremotelogin on
    #
    # # Create the com.apple.access_ssh group
    # dseditgroup -o create -q com.apple.access_ssh
    #
    # # Add the admin group to com.apple.access_ssh
    # dseditgroup -o edit -a admin -t group com.apple.access_ssh
    # ---
    #
    # Here's the author's reply to only enabling it for a single user:
    # ---
    # # Add user with the shortname “fred” to com.apple.access_ssh
    # dseditgroup -o edit -a fred -t user com.apple.access_ssh
    # ---

    # TODO: Can this be done with Chef groups? There's a Dscl provider, but I'm
    #       not sure if it'd work with dseditgroup.
    bash 'Enable Remote Login (SSH)' do
      code <<-SETUP
        systemsetup -setremotelogin on
        dseditgroup -o create -q com.apple.access_ssh
        dseditgroup -o edit -a git -t user com.apple.access_ssh
      SETUP

      user 'root'
    end
  elsif %w[debian rhel].include?(node[:platform_family])
    package 'openssh-server'
    service('sshd') { action :enable }
  end

  conf_path = value_for_platform({
    'mac_os_x' => '/etc/sshd_config',
    'default' => '/etc/ssh/sshd_config'
  })
  configuration = ::File.read(conf_path)

  # NOTE: This stops the account from being logged in with a password.
  #       Is there a version independent way to do this? The version of
  #       OpenSSH on some older distros won't recognize the Match keyword.
  configuration = <<-SSH_CONF.gsub(/^\s+\|\s/, '')
    | # Added by Chef
    | Match User git
    |   PasswordAuthentication no
    |   KbdInteractiveAuthentication no
  SSH_CONF

  file conf_path do
    content configuration
    owner 'root'
    group(platform?('mac_os_x') ? 'wheel' : 'root')
  end

  home_dir = "#{(platform?('mac_os_x') ? '/Users' : '/home')}/git"
  directory "#{home_dir}/.ssh" do
    owner 'git'
    group 'git'
  end

  directory "#{home_dir}/git-shell-commands" do
    owner 'git'
    group 'git'
  end

  unless node[:mirror][:server][:'git-shell-commands']
    file "#{home_dir}/git-shell-commands/no-interactive-login" do
      content <<-CONTENT.gsub(/^\s+\|\s/, '')
        | #!/bin/bash
        |
        | echo "Congrats, you've successfully authenticated, but I do not"
        | echo "provide interactive shell access."
        |
        | exit 128
      CONTENT
      owner 'git'
      group 'git'
      mode 0777
    end
  end

  node[:mirror][:server][:'git-shell-commands'].each do |script|
    file "#{home_dir}/git-shell-commands/#{script[:name]}" do
      content script[:code]
      owner 'git'
      group 'git'
      mode 0777
    end
  end
else
  log "Unrecognized git protocol #{protocol}" do
    message 'You specified the mirror::git recipe with an invalid git protocol.'
    level :error
  end
end
