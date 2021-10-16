class Post < ApplicationRecord
  belongs_to :user, class_name: "User"
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :image
  
end
