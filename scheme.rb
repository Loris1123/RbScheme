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
global_env.put(:+, BuiltinFunction.new("SchemePlus", Proc.new{Functions.scheme_plus}))
global_env.put(:a, SchemeInteger.new(123))

puts "Welcome to RbScheme"
while TRUE
  begin
    print "> "
    input = UserInput.new(gets)
    read = Reader.read_input(input)
    eval = Eval.eval(read, global_env)
    print = SchemePrinter.scheme_print(eval)
    puts print
  rescue SchemeUserError => err
    puts err.message
  end
end
