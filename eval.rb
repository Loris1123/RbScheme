require_relative 'lang/errors'
require_relative 'lang/builtinfunctions'
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
      # Todo: or BuiltinSyntax, UserFunction, UserSyntax
      raise SchemeSyntaxError.new("#{function} is not a function")
    end

    function_arguments = cons.cdr

    if function.class == BuiltinFunction
      return self.eval_builtin_functon(environment, function, function_arguments)
    end

  end

  def self.eval_builtin_syntax(environment, function, args)
    raise Exception.new('Not yet implemented')
  end

  def self.eval_builtin_functon(environment, function, function_arguments)
    args = []
    loop do
      args << function_arguments.car
      break if function_arguments.cdr.class == SchemeNil
      function_arguments = function_arguments.cdr
    end

    ## TODO: Can't do define. arguments will be evaluated, so it will find an undefine variable
    return function.work(environment, args)
  end

  def self.eval_user_syntax(environment, function, args)
    raise Exception.new('Not yet implemented')
  end

  def self.eval_user_function(environment, function, args)
    raise Exception.new('Not yet implemented')
  end
end
