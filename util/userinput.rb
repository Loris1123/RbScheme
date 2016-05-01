require_relative "../lang/errors"

class UserInput

  def initialize(input)
    @index = -1
    @input = input.strip
  end

  def next_char
    """
    Returns the next char in  input. Nil if not available
    """
    if @index < @input.size
      @index+=1
    end
    @input[@index]
  end

  def previous_char
    """
    Returns the previous char. Nil if not available
    """
    if @index > -1
      @index -= 1
    end
    if @index == -1
      return nil
    end
    @input[@index]
  end

  def get_input
    return @input
  end

  def get_current_char
    return @input[@index]
  end
end
