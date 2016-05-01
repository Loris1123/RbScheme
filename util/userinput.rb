class UserInput

  def initialize(input)
    @index = 0
    @input = input.strip
  end

  def next_char
    """
    Returns the next char in  input. Nil if not available
    """
    if @index == @input.size
      return nil
    end

    ret = @input[@index]
    @index+=1
    return ret
  end

  def previous_char
    """
    Returns the previous char. Nil if not available
    """
    if @index == 0
      return nil
    end
    ret = @input[@index]
    @index -= 1
    return ret
  end

  def get_input
    return @input
  end

end
