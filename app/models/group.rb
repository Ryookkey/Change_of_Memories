class Group < ApplicationRecord
  has_many :posts
  has_many :favorites
end