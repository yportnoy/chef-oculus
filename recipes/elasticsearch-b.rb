node.set['elasticsearch']['cluster']['name'] = node['oculus']['elasticsearch']['server']['b']['cluster']
node.set['elasticsearch']['node']['name'] = node['oculus']['elasticsearch']['server']['b']['host']

include_recipe "oculus::elasticsearch"
