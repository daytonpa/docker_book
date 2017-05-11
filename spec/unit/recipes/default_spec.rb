#
# Cookbook:: docker_book
# Spec:: install_docker
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# To run this unit test, copy and paste the command below in your terminal
# chef exec rspec -fd spec/unit/recipes/default_spec.rb --color

require 'spec_helper'

describe 'docker_book::install_docker' do
  # for a complete list of available platforms and versions see:
  # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
  {
    'ubuntu' => ['16.04'],
    'centos' => ['7.2.1511']
  }.each do |os, version|
    version.each do |v|
      context "When installing docker as a package on #{os.upcase}-#{v}" do

        let(:installation_method) { 'package' }

        let(:chef_run) do
          ChefSpec::ServerRunner.new(platform: os, version: v) do |node|
            node.normal['docker_book']['installation_method'] = installation_method
          end.converge(described_recipe)
        end

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end

        case os
        when 'ubuntu'
          it 'updates the apt caches' do
            expect(chef_run).to include_recipe('apt')
          end
          it 'installs the required packages for Docker' do
            %w(apt-transport-https ca-certificates curl software-properties-common).each do |pkg|
              expect(chef_run).to install_apt_package(pkg)
            end
          end
          it 'installs the Docker package' do
            expect(chef_run).to install_package('docker.io')
          end
          it 'starts and enables the Docker service' do
            expect(chef_run).to start_service('docker')
            expect(chef_run).to enable_service('docker')
          end

        when 'centos'
          it 'updates the yum caches' do
            expect(chef_run).to include_recipe('yum')
          end
          it 'installs the required packages for Docker' do
            expect(chef_run).to install_yum_package('yum-utils')
          end
          it 'installs the Docker package' do
            expect(chef_run).to install_package('docker')
          end
          it 'starts and enables the Docker service' do
            expect(chef_run).to start_service('docker')
          end
        end
      end
      context "When installing docker from a repository on #{os.upcase}-#{v}" do

        let(:installation_method) { 'repo' }

        let(:chef_run) do
          ChefSpec::ServerRunner.new(platform: os, version: v) do |node|
            node.normal['docker_book']['installation_method'] = installation_method
          end.converge(described_recipe)
        end

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end

        case os
        when 'ubuntu'
          it 'downloads the Docker repository' do
            expect(chef_run).to add_apt_repository('docker')
          end
        when 'centos'
          it 'downloads the Docker repository' do
            expect(chef_run).to create_yum_repository('docker')
          end
        end
      end
    end
  end
end
