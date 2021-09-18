class Friend < ApplicationRecord
    validates :friend_id, uniqueness: {scope: :user_id}
    belongs_to :user, class_name: "User"
    belongs_to :friend, class_name: "User"

end
