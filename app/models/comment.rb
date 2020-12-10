class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user, foreign_key: 'user_id'
end
