class Place < ApplicationRecord
  belongs_to :user

  validates :adress, :price, :transaction_type, :surface, :description, presence: true
end
