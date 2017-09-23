class Place < ApplicationRecord
  belongs_to :user

  has_many :place_options, dependent: :destroy
  has_many :options, through: :place_options
  has_many :categories, through: :options

  has_attachments :pictures, maximum: 5

  validates :address, :price, :title, :transaction_type,
            :surface, :description,   :pictures, presence: true

  after_validation :geocode, if: :address_changed?
  geocoded_by :address

  enum transaction_type: [:achat, :location]

  scope :matching_options, ->(options) { where(id: PlaceOption.of_options(options).select(:place_id)) }
end
