class SchemeSymbol < SchemeDataObject
  def initialize(value)
    @value = value
  end

  def ==(x)
    if x.class==SchemeSymbol
      return @value == x.value
    end
    return false
  end

  def to_str
    "SchemeSymbol: #{@value}"
  end
end