class SchemeError < StandardError
  def initialize(message)
    super "\n\n=======================\n\n"+
          "Internal Scheme Error. Please report a bug at https://github.com/Loris1123/RbScheme\n\n"+
          "-----------------------\n\n"+
          "Error: #{message}\n\n"+
          "======================="
  end
end

class WrongInputError < SchemeError
  def initialize(input)
    super("Input was no UserInput. Got #{input.class}")
  end
end

class SchemeArgumentError < SchemeError
  def initialize(need, got)
    super("Wrong argument. Need #{need}. Got #{got}")
  end
end
