node.set['elasticsearch']['cluster']['name'] = node['oculus']['elasticsearch']['server']['a']['cluster']
node.set['elasticsearch']['node']['name'] = node['oculus']['elasticsearch']['server']['a']['host']

include_recipe 'oculus::elasticsearch'
