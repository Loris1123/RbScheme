require_relative "util/userinput"
require_relative "lang/errors"

module Reader
  def self.read_input(input)
    if input.class != UserInput
      raise WrongInputError, input
    end
    input
  end

  def self.read_number(input)
    nil
  end

  def self.is_digit(x)
    # Small helper to check if the given parameter is a number
    if x.class == Fixnum
      return TRUE
    end
    FALSE
  end
end
