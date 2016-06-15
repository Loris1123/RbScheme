require_relative '../eval'

class UserSpaceFunctions

  def initialize(name, function)
    @name = name
    @function = function
  end

  def name
    @name
  end

  def function
    @function
  end
end

class UserdefinedFunction < UserSpaceFuctions

end

class UserdefinedSyntax < UserSpaceFuctions

end

