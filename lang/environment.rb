# Normal hashtable for now...will implement my own later
class Environment
  def initialize
    @environment = Hash.new
  end

  def get(symbol)
    @environment[symbol.value]
  end

  def put(symbol, value)
    @environment[symbol.value] = value
  end

  def get_environment
    @environment
  end
end
