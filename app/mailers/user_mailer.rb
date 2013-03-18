class UserMailer < ActionMailer::Base

  #@param [User] user
  #@param [User] friend
  def friend_email(user, friend)
    @user = user
    @friend = friend
    mail :to => @user.email, :subject => t('users.mailers.friend_mailer.subject', :name => @friend.name)
  end

end
