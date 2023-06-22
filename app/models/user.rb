class User < ApplicationRecord
  after_initialize :set_defaults
  has_many :reviews
  

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def set_defaults
    self.role ||= :user
  end

  enum :role, {user:0, admin:1}, suffix: true
end
