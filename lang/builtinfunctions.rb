require_relative 'objects'
require_relative 'errors'

class BuiltinFunction

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
      environment.put(args[0], args[1])
    }
  end



end
