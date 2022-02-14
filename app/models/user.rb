class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates_presence_of :name
  has_many :recipes

  after_create :send_notification
  
  def send_notification
    ActionCable.server.broadcast("NotificationsChannel", { message: "A new user has been created!" })
  end
end
