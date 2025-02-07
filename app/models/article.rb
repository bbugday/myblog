class Article < ApplicationRecord
  has_one_attached :cover, dependent: :destroy
  has_many :comments, dependent: :destroy, as: :commentable
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings, dependent: :destroy
  belongs_to :user
  validates :title, presence: true,
            length: { minimum: 3 }
  validates :text, presence: true,
            length: { minimum: 5}
  validates :user, presence:true
  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end
  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end
end
