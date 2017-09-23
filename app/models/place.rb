class Place < ApplicationRecord
  belongs_to :user

  has_many :place_options, dependent: :destroy
  has_many :options, through: :place_options
  has_attachments :pictures, maximum: 5

  validates :address, :price,       :transaction_type,
            :surface, :description, :pictures, presence: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  scope :with_options, ->(options) { where(id: PlaceOption.of_options(options).select(:place_id)) }
end
