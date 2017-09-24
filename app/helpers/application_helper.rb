module ApplicationHelper

  def image_tag_or_default(picture, options)
    if picture
      cl_image_tag picture.path, options
    else
      "no image"
    end
  end

  def money price
    "#{thousand_separator price.to_i} €"
  end

  def area surface
    "#{thousand_separator surface.to_i} m²"
  end

  def format_phone_number phone_number
    phone_number.gsub(/\+33/, "0").scan(/\d{2}/).join(".")
  end

  def svg_selector category_name
    case category_name
      when "type de bien" then "type-de-bien.svg"
      when "type de sol" then "type-de-sol.svg"
      when "services" then "services.svg"
      when "équipements" then "équipements.svg"
    end
  end

private
  def thousand_separator str
    str.to_s.reverse.gsub(/...(?=.)/,'\& ').reverse
  end
end
