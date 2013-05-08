class Post < ActiveRecord::Base

  YOUTUBE_REGEX = %r{https?://(www\.)?(youtube.com/watch\?v=|youtu.be/)([a-zA-Z0-9]+)\S+}

  attr_accessor :video

  attr_accessible :author_id, :body, :deleted, :published, :title, :parent_post_id, :video


  belongs_to :parent_post, :class_name => 'Post'
  belongs_to :author, :class_name => 'User'

  has_many :stars
  has_many :replies, :class_name => 'Post', :foreign_key => 'parent_post_id'

  before_validation :build_title_and_slug
  before_save :replace_video_embed_code


  # TODO test race condition too!
  validates_presence_of :slug
  validates_uniqueness_of :slug
  validates_length_of :body, :maximum => 1000

  # validates_presence_of :body
  validates_length_of :body, :minimum => 1

  validates_format_of :video, :with => YOUTUBE_REGEX, :allow_blank => true

  def to_param
    slug
  end

  def starred_by?(user)
    stars.where(:user_id => user.id).any?
  end

  def self.friend_posts(user)
    uids = user.followings.collect(&:followed_id)
    uids << user.id
    where{ author_id >> uids }
  end

  private

  def replace_video_embed_code
    if self.body
      self.body = self.body.sub(
          YOUTUBE_REGEX,
          '<a href="http://youtu.be/\3" class="youtube-link"><img src="http://img.youtube.com/vi/\3/0.jpg" width="480" height="360" /></a>'
      )
    end
  end



  def build_title_and_slug
    build_title
    build_slug
  end

  # TODO move it to background task?
  # TODO or use slug gem?
  def build_slug
    if slug.blank? or title_changed?
      self.slug = self.title.blank? ? Time.now.strftime('%s') + id.to_s :  ActiveSupport::Inflector.transliterate(title).downcase.gsub(/[^\w]+/, '-')


      i = 0
      # Slug must be unique, so we try guess a good one
      loop do
        if Post.where(:slug => slug).count == 0
          break
        end
        i += 1
        if slug == 1
          slug = [slug, sprintf('%03d', i)].join('-')
        else
          orig_slug = slug.scan(/^(.+)-(\d+)$/).flatten.first
          slug = [orig_slug, sprintf('%03d', i)].join('-')
        end
      end
    end
  end

  # Builds a title if not present
  def build_title
    if title.blank?
      lines = body.to_s.strip.gsub(/\r\n/, "\n").split(/\n/)
      if lines.size > 0 and lines.first.match(/\A# (.*)\Z/)
        self.title = $1
        lines.shift
        self.body = lines.join("\n").strip
      end
    end
  end
end
