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
