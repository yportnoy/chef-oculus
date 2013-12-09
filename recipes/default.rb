# Use this recipe for almost self-contained Oculus server
# You'll just need Elasticsearch servers
include_recipe 'oculus::worker-master'
include_recipe 'oculus::importer'
include_recipe 'oculus::webapp'
