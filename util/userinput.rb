require_relative "../lang/errors"

class UserInput
  attr_reader :index, :input, :line_counter

  def initialize(input)
    @input = input.strip  # Remove beginning and ending whitespace.
    @line_counter = 1 # Counts the lines of the currently read input.
    @index = 0
  end

  def to_str
    "Userinput: #{@input}"
  end

  def require_input(allow_newline=false)
    # Calles when the reader reaches the end of input, but still
    # needs some characters for the current statement.
    # newlines are only allowed when reading strings.
    if allow_newline
      @input << "\n"
    else
      @input << " "
    end
    @input << gets.strip
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

  def skip_whitespace
    # Skips til the next none-whitespace character
    while current != nil && current.strip.empty?
      if current == '\n'
        @line_counter += 1
      end
      @index = @index.next
    end
  end
end
