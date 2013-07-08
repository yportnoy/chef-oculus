
include_recipe "git"

git node['oculus']['install_dir'] do
  repository node['oculus']['source']['repo']
  reference node['oculus']['source']['reference']
  action :export
end

user node['oculus']['user'] do
  comment "Oculus Service Account"
  supports :manage_home => true
  system  true
  action  :create 
end

directory node['oculus']['log_path'] do
  owner node['oculus']['user']
  group node['oculus']['group']
  mode 00755
  action :create
end

directory node['oculus']['pid_path'] do
  owner node['oculus']['user']
  group node['oculus']['group']
  mode 00755
  action :create
end

template "#{node['oculus']['install_dir']}/config/config.yml" do
  source "config.yml.erb"
  owner "root"
  group "root"
  mode 00644
end
