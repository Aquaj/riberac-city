class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :places

  validates :phone_number, phony_plausible: true
  validates :first_name, :last_name, :phone_number, presence: true
end
