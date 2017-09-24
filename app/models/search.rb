class Search
  # Validations
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :price_min, :price_max, :option_ids

  validates :price_min, numericality: true
  validates :price_max, numericality: true


  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
    if instance_variable_defined? :@option_ids
      @option_ids.reject!(&:blank?)
    end
  end

  def persisted?
    false # which means this object persisted in the database.
  end
end
