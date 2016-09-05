class SchemeSymbol < SchemeDataObject

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def ==(x)
    if x.class==SchemeSymbol
      return @value == x.value
    end
    return false
  end

  def to_s
    "SchemeSymbol: #{@value}"
  end
end
