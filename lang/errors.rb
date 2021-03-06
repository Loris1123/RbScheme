class SchemeError < StandardError; end

class SchemeInternalError < StandardError
  def initialize(message)
    super "\n\n==============================================\n\n"+
          "Internal Scheme Error. Please report a bug at https://github.com/Loris1123/RbScheme\n\n"+
          "----------------------------------------------\n\n"+
          "Error: #{message}\n\n"+
          "==============================================\n"
  end
end

class WrongInputError < SchemeInternalError
  def initialize(input)
    super("Input was no UserInput. Got #{input.class}")
  end
end

class SchemeArgumentError < SchemeInternalError
  def initialize(need, got)
    super("Wrong argument. Need #{need}. Got #{got}")
  end
end

class SchemeUserError < SchemeError
  def initialize(message)
    super "\n\n==============================================\n\n"+
          "Scheme Error\n\n"+
          "----------------------------------------------\n\n"+
          "#{message}\n\n"+
          "==============================================\n\n"
  end
end

class SchemeArgumentNumberError < SchemeUserError
  def initialize(functionname, need, got)
    super("Wrong number of arguments for function #{functionname}: Need: #{need}. Got #{got}")
  end
end

class UnterminatedStringError < SchemeUserError
  def initialize(unterminated_string)
    super("Unterminated string: #{unterminated_string}")
  end
end

class UnterminatedConsError < SchemeUserError
  def initialize(unterminated_cons)
    super("Unterminated cons: #{unterminated_cons}")
  end
end

class UndefinedVariableError < SchemeUserError
  def initialize(symbolname)
    super("Undefined variable: #{symbolname}")
  end
end

class SchemeSyntaxError < SchemeUserError
  def initialize(error_message, userinput=nil)
    if userinput==nil
      super("Invalid Syntax: #{error_message}")
    else
      # Calculate spaces
      # 16 = lenth of "Invalid Syntax: "
      error_marker = "_"*(16 + userinput.index)
      error_marker += "^"
      super("Invalid Syntax: #{userinput.input}\n#{error_marker}\n\n#{error_message}")
    end
  end
end
