require_relative '../lang/errors'
require_relative '../util/hashtable'

# Normal hashtable for now...will implement my own later
class Environment
  def initialize(parent=nil)
    @environment = Hashtable.new
    @parent = parent
  end

  def get(symbol)
    result = @environment.get(symbol.value)
    if result == nil and @parent != nil
      result = @parent.get(symbol)
    end
    return result
  end

  def put(symbol, value)
    raise SchemeInternalError.new("Only Symbols are allowed as keys. Got #{symbol.class}") unless symbol.class == SchemeSymbol
    @environment.put(symbol.value, value)
  end

  # Set the parent of an environment. Only needed for testing
  def set_parent(parent)
    @parent = parent
  end

  def parent
    @parent
  end

  def get_environment
    @environment
  end
end
