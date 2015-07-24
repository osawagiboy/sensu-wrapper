#
# Cookbook Name:: sensu-wrapper
# Recipe:: server
#
# Copyright 2014, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

include_recipe "sensu-wrapper::server_for_#{node['sensu-wrapper']['server']['install_method']}"
