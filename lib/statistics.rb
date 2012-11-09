module Statistics

  def mean(array)
    array.inject(0) { |sum, x| sum += x } / array.size.to_f
  end

  def mean_and_standard_deviation(array)
    m = mean(array)
    variance = array.inject(0) { |variance, x| variance += (x - m) ** 2 }
    return m, Math.sqrt(variance/(array.size-1))
  end

end
