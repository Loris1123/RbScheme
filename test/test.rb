require_relative "reader.rb"

module Test
  def self.test
    puts "Running Tests"
    puts "\tReaderTest"
    ReaderTest.test
    puts "\tSuccess"
    puts "All tests completed"
  end
end
