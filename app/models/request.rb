class Request < ApplicationRecord
    validates :reciever_id, uniqueness: { scope: :sender_id }
    validate :one_directional_request
    validate :no_request_to_existing_friends, if: -> { sender }

    belongs_to :sender, class_name: :User
    belongs_to :reciever, class_name: :User

    private

    def one_directional_request
        if Request.exists?(sender_id: reciever_id, reciever_id: sender_id)
        errors[:reciever_id] << 'There is a pending request from this user.'
        end
    end

    def no_request_to_existing_friends
        if sender.fans.any? { |fan| fan.id == reciever.id }
        errors[:reciever_id] << 'User is already friends with this reciever.'
        end
    end
end
 