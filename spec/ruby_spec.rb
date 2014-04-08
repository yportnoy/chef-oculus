require 'spec_helper'

describe 'oculus::ruby' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
