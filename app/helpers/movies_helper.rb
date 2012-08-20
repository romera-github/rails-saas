module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
<<<<<<< HEAD

  def is_sort_target(header, value)
    return '' if value.nil?
    class_name = value.to_s + '_cabecera'
    (header == class_name) ? 'hilite' : ''
  end
=======
>>>>>>> 2ff1e2cd6859061d47d89d4d504512de3734d3d3
end
