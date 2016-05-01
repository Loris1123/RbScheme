require_relative "util/userinput"
require_relative "lang/errors"

module Reader
  def self.read_input(input)
    if input.class != UserInput
      raise WrongInputError, input
    end
    return input
  end
end
