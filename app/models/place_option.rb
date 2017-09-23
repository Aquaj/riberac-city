class PlaceOption < ApplicationRecord
  belongs_to :place
  belongs_to :option

  scope :of_options, ->(options){ where(option_id: options.select(:id)) }
end
