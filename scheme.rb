#!/usr/bin/ruby

require_relative "reader.rb"
require_relative "util/userinput.rb"

# Start tests
require_relative "test/test.rb"
Test.test

puts "Welcome to RbScheme"
while TRUE
  print "> "
  input = UserInput.new(gets)
  puts Reader.read_input input
end
