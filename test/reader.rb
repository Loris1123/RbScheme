require_relative "../reader"
require_relative "../util/userinput"

module ReaderTest
  def self.test
    raise "Should be digit" unless Reader.is_digit 3
    raise "Shoud not be a digit" if Reader.is_digit "No Digit"
    raise "Shoud not be a digit" if Reader.is_digit ""
    raise "Shoud not be a digit" if Reader.is_digit nil

    u = UserInput.new("1234")
    u.read_char
    r = Reader.read_number u
    raise "Read input should be SchemeInteger, is #{r.class}" unless r.class == SchemeInteger
    raise "Read number should be 1234, is #{r.get_value}" unless r.get_value == 1234

    u = UserInput.new("\"abcd\"")
    u.read_char
    r = Reader.read_string u
    raise "Read input should be SchemeString, is #{r.class}" unless r.class == SchemeString
    raise "Read string should be \"abcd\", is #{r.get_value}" unless r.get_value == "abcd"


    u = UserInput.new("\"abcd")
    u.read_char
    begin
      r = Reader.read_string u
      raise "Should raise an UnterminatedStringError"
    rescue UnterminatedStringError
    end

  end
end
