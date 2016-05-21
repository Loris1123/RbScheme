#!/usr/bin/ruby

require_relative "reader"
require_relative "util/userinput"
require_relative "print"
require_relative "lang/errors"
require_relative "eval"
require_relative "lang/environment"
require_relative "lang/builtinfunctions"
require_relative "lang/objects"
# Start tests
require_relative "test/test"
Test.test

global_env = Environment.new()
global_env.put(:+, BuiltinFunction.new("SchemePlus", Functions.scheme_plus))
global_env.put(:*, BuiltinFunction.new("SchemeTimes", Functions.scheme_times))
global_env.put(:-, BuiltinFunction.new("SchemeSubstract", Functions.scheme_substract))
global_env.put(:/, BuiltinFunction.new("SchemeDivide", Functions.scheme_divide))
global_env.put(:a, SchemeInteger.new(10))
global_env.put(:b, SchemeInteger.new(20))

puts "Welcome to RbScheme"
while TRUE
  begin
    print "> "
    input = UserInput.new(gets)
    read = Reader.read_input(input)
    evaled = Eval.eval(read, global_env)
    printed = SchemePrinter.scheme_print(evaled)
    puts printed
  rescue SchemeUserError => err
    puts err.message
  end
end
