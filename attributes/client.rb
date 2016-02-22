
# client settings
default['sensu-wrapper']['client']['ipaddress'] = false
default['sensu-wrapper']['client']['roles'] = []
default['sensu-wrapper']['client']['keepalive'] = {
    :thresholds => {
      :warning => 120,
      :critical => 180,
    },
    :refresh => 240,
    :handlers => ['default']
}
default['sensu-wrapper']['client']['additional'] = {}

# checks plugins
default['sensu-wrapper']['client']['default_plugins'] = [
  { :name => 'check-procs', :source => 'https://raw.githubusercontent.com/sensu-plugins/sensu-plugins-process-checks/master/bin/check-process.rb' },
  { :name => 'check-load', :source => 'https://raw.githubusercontent.com/sensu-plugins/sensu-plugins-load-checks/master/bin/check-load.rb' },
  { :name => 'check-disk', :source => 'https://raw.githubusercontent.com/sensu-plugins/sensu-plugins-disk-checks/master/bin/check-disk-usage.rb' },
  { :name => 'check-cpu', :source => 'https://raw.githubusercontent.com/sensu-plugins/sensu-plugins-cpu-checks/master/bin/check-cpu.rb' },
  { :name => 'check-ram', :source => 'https://raw.githubusercontent.com/sensu-plugins/sensu-plugins-memory-checks/master/bin/check-ram.rb' }
]
default['sensu-wrapper']['client']['extension_plugins'] = []

default['sensu-wrapper']['client']['config'] = {}
