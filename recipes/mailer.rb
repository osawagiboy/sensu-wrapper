#
# Cookbook Name:: sensu-wrapper
# Recipe:: mailer
#
# Copyright 2014, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

mailer = node['sensu-wrapper']['server']['mailer_handler']

remote_file "/etc/sensu/handlers/#{mailer['name']}.rb" do
  source node['sensu-wrapper']['server']['mailer_script']
  mode 0755
end

sensu_handler mailer['name'] do
  %w{type filters mutator severities handlers command timeout socket pipe additional}.each do |attr|
    send(attr, mailer[attr]) if mailer[attr]
  end
end

sensu_json_file "#{node.sensu.directory}/conf.d/handlers/mailer_config.json" do
  owner "root"
  group "sensu"
  mode 00640
  content(mailer['json_config'])
end
