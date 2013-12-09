node.set['redis']['config']['bind'] = '0.0.0.0'
include_recipe 'redis::server'
