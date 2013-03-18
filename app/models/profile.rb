class Profile < ActiveRecord::Base
  attr_accessible :enable_title, :jabber_id, :phone, :skype_id, :twitter_id, :locale, :timezone, :country, :city

  belongs_to :user

  validates_inclusion_of :locale, :in => I18n.available_locales.map { |s| s.to_s }
end
