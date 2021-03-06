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
    if x.class == self.class
      return self.class.new(@value * x.value)
    elsif (self.class == SchemeInteger and x.class == SchemeFloat) or (self.class == SchemeFloat and x.class == SchemeInteger)
      return SchemeFloat.new(@value * x.value)
    elsif (self.class == SchemeInteger and x.class == SchemeRational) or (self.class == SchemeRational and x.class == SchemeInteger)
      return SchemeRational.new(@value * x.value)
    elsif (self.class == SchemeFloat and x.class == SchemeRational) or (self.class == SchemeRational and x.class == SchemeFloat)
      return SchemeFloat.new(@value * x.value)
    else
      raise "Can't do multiples of #{x.class} to #{self.class}"
    end
  end

  def +(x)
    if x.class == self.class
      return self.class.new(@value+x.value)
    elsif (self.class == SchemeInteger and x.class == SchemeFloat) or (self.class == SchemeFloat and x.class == SchemeInteger)
      return SchemeFloat.new(@value+x.value)
    elsif (self.class == SchemeInteger and x.class == SchemeRational) or (self.class == SchemeRational and x.class == SchemeInteger)
      return SchemeRational.new(@value+x.value)
    elsif (self.class == SchemeFloat and x.class == SchemeRational) or (self.class == SchemeRational and x.class == SchemeFloat)
      return SchemeFloat.new(@value + x.value)
    else
      raise "Can't add #{x.class} to #{self.class}"
    end
  end

  def /(x)
    raise SchemeUserError.new('Division by zero!') unless x.value != 0
    if x.class == self.class
      return self.class.new(@value/x.value)
    elsif (self.class == SchemeInteger and x.class == SchemeFloat) or (self.class == SchemeFloat and x.class == SchemeInteger)
      return SchemeFloat.new(@value / x.value)
    elsif (self.class == SchemeInteger and x.class == SchemeRational) or (self.class == SchemeRational and x.class == SchemeInteger)
      return SchemeRational.new(@value / x.value)
    elsif (self.class == SchemeFloat and x.class == SchemeRational) or (self.class == SchemeRational and x.class == SchemeFloat)
      return SchemeFloat.new(@value / x.value)
    else
      raise "Can't divide #{x.class} through #{self.class}"
    end
  end

  def -(x)
    if x.class == self.class
      return self.class.new(@value - x.value)
    elsif (self.class == SchemeInteger and x.class == SchemeFloat) or (self.class == SchemeFloat and x.class == SchemeInteger)
      return SchemeFloat.new(@value - x.value)
    elsif (self.class == SchemeInteger and x.class == SchemeRational) or (self.class == SchemeRational and x.class == SchemeInteger)
      return SchemeRational.new(@value - x.value)
    elsif (self.class == SchemeFloat and x.class == SchemeRational) or (self.class == SchemeRational and x.class == SchemeFloat)
      return SchemeFloat.new(@value - x.value)
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

  def /(x)
    raise SchemeUserError.new('Division by zero!') unless x.value != 0

    if x.class == SchemeInteger and (@value % x.value != 0)
      return SchemeRational.new(@value, x.value)
    else
      super(x)
    end
  end

end

class SchemeFloat < SchemeNumber
  def initialize(value)
    @value = Float(value)
  end
end

class SchemeRational < SchemeNumber

  # Creates a new SchemeRational.
  # If one parameter is given, it must be possible to cast it to a Rational.
  # If two parameters are given, we
  def initialize(*args)
    if args.size == 1
      @value = Rational(args[0])
    elsif args.size == 2
      @value = Rational(args[0], args[1])
    else
      raise SchemeInternalError.new("Unknown parameters for SchemeRational: #{args.inpsect}")
    end
  end
end
