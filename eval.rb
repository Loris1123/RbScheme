require_relative "lang/errors"

module Eval

  def self.eval(input, environment)
    case input
    when Symbol
      symbol = environment.get(input)
      raise UndefinedSymbolError.new(input) unless symbol != nil
      return symbol
    when SchemeCons
      return self.eval_cons(input, environment)
    end
    return input
  end

  def self.eval_cons(cons, environment)
    function = self.eval(cons.get_car, environment)
    function_arguments = cons.get_cdr
    arg1 = self.eval(function_arguments.get_car, environment)
    arg2 = self.eval(function_arguments.get_cdr.get_car, environment)
    return function.work(arg1, arg2)
  end
end
