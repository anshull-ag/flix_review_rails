class User < ApplicationRecord
  after_initialize :set_defaults
  after_create :welcome_email
  has_many :reviews, dependent: :destroy
  validates :name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def set_defaults
    self.role ||= :user
  end

  def welcome_email
    UserMailer.user_confirmation_email(self).tap do |mail|
      mail.subject = 'Confirmation Email'
      mail.deliver_now
    end
  end
  
  enum :role, {user:0, admin:1}, suffix: true
end