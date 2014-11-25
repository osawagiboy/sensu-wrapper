
# client settings
default['sensu-wrapper']['client']['ipaddress'] = false
default['sensu-wrapper']['client']['roles'] = []
default['sensu-wrapper']['client']['keepalive'] = {
    :thresholds => {
      :warning => 20,
      :critical => 120,
    },
    :refresh => 240,
    :handlers => ['default']
}

# checks plugins
default['sensu-wrapper']['client']['default_plugins'] = [
  { :name => 'check-procs', :source => 'https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/processes/check-procs.rb' },
  { :name => 'check-load', :source => 'https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/check-load.rb' },
  { :name => 'check-disk', :source => 'https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/check-disk.rb' },
  { :name => 'check-cpu', :source => 'https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/check-cpu.rb' },
  { :name => 'check-ram', :source => 'https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/check-ram.rb' }
]
default['sensu-wrapper']['client']['extension_plugins'] = []
