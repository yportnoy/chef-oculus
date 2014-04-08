require 'spec_helper'

describe 'oculus::ruby_gems' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
