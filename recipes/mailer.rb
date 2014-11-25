#
# Cookbook Name:: sensu-wrapper
# Recipe:: mailer
#
# Copyright 2014, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

remote_file '/etc/sensu/handlers/mailer.rb' do
  source node['sensu-wrapper']['server']['mailer_script']
  mode 0755
end

mailer = node['sensu-wrapper']['server']['mailer_handler']

sensu_handler mailer['name'] do
  %w{type filters mutator severities handlers command timeout socket pipe additional}.each do |attr|
    send(attr, mailer[attr]) if mailer[attr]
  end
end
  
service "sensu-server" do
  action :restart
end

service "sensu-api" do
  action :restart
end
