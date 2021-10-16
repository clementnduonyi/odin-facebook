class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook]
  has_many :posts,
            dependent: :destroy
  
  has_many :comments, as: :commentable,
            dependent: :destroy

  has_many :likes,
            dependent: :destroy

  has_many :liked_post, 
            through: :likes, 
            source: :post,  
            dependent: :destroy

  has_many :commented_post, 
             through: :comments, 
             source: :post, 
             dependent: :destroy

  has_many :sent_requests, 
            class_name: "Request", 
            foreign_key: :sender_id, 
            dependent: :destroy

  has_many :recieved_requests, 
            class_name: "Request", 
            foreign_key: :reciever_id, 
            dependent: :destroy

  has_many :friends, 
            dependent: :destroy

  has_many :fans, 
           :through => :friends, 
           source: :friend, 
           dependent: :destroy
  has_one_attached :avatar
  after_commit :add_default_avatar, on: %i[create update]


  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: '150x150!').processed
    else
      '/default_profile.png'
    end
  end

  def self.from_omniauth(auth)
    name_split = auth.info.name.split(" ")
    user = User.where(email: auth.info.email).first
    user ||= User.create!(provider: auth.provider, uid: auth.uid, last_name: name_split[0], first_name: name_split[1], email: auth.info.email, password: Devise.friendly_token[0, 20])
      user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private
  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default_profile.png'
          )
        ), filename: 'default_profile.png',
        content_type: 'images/png'
      )
    end
  end
end
