require_relative "lang/errors"

module Eval

  def self.eval(input, environment)
    puts input
    case input
    when Symbol
      symbol = environment.get(input)
      raise UndefinedSymbolError.new(input) unless symbol != nil
      return symbol
    end
    return input
  end
end
