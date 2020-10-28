class Article < ApplicationRecord
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  belongs_to :user
  validates :title, presence: true,
            length: { minimum: 3 }
  validates :text, presence: true,
            length: { minimum: 5}
  #not sure if it's needed
  validates :user, presence:true
end
