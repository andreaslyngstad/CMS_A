class Comment < ActiveRecord::Base
  belongs_to :post, :counter_cache => true
  validates_presence_of :content, :author
  validates_format_of :author_email, :with => /^(\S+)@(\S+)\.(\S+)$/
end
