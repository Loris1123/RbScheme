require_relative '../lang/environment'
require_relative '../lang/objects'

module EnvironmentTest
  def self.test
    env = Environment.new
    raise "Environment should be empty. Filllevel is #{env.get_environment.fill_level}" unless env.get_environment.fill_level == 0

    sym = SchemeSymbol.new('a')
    env.put(sym, 666)
    raise "Length of Environment should be 1. Is #{env.get_environment.fill_level}" unless env.get_environment.fill_level == 1
    res = env.get(sym)
    raise "A should have the value 666. Is #{res}" unless res == 666

    child_env = Environment.new
    child_env.set_parent(env)
    # Not in child. Should look in parent now
    res = child_env.get(sym)
    raise "A should have the value 666. Is #{res}" unless res == 666

    # Now something from child
    sym2 = SchemeSymbol.new('b')
    child_env.put(sym2, 123)
    res = child_env.get(sym2)
    raise "A should have the value 123. Is #{res}"  unless  res == 123

    # Now we have the same key in env and child. Value from child should be returned
    child_env.put(sym, 321)
    res = child_env.get(sym)
    raise "A should have the value 321. Is #{res}" unless child_env.get(sym) == 321

  end
end
