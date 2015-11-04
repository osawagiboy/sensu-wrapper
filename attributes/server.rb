default['sensu-wrapper']['server']['install_method'] = 'package'

# handlers
default['sensu-wrapper']['server']['handlers'] = [ 'default' ]

# mailer notification
default['sensu-wrapper']['server']['notifications'] = []

# checks
default['sensu-wrapper']['server']['default_checks'] = [
  {
    :name => 'check-load',
    :command => '/etc/sensu/plugins/check-load.rb',
    :subscribers => [ 'all' ],
    :interval => 60,
    :handlers => node['sensu-wrapper']['server']['handlers'],
    :additional => {
      :occurrences => 5,
      :refresh => 180
    }
  },
  {
    :name => 'check-disk',
    :command => '/etc/sensu/plugins/check-disk.rb -w 70 -c 90',
    :subscribers => [ 'all' ],
    :interval => 60,
    :handlers => node['sensu-wrapper']['server']['handlers'],
    :additional => {
      :occurrences => 5,
      :refresh => 180
    }
  },
  {
    :name => 'check-cpu',
    :command => '/etc/sensu/plugins/check-cpu.rb -w 70 -c 90',
    :subscribers => [ 'all' ],
    :interval => 60,
    :handlers => node['sensu-wrapper']['server']['handlers'],
    :additional => {
      :occurrences => 5,
      :refresh => 180
    }
  },
  {
    :name => 'check-ram',
    :command => '/etc/sensu/plugins/check-ram.rb -w 10 -c 5',
    :subscribers => [ 'all' ],
    :interval => 60,
    :handlers => node['sensu-wrapper']['server']['handlers'],
    :additional => {
      :occurrences => 5,
      :refresh => 180
    }
  }
]
default['sensu-wrapper']['server']['extension_checks'] = []
default['sensu-wrapper']['server']['config'] = {}
