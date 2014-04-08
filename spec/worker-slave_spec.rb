require 'spec_helper'

describe 'oculus::worker-slave' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
