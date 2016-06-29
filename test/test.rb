require_relative 'reader'
require_relative 'userinput'
require_relative 'objects'
require_relative 'linkedlist'
require_relative 'environment'
require_relative 'symboltable'
require_relative 'hashtable'
require_relative 'eval'

module Test
  def self.test
    puts "Running Tests"
    puts "\tUserinput"
    UserInputTest.test
    puts "\tSuccess"

    puts "\tSymboltable"
    SymboltableTest.test
    puts "\tSuccess"

    puts "\tHashtable"
    HashtableTest.test
    puts "\tSuccess"

    puts "\tEnvironment"
    EnvironmentTest.test
    puts "\tSuccess"

    puts "\tObject"
    ObjectsTest.test
    puts "\tSuccess"

    puts "\tReader"
    ReaderTest.test
    puts "\tSuccess"

    puts "\tEval"
    EvalTest.test
    puts "\tSuccess"

    puts "All tests completed"
  end
end
