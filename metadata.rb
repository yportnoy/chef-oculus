name 'oculus'
maintainer 'Brian Flad'
maintainer_email 'bflad417@gmail.com'
license 'Apache 2.0'
description 'Installs/Configures oculus'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.2'
recipe 'oculus', 'Default installation/configuration of almost self-contained Oculus server'
recipe 'oculus::elasticsearch', 'Installs/configures common Elasticsearch functionality'
recipe 'oculus::elasticsearch-a', 'Installs/configures Elasticsearch A cluster'
recipe 'oculus::elasticsearch-b', 'Installs/configures Elasticsearch B cluster'
recipe 'oculus::importer', 'Installs/starts Skyline importer'
recipe 'oculus::init', 'Installs init scripts'
recipe 'oculus::redis', 'Installs/configures Redis'
recipe 'oculus::ruby', 'Installs Ruby and RubyGems'
recipe 'oculus::ruby_gems', 'Installs RubyGems via bundle install'
recipe 'oculus::source', 'Installs Oculus via source'
recipe 'oculus::worker', 'Installs/configures common worker functionality'
recipe 'oculus::worker-master', 'Installs/configures worker master'
recipe 'oculus::worker-slave', 'Installs/configures worker slaves'
recipe 'oculus::webapp', 'Installs/configures webapp'

%w(centos fedora redhat ubuntu).each do |os|
  supports os
end

%w(ark cron elasticsearch git java redis xml).each do |cb|
  depends cb
end
