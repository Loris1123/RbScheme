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
      read_number input
    end



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

  def self.is_digit(x)
    # Small helper to check if the given parameter is a number
    begin
      Integer(x)
      return TRUE
    rescue ArgumentError, TypeError
      return FALSE
    end
  end
end
