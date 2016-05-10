require_relative "reader"
require_relative "userinput"
require_relative "objects"
require_relative "linkedlist"

module Test
  def self.test
    puts "Running Tests"
    puts "\tUserinput"
    UserInputTest.test
    puts "\tSuccess"

    puts "\tLinkedlist"
    LinkedListTest.test
    puts "\tSuccess"

    puts "\tReader"
    ReaderTest.test
    puts "\tSuccess"

    puts "\tObject"
    ObjectsTest.test
    puts "\tSuccess"

    puts "All tests completed"
  end
end
