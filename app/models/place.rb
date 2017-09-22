class Place < ApplicationRecord
  belongs_to :user

  has_many :place_options, dependent: :destroy
  has_many :options, through: :place_options

  validates :adress, :price, :transaction_type, :surface, :description, presence: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
