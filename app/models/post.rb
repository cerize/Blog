class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy

  validates :title, presence: true,
  uniqueness: { case_sensitive: false }

  has_attached_file :image, styles: { large: "900x900", medium: "300x300>", thumb: "#200x200>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def self.search(q)
    wildcard_term = "%#{q}%"
    where("title ILIKE ? OR body ILIKE ?", wildcard_term, wildcard_term)
  end
end
