# OculusPlugins.jar currently only compiles on 0.20.X :(
node.set['elasticsearch']['version'] = "0.20.6"
node.set['elasticsearch']['filename'] = "elasticsearch-#{node['elasticsearch']['version']}.tar.gz"
node.set['elasticsearch']['download_url']  = [node['elasticsearch']['host'], node['elasticsearch']['repository'], node['elasticsearch']['filename']].join('/')

if node['oculus']['elasticsearch']['scorers']
  scripts = []
  node['oculus']['elasticsearch']['scorers'].each do |scorer|
    scripts << "oculus_#{scorer}.type: #{node['oculus']['elasticsearch']['scorer'][scorer]['script']}"
  end
  node.set['elasticsearch']['custom_config'] = {
    "script.native" => "\n  #{scripts.join("\n  ")}"
  }
end

include_recipe "java"
include_recipe "elasticsearch"
include_recipe "oculus::elasticsearch-plugin"
