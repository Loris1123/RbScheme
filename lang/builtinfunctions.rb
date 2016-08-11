require_relative 'objects'
require_relative 'errors'
require_relative '../lang/userspace'
require_relative '../eval'

class SchemeBuiltin

  def initialize(name, job, min_arguments, max_arguments)
    @name = name
    @job = job
    @min_arguments = min_arguments
    @max_arguments = max_arguments
  end

  def work(environment, args)
    check_number_of_arguments args
    @job.call(environment, args)
  end

  def name
    @name
  end

  def number_of_arguments
    @number_of_arguments
  end

  private

  # Check if the number of given arguments
  # machtes the number of neede darguments
  def check_number_of_arguments(args)
    if args.length < @min_arguments
      raise SchemeUserError.new("Invalid number of arguments for #{@name}. Need between #{@min_arguments} and #{@max_arguments}. Got #{args.length}")
    end

    if args.length > @max_arguments and @max_arguments != -1
      raise SchemeUserError.new("Invalid number of arguments for #{@name}. Need between #{@min_arguments} and #{@max_arguments}. Got #{args.length}")
    end
  end
end

class BuiltinFunction < SchemeBuiltin

end


module Functions

  def self.scheme_plus
    Proc.new{|environment, args|
      res = args[0]
      args = args.drop(1)
      args.each do |a|
        res += a
      end
      res
    }
  end

  def self.scheme_times
    Proc.new{|environment, args|
      res = args[0]
      args = args.drop(1)
      args.each do |a|
        res *= a
      end
      res }
  end

  def self.scheme_substract
    Proc.new{|environment, args|
      res = args[0]
      args = args.drop(1)
      args.each do |a|
        res -= a
      end
      res }
  end

  def self.scheme_divide
    Proc.new{|environment, args| args[0] / args[1]}
  end

  def self.scheme_modulo
    Proc.new{|environment, args|
      SchemeInteger.new(args[0].value % args[1].value)
    }
  end

  def self.greater_than
    Proc.new{|environment, args|
      raise SchemeUserError.new("Invalid argument for >. Need SchemeInteger . Got #{args[0].class}") unless args[0].class == SchemeInteger
      raise SchemeUserError.new("Invalid argument for >. Need SchemeInteger . Got #{args[1].class}") unless args[1].class == SchemeInteger

      args[0].value > args[1].value ? SchemeTrue.instance : SchemeFalse.instance
    }
  end

  def self.lower_than
    Proc.new{|environment, args|
      raise SchemeUserError.new("Invalid argument for <. Need SchemeInteger . Got #{args[0].class}") unless args[0].class == SchemeInteger
      raise SchemeUserError.new("Invalid argument for <. Need SchemeInteger . Got #{args[1].class}") unless args[1].class == SchemeInteger

      args[0].value < args[1].value ? SchemeTrue.instance : SchemeFalse.instance
    }
  end

  def self.scheme_abs
    Proc.new{|environment, args|
      if args[0].class != SchemeInteger and args[0].class != SchemeFloat and args[0].class != SchemeRational
        raise SchemeUserError.new("Cannot create an abs of #{args[0].class}")
      end

      args[0].class.new(args[0].value.abs)
    }
  end

  def self.scheme_equals
    Proc.new{|environment, args|
      args[0] == args[1] ? SchemeTrue.instance : SchemeFalse.instance
    }
  end

  def self.scheme_cons
    Proc.new{|environment, args|
      # Call reader like you'd call it when entered to get a correct cons?
      # require_relative '../reader'
      # Reader.read_input(UserInput.new("(#{args[0]} #{args[1]})"))
      SchemeCons.new(args[0], SchemeCons.new(args[1], SchemeNil.instance))
    }
  end

  # Return true if the argument is a cons
  def self.scheme_cons?
    Proc.new{|environment, args|
      args[0].class == SchemeCons ? SchemeTrue.instance : SchemeFalse.instance
    }
  end

  def self.integer?
    Proc.new{|environment, args|
      args[0].class == SchemeInteger ? SchemeTrue.instance : SchemeFalse.instance
    }
  end

  def self.rational?
    Proc.new{|environment, args|
      args[0].class == SchemeRational ? SchemeTrue.instance : SchemeFalse.instance
    }
  end

  def self.float?
    Proc.new{|environment, args|
      args[0].class == SchemeFloat ? SchemeTrue.instance : SchemeFalse.instance
    }
  end

  def self.number?
    Proc.new{|environment, args|
      args[0].kind_of?(SchemeNumber) ? SchemeTrue.instance : SchemeFalse.instance
    }
  end

  def self.symbol?
    Proc.new{|environment, args|
      args[0].class == SchemeSymbol ? SchemeTrue.instance : SchemeFalse.instance
    }
  end

  def self.string?
    Proc.new{|environment, args|
      args[0].class == SchemeString ? SchemeTrue.instance : SchemeFalse.instance
    }
  end

  def self.builtin_function?
    Proc.new{|environment, args|
      args[0].class == BuiltinFunction ? SchemeTrue.instance : SchemeFalse.instance
    }
  end

  def self.builtin_syntax?
  Proc.new{|environment, args|
    args[0].class == BuiltinSyntax ? SchemeTrue.instance : SchemeFalse.instance
  }
  end

  def self.function?
    Proc.new{|environment, args|
      (args[0].class == BuiltinFunction) || args[0].class == UserdefinedFunction ? SchemeTrue.instance : SchemeFalse.instance
    }
  end

  def self.syntax?
    Proc.new{|environment, args|
      (args[0].class == BuiltinSyntax) || args[0].class == UserdefinedSyntax ? SchemeTrue.instance : SchemeFalse.instance
    }
  end


  def self.scheme_car
    Proc.new{|environment, args|
      raise SchemeSyntaxError.new("Wrong argument for car. Need a cons as argument. Got #{args[0].class}") unless args[0].class == SchemeCons
      args[0].car
    }
  end

  def self.scheme_cdr
    Proc.new{|environment, args|
      raise SchemeSyntaxError.new("Wrong argument for cdr. Need a cons as argument. Got #{args[0].class}") unless args[0].class == SchemeCons
      if args[0].cdr.cdr.class == SchemeNil
        args[0].cdr.car
      else
        args[0].cdr
      end
    }
  end

  def self.set_car!
    Proc.new{|environment, args|
      raise SchemeSyntaxError.new("Wrong argument for cdr. Need a cons as argument. Got #{args[0].class}") unless args[0].class == SchemeCons
      args[0].car = Eval.eval(environment, args[1])
      args[0]
    }
  end

  def self.set_cdr!
    Proc.new{|environment, args|
      raise SchemeSyntaxError.new("Wrong argument for cdr. Need a cons as argument. Got #{args[0].class}") unless args[0].class == SchemeCons
      args[0].cdr = SchemeCons.new(Eval.eval(environment, args[1]), SchemeNil.instance)
      args[0]
    }
  end
end
