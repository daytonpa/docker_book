
# Default Docker installation attributes
default['docker_book'].tap do |dock|

  # Required packages
  case node['platform']
  when 'ubuntu'
    dock['req_packages'] = %w(
      apt-transport-https ca-certificates curl software-properties-common
    )
  when 'centos'
    dock['req_packages'] = %w(
      yum-utils
    )
  end

  # Docker package name
  case node['platform_family']
  when 'debian'
    dock['install_package']['name'] = 'docker.io'
  when 'rhel'
    dock['install_package']['name'] = 'docker'
  end

  dock['service']['name'] = 'docker'

  # Choose your desired Docker installation method.  You may pick 'package'
  # or 'repo'.
  # Default is set to 'package'
  dock['installation_method'] = 'package'
  plat_v = node['platform_version'].split('.').first


  case node['platform']
  when 'centos'
    dock['url'] = 'https://apt.dockerproject.org/repo'
    dock['key'] = 'https://apt.dockerproject.org/gpg'
  when 'centos'
    dock['url'] = "https://yum.dockerproject.org/repo/main/centos/#{plat_v}/"
    dock['key'] = 'https://yum.dockerproject/gpg'
  end

  dock['components'] = ['main', 'stable']
  dock['distribution'] = "#{node['platform']}-#{node['lsb']['codename']}"

end
