#
# Cookbook Name:: sensu-wrapper
# Recipe:: package
#
# Copyright 2015, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

%w(/etc/sensu /var/log/sensu /etc/sensu/conf.d /etc/sensu/plugins /etc/sensu/mutators /etc/sensu/handlers /etc/sensu/extensions /etc/sensu/conf.d/handlers /etc/sensu/conf.d/checks).each do |dir|
  directory dir do
    mode 00777
  end
end

ruby_block "sensu_service_trigger" do
  block do
    # Sensu service action trigger for LWRP's
  end
  action :nothing
end

group 'sensu' do
  append true
end

user 'sensu' do
  gid 'sensu'
  home '/opt/sensu'
  shell '/bin/false'
end

sensu_base_config node.name

include_recipe 'sensu-wrapper::handlers'
include_recipe 'sensu-wrapper::checks'

if node['sensu-wrapper']['server']['mailer']
  include_recipe 'sensu-wrapper::mailer'
end

# uchiwa
settings = {}
node['uchiwa']['settings'].each do |k, v|
  settings[k] = v
end
config = { 'uchiwa' => settings, 'sensu' => node['uchiwa']['api'] }

group node['uchiwa']['group'] do
  append true
end

user node['uchiwa']['owner'] do
  gid node['uchiwa']['group']
  home '/opt/uchiwa'
  shell '/bin/false'
end

template "#{node['uchiwa']['sensu_homedir']}/uchiwa.json" do
  user node['uchiwa']['owner']
  group node['uchiwa']['group']
  mode 00777
  variables(:config => JSON.pretty_generate(config))
  cookbook 'uchiwa'
end

# install docker and image
include_recipe 'docker'
docker_image 'osawagiboy/sensu-server' do
  action :pull
end

docker_container 'osawagiboy/sensu-server' do
  cmd_timeout 900
  container_name 'sensu-server'
  port %w(4567:4567 5672:5672 3000:3000)
  action :run
  volume [ '/etc/sensu:/etc/sensu', '/var/log/sensu:/var/log/sensu' ]
  detach true
end
