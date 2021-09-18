class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :sent_requests, class_name: "Request", foreign_key: :sender_id, dependent: :destroy
  has_many :recieved_requests, class_name: "Request", foreign_key: :reciever_id, dependent: :destroy
  has_many :friends, dependent: :destroy       
  has_many :fans, :through => :friends, source: :friend, dependent: :destroy
end
