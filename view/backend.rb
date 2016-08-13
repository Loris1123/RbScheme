require_relative '../reader'
require_relative '../eval'
require_relative '../print'

# Interface for accessing the RbScheme backend
module Backend

  @@environment = GlobalEnvironment.get

  # Reads and evaluates an input. Returns the evaled result.
  def self.read_eval(input)
    userinput = UserInput.new(input)
    begin
      read = Reader.read_input(userinput)
      evaled = Eval.eval(@@environment, read)
      SchemePrinter.scheme_print(evaled).to_s
    rescue SchemeUserError => err
      return err.message
    end
  end

  def self.environment
    @@environment
  end
end
