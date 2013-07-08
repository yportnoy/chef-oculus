include_recipe "xml"
gem_package "bundler"

execute "oculus_bundle_install" do
  cwd node['oculus']['install_dir']
  command "bundle install"
  action :run
end
