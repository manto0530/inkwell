require 'inkwell/engine'
require 'awesome_nested_set'
require 'kaminari'
require 'acts_as_blog_owner/base'
require 'acts_as_commentable/base'
require 'acts_as_blog_item/base'
require 'acts_as_community/base'
require 'acts_as_community_user/base'
require 'acts_as_category/base'
require 'can_favorite_objects/base'
require 'can_be_favorited/base'

module Inkwell
  %w{blog community favorite reblog comment}.each do |feature|
    mattr_writer "#{feature}_feature".to_sym

    define_singleton_method "#{feature}_feature" do
      result = class_variable_get("@@#{feature}_feature".to_sym)
      result.nil? ? true : result
    end
  end

  %w{post user community category comment}.each do |name|
    %w{class plural singular}.each do |postfix|
      mattr_accessor "#{name}_#{postfix}".to_sym
    end

    define_singleton_method "#{name}_class" do
      current = class_variable_get("@@#{name}_class".to_sym)
      if current
        current.constantize
      else
        class_name = class_variable_get("@@#{name}_class".to_sym)
        result = class_name.present? ? class_name : nil
        class_variable_set("@@#{name}_class".to_sym, result)
        result.constantize
      end
    end

    define_singleton_method "#{name}_plural" do
      current = class_variable_get("@@#{name}_plural".to_sym)
      if current
        current
      else
        class_name = class_variable_get("@@#{name}_class".to_sym)
        result = class_name.present? ? class_name.downcase.pluralize : nil
        class_variable_set("@@#{name}_plural".to_sym, result)
        result
      end
    end

    define_singleton_method "#{name}_singular" do
      current = class_variable_get("@@#{name}_singular".to_sym)
      if current
        current
      else
        class_name = class_variable_get("@@#{name}_class".to_sym)
        result = class_name.present? ? class_name.downcase.singularize : nil
        class_variable_set("@@#{name}_singular".to_sym, result)
        result
      end
    end
  end

end
