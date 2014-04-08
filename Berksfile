site :opscode

metadata

cookbook 'elasticsearch', github: 'elasticsearch/cookbook-elasticsearch'
cookbook 'redis', github: 'miah/chef-redis'

group :integration do
  cookbook 'minitest-handler'
  cookbook 'oculus_test', :path => 'test/cookbooks/oculus_test'
end
