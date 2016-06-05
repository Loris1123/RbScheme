require_relative "objects"

class BuiltinFunction
  def initialize(name, job)
    @name = name
    @job = job
  end

  def work(*args)
    @job.call(args)
  end

  def name
    @name
  end

end

module Functions

  def self.scheme_plus
    Proc.new{|args| args[0]+args[1] }
  end

  def self.scheme_times
    Proc.new{|args| args[0]*args[1] }
  end

  def self.scheme_substract
    Proc.new{|args| args[0]-args[1] }
  end

  def self.scheme_divide
    Proc.new{|args| args[0]/args[1] }
  end

  def self.scheme_equals
    Proc.new{|args| 
      if args[0] == args[1]
        SchemeTrue.new
      else
        SchemeFalse.new
      end
    }
  end

end
