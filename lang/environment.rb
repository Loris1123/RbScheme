require_relative '../lang/errors'

# Normal hashtable for now...will implement my own later
class Environment
  def initialize(parent=nil)
    @environment = Hash.new
    @parent = parent
  end

  def get(symbol)
    result = @environment[symbol.value]
    if result == nil and @parent != nil
      result = @parent.get(symbol)
    end
    return result
  end

  def put(symbol, value)
    raise SchemeInternalError.new("Only Symbols are allowed as keys. Got #{symbol.class}") unless symbol.class == SchemeSymbol
    @environment[symbol.value] = value
  end

  def parent
    @parent
  end

  def get_environment
    @environment
  end
end
