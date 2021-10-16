class Comment < ApplicationRecord
    belongs_to :user, class_name: "User"
    belongs_to :post
    belongs_to :parent, class_name: "Comment", optional: true
    has_many :replies, class_name: "Comment",   
             foreign_key: :parent_id, dependent: :destroy

    scope :is_parent, -> { where(parent_id: nil) }
    scope :is_not_parent, -> { where("parent_id IS NOT NULL") }
    
    validates :body, presence: :true
end
#scope :filter_by_location, -> (location_id) { where location_id: location_id }
#scope :upcoming, -> { where('event_end_date >= ?', Date.today) }