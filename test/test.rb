require_relative "reader"
require_relative "userinput"
require_relative "objects"
require_relative "linkedlist"
require_relative "hashtable"
require_relative "symboltable"

module Test
  def self.test
    puts "Running Tests"
    puts "\tUserinput"
    UserInputTest.test
    puts "\tSuccess"

    puts "\tSymboltable"
    SymboltableTest.test
    puts "\tSuccess"

    #puts "\tLinkedlist"
    #LinkedListTest.test
    #puts "\tSuccess"

    #puts "\tHashTable"
    #HashtableTest.test
    #puts "\tSuccess"

    puts "\tReader"
    ReaderTest.test
    puts "\tSuccess"

    puts "\tObject"
    ObjectsTest.test
    puts "\tSuccess"

    puts "All tests completed"
  end
end
