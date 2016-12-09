class History

  def initialize
    @history = Array.new
    @current_index = 0
  end

  def append x
    @history.push(x)
    @current_index = @history.length
    #puts "History now:"
    #puts @history
  end

  def up
    if @current_index > 0
      @current_index -= 1
    end
    return @history[@current_index]
  end

  def down
    if @current_index < @history.length-1
      @current_index += 1
    end
    return @history[@current_index]
  end
end
