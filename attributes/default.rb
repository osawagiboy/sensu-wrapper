override['sensu']['use_ssl'] = false
override['sensu']['use_embedded_ruby'] = true
override['sensu']['version'] = '0.20.3-1'

default['sensu-wrapper']['dependency_pkgs'] = []

include_attribute 'uchiwa'
