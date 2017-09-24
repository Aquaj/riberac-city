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

private
  def thousand_separator str
    str.to_s.reverse.gsub(/...(?=.)/,'\& ').reverse
  end
end
