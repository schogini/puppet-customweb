require 'spec_helper'
describe 'customweb' do
  context 'with default values for all parameters' do
    it { should contain_class('customweb') }
  end
end
