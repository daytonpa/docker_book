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

  # apt_repository 'docker-ce' do
  #   uri node['docker_book']['uri']
  #   distribution node['docker_book']['distribution']
  #   key node['docker_book']['gdp_key']
  #   components ['main', 'stable']
  #   action :add
  # end

when 'centos'
  include_recipe 'yum'
end
