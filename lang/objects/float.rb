class SchemeFloat < SchemeDataObject
  attr_reader :value
  def initialize(value)
    @value = Float(value)
  end

  def ==(x)
    if x.class == SchemeFloat
      return x.value == @value
    else
      return false
    end
  end

  def *(x)
    case x
    when SchemeFloat
      return SchemeFloat.new(@value*x.value)
    else
      raise "Can't do multiples of #{x.class} to SchemeFloat"
    end
  end

  def +(x)
    case x
    when SchemeFloat
      return SchemeFloat.new(@value+x.value)
    else
      raise "Can't add #{x.class} to SchemeFloat"
    end
  end

  def /(x)
    case x
    when SchemeFloat
      raise SchemeUserError.new('Division by zero!') unless x.value != 0
      return SchemeFloat.new(@value/x.value)
    else
      raise "Can't divide #{x.class} through SchemeFloat"
    end
  end

  def -(x)
    case x
    when SchemeFloat
      return SchemeFloat.new(@value-x.value)
    else
      raise "Can't substract #{x.class} from SchemeFloat"
    end
  end

  def to_s
    @value.to_s
  end
end
