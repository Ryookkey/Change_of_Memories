class Group < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :favorites
end
