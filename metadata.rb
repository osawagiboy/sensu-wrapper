name             'sensu-wrapper'
maintainer       'Yuki Osawa'
maintainer_email 'osawagiboy@gmail.com'
license          'All rights reserved'
description      'Installs/Configures sensu-wrapper'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

depends          'sensu', '2.10.0'
depends          'docker'
depends          'uchiwa'
