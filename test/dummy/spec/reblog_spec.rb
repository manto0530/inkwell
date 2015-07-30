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

    it 'should add object to blog' do
      expect(@user_1.blog.size).to eq(0)
      @user_1.reblog(@post)
      expect(@user_1.blog.size).to eq(1)
      expect(@user_1.blog[0]).to eq(@post)
    end

    it 'should not be done because obj is not blog item' do
      expect{@user_1.reblog(@user)}.to raise_error(/User tries to reblog User object but it is not acts_as_blog_item/)
    end

    it 'should not be done because user is object owner' do
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

    it 'should remove object from blog' do
      @user_1.reblog(@post)
      expect(@user_1.blog.size).to eq(1)
      expect(@user_1.blog[0]).to eq(@post)
      @user_1.unreblog(@post)
      expect(@user_1.blog.size).to eq(0)
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

  describe 'blog' do
    it 'should return reblogged item for reblog owner' do
      @user_1.reblog(@post)
      result = @user_1.blog(for_viewer: @user_1)
      expect(result.size).to eq(1)
      expect(result[0]).to eq(@post)
      expect(result[0].reblogged?).to eq(true)
      expect(result[0].reblog?).to eq(true)
    end

    it 'should return not reblogged item for not reblog owner' do
      @user_1.reblog(@post)
      result = @user_1.blog(for_viewer: @user)
      expect(result.size).to eq(1)
      expect(result[0]).to eq(@post)
      expect(result[0].reblogged?).to eq(false)
      expect(result[0].reblog?).to eq(true)
    end

    it 'should return not reblogged item without viewer' do
      @user_1.reblog(@post)
      result = @user_1.blog
      expect(result.size).to eq(1)
      expect(result[0]).to eq(@post)
      expect(result[0].reblogged?).to eq(false)
      expect(result[0].reblog?).to eq(true)
    end
  end
end