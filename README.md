# chef-oculus [![Build Status](https://secure.travis-ci.org/bflad/chef-oculus.png?branch=master)](http://travis-ci.org/bflad/chef-oculus)

## Description

Installs/configures [Oculus](https://github.com/etsy/oculus).

## Requirements

### Platforms

* CentOS 6
* Fedora 17, 18, 19
* Red Hat Enterprise Linux 6
* Ubuntu 12.04, 12.10, 13.04

### Cookbooks

[Opscode Cookbooks](https://github.com/opscode-cookbooks/)

* [ark](https://github.com/opscode-cookbooks/ark)
* [cron](https://github.com/opscode-cookbooks/cron)
* [git](https://github.com/opscode-cookbooks/git)
* [java](https://github.com/opscode-cookbooks/java)
* [xml](https://github.com/opscode-cookbooks/xml)

Third-Party Cookbooks

* [elasticsearch](https://github.com/elasticsearch/cookbook-elasticsearch)
* [redis](https://github.com/miah/chef-redis)

## Attributes

These attributes are under the `node['oculus']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
group | oculus group | String | `node['oculus']['user']`
install_dir | Directory to install Oculus | String | /opt/oculus
install_ruby | Install Ruby packages | Boolean | true
install_ruby_gems | Install Ruby Gems | Boolean | true
log_path | Path for log files | String | /var/log/oculus
pid_path | Path for PID files | String | /var/run/oculus
results_explain | Explain results flag | Boolean | false
user | oculus user | String | oculus

### Elasticsearch Attributes

These attributes are under the `node['oculus']['elasticsearch']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
index | Metrics index name | String | metrics
install_dir | Directory where Elasticsearch is installed | String | /usr/local/elasticsearch
phrase_slop | Phrase slop | Fixnum | 20
scorers | Array of Elasticsearch scorers | Array of Strings | `[ "dtw", "euclidian" ]`
servers | Array of Elasticsearch servers (A and B) | Array of Strings | `[ "http://#{node['oculus']['elasticsearch']['server']['a']['host']}:#{node['oculus']['elasticsearch']['server']['a']['port']}", "http://#{node['oculus']['elasticsearch']['server']['b']['host']}:#{node['oculus']['elasticsearch']['server']['b']['port']}" ]`
timeout | Timeout seconds | Fixnum | 30

### Elasticsearch Scorer Attributes

These attributes are under the `node['oculus']['elasticsearch']['scorer']['dtw']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
radius | Radius for scorer | Fixnum | 5
scale_points | Scale points for scorer | Fixnum | 25
script | Script name for scorer | String | com.etsy.oculus.tsscorers.DTWScriptFactory

These attributes are under the `node['oculus']['elasticsearch']['scorer']['euclidian']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
scale_points | Scale points for scorer | Fixnum | 25
script | Script name for scorer | String | com.etsy.oculus.tsscorers.EuclidianScriptFactory

### Elasticsearch Server Attributes

These attributes are under the `node['oculus']['elasticsearch']['server']['a']` and `node['oculus']['elasticsearch']['server']['b']` namespaces.

Attribute | Description | Type | Default
----------|-------------|------|--------
cluster | Elasticsearch cluster name | String | "Oculus Elasticsearch A" or "Oculus Elasticsearch B"
host | Elasticsearch hostname | String | `node['fqdn']`
port | Elasticsearch port | Fixnum | 9200

### Importer Attributes

These attributes are under the `node['oculus']['importer']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
minute | Crontab minute field | String | */2

### Redis Attributes

These attributes are under the `node['oculus']['redis']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
host | Redis master hostname | String | `node['fqdn']`
port | Redis master port | Fixnum | 6379

### Skyline Attributes

These attributes are under the `node['oculus']['skyline']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
host | Hostname | String | skyline.example.com
listener_port | Listener port | Fixnum | 2015
metric_prefix | Prefix for mini metrics | String | mini
port | Redis port | Fixnum | 6379

### Source Attributes

These attributes are under the `node['oculus']['source']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
repo | Source repository | String | git://github.com/etsy/oculus.git
reference | Source reference | String | master

### Webapp Attributes

These attributes are under the `node['oculus']['webapp']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
webapp_ip | IP to run webapp | String | 127.0.0.1
webapp_port | Port to run webapp | Fixnum | 3000

## Recipes

* `recipe[oculus]` default installation/configuration of almost self-contained Oculus server (still requires Elasticsearch servers)
* `recipe[oculus::elasticsearch]` installs/configures default Elasticsearch functionality
* `recipe[oculus::elasticsearch-a]` installs/configures default Elasticsearch cluster A
* `recipe[oculus::elasticsearch-b]` installs/configures default Elasticsearch cluster B
* `recipe[oculus::elasticsearch-plugin]` installs Elasticsearch plugin
* `recipe[oculus::importer]` installs/starts Skyline importer
* `recipe[oculus::init]` installs init scripts
* `recipe[oculus::redis]` installs/configures Redis
* `recipe[oculus::ruby]` installs Ruby and RubyGems packages
* `recipe[oculus::ruby_gems]` installs RubyGems via `bundle install`
* `recipe[oculus::source]` installs/configures Oculus via source
* `recipe[oculus::worker]` installs/configures common worker functionality
* `recipe[oculus::worker-master]` installs/configures worker master
* `recipe[oculus::worker-slave]` installs/configures worker slave
* `recipe[oculus::webapp]` installs/starts webapp

## Usage

There are quite a few components necessary to run Oculus, including:
* Two separate Elasticsearch clusters (referred to as A and B in this cookbook)
* Resque/Redis Worker Master
* Skyline Importer
* Webapp

Optionally:
* Resque Worker Slaves

### Oculus Almost Self-Contained Installation

This handles installing/configuring all on the same box:
* Resque/Redis Worker Master `recipe[worker-master]`
* Skyline Importer `recipe[importer]`
* Webapp `recipe[webapp]`

Setup:
* Build 2 Elasticsearch clusters (see elasticsearch-a and elasticsearch-b recipes)
* Set `node['oculus']['elasticsearch']['servers']` or `node['oculus']['elasticsearch']['server']` attributes appropriately
* Set `node['oculus']['skyline']` attributes appropriately
* Add `recipe[oculus]` to your node's run list.

### Oculus Elasticsearch Server Installation

Recipes are available to get Elasticsearch clusters running with the Oculus plugins.

* To install default A cluster: Add `recipe[oculus::elasticsearch-a]` to your node's run list
* To install default B cluster: Add `recipe[oculus::elasticsearch-b]` to your node's run list
* To just install Elasticsearch plugin: Add `recipe[oculus::elasticsearch-plugin]` to your node's run list

## Testing and Development

Here's how you can quickly get testing or developing against the cookbook thanks to [Vagrant](http://vagrantup.com/) and [Berkshelf](http://berkshelf.com/).

    git clone git://github.com/bflad/chef-oculus.git
    cd chef-oculus
    vagrant plugin install vagrant-berkshelf
    vagrant plugin install vagrant-omnibus
    vagrant up BOX # BOX being centos6, ubuntu1204, ubuntu1210, or ubuntu1304

You can then SSH into the running VM using the `vagrant ssh` command.
The VM can easily be stopped and deleted with the `vagrant destroy`
command. Please see the official [Vagrant documentation](http://vagrantup.com/v1/docs/commands.html)
for a more in depth explanation of available commands.

## Contributing

Please use standard Github issues/pull requests and if possible, in combination with testing on the Vagrant boxes.

## License and Authors

See [LICENSE](LICENSE) file for more information.

* Author:: Brian Flad (<bflad417@gmail.com>)
* Copyright:: 2013 Brian Flad
