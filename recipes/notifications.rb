#
# Cookbook name:: sensu-wrapper
# Recipe:: notifications
#
# Copyright 2015, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

notifications = node['sensu-wrapper']['server']['notifications']

notifications.each do |notification|
  remote_file "/etc/sensu/handlers/#{notification['destination']}.rb" do
    source notification['script']
    mode 0755
  end

  sensu_handler notification['destination'] do
    %w{type filters mutator severities handlers command timeout socket pipe additional}.each do |attr|
      send(attr, notification['handler'][attr]) if notification['handler'][attr]
    end
  end

  sensu_json_file "#{node.sensu.directory}/conf.d/handlers/#{notification['destination']}_config.json" do
    owner "root"
    group "sensu"
    mode 00640
    content(notification['json_config'])
  end
end
