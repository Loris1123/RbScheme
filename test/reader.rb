require_relative "../reader"

module ReaderTest
  def self.test
    raise "Should be digit" unless Reader.is_digit 3
    raise "Shoud not be a digit" if Reader.is_digit "No Digit"
    raise "Shoud not be a digit" if Reader.is_digit ""
    raise "Shoud not be a digit" if Reader.is_digit nil
  end
end
