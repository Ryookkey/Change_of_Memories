class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 氏名のバリデーション
  validates :name, presence: true

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post
  has_many :comments, dependent: :destroy

  has_one_attached :profile_image

  validates :profile_image, content_type: {in:[:png, :jpg, :jpeg], message: "はpng, jpg, jpegいずれかの形式にして下さい"},
                                  size: { between: 1.kilobyte..4.megabytes , message: '画像容量が大きいです。4megabytes以下でお願いいたします' }

  GUEST_USER_EMAIL = "guest@example.com"

  def guest_user?
    email == GUEST_USER_EMAIL
  end

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  # 画像設定用メソッド
  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [70, 70]).processed
  end

  has_many :active_relation, class_name: "Relation", foreign_key: "follower_id", dependent: :destroy

  has_many :passive_relation, class_name: "Relation", foreign_key: "followed_id", dependent: :destroy

  has_many :followings, through: :active_relation, source: :followed

  has_many :followers, through: :passive_relation, source: :follower

  #指定ユーザのフォロー
  def follow(user)
    active_relation.create(followed_id: user.id)
  end

  #指定ユーザのフォロー解除
  def unfollow(user)
    active_relation.find_by(followed_id: user.id).destroy
  end

  # 指定したユーザーをフォローしているかどうかを判定
  def following?(user)
    followings.include?(user)
  end

  #ユーザ検索
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "backward_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
end