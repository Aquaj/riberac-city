class Category < ApplicationRecord
  has_many :place_options
  has_many :options, through: :place_options

  validates :name, presence: true
end
