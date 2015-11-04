#
# Cookbook Name:: sensu-wrapper
# Recipe:: server
#
# Copyright 2014, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

node['sensu-wrapper']['server']['config'].each do |key, val|
  node.override['sensu'][key] = val
end
include_recipe "sensu-wrapper::server_for_#{node['sensu-wrapper']['server']['install_method']}"
