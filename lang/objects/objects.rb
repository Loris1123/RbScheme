require_relative '../../lang/errors'
require 'singleton'

# Baseclass of all objects
class SchemeObject; end

# Objects, that can exist only one time.
class SchemeSingletonObject < SchemeObject
  include Singleton
end

# All other objects. Can exist multiple times and contain data.. Numbers, Strings, etc..
class SchemeDataObject < SchemeObject
  attr_accessor :value
end

class SchemeVoid < SchemeSingletonObject
  def ==(x)
    return x.class == SchemeVoid
  end
end

class SchemeNil < SchemeSingletonObject
  def ==(x)
    return x.class == SchemeNil
  end
end

class SchemeTrue < SchemeSingletonObject
  def value
    '#t'
  end

  def ==(x)
    return x.class == SchemeTrue
  end
end

class SchemeFalse < SchemeSingletonObject
  def value
    '#f'
  end

  def ==(x)
    return x.class == SchemeFalse
  end
end
