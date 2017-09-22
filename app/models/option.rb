class Option < ApplicationRecord
  belongs_to :category

  validates :name, presence: true
end
