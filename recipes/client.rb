#
# Cookbook Name:: sensu-wrapper
# Recipe:: client
#
# Copyright 2014, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

node['sensu-wrapper']['client']['config'].each do |key, val|
  node.override['sensu'][key] = nil
  node.override['sensu'][key] = val
end

include_recipe 'sensu::default'

node['sensu-wrapper']['dependency_pkgs'].each do |pkg|
  sensu_gem pkg
end

if node['sensu-wrapper']['client']['ipaddress'] then
  ipaddress = node['sensu-wrapper']['client']['ipaddress']
else
  ipaddress = node['ipaddress']
end

if node['sensu-wrapper']['client']['roles'] then
  subscriptions = node['sensu-wrapper']['client']['roles'] + ['all']
else
  subscriptions = ['all']
end

file '/etc/sensu/conf.d/client.json' do
  action :nothing
  notifies :restart, 'service[sensu-client]'
end

sensu_client node['hostname'] do
  address ipaddress
  subscriptions subscriptions
  keepalive node['sensu-wrapper']['client']['keepalive']
  additional node['sensu-wrapper']['client']['additional']
end

include_recipe 'sensu::client_service'

# Installing check plugins
plugins = node['sensu-wrapper']['client']['default_plugins'].concat(node['sensu-wrapper']['client']['extension_plugins'])
plugins.each do |plugin|
  remote_file "/etc/sensu/plugins/#{plugin['name']}.rb" do
    source plugin['source']
    mode 00755
    notifies :restart, 'service[sensu-client]'
  end
end

service 'sensu-client' do
  action :nothing
end
