override['sensu']['use_ssl'] = false
override['sensu']['use_embedded_ruby'] = true
override['sensu']['version'] = '0.14.0-1'

default['sensu-wrapper']['dependency_pkgs'] = []

include_attribute 'uchiwa'
