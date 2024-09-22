class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("first_memo LIKE?", "#{word}")
    elsif search == "forward_match"
      @post = Post.where("first_memo LIKE?", "#{word}")
    elsif search == "backward_match"
      @post = Post.where("first_memo LIKE?", "#{word}")
    elsif search == "partia_match"
      @post = Post.where("first_memo LIKE?", "#{word}")
    else
      @post = Post.all
    end
  end

end
