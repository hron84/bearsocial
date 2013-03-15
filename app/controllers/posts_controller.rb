class PostsController < InheritedResources::Base
  defaults :finder => :find_by_slug!
end
