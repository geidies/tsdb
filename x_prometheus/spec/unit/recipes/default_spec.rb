#
# Cookbook Name:: x_prometheus
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'x_prometheus::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      stub_command("/usr/local/go/bin/go version | grep \"go1.5 \"").and_return("go1.5 foo bar")
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'installs golang' do
      expect(chef_run).to include_recipe('golang')
    end
    it 'installs missing packages' do
      expect(chef_run).to run_execute('go get github.com/influxdata/influxdb/client')
      expect(chef_run).to run_execute('go get github.com/prometheus/prometheus/cmd/prometheus')
    end
    it 'links the go binary into the path' do
      expect(chef_run).to create_link('/usr/bin/go').with_to('/usr/local/go/bin/go')
    end
    it 'installs prometheus' do
      expect(chef_run).to include_recipe('prometheus')
    end
  end
end
