require_relative "lang/errors"
require_relative "lang/builtinfunctions"
module Eval

  def self.eval(environment, userinput)
    case userinput
    when SchemeSymbol
      symbol = environment.get(userinput)
      raise UndefinedVariableError.new(userinput.value) unless symbol != nil
      return symbol
    when SchemeCons
      return self.eval_cons(environment, userinput)
    when SchemeNil
      return nil
    #else
    #  raise SchemeInternalError.new("Unimplemented eval: #{input.class}")
    end
    return userinput
  end

  def self.eval_cons(environment, cons)
    function = self.eval(environment, cons.car)

    if function.class != BuiltinFunction
      raise SchemeSyntaxError.new("#{function} is not a function")
    end

    function_arguments = cons.cdr
    # TODO: Can't do define. arguments will be evaluated, so it will find an undefine variable
    arg1 = self.eval(environment, function_arguments.car)
    arg2 = self.eval(environment, function_arguments.cdr.car)
    return function.work(environment, arg1, arg2)
  end
end
