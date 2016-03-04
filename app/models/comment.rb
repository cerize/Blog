class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :body, presence: true,
                   uniqueness: {scope: :post_id}
  # for a uniqueness with the blog post, you must have
  # the association first. Then, it could do sth like:
  # validates :body, uniqueness: {scope: :post.id}
end
