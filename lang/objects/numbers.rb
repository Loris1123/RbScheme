class SchemeNumber < SchemeDataObject
  attr_reader :value

  def ==(x)
    if x.class == self.class
      return x.value == @value
    else
      return false
    end
  end

  def *(x)
    case x
    when self.class
      return self.class.new(@value*x.value)
    else
      raise "Can't do multiples of #{x.class} to #{self.class}"
    end
  end

  def +(x)
    case x
    when self.class
      return self.class.new(@value+x.value)
    else
      raise "Can't add #{x.class} to #{self.class}"
    end
  end

  def /(x)
    case x
    when self.class
      raise SchemeUserError.new('Division by zero!') unless x.value != 0
      return self.class.new(@value/x.value)
    else
      raise "Can't divide #{x.class} through #{self.class}"
    end
  end

  def -(x)
    case x
    when self.class
      return self.class.new(@value-x.value)
    else
      raise "Can't substract #{x.class} from #{self.class}"
    end
  end

  def to_s
    @value.to_s
  end
end

class SchemeInteger < SchemeNumber
  def initialize(value)
    @value = Integer(value)
  end
end

class SchemeFloat < SchemeNumber
  def initialize(value)
    @value = Float(value)
  end
end
