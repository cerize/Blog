class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :users, through: :favourites

  validates :title, presence: true,
  uniqueness: { case_sensitive: false }

  has_attached_file :image, styles: { large: "900x900", medium: "300x300>", thumb: "200x200#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def self.search(q)
    wildcard_term = "%#{q}%"
    where("title ILIKE ? OR body ILIKE ?", wildcard_term, wildcard_term)
  end

  def favourite_by(user)
    favourites.find_by_user_id(user)
  end
end
