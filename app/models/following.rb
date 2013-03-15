class Following < ActiveRecord::Base
  attr_accessible :followed_id, :user_id

  belongs_to :user
  belongs_to :followed, :class_name => 'User'
end
