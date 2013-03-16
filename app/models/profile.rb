class Profile < ActiveRecord::Base
  attr_accessible :enable_title, :jabber_id, :phone, :skype_id, :twitter_id, :locale, :timezone, :country

  belongs_to :user
end
