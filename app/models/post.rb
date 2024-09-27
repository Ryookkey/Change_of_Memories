class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :first_memo, presence: true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 投稿内容の検索
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("first_memo LIKE ?", "#{word}").where(first_post_status: true)
    elsif search == "forward_match"
      @post = Post.where("first_memo LIKE ?", "#{word}%").where(first_post_status: true)
    elsif search == "backward_match"
      @post = Post.where("first_memo LIKE ?", "%#{word}").where(first_post_status: true)
    elsif search == "partial_match"
      @post = Post.where("first_memo LIKE ?", "%#{word}%").where(first_post_status: true)
    else
      @post = Post.where(first_post_status: true)
    end
  end
end
