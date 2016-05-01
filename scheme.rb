#!/usr/bin/ruby

require_relative "reader"
require_relative "util/userinput"
require_relative "print"
# Start tests
require_relative "test/test"
Test.test

puts "Welcome to RbScheme"
while TRUE
  print "> "
  input = UserInput.new(gets)
  SchemePrinter.scheme_print(Reader.read_input input)
end
