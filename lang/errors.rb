class SchemeError < StandardError; end

class SchemeIntenalError < StandardError
  def initialize(message)
    super "\n\n=======================\n\n"+
          "Internal Scheme Error. Please report a bug at https://github.com/Loris1123/RbScheme\n\n"+
          "-----------------------\n\n"+
          "Error: #{message}\n\n"+
          "=======================\n"
  end
end

class WrongInputError < SchemeIntenalError
  def initialize(input)
    super("Input was no UserInput. Got #{input.class}")
  end
end

class SchemeArgumentError < SchemeIntenalError
  def initialize(need, got)
    super("Wrong argument. Need #{need}. Got #{got}")
  end
end

class SchemeUserError < SchemeError
  def initialize(message)
    super "\n\n=======================\n\n"+
          "Scheme Error"+
          "-----------------------\n\n"+
          "#{message}\n\n"+
          "=======================\n"
  end
end

class UnterminatedStringError < SchemeUserError
  def initialize(unterminated_string)
    super("Unterminated string: #{unterminated_string}")
  end
end
