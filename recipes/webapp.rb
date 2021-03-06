include_recipe 'oculus::source'
include_recipe 'oculus::ruby' if node['oculus']['install_ruby']
include_recipe 'oculus::ruby_gems' if node['oculus']['install_ruby_gems']

template '/etc/init.d/oculus-webapp' do
  source 'webapp.init.erb'
  owner 'root'
  group 'root'
  mode 00755
end

service 'oculus-webapp' do
  supports :status => true, :restart => true
  action [:enable, :start]
end
