require 'spec_helper'

describe 'Blog' do
  before :each do
    @post = Post.create!
    @user = User.create!
    Inkwell::BlogItem.create! blogged_item: @post, blogging_owner: @user
  end

  it 'should be return for user' do
    puts @user.blog.inspect
  end
end
