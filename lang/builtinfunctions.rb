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
    return Proc.new{|args| args[0]+args[1] }
  end

  def self.scheme_times
    return Proc.new{|x,y| args[0]*args[1] }
  end

  def self.scheme_substract
    return Proc.new{|x,y| args[0]-args[1] }
  end

  def self.scheme_divide
    return Proc.new{|x,y| args[0]/args[1] }
  end

end
