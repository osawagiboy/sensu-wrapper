#
# Cookbook Name:: sensu-wrapper
# Recipe:: handlers
#
# Copyright 2014, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

Chef::Recipe.send(:include, Sensu)
Chef::Resource.send(:include, Sensu)
sensu_handler "default" do
  type "pipe"
  command "exit 0"
end
