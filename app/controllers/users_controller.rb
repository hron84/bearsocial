class UsersController < InheritedResources::Base
  load_and_authorize_resource :except => :index

  def follow
    @following = current_user.followings.build(:followed_id => @user.id)

    respond_to do |format|
      if @following.save
        flash[:notice] = I18n.t('notices.you_now_following', :name => @user.name)
        format.json { render :json => {} }
      else
        flash[:error] = I18n.t('errors.you_cannot_follow', :name => @user.name)  # "You cannot follow #{@user.name}, because #{@following.errors.full_messages.to_sentence}"
        format.json { render :json => @following.errors, :status => :unprocessable_entity }
      end

      if request.xhr?
        format.html { render :text => "" }
      else
        format.html { redirect_to :back }
      end

    end
  end


  def unfollow
    @following = current_user.followings.where(:followed_id => @user.id).first
    @following.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {} }
    end
  end

  def friend
    current_user.friends << @user

    UserMailer.deliver_friend_email(current_user, @user)

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {} }
    end
  end

  def unfriend
    current_user.friends.delete(@user)

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {} }
    end
  end

  protected

  def collection
    @users ||= end_of_association_chain.page(params[:page])
  end
end
