require_relative "objects"

class BuiltinFunction
  def initialize(name, job)
    @name = name
    @job = job
  end

  def work(x,y)
    @job.call(x,y)
  end

  def name
    @name
  end

end

module Functions

  def self.scheme_plus
    return Proc.new{|x,y| SchemeInteger.new(x+y) }
  end

  def self.scheme_times
    return Proc.new{|x,y| SchemeInteger.new(x*y) }
  end

  def self.scheme_substract
    return Proc.new{|x,y| SchemeInteger.new(x-y) }
  end
end
