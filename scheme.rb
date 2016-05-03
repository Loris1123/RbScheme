#!/usr/bin/ruby

require_relative "reader"
require_relative "util/userinput"
require_relative "print"
require_relative "lang/errors"
# Start tests
require_relative "test/test"
Test.test

puts "Welcome to RbScheme"
while TRUE
  begin
    print "> "
    input = UserInput.new(gets)
    puts SchemePrinter.scheme_print(Reader.read_input input)
  rescue SchemeUserError => err
    puts err.message
  end
end
