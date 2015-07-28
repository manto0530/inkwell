require 'spec_helper'

describe 'Blog owner' do
  before :each do
    # ActiveRecord::Base.logger = Logger.new(STDOUT) # TODO remove before release
    @user = User.create!
    other_user = User.create!
    @posts = (0..30).to_a.map{|i| Post.create! user: other_user}
    @other_posts = (0..10).to_a.map{|i| Post.create! user: other_user}
    @posts.each {|post| Inkwell::BlogItem.create! blogged_item: post, blogging_owner: @user}
  end

  describe 'blog' do
    it 'should return objects' do
      result = @user.blog
      expect(result.size).to be > 0
      result.each do |item|
        expect(item.class).to eq(Post)
      end
    end

    it 'should return only this user objects' do
      expect(@user.blog(per_page: 100).size).to eq(@user.blog_items.size)
    end

    describe 'pagination' do
      it 'should return objects with default params' do
        expect(@user.blog.size).to eq(10)
      end

      it 'should return objects with custom page' do
        result = @user.blog(page: 2)
        expect(result.size).to eq(10)
        expect((result.map(&:id) & @user.blog.map(&:id)).size).to eq(0)
      end

      it 'should return objects with custom per page' do
        expect(@user.blog(per_page: 20).size).to eq(20)
      end
    end

    describe 'favorites' do
      it 'should return not favorited object without for_viewer' do
        user = User.create!
        Post.create! user: user
        expect(user.blog.size).to eq(1)
        item = user.blog.first
        expect(item.favorited?).to eq(false)
      end

      it 'should return not favorited object with for_viewer' do
        user = User.create!
        Post.create! user: user
        expect(user.blog(for_viewer: @user).size).to eq(1)
        item = user.blog(for_viewer: @user).first
        expect(item.favorited?).to eq(false)
      end

      it 'should return favorited object with for_viewer' do
        user = User.create!
        post = Post.create! user: user
        @user.favorite(post)
        expect(user.blog(for_viewer: @user).size).to eq(1)
        item = user.blog(for_viewer: @user).first
        expect(item.favorited?).to eq(true)
      end
    end
  end
end
