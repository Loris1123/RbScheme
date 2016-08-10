require_relative "../lang/errors"

class UserInput
  attr_reader :index, :input


  def initialize(input)
    @input = input.strip  # Remove beginning and ending whitespace.
    @index = 0
  end

  def to_str
    "Userinput: #{@input}"
  end

  def next
    # Do not skip spaces here!
    # Arguments would be moved together! (+ 1 2) -> (+12)
    @index = @index.next
    @input[@index]
  end

  # Gets the next character without changing the index
  def get_next
    @input[index+1]
  end

  def current
    @input[@index]
  end
end
