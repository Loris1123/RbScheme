require_relative "objects"

class BuiltinFunction
  def initialize(name, job)
    @name = name
    @job = job
  end

  def work
    @job.call
  end

  def name
    @name
  end
  
end

module Functions

  def scheme_plus
    return SchemeInteger(666)
  end

end
