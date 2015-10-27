#
# Cookbook Name:: sensu-wrapper
# Recipe:: package
#
# Copyright 2015, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

include_recipe "sensu::default"
include_recipe "sensu::redis"
include_recipe "sensu::rabbitmq"
include_recipe "sensu::server_service"
include_recipe "sensu::api_service"

node['sensu-wrapper']['dependency_pkgs'].each do |pkg|
  sensu_gem pkg
end

include_recipe 'sensu-wrapper::handlers'
include_recipe 'sensu-wrapper::checks'
include_recipe 'sensu-wrapper::notifications'
