# Generates a hash of a given String-value.
# Will probably implement multiple hash-algorithms.
module SchemeHash

  # Change here the algorithm you want to use
  def self.hash(x)
    return self.fnv1 x
  end

  private
  def self.fnv1a(x)
    fnv_offset = 14695981039346656037
    fnv_prime = 1099511628211

    hash = fnv_offset
    x.each_byte do |b|
      hash = hash ^ b
      hash = (hash * fnv_prime).to_s(2)[0...64].to_i(2)  # get only the lowest 64 bit
    end
    return hash
  end

  def self.fnv1(x)
    fnv_offset = 14695981039346656037
    fnv_prime = 1099511628211

    hash = fnv_offset
    x.each_byte do |b|
      hash = (hash * fnv_prime).to_s(2)[0...64].to_i(2)  # get only the lowest 64 bit
      hash = hash ^ b
    end
    return hash
  end

end