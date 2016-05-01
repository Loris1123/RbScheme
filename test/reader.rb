require_relative "../reader"

module ReaderTest
  def self.test
    raise "Should be digit" unless Reader.is_digit 3
    raise "Shoud not be a digit" if Reader.is_digit "No Digit"
  end
end
