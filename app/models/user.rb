class User < ApplicationRecord
  after_initialize :set_defaults

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def set_defaults
    self.role ||= 0
  end
end
