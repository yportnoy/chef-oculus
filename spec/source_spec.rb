require 'spec_helper'

describe 'oculus::source' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
