require_relative '../lang/environment'
require_relative '../lang/objects'

module EnvironmentTest
  def self.test
    env = Environment.new
    raise 'Environment should be empty' unless env.get_environment.size == 0

    sym = SchemeSymbol.new('a')
    env.put(sym, 666)
    raise 'Length of Environment should be 1' unless env.get_environment.size == 1
    raise 'A should have the value 666' unless env.get(sym) == 666
  end
end
