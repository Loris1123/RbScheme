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
    elsif (input.current == '+' or input.current=='-') and is_digit(input.get_next)
      # Negative numbers or numbers that start with +. Check the Space! Builtinfunctions +/-
      return read_number input
    elsif input.current == "\""
      return read_string input
    elsif input.current == "("
      return read_list input
    else
      return read_symbol input
    end
  end

  # Reads a list and returns Cons
  def self.read_list(input)
    if input.current == ")"
      input.next # Recursion will always return SchemeNil, if we do not do this.
      return SchemeNil.instance
    end
    skip_spaces(input)
    if input.current == nil
      raise UnterminatedConsError.new(input.input)
    end
    car = read_input(input)
    cdr = read_list(input)
    SchemeCons.new(car, cdr)
  end

  # Reads a symbol and returns the corresponding value from environment.
  def self.read_symbol(input)
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
      return SchemeNil.instance
    when "\#t"
      return SchemeTrue.instance
    when "\#f"
      return SchemeFalse.instance
    end
    return Symboltable.get_or_add(symbol)
  end

  # Reads a Number and returns SchemeInteger
  def self.read_number(input)
    is_negative = false
    if input.current == '-'
      is_negative = true
      input.next
    end
    if input.current == '+'
      input.next
    end

    number = ""
    while is_digit input.current
      number += input.current
      input.next
    end
    if input.current != " " && input.current != nil && input.current != ")"
      # There must be a space, end of cons or EOF now
      raise SchemeSyntaxError, input.input
    end
    if is_negative
      return SchemeInteger.new(number.to_i * -1)
    else
      return SchemeInteger.new(number.to_i)
    end
  end

  # Reads a string and returns SchemeString
  def self.read_string(input)
    input.next # Skip "
    string = ""
    while input.current != "\"" && input.current != nil
      string += input.current
      input.next
    end

    if input.current != "\""
      raise UnterminatedStringError.new(input.input)
    end
    input.next
    SchemeString.new(string)
  end

  # Small helper to check if the given parameter is a number
  def self.is_digit(x)
    begin
      Integer(x)
      return true
    rescue ArgumentError, TypeError
      return false
    end
  end

  def self.skip_spaces(input)
    loop do
      input.next
      break if input.current != ' '
    end
  end
end
