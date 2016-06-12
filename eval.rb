require_relative "lang/errors"
require_relative "lang/builtinfunctions"
module Eval

  def self.eval(input, environment)
    case input
    when SchemeSymbol
      symbol = environment.get(input)
      raise UndefinedVariableError.new(input.value) unless symbol != nil
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
    function = self.eval(cons.car, environment)

    if function.class != BuiltinFunction
      raise SchemeSyntaxError.new("#{function} is not a function")
    end

    function_arguments = cons.cdr
    # TODO: Can't do define. arguments will be evaluated, so it will find an undefine variable
    arg1 = self.eval(function_arguments.car, environment)
    arg2 = self.eval(function_arguments.cdr.car, environment)
    return function.work(environment, arg1, arg2)
  end
end
