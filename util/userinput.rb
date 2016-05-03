require_relative "../lang/errors"

class UserInput

  def initialize(input)
    @read_input = ""
    @input = input.strip+"<EOF>"   # Mark the end of the input
  end

  def read_char
    """
    Returns the next char in  input. Nil if not available
    """
    if @input.size == 0
      return nil
    end
    if @input == "<EOF>"
      return nil
    end

    c = @input[0]
    @read_input += @input[0]
    @input = @input[1..-1]
    return c
  end

  def unread_char
    """
    Returns the previous char. Nil if not available
    """
    if @read_input.size == 0
      return nil
    end

    @input = @read_input[-1] + @input
    @read_input = @read_input[0..-2]
    return @input[0]
  end

  def get_input
    return @read_input+@input[0..-6]
  end

  def get_current_char
    # Current is the last read character
    if @input == "<EOF>"
      return nil
    end
    return @read_input[-1]
  end

end
