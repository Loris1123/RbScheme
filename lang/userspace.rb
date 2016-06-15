require_relative '../eval'

class UserspaceFunction

  def initialize(name, function, parameter)
    @name = name
    @function = function
    @parameter = parameter
    @number_of_arguments = parameter.size
  end

  def name
    @name.value
  end

  def parameter
    @parameter
  end

  def function
    @function
  end

  def number_of_arguments
    @number_of_arguments
  end
end

class UserdefinedFunction < UserspaceFunction

end

class UserdefinedSyntax < UserspaceFunction

end

