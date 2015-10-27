override['sensu']['use_ssl'] = false
override['sensu']['use_embedded_ruby'] = true
override['sensu']['version'] = '2.10.0'

default['sensu-wrapper']['dependency_pkgs'] = []

include_attribute 'uchiwa'
