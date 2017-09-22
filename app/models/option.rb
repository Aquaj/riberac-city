class Option < ApplicationRecord
  belongs_to :category
  has_many :place_options, dependent: :destroy
  has_many :places, through: :place_options

  validates :name, presence: true
end
