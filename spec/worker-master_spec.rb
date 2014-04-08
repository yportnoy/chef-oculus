require 'spec_helper'

describe 'oculus::worker-master' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
