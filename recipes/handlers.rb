#
# Cookbook Name:: sensu-wrapper
# Recipe:: handlers
#
# Copyright 2014, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

sensu_handler "default_handler" do
  type "pipe"
  command "exit 0"
end

node['sensu-wrapper']['server']['handlers'].each do |handler|
  sensu_handler handler['name'] do
    %w{type filters mutator serverities handlers command timeout socket pipe additional}.each do |attr|
      send(attr, handler[attr]) if handler[attr]
    end
  end
end

service "sensu-server" do
  action :restart
end

service "sensu-api" do
  action :restart
end
