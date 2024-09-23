class Favorite < ApplicationRecord
  belongs_to :group
  belongs_to :post
  belongs_to :user
  
  validates :user_id, uniqueness: {scope: :post_id}
end
