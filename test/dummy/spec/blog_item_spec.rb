require 'spec_helper'

describe 'Blog item' do
  before :each do
    @user = User.create!
  end

  it 'should be created when as blog item object is created' do
    post = Post.create! user: @user
    expect(post.blog_items.size).to eq(1)
    result = post.blog_items.first
    expect(result.blogged_item).to eq(post)
    expect(result.blogging_owner).to eq(@user)
  end

  it 'should not be created because of validations is fail' do
    product = Product.create
    expect(product.id.present?).to eq(false)
    expect(Inkwell::BlogItem.all.size).to eq(0)
  end

  it 'should not be created when need_to_create_blog_item? is false' do
    allow_any_instance_of(Post).to receive(:need_to_create_blog_item?).and_return(false)
    post = Post.create! user: @user
    expect(post.blog_items.size).to eq(0)
    expect(Inkwell::BlogItem.all.size).to eq(0)
  end

  it 'should raise exception when need_to_create_blog_item? is true but owner is undefined' do
    expect{Post.create!}.to raise_error(Inkwell::Exceptions::Blog::UndefinedBlogItemOwner)
  end
end
