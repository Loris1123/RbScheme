require_relative "util/userinput"
require_relative "lang/errors"
require_relative "lang/objects"

module Reader
  def self.read_input(input)
    if input.class != UserInput
      raise WrongInputError, input
    end
    c = input.next_char

    if is_digit c
      return read_number input
    elsif c == "\""
      return read_string input
    elsif c == "("
      return read_list input
    end
    return read_symbol
  end

  def read_list(input)
    """
    Reads a list and returns Cons
    """
    raise "Unimplemented: read_list"
  end

  def read_symbol(input)
  end

  def self.read_number(input)
    """
    Reads a Number and returns SchemeInteger
    """
    number = ""
    while is_digit input.get_current_char
      number += input.get_current_char
      input.next_char
    end
    SchemeInteger.new(number)
  end

  def self.read_string(input)
    """
    Reads a string and returns SchemeString
    """
    input.next_char  # Skip "
    string = ""
    while input.get_current_char != "\"" && input.get_current_char != nil
     string += input.get_current_char
     input.next_char
    end

    if input.get_current_char != "\""
     raise UnterminatedStringError, string
    end
    return SchemeString.new(string)
  end

  def self.is_digit(x)
    """
    Small helper to check if the given parameter is a number
    """
    begin
      Integer(x)
      return TRUE
    rescue ArgumentError, TypeError
      return FALSE
    end
  end
end
