require_relative "lang/errors"
require_relative "lang/builtinfunctions"
module Eval

  def self.eval(input, environment)
    case input
    when SchemeSymbol
      symbol = environment.get(input)
      raise UndefinedSymbolError.new(input) unless symbol != nil
      return symbol
    when SchemeCons
      return self.eval_cons(input, environment)
    when SchemeNil
      return nil
    #else
    #  raise SchemeInternalError.new("Unimplemented eval: #{input.class}")
    end
    return input
  end

  def self.eval_cons(cons, environment)
    function = self.eval(cons.get_car, environment)

    if function.class != BuiltinFunction
      raise SchemeSyntaxError.new("#{function} is not a function")
    end

    function_arguments = cons.get_cdr

    arg1 = self.eval(function_arguments.get_car, environment)
    arg2 = self.eval(function_arguments.get_cdr.get_car, environment)
    return function.work(environment, arg1, arg2)
  end
end
