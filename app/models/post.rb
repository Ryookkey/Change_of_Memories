class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :favorites
  has_many :comments
end
