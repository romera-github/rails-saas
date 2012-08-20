module MoviesHelper

  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end


  def es_ordenable(header, value)
    return '' if value.nil?
    class_name = value.to_s + '_header'
    (header == class_name) ? 'hilite' : ''
  end

end
