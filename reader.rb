require_relative "lang/userinput"
require_relative "lang/errors"
require_relative "lang/objects"
require_relative "lang/symboltable"

module Reader

  def self.read_input(input)
    if input.class != UserInput
      raise WrongInputError, input
    end

    if is_digit input.current
      return read_number input
    elsif input.current == "\""
      return read_string input
    elsif input.current == "("
      return read_list input
    else
      return read_symbol input
    end
  end

  def self.read_list(input)
    """
    Reads a list and returns Cons
    """
    if input.current == nil
      raise UnterminatedConsError.new(input.input)
    end
    if input.current == ")"
      input.next # Recursion will always return SchemeNil, if we do not do this.
      return SchemeNil.new
    end
    input.next
    skip_spaces(input)
    car = read_input(input)
    cdr = read_list(input)
    SchemeCons.new(car, cdr)
  end

  def self.read_symbol(input)
    """
    Reads a symbol and returns the corresponding value from environment.
    """
    symbol = ""
    while input.current != "(" &&
      input.current != ")" &&
      input.current != " " &&
      input.current != nil
      symbol += input.current
      input.next
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
    return Symboltable.get_or_add(symbol)
  end

  def self.read_number(input)
    """
    Reads a Number and returns SchemeInteger
    """
    number = ""
    while is_digit input.current
      number += input.current
      input.next
    end
    if input.current != " " && input.current != nil && input.current != ")"
      # There must be a space, end of cons or EOF now
      raise SchemeSyntaxError, input.input
    end
    SchemeInteger.new(number)
  end

  def self.read_string(input)
    """
    Reads a string and returns SchemeString
    """
    input.next # Skip "
    string = ""
    while input.current != "\"" && input.current != nil
      string += input.current
      input.next
    end

    if input.current != "\""
      raise UnterminatedStringError.new(input.input)
    end
    SchemeString.new(string)
  end

  def self.is_digit(x)
    """
    Small helper to check if the given parameter is a number
    """
    begin
      Integer(x)
      return true
    rescue ArgumentError, TypeError
      return false
    end
  end

  def self.skip_spaces(input)
    while input.current == " "
      input.next
    end
  end
end
