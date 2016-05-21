class SchemeObject; end

class SchemeVoid < SchemeObject; end

class SchemeNil < SchemeObject; end

class SchemeTrue < SchemeObject; end

class SchemeFalse < SchemeObject; end

# Using Ruby-Symbols at the moment instead of SchemeSymbol
#class SchemeSymbol < SchemeObject
#  def initialize(value)
#    @value = value
#  end
#
#  def value
#    @value
#  end
#end

class SchemeInteger < SchemeObject
  def initialize(value)
    set_value(value)
  end

  def get_value
    Integer(@value)
  end

  def *(x)
    case x
    when SchemeInteger
      return @value*x.get_value
    when Fixnum
      return @value*x
    else
      raise "Can't do multiples of #{x.class} to SchemeInteger"
    end
  end

  def +(x)
    case x
    when SchemeInteger
      return @value+x.get_value
    when Fixnum
      return @value+x
    else
      raise "Can't add #{x.class} to SchemeInteger"
    end
  end

  def set_value(value)
    begin
      @value = Integer(value)
    rescue ArgumentError, TypeError
      raise SchemeArgumentError.new(Fixnum, value.class)
    end
  end
end

class SchemeString < SchemeObject
  def initialize(value)
    @value = String(value)
  end

  def get_value
    @value
  end

  def set_value(value)
    @value = String(value)
  end
end

class SchemeCons < SchemeObject
  def initialize(car, cdr)
    @car = car
    @cdr = cdr
  end

  def get_car; @car; end
  def get_cdr; @cdr; end
end
