class PostsController < InheritedResources::Base
  defaults :finder => :find_by_slug!
  load_and_authorize_resource :except => :index

  def star
    unless @post.starred_by?(current_user)
      star = @post.stars.create!(:user_id => current_user.id)

      respond_to do |format|
        format.json { render :json => star  }
        format.html { redirect_to :back }
      end
    end
  end

  def unstar
    if @post.starred_by?(current_user)
      @star = @post.stars.where(:user_id => current_user.id).first
      @star.destroy
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {} }
    end
  end

  def new
    if params[:parent]
      parent = Post.find(params[:parent])
      if parent
        @post = parent.replies.build
      end
    end
  end

  def create
    @post.author = current_user
    unless @post.video.blank?
      @post.body << "\n\n#{@post.video}"
    end
    create! do |success, failure|
      success.html { redirect_to posts_path }
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to posts_path }
    end
  end

  protected


  def collection
    @posts ||= Post.friend_posts(current_user).order('created_at DESC').page(params[:page])
  end
end
