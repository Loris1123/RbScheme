#!/usr/bin/ruby

require_relative 'reader'
require_relative 'lang/userinput'
require_relative 'print'
require_relative 'lang/errors'
require_relative 'eval'
require_relative 'lang/environment'
require_relative 'lang/builtinfunctions'
require_relative 'lang/objects'

# Start tests
require_relative 'test/test'
Test.test

global_env = Environment.new()
global_env.put(SchemeSymbol.new('+'), BuiltinFunction.new('SchemePlus', Functions.scheme_plus , 2))
global_env.put(SchemeSymbol.new('*'), BuiltinFunction.new('SchemeTimes', Functions.scheme_times , 2))
global_env.put(SchemeSymbol.new('-'), BuiltinFunction.new('SchemeSubstract', Functions.scheme_substract , 2))
global_env.put(SchemeSymbol.new('/'), BuiltinFunction.new('SchemeDivide', Functions.scheme_divide , 2))
global_env.put(SchemeSymbol.new('eq?'), BuiltinFunction.new('SchemeEquals', Functions.scheme_equals , 2))
#global_env.put(SchemeSymbol.new("define"), BuiltinFunction.new("SchemeDefine", Functions.scheme_define))
global_env.put(SchemeSymbol.new('cons'), BuiltinFunction.new('SchemeCons', Functions.scheme_cons , 2))
global_env.put(SchemeSymbol.new('car'), BuiltinFunction.new('SchemeCar', Functions.scheme_car, 1))
global_env.put(SchemeSymbol.new('cdr'), BuiltinFunction.new('SchemeCdr', Functions.scheme_cdr, 1))
global_env.put(SchemeSymbol.new('a'), SchemeInteger.new(10))
global_env.put(SchemeSymbol.new('b'), SchemeInteger.new(20))

puts 'Welcome to RbScheme'
while TRUE
  begin
    print '> '
    input = UserInput.new(gets)
    #input = UserInput.new("(cons 1 2 3)")
    read = Reader.read_input(input)
    evaled = Eval.eval(global_env, read)
    printed = SchemePrinter.scheme_print(evaled)
    puts printed
  rescue SchemeUserError => err
    puts err.message
  end
end
