class Category < ApplicationRecord
  has_many :options, dependent: :destroy

  validates :name, presence: true
end
