class SchemeObject; end

class SchemeVoid < SchemeObject; end

class SchemeTrue < SchemeObject; end

class SchemeFalse < SchemeObject; end

class SchemeInteger < SchemeObject
  def initialize(value)
    @value = value
  end

  def get_value
    @value
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
