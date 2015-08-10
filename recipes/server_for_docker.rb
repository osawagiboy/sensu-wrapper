#
# Cookbook Name:: sensu-wrapper
# Recipe:: package
#
# Copyright 2015, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

ruby_block "sensu_service_trigger" do
  block do
    # Sensu service action trigger for LWRP's
  end
  action :nothing
end

group 'sensu' do
  append true
  gid '10001'
end

user 'sensu' do
  gid 'sensu'
  uid '10001'
  home '/opt/sensu'
  shell '/bin/false'
end

%w(/etc/sensu /etc/sensu/conf.d /etc/sensu/plugins /etc/sensu/mutators /etc/sensu/handlers /etc/sensu/extensions /etc/sensu/conf.d/handlers /etc/sensu/conf.d/checks).each do |dir|
  directory dir do
    user 'root'
    group 'sensu'
    mode 00755
    recursive true
  end
end

directory '/var/log/sensu' do
  user 'sensu'
  group 'sensu'
  mode 00750
end

node.set['sensu']['rabbitmq']['host'] = 'localhost'
node.set['sensu']['rabbitmq']['port'] = 5672
node.set['sensu']['redis']['host'] = 'localhost'
node.set['sensu']['redis']['port'] = 6379
node.set['sensu']['api']['host'] = 'localhost'
node.set['sensu']['api']['binde'] = '0.0.0.0'
node.set['sensu']['api']['port'] = 4567

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

template "#{node['uchiwa']['sensu_homedir']}/uchiwa.json" do
  mode 00666
  variables(:config => JSON.pretty_generate(config))
  cookbook 'uchiwa'
end

# install docker and image
include_recipe 'docker'

docker_image 'osawagiboy/sensu-server' do
  cmd_timeout 900
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
