require 'spec_helper'
describe 'gitlabci' do

  context 'with defaults for all parameters' do
    it { should contain_class('gitlabci') }
  end
end
