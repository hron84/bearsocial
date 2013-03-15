class Post < ActiveRecord::Base
  attr_accessible :author_id, :body, :deleted, :published, :title


  belongs_to :parent_post, :class_name => 'Post'
  belongs_to :author, :class_name => 'User'

  before_validation :build_title
  before_validation :build_slug

  # TODO test race condition too!
  validates_presence_of :slug
  validates_uniqueness_of :slug

  def to_param
    slug
  end

  private

  # TODO move it to background task?
  # TODO or use slug gem?
  def build_slug
    self.slug = ActiveSupport::Inflector.transliterate(title).downcase.gsub(/[^\w]+/, '-')
    self.slug = Time.now.strftime('%s') + id.to_s if self.slug.blank?

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

  # Builds a title if not present
  def build_title
    if title.blank?
      lines = body.strip.gsub(/\r\n/, "\n").split(/\n/)
      if lines.first.match(/\A# (.*)\Z/)
        title = lines.shift
        body = lines.join("\n")
      end
    end
  end
end
