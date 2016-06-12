class SchemeObject; end

class SchemeVoid < SchemeObject
  def ==(x)
    return x.class == SchemeVoid
  end
end

class SchemeNil < SchemeObject
  def ==(x)
    return x.class == SchemeNil
  end
end

class SchemeTrue < SchemeObject
  def ==(x)
    return x.class == SchemeTrue
  end
end

class SchemeFalse < SchemeObject
  def ==(x)
    return x.class == SchemeFalse
  end
end

class SchemeSymbol < SchemeObject
  def initialize(value)
    @value = value
  end

  def ==(x)
    if x.class==SchemeSymbol
      return @value == x.value
    end
    return false
  end

  def value
    @value
  end

  def to_str
    "SchemeSymbol: #{@value}"
  end
end

class SchemeInteger < SchemeObject
  def initialize(value)
    set_value(value)
  end

  def value
    Integer(@value)
  end

  def ==(x)
    return x.value==@value
  end

  def *(x)
    case x
    when SchemeInteger
      return SchemeInteger.new(@value*x.value)
    when Fixnum
      return SchemeInteger.new(@value*xx)
    else
      raise "Can't do multiples of #{x.class} to SchemeInteger"
    end
  end

  def +(x)
    case x
    when SchemeInteger
      return SchemeInteger.new(@value+x.value)
    when Fixnum
      return SchemeInteger.new(@value+x)
    else
      raise "Can't add #{x.class} to SchemeInteger"
    end
  end

  def /(x)
    case x
    when SchemeInteger
      return SchemeInteger.new(@value/x.value)
    when Fixnum
      return SchemeInteger.new(@value/x)
    else
      raise "Can't divide #{x.class} through SchemeInteger"
    end
  end

  def -(x)
    case x
    when SchemeInteger
      return SchemeInteger.new(@value-x.value)
    when Fixnum
      return SchemeInteger.new(@value-x)
    else
      raise "Can't substract #{x.class} from SchemeInteger"
    end
  end

  def set_value(value)
    begin
      @value = Integer(value)
    rescue ArgumentError, TypeError
      raise SchemeArgumentError.new(Fixnum, value.class)
    end
  end

  def to_s
    @value.to_s
  end
end

class SchemeString < SchemeObject
  def initialize(value)
    @value = String(value)
  end

  def value
    @value
  end

  def set_value(value)
    @value = String(value)
  end

  def ==(x)
    return @value==x.value
  end
end

class SchemeCons < SchemeObject
  def initialize(car, cdr)
    @car = car
    @cdr = cdr
  end

  def car; @car; end
  def cdr; @cdr; end
end
