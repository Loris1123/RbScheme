require_relative "../lang/errors"

class UserInput
  def initialize(input)
    @input = input.strip  # Remove beginning and ending whitespace.
    @index = 0
  end

  def input
    @input
  end

  def to_str
    "Userinput: #{@input}"
  end

  def index
    @index
  end

  def next
    # Do not skip spaces here!
    # Arguments will be moved together! (+ 1 2) -> (+12)
    @index = @index.next
    @input[@index]
  end

  def current
    @input[@index]
  end
end
