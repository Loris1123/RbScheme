require_relative "reader"
require_relative "userinput"
require_relative "objects"

module Test
  def self.test
    puts "Running Tests"
    puts "\tReadertest"
    ReaderTest.test
    puts "\tSuccess"

    puts "\tUserinputtest"
    UserInputTest.test
    puts "\tSuccess"

    puts "\tObjecttest"
    ObjectsTest.test
    puts "\tSuccess"

    puts "All tests completed"
  end
end
