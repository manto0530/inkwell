require 'spec_helper'

describe 'Reblogging' do
  before :each do
    @user = User.create!
    @post = Post.create! user: @user
    @user_1 = User.create!
  end

  describe 'reblog' do
    it 'should be done' do
      expect(@user_1.reblog?(@post)).to eq(false)
      @user_1.reblog(@post)
      expect(@user_1.reblog?(@post)).to eq(true)
    end

    it 'should not be done because obj is not blog item' do
      expect{@user_1.reblog(@user)}.to raise_error(/User tries to reblog User object but it is not acts_as_blog_item/)
    end

    it 'should not be done because obj is not blog item' do
      expect{@user.reblog(@post)}.to raise_error('User can not reblog its own post')
    end

    it 'should chaining' do
      expect(@user_1.reblog(@post)).to eq(@user_1)
    end
  end

  describe 'unreblog' do
    it 'should be done' do
      @user_1.reblog(@post)
      expect(@user_1.reblog?(@post)).to eq(true)
      @user_1.unreblog(@post)
      expect(@user_1.reblog?(@post)).to eq(false)
    end

    it 'should not be done' do
      expect(@user_1.reblog?(@post)).to eq(false)
      @user_1.unreblog(@post)
      expect(@user_1.reblog?(@post)).to eq(false)
    end

    it 'should chaining' do
      expect(@user_1.unreblog(@post)).to eq(@user_1)
    end
  end

  describe 'reblog?' do
    it 'should return true' do
      @user_1.reblog(@post)
      expect(@user_1.reblog?(@post)).to eq(true)
    end

    it 'should return false' do
      expect(@user_1.reblog?(@post)).to eq(false)
    end
  end
end