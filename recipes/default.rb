#
# Cookbook:: docker_book
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Update our caches if needed, depending on our OS
case node['platform']
when 'ubuntu'
  include_recipe 'apt'
when 'centos'
  include_recipe 'yum'
end
