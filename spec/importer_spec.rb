require 'spec_helper'

describe 'oculus::importer' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
