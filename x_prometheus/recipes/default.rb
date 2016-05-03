#
# Cookbook Name:: x_prometheus
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'golang'

link '/usr/bin/go' do
  to '/usr/local/go/bin/go'
  action :create
end

execute 'go get github.com/influxdata/influxdb/client' do
  creates '/opt/go/src/github.com/influxdata/influxdb/client'
  action :run
end
execute 'go get github.com/prometheus/prometheus/cmd/prometheus' do
  creates '/opt/go/src/github.com/prometheus/prometheus/cmd/prometheus'
  action :run
end

include_recipe 'prometheus'
