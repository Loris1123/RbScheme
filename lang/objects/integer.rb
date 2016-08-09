class SchemeInteger < SchemeDataObject
  attr_reader :value
  def initialize(value)
    @value = Integer(value)
  end

  def ==(x)
    if x.class == SchemeInteger
      return x.value == @value
    else
      return false
    end
  end

  def *(x)
    case x
    when SchemeInteger
      return SchemeInteger.new(@value*x.value)
    else
      raise "Can't do multiples of #{x.class} to SchemeInteger"
    end
  end

  def +(x)
    case x
    when SchemeInteger
      return SchemeInteger.new(@value+x.value)
    else
      raise "Can't add #{x.class} to SchemeInteger"
    end
  end

  def /(x)
    case x
    when SchemeInteger
      raise SchemeUserError.new('Division by zero!') unless x.value != 0
      return SchemeInteger.new(@value/x.value)
    else
      raise "Can't divide #{x.class} through SchemeInteger"
    end
  end

  def -(x)
    case x
    when SchemeInteger
      return SchemeInteger.new(@value-x.value)
    else
      raise "Can't substract #{x.class} from SchemeInteger"
    end
  end

  def to_s
    @value.to_s
  end
end
