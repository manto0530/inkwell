require 'spec_helper'

describe 'Favoritable' do
  describe 'favorited_by' do
    it 'should be return correct result' do
      user = User.create!
      company = Company.create!
      post = Post.create! user: user
      user.favorite(post)
      company.favorite(post)
      result = post.favorited_by
      expect(result.size).to eq(2)
      expect(result.include?(user)).to eq(true)
      expect(result.include?(company)).to eq(true)
    end

    it 'should return not paginated result when page is not passed' do
      user = User.create!
      post = Post.create! user: user
      30.times do
        u = User.create!
        u.favorite(post)
      end
      result = post.favorited_by
      expect(result.size).to eq(30)
      expect(result.uniq.size).to eq(result.size)
    end

    it 'should return paginated result when page is passed' do
      user = User.create!
      post = Post.create! user: user
      30.times do
        u = User.create!
        u.favorite(post)
      end
      result = post.favorited_by(page: 1)
      expect(result.size).to eq(10)
      expect(result.uniq.size).to eq(result.size)
    end

    it 'should return paginated result with correct per page count when page is passed' do
      user = User.create!
      post = Post.create! user: user
      30.times do
        u = User.create!
        u.favorite(post)
      end
      result = post.favorited_by(page: 1, per_page: 15)
      expect(result.size).to eq(15)
      expect(result.uniq.size).to eq(result.size)
    end

    it 'should return paginated result with correct order' do
      user = User.create!
      post = Post.create! user: user
      30.times do
        u = User.create!
        u.favorite(post)
      end
      result = post.favorited_by(order: 'created_at ASC')
      other_sorting_result = post.favorited_by
      expect(result.size).to eq(other_sorting_result.size)
      expect(result).to eq(other_sorting_result.reverse)
    end
  end
end