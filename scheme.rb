#!/usr/bin/ruby

require_relative 'reader'
require_relative 'lang/userinput'
require_relative 'print'
require_relative 'lang/errors'
require_relative 'eval'
require_relative 'lang/environment'
require_relative 'lang/builtinfunctions'
require_relative 'lang/objects'
require_relative 'lang/symboltable'

if ARGV[1] != "skiptest"
  # Start tests
  require_relative 'test/test'
  Test.test
end

global_env = Environment.new()
global_env.put(Symboltable.get_or_add(SchemeSymbol.new('+')), BuiltinFunction.new('SchemePlus', Functions.scheme_plus , 2, -1))
global_env.put(Symboltable.get_or_add(SchemeSymbol.new('-')), BuiltinFunction.new('SchemeSubstract', Functions.scheme_substract ,2, -1))
global_env.put(Symboltable.get_or_add(SchemeSymbol.new('*')), BuiltinFunction.new('SchemeTimes', Functions.scheme_times , 2, -1))
global_env.put(Symboltable.get_or_add(SchemeSymbol.new('/')), BuiltinFunction.new('SchemeDivide', Functions.scheme_divide ,2, 2))
global_env.put(Symboltable.get_or_add(SchemeSymbol.new('<')), BuiltinFunction.new('SchemeLowerThan', Functions.lower_than,2, 2))
global_env.put(Symboltable.get_or_add(SchemeSymbol.new('>')), BuiltinFunction.new('SchemeGreaterThan', Functions.greater_than ,2, 2))
global_env.put(Symboltable.get_or_add(SchemeSymbol.new('modulo')), BuiltinFunction.new('SchemeModulo', Functions.scheme_modulo , 2, 2))
global_env.put(Symboltable.get_or_add(SchemeSymbol.new('abs')), BuiltinFunction.new('SchemeAbs', Functions.scheme_abs , 1, 1))

global_env.put(Symboltable.get_or_add(SchemeSymbol.new('eq?')), BuiltinFunction.new('SchemeEquals', Functions.scheme_equals ,2, 2))
global_env.put(Symboltable.get_or_add(SchemeSymbol.new('integer?')), BuiltinFunction.new('SchemeInteger?', Functions.integer? ,1, 1))
global_env.put(Symboltable.get_or_add(SchemeSymbol.new('symbol?')), BuiltinFunction.new('SchemeSymbol?', Functions.symbol? ,1, 1))
global_env.put(Symboltable.get_or_add(SchemeSymbol.new('string?')), BuiltinFunction.new('SchemeString?', Functions.string? ,1, 1))
global_env.put(Symboltable.get_or_add(SchemeSymbol.new('function?')), BuiltinFunction.new('SchemeFunction?', Functions.function? ,1, 1))
global_env.put(Symboltable.get_or_add(SchemeSymbol.new('builtin-function?')), BuiltinFunction.new('SchemeBuiltinFunction?', Functions.builtin_function? ,1, 1))
global_env.put(Symboltable.get_or_add(SchemeSymbol.new('syntax?')), BuiltinFunction.new('SchemeSyntax?', Functions.syntax? ,1, 1))
global_env.put(Symboltable.get_or_add(SchemeSymbol.new('builtin-syntax?')), BuiltinFunction.new('SchemeBuiltinSyntax?', Functions.builtin_syntax? ,1, 1))

global_env.put(Symboltable.get_or_add(SchemeSymbol.new('cons')), BuiltinFunction.new('SchemeCons', Functions.scheme_cons, 2, 2))
global_env.put(Symboltable.get_or_add(SchemeSymbol.new('cons?')), BuiltinFunction.new('SchemeCons?', Functions.scheme_cons?, 1, 1))
global_env.put(Symboltable.get_or_add(SchemeSymbol.new('car')), BuiltinFunction.new('SchemeCar', Functions.scheme_car, 1, 1))
global_env.put(Symboltable.get_or_add(SchemeSymbol.new('cdr')), BuiltinFunction.new('SchemeCdr', Functions.scheme_cdr, 1, 1))
global_env.put(Symboltable.get_or_add(SchemeSymbol.new('define')), BuiltinSyntax.new('SchemeDefine', Functions.scheme_define, 2, 2))

input = ARGV[0]
if input != nil
  # Parse commandline argument
  puts SchemePrinter.scheme_print(Eval.eval(global_env, Reader.read_input(UserInput.new(input))))
else
  puts 'Welcome to RbScheme'
  # Interactive mode
  while TRUE

    begin
      print '> '
      input = UserInput.new(gets)
      read = Reader.read_input(input)
      evaled = Eval.eval(global_env, read)
      puts SchemePrinter.scheme_print(evaled)
    rescue SchemeUserError => err
      puts err.message
    end
  end
end
