class Place < ApplicationRecord
  belongs_to :user

  validates :adress, :price, :transaction_type, :surface, :description, presence: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
