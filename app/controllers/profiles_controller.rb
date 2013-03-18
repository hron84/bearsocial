class ProfilesController < ApplicationController
  before_filter :build_profile

  def edit
  end

  def update

    respond_to do |format|

      if @user.update_attributes params[:user]
        flash[ :notice] = I18n.t('notices.profile_update_successful')
        format.html { redirect_to edit_user_profile_path(@user) }
        format.json { render :json => @user }
      else
        flash[:notice] = I18n.t('errors.profile_update_failed')
        format.html { render :action => 'edit' }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end


  end

  private
  def build_profile
    @user = User.find(params[:user_id])
    @user.build_profile unless @user.profile

    @user.profile.timezone ||= Time.zone.name
    @user.profile.country  ||= I18n.locale.to_s.upcase

    @user.profile.locale   ||= I18n.locale.to_s

  end
end
