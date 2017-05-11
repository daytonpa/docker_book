#
# Cookbook:: docker_book
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Update our caches if needed, depending on our OS, and grab some required
# packages
case node['platform']
when 'ubuntu'
  include_recipe 'apt'

  node['docker_book']['req_packages'].each do |pkg|
    apt_package pkg
  end

  case node['docker_book']['installation_method']
  when 'package'
    package node['docker_book']['install_package']['name']
  when 'repo'
    apt_repository 'docker' do
      uri node['docker_book']['url']
      distribution "#{node['platform']}-#{node['lsb']['codename']}"
      components ['main', 'stable']
      key node['docker_book']['key']
    end
  end

when 'centos'
  include_recipe 'yum'

  node['docker_book']['req_packages'].each do |pkg|
    yum_package pkg
  end

  case node['docker_book']['installation_method']
  when 'package'
    package node['docker_book']['install_package']['name']
  when 'repo'
    yum_repository 'docker' do
      description 'Docker Repository'
      baseurl node['docker_book']['url']
      gpgkey node['docker_book']['key']
      action :create
    end
  end
else
  raise 'Sorry... that OS is not supported by this cookbook at this time.'\
    'Please refer to the README.md for more information regarding supported'\
    'platforms.'
end

# Start and enable the Docker service
service node['docker_book']['service']['name'] do
  supports status: true, reload: true
  action [:enable, :start]
end
