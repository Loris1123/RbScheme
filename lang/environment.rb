require_relative "builtinfunctions"

class Environment
  def initialize
    @environment = Hash.new
  end

  def get(key)
    @environment[key]
  end

  def put(key, value)
    @environment[key] = value
  end
end
