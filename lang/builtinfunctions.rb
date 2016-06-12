require_relative "objects"

class BuiltinFunction
  def initialize(name, job)
    @name = name
    @job = job
  end

  def work(environment, *args)
    @job.call(environment, args)
  end

  def name
    @name
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
      SchemeCons.new(args[0], args[1])
    }
  end

  def self.scheme_car

  end

  def self.scheme_cdr

  end

  def self.scheme_define
    Proc.new{|environment, args| 
      environment.put(args[0], args[1])
    }
  end



end
