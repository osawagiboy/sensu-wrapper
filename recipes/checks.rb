#
# Cookbook Name:: sensu-wrapper
# Recipe:: checks
#
# Copyright 2014, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

checks = node['sensu-wrapper']['server']['default_checks'].concat(node['sensu-wrapper']['server']['extension_checks'])

checks.each do |check|
  sensu_check check['name'] do
    %w{type command timeout subscribers standalone aggregate interval handle handlers publish low_flap_threshold high_flap_threshold additional}.each do |attr|
      send(attr, check[attr]) if check[attr]
    end
  end
end 
