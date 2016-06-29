require_relative '../lang/errors'
require 'singleton'
# Baseclass of all objects
class SchemeObject; end

# Objects, that can exist only one time.
class SchemeSingletonObject < SchemeObject
  include Singleton
end

# All other objects. Can exist multiple times and contain data.. Numbers, Strings, etc..
class SchemeDataObject < SchemeObject
  attr_accessor :value
end

class SchemeVoid < SchemeSingletonObject
  def ==(x)
    return x.class == SchemeVoid
  end
end

class SchemeNil < SchemeSingletonObject
  def ==(x)
    return x.class == SchemeNil
  end
end

class SchemeTrue < SchemeSingletonObject
  def ==(x)
    return x.class == SchemeTrue
  end
end

class SchemeFalse < SchemeSingletonObject
  def ==(x)
    return x.class == SchemeFalse
  end
end

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

class SchemeInteger < SchemeDataObject
  def initialize(value)
    @value = value
  end

  def value=(val)
    begin
      @value = Integer(val)
    rescue ArgumentError, TypeError
      raise SchemeArgumentError.new(Fixnum, val.class)
    end
  end

  def ==(x)
    if x.class == Fixnum
      return x==@value
    elsif x.class == SchemeInteger
      return x.value == @value
    else
      return false
    end
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
      raise SchemeUserError.new('Division by zero!') unless x.value != 0
      return SchemeInteger.new(@value/x.value)
      when Fixnum
        raise SchemeUserError.new('Division by zero!') unless x != 0
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

  def to_s
    @value.to_s
  end
end

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

class SchemeCons < SchemeDataObject
  attr_accessor :car
  attr_accessor :cdr
  def initialize(car, cdr)
    @car = car
    @cdr = cdr
  end

  def value=(val)
    if val.class == SchemeCons
      @car = val.car
      @cdr = val.cdr
    else
      raise SchemeError("Only cons are allowrd for value= in cons. Got #{val.class}")
    end
  end
end
