
# Shared Settings

default['oculus']['install_dir'] = '/opt/oculus'
default['oculus']['install_ruby'] = true
default['oculus']['install_ruby_gems'] = true
default['oculus']['log_path'] = '/var/log/oculus'
default['oculus']['pid_path'] = '/var/run/oculus'
default['oculus']['results_explain'] = false

default['oculus']['user'] = 'oculus'
default['oculus']['group'] = node['oculus']['user']

# Elasticsearch Settings

default['oculus']['elasticsearch']['index'] = 'metrics'
default['oculus']['elasticsearch']['install_dir'] = '/usr/local/elasticsearch'
default['oculus']['elasticsearch']['phrase_slop'] = 20
default['oculus']['elasticsearch']['timeout'] = 30

# Elasticsearch Scorer Settings

default['oculus']['elasticsearch']['scorer']['dtw']['radius'] = 5
default['oculus']['elasticsearch']['scorer']['dtw']['scale_points'] = 5
default['oculus']['elasticsearch']['scorer']['dtw']['script'] = 'com.etsy.oculus.tsscorers.DTWScriptFactory'

default['oculus']['elasticsearch']['scorer']['euclidian']['scale_points'] = 5
default['oculus']['elasticsearch']['scorer']['euclidian']['script'] = 'com.etsy.oculus.tsscorers.EuclidianScriptFactory'

default['oculus']['elasticsearch']['scorers'] = %w{ dtw euclidian }

# Elasticsearch Server Settings

default['oculus']['elasticsearch']['server']['a']['cluster'] = 'Oculus Elasticsearch A'
default['oculus']['elasticsearch']['server']['a']['host'] = node['fqdn']
default['oculus']['elasticsearch']['server']['a']['port'] = 9200

default['oculus']['elasticsearch']['server']['b']['cluster'] = 'Oculus Elasticsearch B'
default['oculus']['elasticsearch']['server']['b']['host'] = node['fqdn']
default['oculus']['elasticsearch']['server']['b']['port'] = 9200

default['oculus']['elasticsearch']['servers'] = [
  "http://#{node['oculus']['elasticsearch']['server']['a']['host']}:#{node['oculus']['elasticsearch']['server']['a']['port']}",
  "http://#{node['oculus']['elasticsearch']['server']['b']['host']}:#{node['oculus']['elasticsearch']['server']['b']['port']}"
]

# Importer Settings

default['oculus']['importer']['minute'] = '*/2'

# Redis Settings

default['oculus']['redis']['host'] = node['fqdn']
default['oculus']['redis']['port'] = 6379

# Resque Settings

default['oculus']['resque']['graphite_workers'] = 22
default['oculus']['resque']['redis_workers'] = 22

# Skyline Settings

default['oculus']['skyline']['host'] = 'skyline.example.com'
default['oculus']['skyline']['listener_port'] = 2015
default['oculus']['skyline']['metric_prefix'] = 'mini'
default['oculus']['skyline']['port'] = 6379

# Source Settings

default['oculus']['source']['repo'] = 'git://github.com/etsy/oculus.git'
default['oculus']['source']['reference'] = 'master'

# Webapp Settings

default['oculus']['webapp']['webapp_ip'] = '127.0.0.1'
default['oculus']['webapp']['webapp_port'] = 3000
