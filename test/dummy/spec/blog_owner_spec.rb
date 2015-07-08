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
  end
end
