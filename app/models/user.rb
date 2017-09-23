class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  phony_normalize :phone_number, default_country_code: 'FR'

  has_many :places, dependent: :destroy

  validates :phone_number, phony_plausible: true
  validates :first_name, :last_name, :phone_number, presence: true
end
