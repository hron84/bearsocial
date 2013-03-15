class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :encryptable, :confirmable,
         :lockable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :avatar_url
  # attr_accessible :title, :body

  has_many :followings

  has_many :friends, :through => :followings, :source => 'followed'

  has_many :followeds, :class_name => 'Following', :foreign_key => 'followed_id'
  has_many :followers, :through => :followeds, :source => :user

  has_many :posts
  has_one :profile

  validates_presence_of :name

  validates_presence_of :avatar_url
  validates_format_of :avatar_url, :with => %r{^https?://(.*)$}

  before_validation :build_avatar_url

  private

  def build_avatar_url
    if avatar_url.blank?
      gravatar_id = Digest::MD5::hexdigest(email).downcase
      avatar_url = "https://gravatar.com/avatar/#{gravatar_id}.png?r=pg"
    end
  end
end
