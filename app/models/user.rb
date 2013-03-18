class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :encryptable, :confirmable,
         :lockable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :avatar_url, :profile_attributes
  # attr_accessible :title, :body

  has_many :followings

  has_many :friends, :through => :followings, :source => 'followed'

  has_many :followeds, :class_name => 'Following', :foreign_key => 'followed_id'
  has_many :followers, :through => :followeds, :source => :user

  has_many :posts

  has_one :profile
  accepts_nested_attributes_for :profile


  has_and_belongs_to_many :friends,
                          :class_name => "User",
                          :association_foreign_key => "friend_id",
                          :join_table => "friends_users"


  validates_presence_of :name

  validates_presence_of :avatar_url
  validates_format_of :avatar_url, :with => %r{^https?://(.*)$}

  before_validation :build_avatar_url
  #after_save :rebuild_friendships # Bidirectional friendship check

  def follows?(user)
    followings.where(:followed_id => user.id).any?
  end

  def followed_by?(user)
    user.followings.where(:followed_id => self.id).any?
  end

  def friend_of?(user)
    friend_ids.include?(user.id)
  end

  def password_required?
    !new_record? ? false : super
  end

  private

  # TODO move me to Resque task
  def rebuild_friendships
    friends.each do |f|
      unless f.friend_ids.include?(self.id)
        f.friends << self
        f.save
      end
    end
  end

  def build_avatar_url
    if avatar_url.blank?
      gravatar_id = Digest::MD5::hexdigest(email).downcase
      self.avatar_url = "https://gravatar.com/avatar/#{gravatar_id}.png?r=pg"
    end
  end

end
