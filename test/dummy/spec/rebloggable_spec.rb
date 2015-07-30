require 'spec_helper'

describe 'Rebloggable' do
  before :each do
    @user = User.create!
    @user_1 = User.create!
    @post = Post.create! user: @user
  end

  describe 'reblogged_by' do
    it 'should be return correct result' do
      company = Company.create!
      @user_1.reblog(@post)
      company.reblog(@post)
      result = @post.reblogged_by
      expect(result.size).to eq(2)
      expect(result.include?(@user_1)).to eq(true)
      expect(result.include?(company)).to eq(true)
    end

    it 'should return not paginated result when page is not passed' do
      30.times do
        u = User.create!
        u.reblog(@post)
      end
      result = @post.reblogged_by
      expect(result.size).to eq(30)
      expect(result.uniq.size).to eq(result.size)
    end

    it 'should return paginated result when page is passed' do
      30.times do
        u = User.create!
        u.reblog(@post)
      end
      result = @post.reblogged_by(page: 1)
      expect(result.size).to eq(10)
      expect(result.uniq.size).to eq(result.size)
    end

    it 'should return paginated result with correct per page count when page is passed' do
      30.times do
        u = User.create!
        u.reblog(@post)
      end
      result = @post.reblogged_by(page: 1, per_page: 15)
      expect(result.size).to eq(15)
      expect(result.uniq.size).to eq(result.size)
    end

    it 'should return paginated result with correct order' do
      30.times do
        u = User.create!
        u.reblog(@post)
      end
      result = @post.reblogged_by(order: 'created_at ASC')
      other_sorting_result = @post.reblogged_by
      expect(result.size).to eq(other_sorting_result.size)
      expect(result).to eq(other_sorting_result.reverse)
    end
  end
end