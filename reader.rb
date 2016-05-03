require_relative "util/userinput"
require_relative "lang/errors"
require_relative "lang/objects"

module Reader
  def self.read_input(input)
    if input.class != UserInput
      raise WrongInputError, input
    end
    skip_spaces(input)
    c = input.read_char
    puts "C: #{c}"

    if is_digit c
      return read_number input
    elsif c == "\""
      return read_string input
    elsif c == "("
      return read_list input
    else
      return read_symbol input
    end
  end

  def self.read_list(input)
    """
    Reads a list and returns Cons
    """
    raise "Unimplemented: read_list"

  end

  def self.read_symbol(input)
    """
    Reads a symbol and returns the corresponding value from environment.
    """
    symbol = ""
    while input.get_current_char != "(" &&
      input.get_current_char != ")" &&
      input.get_current_char != " " &&
      input.get_current_char != nil
      symbol += input.get_current_char
      input.read_char
    end
    # Well known symbols
    case symbol
    when "nil"
      return SchemeNil.new
    when "\#t"
      return SchemeTrue.new
    when "\#f"
      return SchemeFalse.new
    end
    # TODO Implement Env and get value from Env
      return SchemeString.new("Env Not Implemented")
  end

  def self.read_number(input)
    """
    Reads a Number and returns SchemeInteger
    """
    number = input.get_current_char
    while is_digit input.get_current_char
      number += input.read_char
    end

    if input.get_current_char != " " and input.get_current_char != nil
      # There must be a space or EOF now
      raise SchemeSyntaxError, input.get_input
    end

    SchemeInteger.new(number)
  end

  def self.read_string(input)
    """
    Reads a string and returns SchemeString
    """
    string = input.read_char
    while input.get_current_char != "\"" && input.get_current_char != nil
      string += input.read_char
    end

    if string[-1] != "\""
      raise UnterminatedStringError.new(input.get_input)
    end
    SchemeString.new(string[0..-2]) # Cut the last read "
  end

  def self.skip_spaces(input)
    while input.get_current_char == " "
      input.read_char
    end
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
