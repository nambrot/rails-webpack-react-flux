class Post < ActiveRecord::Base

  validates :title, presence: true
  validates :content, presence: true

  default_scope { order("updated_at DESC") }

end
