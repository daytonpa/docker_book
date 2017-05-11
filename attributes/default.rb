
# Default Docker installation attributes
default['docker_book'].tap do |dock|
  case node['platform']
  when 'ubuntu'
    dock['uri'] =
    dock['gdp_key'] = 'https://download.docker.com/linux/ubuntu/gpg'
    dock['distribution'] = 'trusty'

    dock['req_packages'] = %w(
      apt-transport-https ca-certificates curl software-properties-common
    )
  end
end
