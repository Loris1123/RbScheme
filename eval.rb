require_relative 'lang/errors'
require_relative 'lang/builtinfunctions'
require_relative 'lang/environment'
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
    function_arguments = cons.cdr

    case function
      when BuiltinFunction
        return self.eval_builtin_function(environment, function, function_arguments)
      when BuiltinSyntax
        return self.eval_builtin_syntax(environment, function, function_arguments)
      when UserdefinedFunction
        return self.eval_user_function(environment, function, function_arguments)
      else
        raise SchemeSyntaxError.new("#{function} is not a function")
    end
  end

  def self.eval_builtin_syntax(environment, function, function_arguments)
    args = []
    loop do
      args << function_arguments.car
      break if function_arguments.cdr.class == SchemeNil
      function_arguments = function_arguments.cdr
    end
    return function.work(environment, args)
  end

  def self.eval_builtin_function(environment, function, function_arguments)
    args = []
    loop do
      args << self.eval(environment, function_arguments.car)
      break if function_arguments.cdr.class == SchemeNil
      function_arguments = function_arguments.cdr
    end
    return function.work(environment, args)
  end

  def self.eval_user_syntax(environment, function, args)

    raise Exception.new('Not yet implemented')
  end

  def self.eval_user_function(environment, function, function_arguments)
    # Create argument List
    args = []
    loop do
      args << self.eval(environment, function_arguments.car)
      break if function_arguments.cdr.class == SchemeNil
      function_arguments = function_arguments.cdr
    end

    if args.size != function.number_of_arguments
      raise SchemeArgumentNumberError.new(function.name, function.number_of_arguments, args.size)
    end

    # Create a new environment for function and map parameters to arguments
    local_env = Environment.new(environment)
    i = 0
    while i < args.size
      local_env.put(function.parameter[i], args[i])
      i+=1
    end
    self.eval(local_env, function.function)
  end
end
