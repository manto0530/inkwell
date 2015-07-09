require 'spec_helper'

describe 'Community' do
  before :each do
    @user = User.create!
  end

  it 'should be created' do
    Community.create!
  end
end
