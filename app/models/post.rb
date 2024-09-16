class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :favorites
  has_many :comments, dependent: :destroy
  # @post.group_id = some_default_group_id  # 適切なgroup_idを設定
end
