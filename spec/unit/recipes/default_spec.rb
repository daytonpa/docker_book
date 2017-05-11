#
# Cookbook:: docker_book
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'docker_book::default' do

  # for a complete list of available platforms and versions see:
  # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md

  {
    'ubuntu' => ['16.04'],
    'centos' => ['7.2.1511']
  }.each do |os, version|
    version.each do |v|
      context "When all attributes are default on #{os.upcase}-#{v}" do
        let(:chef_run) do
          ChefSpec::ServerRunner.new(platform: os, version: v) do |node|
            # Default attributes
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
        when 'centos'
          it 'updates the yum caches' do
            expect(chef_run).to include_recipe('yum')
          end
        end


      end
    end
  end
end
