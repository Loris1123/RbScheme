require_relative "reader"
require_relative "userinput"
module Test
  def self.test
    puts "Running Tests"
    puts "\tReadertest"
    ReaderTest.test
    puts "\tSuccess"

    puts "\tUserinputtest"
    UserInputTest.test
    puts "\tSuccess"
    
    puts "All tests completed"
  end
end
