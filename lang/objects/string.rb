class SchemeString < SchemeDataObject

  def initialize(value)
    @value = String(value)
  end

  def ==(x)
    if x.class == SchemeString
      @value==x.value
    elsif x.class == String
      @value==x
    else
      super.==(x)
    end
  end
end
