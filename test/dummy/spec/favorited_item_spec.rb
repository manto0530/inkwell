require 'spec_helper'

describe 'Favorited item' do
  before :each do
    @user = User.create!
    @post = Post.create! user: @user
  end

  before :each, with_company: true do
    @company = Company.create!
  end

  before :each, with_favorited_post: true do
    @post_1 = Post.create! user: @user
    @user.favorite(@post_1)
  end

  it 'should be created' do
    expect(@user.favorite?(@post)).to eq(false)
    @user.favorite(@post)
    expect(@user.favorite?(@post)).to eq(true)
  end

  it 'should be destroyed', with_favorited_post: true do
    expect(@user.favorite?(@post_1)).to eq(true)
    @user.unfavorite(@post_1)
    expect(@user.favorite?(@post)).to eq(false)
  end

  it 'should be exists', with_favorited_post: true do
    expect(@user.favorite?(@post_1)).to eq(true)
  end

  it 'should not be exists' do
    expect(@user.favorite?(@post)).to eq(false)
  end

  it 'operations should be chained', with_company: true do
    @user.favorite(@post).favorite(@company)
    expect(@user.favorite?(@post)).to eq(true)
    expect(@user.favorite?(@company)).to eq(true)
  end

  describe 'favorites' do
    before :each do
      @other_user = User.create!
      ((0...20).to_a.map{|i| Post.create! user: @user, created_at: Time.now - i.minutes} +
          (0...20).to_a.map{|i| Company.create! created_at: Time.now - i.minutes}).each do |obj|
        @user.favorited_items.create!(favorited: obj, created_at: obj.created_at)
        @other_user.favorite(obj)
      end
    end

    it 'should return objects' do
      result = @user.favorites
      expect(result.size).to eq(10)
      expect(result.select{|r| r.is_a?(Post)}.size).to eq(5)
      expect(result.select{|r| r.is_a?(Company)}.size).to eq(5)
    end

    it 'should return only this user objects' do
      expect(@user.favorites(per_page: 100).size).to eq(40)
    end

    describe 'pagination' do
      it 'should return objects with default params' do
        expect(@user.favorites.size).to eq(10)
      end

      it 'should return objects with custom page' do
        result = @user.favorites(page: 2)
        expect(result.size).to eq(10)
        expect((result + @user.favorites).uniq.size).to eq(20)
      end

      it 'should return objects with custom per page' do
        expect(@user.favorites(per_page: 20).size).to eq(20)
      end
    end
  end

  describe 'favorites' do
    it 'should return not favorited object without for_viewer' do
      user = User.create!
      post = Post.create! user: user
      user.favorite(post)
      expect(user.favorites.size).to eq(1)
      item = user.favorites.first
      expect(item.favorited?).to eq(false)
    end

    it 'should return not favorited object with for_viewer' do
      user = User.create!
      post = Post.create! user: user
      user.favorite(post)
      expect(user.favorites(for_viewer: @user).size).to eq(1)
      item = user.favorites(for_viewer: @user).first
      expect(item.favorited?).to eq(false)
    end

    it 'should return favorited object with for_viewer' do
      user = User.create!
      post = Post.create! user: user
      @user.favorite(post)
      user.favorite(post)
      expect(user.favorites(for_viewer: @user).size).to eq(1)
      item = user.favorites(for_viewer: @user).first
      expect(item.favorited?).to eq(true)
    end
  end

  describe 'favorites with reblog feature' do
    before :each do
      @user_1 = User.create!
    end

    it 'should return reblogged item for reblog owner' do
      @user_1.favorite(@post)
      @user_1.reblog(@post)
      result = @user_1.favorites(for_viewer: @user_1)
      expect(result.size).to eq(1)
      expect(result[0]).to eq(@post)
      expect(result[0].reblogged?).to eq(true)
    end

    it 'should return not reblogged item for not reblog owner' do
      @user_1.favorite(@post)
      @user_1.reblog(@post)
      result = @user_1.favorites(for_viewer: @user)
      expect(result.size).to eq(1)
      expect(result[0]).to eq(@post)
      expect(result[0].reblogged?).to eq(false)
    end

    it 'should return not reblogged item without viewer' do
      @user_1.favorite(@post)
      @user_1.reblog(@post)
      result = @user_1.favorites
      expect(result.size).to eq(1)
      expect(result[0]).to eq(@post)
      expect(result[0].reblogged?).to eq(false)
    end
  end

end
