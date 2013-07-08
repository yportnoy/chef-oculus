include_recipe "oculus::source"
include_recipe "oculus::ruby" if node['oculus']['install_ruby']
include_recipe "oculus::ruby_gems" if node['oculus']['install_ruby_gems']

execute "copy_oculus_elasticsearch_plugin_directory" do
  cwd node['oculus']['elasticsearch']['install_dir']
  command "cp -r #{node['oculus']['install_dir']}/resources/elasticsearch-oculus-plugin ."
  creates "#{node['oculus']['elasticsearch']['install_dir']}/elasticsearch-oculus-plugin"
  action :run
end

execute "compile_oculus_elasticsearch_plugin" do
  cwd "#{node['oculus']['elasticsearch']['install_dir']}/elasticsearch-oculus-plugin"
  command "rake build"
  creates "#{node['oculus']['elasticsearch']['install_dir']}/elasticsearch-oculus-plugin/OculusPlugins.jar"
  action :run
end

execute "copy_oculus_elasticsearch_plugin_jar" do
  cwd node['oculus']['elasticsearch']['install_dir']
  command "cp elasticsearch-oculus-plugin/OculusPlugins.jar lib/"
  creates "#{node['oculus']['elasticsearch']['install_dir']}/lib/OculusPlugins.jar"
  action :run
end
