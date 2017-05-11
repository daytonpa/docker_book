name 'docker_book'
maintainer 'Patrick Dayton'
maintainer_email 'daytonpa@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures docker_book'
long_description 'This cookbook will install and configure your desired version of Docker'
version '1.0.1'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/docker_book/issues'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/daytonpa/docker_book'

# cookbook dependencies
%w( apt docker yum ).each do |d|
  depends d
end
