include_recipe 'oculus::source'

cron_d 'oculus' do
  minute node['oculus']['importer']['minute']
  command "#{node['oculus']['install_dir']}/scripts/import.rb > #{node['oculus']['log_path']}/import.log 2>&1"
end
