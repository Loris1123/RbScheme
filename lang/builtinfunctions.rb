require_relative 'objects'
require_relative 'errors'
require_relative '../lang/userspace'
require_relative '../eval'

class SchemeBuiltin

  def initialize(name, job, number_of_arguments)
    @name = name
    @job = job
    @number_of_arguments = number_of_arguments
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
    if args.length != @number_of_arguments
      raise SchemeArgumentNumberError.new(@name, @number_of_arguments, args.length)
    end
  end
end

class BuiltinFunction < SchemeBuiltin

end

class BuiltinSyntax < SchemeBuiltin

end

module Functions

  def self.scheme_plus
    Proc.new{|environment, args| args[0]+args[1] }
  end

  def self.scheme_times
    Proc.new{|environment, args| args[0]*args[1] }
  end

  def self.scheme_substract
    Proc.new{|environment, args| args[0]-args[1] }
  end

  def self.scheme_divide
    Proc.new{|environment, args| args[0]/args[1] }
  end

  def self.scheme_modulo
    Proc.new{|environment, args|
      SchemeInteger.new(args[0].value % args[1].value)
    }
  end

  def self.scheme_equals
    Proc.new{|environment, args| 
      if args[0] == args[1]
        SchemeTrue.new
      else
        SchemeFalse.new
      end
    }
  end

  def self.scheme_cons
    Proc.new{|environment, args|
      # Call reader like you'd call it when entered to get a correct cons?
      # require_relative '../reader'
      # Reader.read_input(UserInput.new("(#{args[0]} #{args[1]})"))
      SchemeCons.new(args[0], SchemeCons.new(args[1], SchemeNil.new))
    }
  end

  # Return true if the argument is a cons
  def self.scheme_cons?
    Proc.new{|environment, args|
      if args[0].class == SchemeCons
        SchemeTrue.new
      else
        SchemeFalse.new
      end
    }
  end

  def self.scheme_car
    Proc.new{|environment, args|
      # TODO: Error Detection
      args[0].car
    }
  end

  def self.scheme_cdr
    Proc.new{|environment, args|
      # TODO: Error Detection
      args[0].cdr
    }
  end

  def self.scheme_define
    Proc.new{|environment, args|

      case args[0]
        when SchemeSymbol
          # Define a new symbol and assign a value
          if args[1].class == SchemeCons
            # Eval the argument if it is a cons.
            # If there are undefined symbols in the cons,
            # an error will be raised. This is okay and the expected behaviour (compare to racket)
            environment.put(args[0], Eval.eval(environment,args[1]))
          else
            # If it is something other (integer, string, t, f), just assing it to the symbol
            environment.put(args[0], args[1])
          end
        when SchemeCons
          # Userdefined Function

          lambda_header = args[0]
          lambda_body = args[1]
          raise SchemeSyntaxError.new("Wrong define-Syntax. Need a cons as functionbody. Got #{lambda_body.class}") unless lambda_body.class == SchemeCons

          lambda_name = lambda_header.car
          raise SchemeSyntaxError.new("Wrong define-Syntax. Need a Symbol as function identifier. Got #{lambda_name.class}") unless lambda_name.class == SchemeSymbol

          # Create the parameter-list
          parameter_list = lambda_header.cdr
          parameter = []
          loop do
            raise SchemeSyntaxError.new("Wrong define-Syntax. Need a Symbol as parameter. Got #{parameter_list.car.class}") unless parameter_list.car.class == SchemeSymbol
            parameter << parameter_list.car
            break if parameter_list.cdr.class == SchemeNil
            parameter_list = parameter_list.cdr
          end

          environment.put(lambda_name, UserdefinedFunction.new(lambda_name, lambda_body, parameter ))
        else
          raise SchemeSyntaxError.new("Wrong define-Syntax. Only Symbols or Cons are allowed as identifier. Got #{args[0].class}")
      end
    }
  end

end
